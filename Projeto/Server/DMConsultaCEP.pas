unit DMConsultaCEP;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client, REST.Json,
  System.Json,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, EnderecoIntegracao, dmConexao;

type
  TDMCEP = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    FDQAuxCEP1: TFDQuery;
    FDQEnderecoIntegracao: TFDQuery;
    FDQEnderecoIntegracaoidendereco: TLargeintField;
    FDQEnderecoIntegracaodsuf: TWideStringField;
    FDQEnderecoIntegracaonmcidade: TWideStringField;
    FDQEnderecoIntegracaonmbairro: TWideStringField;
    FDQEnderecoIntegracaonmlogradouro: TWideStringField;
    FDQEnderecoIntegracaodscomplemento: TWideStringField;
  private
    { Private declarations }
    function buscadadosCep(cep: String): TJSONObject;
  public
    { Public declarations }
    procedure ConsultaCEP;
  end;

var
  DMCEP: TDMCEP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

function TDMCEP.buscadadosCep(cep: String): TJSONObject;
const
  url = 'https://viacep.com.br/ws/%s/json';
var
  jsonobject: TJSONObject;

begin
  RESTClient1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTClient1.BaseURL := format(url, [cep]);
  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  RESTRequest1.Execute;
  jsonobject := RESTResponse1.JSONValue as TJSONObject;
  result := jsonobject;
end;

procedure TDMCEP.ConsultaCEP;
var
  jsonobject: TJSONObject;
  endereco: TEnderecoIntegracao;
begin

  FDQAuxCEP1.Close;
  FDQAuxCEP1.SQL.Clear;
  FDQAuxCEP1.SQL.Add
    ('select a.idendereco, a.dscep from endereco a where a.idendereco not in (select b.idendereco from endereco_integracao b)');
  FDQAuxCEP1.Open();

  if FDQAuxCEP1.RecordCount > 0 then
  begin
    FDQAuxCEP1.First;

    while not FDQAuxCEP1.Eof do
    begin
      jsonobject := TJSONObject.Create(nil);
      endereco := TEnderecoIntegracao.Create;
      try
        jsonobject := buscadadosCep(FDQAuxCEP1.FieldByName('dscep').AsString);
        // jsonPair := jsonobject.Get(0);
        // jsonArray :=  jsonPair.JsonValue as TJSONArray;
        endereco := TJson.JsonToObject<TEnderecoIntegracao>(jsonobject.ToJSON);

        FDQEnderecoIntegracao.Close;
        FDQEnderecoIntegracao.Open();

        FDQEnderecoIntegracao.Insert;
        FDQEnderecoIntegracao.FieldByName('idendereco').AsInteger :=
          FDQAuxCEP1.FieldByName('idendereco').AsInteger;
        FDQEnderecoIntegracao.FieldByName('dsuf').AsString := endereco.uf;
        FDQEnderecoIntegracao.FieldByName('nmcidade').AsString :=
          endereco.localidade;
        FDQEnderecoIntegracao.FieldByName('nmbairro').AsString :=
          endereco.bairro;
        FDQEnderecoIntegracao.FieldByName('nmlogradouro').AsString :=
          endereco.logradouro;
        FDQEnderecoIntegracao.FieldByName('dscomplemento').AsString :=
          endereco.complemento;
        FDQEnderecoIntegracao.Post;
        FDQEnderecoIntegracao.ApplyUpdates(0);
      finally
        jsonobject.Free;
        endereco.Free;
      end;

      FDQAuxCEP1.Next;
    end;
  end;
end;

end.
