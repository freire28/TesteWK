unit CadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids,REST.Json,System.JSON, Pessoa, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors;

type
  TfrmCadPessoa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable: TFDMemTable;
    FDMemTableidpessoa: TIntegerField;
    FDMemTableflnatureza: TIntegerField;
    FDMemTabledsdocumento: TStringField;
    FDMemTablenmprimeiro: TStringField;
    FDMemTablenmsegundo: TStringField;
    FDMemTabledtregistro: TDateTimeField;
    FDMemTableidendereco: TIntegerField;
    FDMemTabledscep: TStringField;
    FDMemTabledsuf: TStringField;
    FDMemTablenmcidade: TStringField;
    FDMemTablenmbairro: TStringField;
    FDMemTablenmlogradouro: TStringField;
    FDMemTabledscomplemento: TStringField;
    DBECodigo: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    dbeNome: TDBEdit;
    dbeDocumento: TDBEdit;
    dbeSobrenome: TDBEdit;
    dtpDataCadastro: TDateTimePicker;
    dsPessoa: TDataSource;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnCancelar: TButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Timer1: TTimer;
    Panel4: TPanel;
    lbResultado: TLabel;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    procedure FormShow(Sender: TObject);
    procedure dsPessoaStateChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FDMemTableAfterPost(DataSet: TDataSet);
    procedure FDMemTableAfterScroll(DataSet: TDataSet);
    procedure FDMemTableBeforeEdit(DataSet: TDataSet);
    procedure btnExcluirClick(Sender: TObject);
  private
    Fpodecarregardados: boolean;
    Finserindoalterando: boolean;
    { Private declarations }
    procedure carregaRestClient(metodo:String);
    procedure carregadados;
    procedure Setpodecarregardados(const Value: boolean);
    procedure Setinserindoalterando(const Value: boolean);
    property podecarregardados:boolean read Fpodecarregardados write Setpodecarregardados;
    property inserindoalterando :boolean  read Finserindoalterando write Setinserindoalterando;

  public
    { Public declarations }
  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation

{$R *.dfm}

procedure TfrmCadPessoa.btnAlterarClick(Sender: TObject);
begin
  inserindoalterando := true;
  podecarregardados := false;
  FDMemTable.Edit;
  carregaRestClient('PUT');
  dtpDataCadastro.DateTime := now();
end;

procedure TfrmCadPessoa.btnCancelarClick(Sender: TObject);
begin
  FDMemTable.Cancel;
  podecarregardados := true;
  inserindoalterando := false;
end;

procedure TfrmCadPessoa.btnExcluirClick(Sender: TObject) ;
begin
  carregaRestClient('DELETE');
  // RESTRequest1.Resource := '/Pessoa/{id}' ;
  RESTRequest1.Params.AddUrlSegment('id', FDMemTable.FieldByName('idpessoa').AsString);
  RESTRequest1.Execute;
  carregadados;
end;

procedure TfrmCadPessoa.btnNovoClick(Sender: TObject);
begin
  inserindoalterando := true;
  podecarregardados := false;
  FDMemTable.Insert;
  carregaRestClient('POST');
  dtpDataCadastro.DateTime := now();
end;

procedure TfrmCadPessoa.btnSalvarClick(Sender: TObject);
var pessoa :TPessoa;
begin
  FDMemTable.FieldByName('dtregistro').AsDateTime := dtpDataCadastro.DateTime;
  FDMemTable.Post;
  podecarregardados := true;
  inserindoalterando := false;
end;

procedure TfrmCadPessoa.carregadados;
var jsonobject:TJSonObject;
    jsonArray:TJSONArray;
    jsonString:String;
    pessoa:TPessoa;
    i : integer;
begin
  FDMemTable.EmptyDataSet;
  carregaRestClient('GET');
  RESTRequest1.Execute;

  jsonobject := RESTResponse1.JSONValue as TJSONObject;

  // nao sei pq esta tazendo lixo no json ai tive que fazer esse ajuste
  jsonString := jsonobject.ToString;
  jsonString := stringReplace(jsonString,'{"result":"[','[',[]);
  jsonString := stringReplace(jsonString,']"}',']',[]);
  jsonString := stringReplace(jsonString,'\','',[rfReplaceAll]);
  jsonArray :=  TJSONObject.ParseJSONValue(jsonString) as TJSONArray;

   for i := 0 to jsonArray.Count -1  do
   begin
     pessoa := TJson.JsonToObject<Tpessoa>(jsonArray.Get(i).ToString);
     try
       FDMemTable.Insert;
       FDMemTable.FieldByName('idpessoa').AsInteger := pessoa.idPessoa;
       FDMemTable.FieldByName('flnatureza').AsInteger := pessoa.flnatureza;
       FDMemTable.FieldByName('dsdocumento').AsString := pessoa.dsdocumento;
       FDMemTable.FieldByName('nmprimeiro').AsString := pessoa.nmprimeiro;
       FDMemTable.FieldByName('nmsegundo').AsString := pessoa.nmsegundo;
       FDMemTable.FieldByName('dtregistro').AsDateTime := pessoa.dtregistro;
       FDMemTable.FieldByName('idendereco').AsInteger := pessoa.endereco.idEndereco;
       FDMemTable.FieldByName('dscep').AsString := pessoa.endereco.dscep;
       FDMemTable.FieldByName('dsuf').AsString := pessoa.endereco.endIntegracao.uf;
       FDMemTable.FieldByName('nmcidade').AsString := pessoa.endereco.endIntegracao.localidade;
       FDMemTable.FieldByName('nmbairro').AsString := pessoa.endereco.endIntegracao.bairro;
       FDMemTable.FieldByName('nmlogradouro').AsString := pessoa.endereco.endIntegracao.logradouro;
       FDMemTable.FieldByName('dscomplemento').AsString := pessoa.endereco.endIntegracao.complemento;
       FDMemTable.Post;
     finally
       pessoa.Free;
     end;

   end;

   FDMemTable.First;
   lbResultado.Caption := '';
end;

procedure TfrmCadPessoa.carregaRestClient(metodo:String);
begin
  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTClient1.BaseURL := 'http://localhost:211/datasnap/rest/TServerMethods/Pessoas';
  if metodo = 'GET'  then
    RESTRequest1.Method := TRESTRequestMethod.rmGET;
      if metodo = 'POST'  then
        RESTRequest1.Method := TRESTRequestMethod.rmPOST;
          if metodo = 'PUT'  then
            RESTRequest1.Method := TRESTRequestMethod.rmPUT;
              if metodo = 'DELETE'  then
                RESTRequest1.Method := TRESTRequestMethod.rmDELETE;
end;

procedure TfrmCadPessoa.dsPessoaStateChange(Sender: TObject);
begin
 btnNovo.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnSalvar.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancelar.Enabled := btnSalvar.Enabled;
   btnAlterar.Enabled := (btnNovo.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnExcluir.Enabled := btnAlterar.Enabled;
end;

procedure TfrmCadPessoa.FDMemTableAfterPost(DataSet: TDataSet);
var pessoa: TPessoa;
    ObjJSon :TJsonObject;
begin

  if inserindoalterando then
  begin
    pessoa := TPessoa.Create;
    try

      pessoa.idPessoa := FDMemTable.FieldByName('idpessoa').AsInteger ;
      pessoa.endereco.idEndereco := FDMemTable.FieldByName('idEndereco').AsInteger ;
      pessoa.flnatureza  := FDMemTable.FieldByName('flnatureza').AsInteger;
      pessoa.dsdocumento := FDMemTable.FieldByName('dsdocumento').AsString;
      pessoa.nmprimeiro  := FDMemTable.FieldByName('nmprimeiro').AsString;
      pessoa.nmsegundo   := FDMemTable.FieldByName('nmsegundo').AsString;
      pessoa.dtregistro  := FDMemTable.FieldByName('dtregistro').AsDateTime;
      pessoa.endereco.dscep := FDMemTable.FieldByName('dscep').AsString;
      ObjJSon := TJson.ObjectToJsonObject(pessoa);
      RESTRequest1.AddBody(ObjJSon.ToString, ContentTypeFromString('application/json'));
      RESTRequest1.Execute;
    finally
      pessoa.Free;
    end;
  end;

end;

procedure TfrmCadPessoa.FDMemTableAfterScroll(DataSet: TDataSet);
begin
  dtpDataCadastro.DateTime := FDMemTable.FieldByName('dtregistro').AsDateTime;
end;

procedure TfrmCadPessoa.FDMemTableBeforeEdit(DataSet: TDataSet);
begin
  inserindoalterando := true;
  carregaRestClient('PUT');
end;

procedure TfrmCadPessoa.FormShow(Sender: TObject);
begin
  FDMemTable.CreateDataSet;
  carregadados;
  inserindoalterando := false;
//  dtpDataCadastro.DateTime := now();
end;

procedure TfrmCadPessoa.Setinserindoalterando(const Value: boolean);
begin
  Finserindoalterando := Value;
end;

procedure TfrmCadPessoa.Setpodecarregardados(const Value: boolean);
begin
  Fpodecarregardados := Value;
end;

procedure TfrmCadPessoa.Timer1Timer(Sender: TObject);
begin
  if podecarregardados then
    carregadados;
end;

end.
