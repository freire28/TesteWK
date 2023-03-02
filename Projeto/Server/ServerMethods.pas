unit ServerMethods;

interface

uses System.SysUtils, System.Classes, System.JSON, Rest.JSON,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, Pessoa, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Rest.Response.Adapter, DMConsultaCEP,
  Vcl.ExtCtrls, Principal, dmConexao;

type
  TServerMethods = class(TDSServerModule)
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
    procedure FDQPessoaAfterPost(DataSet: TDataSet);
    procedure FDQEnderecoAfterPost(DataSet: TDataSet);
    procedure FDQPessoaAfterDelete(DataSet: TDataSet);
    procedure FDQEnderecoAfterDelete(DataSet: TDataSet);
    procedure FDQEnderecoIntegracaoAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    procedure convertJsonParaDataset(DataSet: TDataSet; JSON: String);
    function retornaProximoId(campo, tabela: String): integer;

  public
    { Public declarations }

    function Pessoas: String;
    function updatePessoas(objPessoa: TJSonObject): TJSONValue;
    function acceptPessoas(objPessoa: TJSonObject): TJSONValue;
    function cancelPessoas(idPessoa: integer): TJSONValue;
    function updateInsertEmLote(jsonPessoas: TJSONArray): TJSONValue;

  end;

implementation

{$R *.dfm}

{ TServerMethods }
// alterando pessoa
function TServerMethods.acceptPessoas(objPessoa: TJSonObject): TJSONValue;
var
  Pessoa: TPessoa;
begin

  Pessoa := TPessoa.Create();
  try
    frmPrincipal.ligaDesligaThread := false;

    Pessoa := TJson.JsonToObject<TPessoa>(objPessoa.ToJSON);

    FDQPessoa.Close;
    FDQPessoa.ParamByName('idpessoa').AsInteger := Pessoa.idPessoa;
    FDQPessoa.Open();
    if FDQPessoa.RecordCount > 0 then
    begin

      try
        dmdConexao.conexao.StartTransaction;
        FDQPessoa.Edit;
        FDQPessoa.FieldByName('flnatureza').AsInteger := Pessoa.flnatureza;
        FDQPessoa.FieldByName('dsdocumento').AsString := Pessoa.dsdocumento;
        FDQPessoa.FieldByName('nmprimeiro').AsString := Pessoa.nmprimeiro;
        FDQPessoa.FieldByName('nmsegundo').AsString := Pessoa.nmsegundo;
        FDQPessoa.FieldByName('dtregistro').AsDateTime := Pessoa.dtregistro;
        FDQPessoa.Post;

        FDQEndereco.Close;
        FDQEndereco.ParamByName('idpessoa').AsInteger := Pessoa.idPessoa;
        FDQEndereco.Open();

        FDQEndereco.Edit;
        FDQEndereco.FieldByName('idpessoa').AsInteger :=
          FDQPessoa.FieldByName('idpessoa').AsInteger;
        FDQEndereco.FieldByName('dscep').AsString := Pessoa.endereco.dscep;
        FDQEndereco.Post;

        Result := TJSONString.Create('Pessoa Alterada com sucesso id : ' +
          FDQPessoa.FieldByName('idpessoa').AsString);
        dmdConexao.conexao.Commit;
      Except
        dmdConexao.conexao.Rollback;
        Result := TJSONString.Create('Erro ao Alterar Pessoa ');
      end;

    end;

  finally
    Pessoa.Free;
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

end;

function TServerMethods.cancelPessoas(idPessoa: integer): TJSONValue;
begin

  try
    frmPrincipal.ligaDesligaThread := false;
    FDQPessoa.Close;
    FDQPessoa.ParamByName('idpessoa').AsInteger := idPessoa;
    FDQPessoa.Open();
    if FDQPessoa.RecordCount > 0 then
    begin

      try
        dmdConexao.conexao.StartTransaction;
        FDQEndereco.Close;
        FDQEndereco.ParamByName('idpessoa').AsInteger := idPessoa;
        FDQEndereco.Open();
        if FDQEndereco.RecordCount > 0 then
        begin
          FDQEnderecoIntegracao.Close;
          FDQEnderecoIntegracao.ParamByName('idendereco').AsInteger :=
            FDQEndereco.FieldByName('idendereco').AsInteger;
          FDQEnderecoIntegracao.Open;
          if FDQEnderecoIntegracao.RecordCount > 0 then
            FDQEnderecoIntegracao.Delete;
          FDQEndereco.Delete;
        end;
        FDQPessoa.Delete;
        Result := TJSONString.Create('Pessoa Excluida com sucesso id : ' +
           IntToStr(idPessoa));
        dmdConexao.conexao.Commit;
      Except
        dmdConexao.conexao.Rollback;
        Result := TJSONString.Create('Erro ao Excluida Pessoa ');
      end;

    end;

  finally
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

end;

procedure TServerMethods.convertJsonParaDataset(DataSet: TDataSet;
  JSON: String);
var
  JObj: TJSONArray;
  vConv: TCustomJSONDataSetAdapter;
begin
  if (JSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSonObject.ParseJSONValue(JSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.DataSet := DataSet;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;

end;

function TServerMethods.Pessoas: String;
var
  jsonRetorno: String;
  LJsonArr: TJSONArray;
  Pessoa: TPessoa;
  ObjJSon: TJSonObject;

begin
  FDQDadosPessoa.Close;
  FDQDadosPessoa.Open();

  if FDQDadosPessoa.RecordCount > 0 then
  begin
    LJsonArr := TJSONArray.Create();
    ObjJSon := TJSonObject.Create;
    try
      FDQDadosPessoa.First;
      while not FDQDadosPessoa.Eof do
      begin
        Pessoa := TPessoa.Create();
        try
          Pessoa.idPessoa := FDQDadosPessoa.FieldByName('idPessoa').AsInteger;
          Pessoa.flnatureza := FDQDadosPessoa.FieldByName('flnatureza')
            .AsInteger;
          Pessoa.dsdocumento := FDQDadosPessoa.FieldByName
            ('dsdocumento').AsString;
          Pessoa.nmprimeiro := FDQDadosPessoa.FieldByName('nmprimeiro')
            .AsString;
          Pessoa.nmsegundo := FDQDadosPessoa.FieldByName('nmsegundo').AsString;
          Pessoa.dtregistro := FDQDadosPessoa.FieldByName('dtregistro')
            .AsDateTime;
          Pessoa.endereco.idEndereco := FDQDadosPessoa.FieldByName('idEndereco')
            .AsInteger;
          Pessoa.endereco.idPessoa := FDQDadosPessoa.FieldByName('idPessoa')
            .AsInteger;
          Pessoa.endereco.dscep := FDQDadosPessoa.FieldByName('dscep').AsString;
          Pessoa.endereco.endIntegracao.cep :=
            FDQDadosPessoa.FieldByName('dscep').AsString;
          Pessoa.endereco.endIntegracao.logradouro :=
            FDQDadosPessoa.FieldByName('nmlogradouro').AsString;
          Pessoa.endereco.endIntegracao.complemento :=
            FDQDadosPessoa.FieldByName('dscomplemento').AsString;
          Pessoa.endereco.endIntegracao.bairro :=
            FDQDadosPessoa.FieldByName('nmbairro').AsString;
          Pessoa.endereco.endIntegracao.localidade :=
            FDQDadosPessoa.FieldByName('nmcidade').AsString;
          Pessoa.endereco.endIntegracao.uf := FDQDadosPessoa.FieldByName
            ('dsuf').AsString;
          Pessoa.endereco.endIntegracao.ibge := '';
          Pessoa.endereco.endIntegracao.gia := '';
          Pessoa.endereco.endIntegracao.ddd := '';
          Pessoa.endereco.endIntegracao.siafi := '';

          ObjJSon := TJson.ObjectToJsonObject(Pessoa);
          LJsonArr.AddElement(ObjJSon);
        finally
          Pessoa.Free;
        end;

        FDQDadosPessoa.Next;
      end;

      Result := LJsonArr.ToString;

    finally
      FreeAndNil(LJsonArr);
    end;
  end
  else
    Result := '';
end;

function TServerMethods.retornaProximoId(campo, tabela: String): integer;
var
  sql: String;
begin
  sql := 'select coalesce(max(' + campo + '),0) as count from ' + tabela;
  FDQAux.Close;
  FDQAux.sql.Clear;
  FDQAux.sql.Add(sql);
  FDQAux.Open();

  if FDQAux.RecordCount > 0 then
  begin
    Result := FDQAux.FieldByName('count').AsInteger + 1;
  end
  else
    Result := 1;
end;

// inserindo pessoa
function TServerMethods.updatePessoas(objPessoa: TJSonObject): TJSONValue;
var
  Pessoa: TPessoa;
begin

  Pessoa := TPessoa.Create();
  try
    frmPrincipal.ligaDesligaThread := false;

    try
      FDQPessoa.Close;
      FDQPessoa.ParamByName('idpessoa').AsInteger := -1;
      FDQPessoa.Open();
      Pessoa := TJson.JsonToObject<TPessoa>(objPessoa.ToJSON);

      dmdConexao.conexao.StartTransaction;
      FDQPessoa.Insert;
      FDQPessoa.FieldByName('idpessoa').AsInteger :=
        retornaProximoId('idpessoa', 'pessoa');
      FDQPessoa.FieldByName('flnatureza').AsInteger := Pessoa.flnatureza;
      FDQPessoa.FieldByName('dsdocumento').AsString := Pessoa.dsdocumento;
      FDQPessoa.FieldByName('nmprimeiro').AsString := Pessoa.nmprimeiro;
      FDQPessoa.FieldByName('nmsegundo').AsString := Pessoa.nmsegundo;
      FDQPessoa.FieldByName('dtregistro').AsDateTime := Pessoa.dtregistro;
      FDQPessoa.Post;

      FDQEndereco.Close;
      FDQEndereco.ParamByName('idpessoa').AsInteger :=
        FDQPessoa.FieldByName('idpessoa').AsInteger;
      FDQEndereco.Open();
      FDQEndereco.Insert;
      FDQEndereco.FieldByName('idendereco').AsInteger :=
        retornaProximoId('idendereco', 'endereco');
      FDQEndereco.FieldByName('idpessoa').AsInteger :=
        FDQPessoa.FieldByName('idpessoa').AsInteger;
      FDQEndereco.FieldByName('dscep').AsString := Pessoa.endereco.dscep;
      FDQEndereco.Post;

      Result := TJSONString.Create('Pessoa cadastrada com sucesso id : ' +
        FDQPessoa.FieldByName('idpessoa').AsString);
      dmdConexao.conexao.Commit;
    Except
      dmdConexao.conexao.Rollback;
      Result := TJSONString.Create('Erro ao cadastrar Pessoa ');
    end;

  finally
    Pessoa.Free;
    FDQPessoa.Close;
    frmPrincipal.ligaDesligaThread := true;
  end;

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
var
  Pessoa: TPessoa;
  i: integer;
  jp, jSubPar: TJSONPair;
  contadorPessoa, contadorEndereco: integer;
begin

  try
    contadorPessoa := retornaProximoId('idpessoa', 'pessoa');
    contadorEndereco := retornaProximoId('idendereco', 'endereco');

    FDQInserePessoaEmLote.Params.ArraySize := jsonPessoas.Count;
    FDQInsereEnderecoEmLote.Params.ArraySize := jsonPessoas.Count;

    for i := 0 to jsonPessoas.Count - 1 do
    begin
      Pessoa := TJson.JsonToObject<TPessoa>(jsonPessoas.Get(i).ToString);
      FDQInserePessoaEmLote.ParamByName('idpessoa').AsIntegers[i] :=
        contadorPessoa;
      FDQInserePessoaEmLote.ParamByName('flnatureza').AsIntegers[i] :=
        Pessoa.flnatureza;
      FDQInserePessoaEmLote.ParamByName('dsdocumento').AsStrings[i] :=
        Pessoa.dsdocumento;
      FDQInserePessoaEmLote.ParamByName('nmprimeiro').AsStrings[i] :=
        Pessoa.nmprimeiro;
      FDQInserePessoaEmLote.ParamByName('nmsegundo').AsStrings[i] :=
        Pessoa.nmsegundo;
      FDQInserePessoaEmLote.ParamByName('dtregistro').AsDateTimes[i] :=
        Pessoa.dtregistro;
      if Pessoa.endereco.dscep <> '' then
      begin
        FDQInsereEnderecoEmLote.ParamByName('idendereco').AsIntegers[i] :=
          contadorEndereco;
        FDQInsereEnderecoEmLote.ParamByName('idpessoa').AsIntegers[i] :=
          contadorPessoa;
        FDQInsereEnderecoEmLote.ParamByName('dscep').AsStrings[i] :=
          Pessoa.endereco.dscep;
      end;

      inc(contadorPessoa);
      inc(contadorEndereco);
    end;

    dmdConexao.conexao.StartTransaction;
    try
      FDQInserePessoaEmLote.Execute(i, 0);
      FDQInsereEnderecoEmLote.Execute(i, 0);
      dmdConexao.conexao.Commit;
    Except
      dmdConexao.conexao.Rollback;
    end;
  finally
    Pessoa.Free;
  end;

end;

end.
