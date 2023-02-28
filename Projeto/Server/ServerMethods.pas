unit ServerMethods;

interface

uses System.SysUtils, System.Classes, System.JSON, Rest.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, Pessoa, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, REST.Response.Adapter, DMConsultaCEP,
  Vcl.ExtCtrls, Principal;

type
  TServerMethods = class(TDSServerModule)
    conexao: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDQPessoa: TFDQuery;
    FDQEndereco: TFDQuery;
    FDQEnderecoIntegracao: TFDQuery;
    FDQPessoaidpessoa: TLargeintField;
    FDQPessoaflnatureza: TSmallintField;
    FDQPessoadsdocumento: TWideStringField;
    FDQPessoanmprimeiro: TWideStringField;
    FDQPessoanmsegundo: TWideStringField;
    FDQPessoadtregistro: TDateField;
    FDQEnderecoidendereco: TLargeintField;
    FDQEnderecoidpessoa: TLargeintField;
    FDQEnderecodscep: TWideStringField;
    FDQEnderecoIntegracaoidendereco: TLargeintField;
    FDQEnderecoIntegracaodsuf: TWideStringField;
    FDQEnderecoIntegracaonmcidade: TWideStringField;
    FDQEnderecoIntegracaonmbairro: TWideStringField;
    FDQEnderecoIntegracaonmlogradouro: TWideStringField;
    FDQEnderecoIntegracaodscomplemento: TWideStringField;
    FDQAux: TFDQuery;
    FDUpdPessoa: TFDUpdateSQL;
    FDQInserePessoaEmLote: TFDQuery;
    FDQInsereEnderecoEmLote: TFDQuery;
    FDQDadosPessoa: TFDQuery;
    FDQDadosPessoaidpessoa: TLargeintField;
    FDQDadosPessoaflnatureza: TSmallintField;
    FDQDadosPessoadsdocumento: TWideStringField;
    FDQDadosPessoanmprimeiro: TWideStringField;
    FDQDadosPessoanmsegundo: TWideStringField;
    FDQDadosPessoadtregistro: TDateField;
    FDQDadosPessoaidendereco: TLargeintField;
    FDQDadosPessoadscep: TWideStringField;
    FDQDadosPessoadsuf: TWideStringField;
    FDQDadosPessoanmcidade: TWideStringField;
    FDQDadosPessoanmbairro: TWideStringField;
    FDQDadosPessoanmlogradouro: TWideStringField;
    FDQDadosPessoadscomplemento: TWideStringField;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure FDQPessoaAfterPost(DataSet: TDataSet);
    procedure FDQEnderecoAfterPost(DataSet: TDataSet);
    procedure FDQPessoaAfterDelete(DataSet: TDataSet);
    procedure FDQEnderecoAfterDelete(DataSet: TDataSet);
    procedure FDQEnderecoIntegracaoAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    procedure convertJsonParaDataset(dataset:TDataSet; json:String);
    function retornaProximoId(campo,tabela:String):integer;

  public
    { Public declarations }

   function Pessoas :String;
   function updatePessoas(objPessoa:TJSonObject):TJSONValue;
   function acceptPessoas(objPessoa:TJSonObject ):TJSONValue;
   function cancelPessoas(idPessoa:integer) :TJSONValue;
   function updateInsertEmLote(jsonPessoas:TJSONArray):TJSONValue;

  end;

implementation


{$R *.dfm}

{ TServerMethods }
// alterando pessoa
function TServerMethods.acceptPessoas(objPessoa:TJSonObject): TJSONValue;
var pessoa:TPessoa;
begin

  pessoa := TPessoa.Create();
  try
    frmPrincipal.ligaDesligaThread := false;

    pessoa := TJson.JsonToObject<Tpessoa>(objPessoa.ToJSON);

      FDQPessoa.Close;
      FDQPessoa.ParamByName('idpessoa').AsInteger := pessoa.idPessoa;
      FDQPessoa.Open();
      if FDQPessoa.RecordCount > 0 then
      begin

        try
          conexao.StartTransaction;
          FDQPessoa.Edit;
          FDQPessoa.FieldByName('flnatureza').Asinteger := pessoa.flnatureza;
          FDQPessoa.FieldByName('dsdocumento').AsString := pessoa.dsdocumento;
          FDQPessoa.FieldByName('nmprimeiro').AsString  := pessoa.nmprimeiro;
          FDQPessoa.FieldByName('nmsegundo').AsString   := pessoa.nmsegundo;
          FDQPessoa.FieldByName('dtregistro').AsDateTime := pessoa.dtregistro;
          FDQPessoa.Post;

          FDQEndereco.Close;
          FDQEndereco.ParamByName('idpessoa').AsInteger := pessoa.idPessoa;
          FDQEndereco.Open();

          FDQEndereco.Edit;
          FDQEndereco.FieldByName('idpessoa').AsInteger := FDQPessoa.FieldByName('idpessoa').Asinteger;
          FDQEndereco.FieldByName('dscep').AsString := pessoa.endereco.dscep;
          FDQEndereco.Post;

          Result := TJSONString.Create('Pessoa Alterada com sucesso id : ' + FDQPessoa.FieldByName('idpessoa').AsString ) ;
          conexao.Commit;
        Except
          conexao.Rollback;
          Result := TJSONString.Create('Erro ao Alterar Pessoa ');
        end;

      end;

  finally
    pessoa.Free;
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

end;

function TServerMethods.cancelPessoas(idPessoa:integer):TJSONValue;
begin

  try
    frmPrincipal.ligaDesligaThread := false;
    FDQPessoa.Close;
    FDQPessoa.ParamByName('idpessoa').AsInteger := idPessoa;
    FDQPessoa.Open();
    if FDQPessoa.RecordCount > 0 then
    begin

      try
        conexao.StartTransaction;
        FDQEndereco.Close;
        FDQEndereco.ParamByName('idpessoa').AsInteger := idPessoa;
        FDQEndereco.Open();
        if FDQEndereco.RecordCount > 0 then
        begin
          FDQEnderecoIntegracao.Close;
          FDQEnderecoIntegracao.ParamByName('idendereco').AsInteger := FDQEndereco.FieldByName('idendereco').AsInteger;
          FDQEnderecoIntegracao.Open;
          if FDQEnderecoIntegracao.RecordCount > 0 then
            FDQEnderecoIntegracao.Delete;
          FDQEndereco.Delete;
        end;
        FDQPessoa.Delete;
        Result := TJSONString.Create('Pessoa Excluida com sucesso id : ' + FDQPessoa.FieldByName('idpessoa').AsString ) ;
        conexao.Commit;
      Except
        conexao.Rollback;
        Result := TJSONString.Create('Erro ao Excluida Pessoa ');
      end;

    end;

  finally
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

end;

procedure TServerMethods.convertJsonParaDataset(dataset: TDataSet;json: String);
var
  JObj: TJSONArray;
  vConv :TCustomJSONDataSetAdapter;
begin
   if (json = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(json) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := dataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;

end;

function TServerMethods.Pessoas: String;
var jsonRetorno:String;
    LJsonArr   : TJSONArray;
    pessoa:TPessoa;
    ObjJSon:TJSONObject;

begin
  FDQDadosPessoa.Close;
  FDQDadosPessoa.Open();

  if FDQDadosPessoa.RecordCount > 0 then
  begin
    LJsonArr := TJSONArray.Create();
    ObjJSon:=TJSONObject.Create;
    try
      FDQDadosPessoa.First;
      while not FDQDadosPessoa.Eof do
      begin
        pessoa := TPessoa.Create();
        try
          pessoa.idPessoa :=  FDQDadosPessoa.FieldByName('idPessoa').AsInteger;
          pessoa.flnatureza  := FDQDadosPessoa.FieldByName('flnatureza').AsInteger;
          pessoa.dsdocumento := FDQDadosPessoa.FieldByName('dsdocumento').AsString;
          pessoa.nmprimeiro  := FDQDadosPessoa.FieldByName('nmprimeiro').AsString;
          pessoa.nmsegundo   := FDQDadosPessoa.FieldByName('nmsegundo').AsString;
          pessoa.dtregistro  := FDQDadosPessoa.FieldByName('dtregistro').AsDateTime;
          pessoa.endereco.idEndereco := FDQDadosPessoa.FieldByName('idEndereco').AsInteger;
          pessoa.endereco.idPessoa   := FDQDadosPessoa.FieldByName('idPessoa').AsInteger;
          pessoa.endereco.dscep     := FDQDadosPessoa.FieldByName('dscep').AsString;
          pessoa.endereco.endIntegracao.cep := FDQDadosPessoa.FieldByName('dscep').AsString;
          pessoa.endereco.endIntegracao.logradouro :=  FDQDadosPessoa.FieldByName('nmlogradouro').AsString;
          pessoa.endereco.endIntegracao.complemento  :=  FDQDadosPessoa.FieldByName('dscomplemento').AsString;
          pessoa.endereco.endIntegracao.bairro :=  FDQDadosPessoa.FieldByName('nmbairro').AsString;
          pessoa.endereco.endIntegracao.localidade :=  FDQDadosPessoa.FieldByName('nmcidade').AsString;
          pessoa.endereco.endIntegracao.uf :=  FDQDadosPessoa.FieldByName('dsuf').AsString;
          pessoa.endereco.endIntegracao.ibge :=  '';
          pessoa.endereco.endIntegracao.gia :=  '';
          pessoa.endereco.endIntegracao.ddd :=  '';
          pessoa.endereco.endIntegracao.siafi :=  '';

          ObjJSon := TJson.ObjectToJsonObject(pessoa);
          LJsonArr.AddElement(ObjJSon);
        finally
          pessoa.Free;
        end;

        FDQDadosPessoa.Next;
      end;

      Result := LJsonArr.ToString;

    finally
      FreeAndNil(LJsonArr);
    end;
  end
  else
    Result :='';
end;

function TServerMethods.retornaProximoId(campo, tabela: String): integer;
var sql:String;
begin
  sql := 'select coalesce(max('+campo+'),0) as count from ' + tabela;
  FDQAux.Close;
  FDQAux.SQL.Clear;
  FDQAux.SQL.Add(sql);
  FDQAux.Open();

  if FDQAux.RecordCount > 0 then
  begin
    result := FDQAux.FieldByName('count').AsInteger + 1 ;
  end
  else
    result := 1;
end;

// inserindo pessoa
function TServerMethods.updatePessoas(objPessoa: TJSonObject): TJSONValue;
var pessoa:TPessoa;
begin

  pessoa := TPessoa.Create();
  try
    frmPrincipal.ligaDesligaThread := false;

    try
      FDQPessoa.Close;
      FDQPessoa.ParamByName('idpessoa').AsInteger := -1;
      FDQPessoa.Open();
      pessoa := TJson.JsonToObject<Tpessoa>(objPessoa.ToJSON);

      conexao.StartTransaction;
      FDQPessoa.Insert;
      FDQPessoa.FieldByName('idpessoa').Asinteger := retornaProximoId('idpessoa','pessoa');
      FDQPessoa.FieldByName('flnatureza').Asinteger := pessoa.flnatureza;
      FDQPessoa.FieldByName('dsdocumento').AsString := pessoa.dsdocumento;
      FDQPessoa.FieldByName('nmprimeiro').AsString  := pessoa.nmprimeiro;
      FDQPessoa.FieldByName('nmsegundo').AsString   := pessoa.nmsegundo;
      FDQPessoa.FieldByName('dtregistro').AsDateTime := pessoa.dtregistro;
      FDQPessoa.Post;

      FDQEndereco.Close;
      FDQEndereco.ParamByName('idpessoa').AsInteger := FDQPessoa.FieldByName('idpessoa').Asinteger;
      FDQEndereco.Open();
      FDQEndereco.Insert;
      FDQEndereco.FieldByName('idendereco').AsInteger := retornaProximoId('idendereco','endereco');
      FDQEndereco.FieldByName('idpessoa').AsInteger := FDQPessoa.FieldByName('idpessoa').Asinteger;
      FDQEndereco.FieldByName('dscep').AsString := pessoa.endereco.dscep;
      FDQEndereco.Post;

      Result := TJSONString.Create('Pessoa cadastrada com sucesso id : ' + FDQPessoa.FieldByName('idpessoa').AsString ) ;
      conexao.Commit;
    Except
      conexao.Rollback;
      Result := TJSONString.Create('Erro ao cadastrar Pessoa ');
    end;

  finally
    pessoa.Free;
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

end;

procedure TServerMethods.DSServerModuleCreate(Sender: TObject);
begin
  conexao.Connected := TRUE;
end;

procedure TServerMethods.FDQEnderecoAfterDelete(DataSet: TDataSet);
begin
  FDQEndereco.ApplyUpdates(0);
end;

procedure TServerMethods.FDQEnderecoAfterPost(DataSet: TDataSet);
begin
  FDQEndereco.ApplyUpdates(0);
end;

procedure TServerMethods.FDQEnderecoIntegracaoAfterDelete(DataSet: TDataSet);
begin
  FDQEndereco.ApplyUpdates(0);
end;

procedure TServerMethods.FDQPessoaAfterDelete(DataSet: TDataSet);
begin
  FDQPessoa.ApplyUpdates(0);
end;

procedure TServerMethods.FDQPessoaAfterPost(DataSet: TDataSet);
begin
  FDQPessoa.ApplyUpdates(0);
end;

function TServerMethods.updateInsertEmLote(jsonPessoas: TJSONArray): TJSONValue;
var pessoa:TPessoa;
    i : integer;
    jp, jSubPar: TJSONPair;
    contadorPessoa,contadorEndereco:integer;
begin

  try
    contadorPessoa := retornaProximoId('idpessoa','pessoa');
    contadorEndereco := retornaProximoId('idendereco','endereco');

    FDQInserePessoaEmLote.Params.ArraySize := jsonPessoas.Count;
    FDQInsereEnderecoEmLote.Params.ArraySize := jsonPessoas.Count;

    for i := 0 to jsonPessoas.Count -1  do
    begin
      pessoa := TJson.JsonToObject<Tpessoa>(jsonPessoas.Get(i).ToString);
      FDQInserePessoaEmLote.ParamByName('idpessoa').AsIntegers[i] := contadorPessoa;
      FDQInserePessoaEmLote.ParamByName('flnatureza').AsIntegers[i] := pessoa.flnatureza;
      FDQInserePessoaEmLote.ParamByName('dsdocumento').AsStrings[i] := pessoa.dsdocumento;
      FDQInserePessoaEmLote.ParamByName('nmprimeiro').AsStrings[i] := pessoa.nmprimeiro;
      FDQInserePessoaEmLote.ParamByName('nmsegundo').AsStrings[i] := pessoa.nmsegundo;
      FDQInserePessoaEmLote.ParamByName('dtregistro').AsDateTimes[i] := pessoa.dtregistro;
      if pessoa.endereco.dscep <> ''  then
      begin
        FDQInsereEnderecoEmLote.ParamByName('idendereco').AsIntegers[i] := contadorEndereco;
        FDQInsereEnderecoEmLote.ParamByName('idpessoa').AsIntegers[i] :=  contadorPessoa;
        FDQInsereEnderecoEmLote.ParamByName('dscep').AsStrings[i] := pessoa.endereco.dscep;
      end;

      inc(contadorPessoa);
      inc(contadorEndereco);
    end;

    conexao.StartTransaction;
    try
      FDQInserePessoaEmLote.Execute(i,0);
      FDQInsereEnderecoEmLote.Execute(i,0);
      conexao.Commit;
    Except
      conexao.Rollback;
    end;
  finally
    pessoa.Free;
  end;

end;

end.

