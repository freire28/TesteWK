unit CadPessoaLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Pessoa,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Rest.Json, System.JSON;

type
  TfrmCadPessoaLote = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    OpenDialog1: TOpenDialog;
    FDMemTable: TFDMemTable;
    FDMemTableidpessoa: TIntegerField;
    FDMemTableflnatureza: TIntegerField;
    FDMemTabledsdocumento: TStringField;
    FDMemTablenmprimeiro: TStringField;
    FDMemTablenmsegundo: TStringField;
    FDMemTabledtregistro: TDateTimeField;
    FDMemTableidendereco: TIntegerField;
    FDMemTabledscep: TStringField;
    dsPessoa: TDataSource;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Panel4: TPanel;
    lbResultado: TLabel;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadPessoaLote: TfrmCadPessoaLote;

implementation

{$R *.dfm}

procedure TfrmCadPessoaLote.Button1Click(Sender: TObject);
var lista,lista2:TStringList;

    i,j:integer;
    pessoa:TPessoa;
  MyClass: TComponent;
begin
  // Carregando o arquivo ...

  FDMemTable.EmptyDataSet;
  OpenDialog1.Execute;

  if FileExists(OpenDialog1.FileName) then
  begin

    lista  := TStringList.Create;
    lista2 := TStringList.Create;
    try
      lista.LoadFromFile(OpenDialog1.FileName) ;
      lista2.Delimiter := ';';
      lista2.StrictDelimiter := true;

      for i := 0 to pred(lista.count) do
      begin
        lista2.DelimitedText := lista.Strings[i];

        FDMemTable.Insert;
        FDMemTable.FieldByName('idpessoa').AsInteger := -1;
        FDMemTable.FieldByName('flnatureza').AsInteger := StrToInt(lista2.Strings[0]);
        FDMemTable.FieldByName('dsdocumento').AsString := lista2.Strings[1];
        FDMemTable.FieldByName('nmprimeiro').AsString := lista2.Strings[2];
        FDMemTable.FieldByName('nmsegundo').AsString := lista2.Strings[3];
        FDMemTable.FieldByName('dtregistro').AsDateTime := now();
        FDMemTable.FieldByName('idendereco').AsInteger := -1;
        FDMemTable.FieldByName('dscep').AsString := lista2.Strings[4];
        FDMemTable.Post;

      end;

    finally
      lista.Free;
      lista2.Free;
    end;

  end;

end;

procedure TfrmCadPessoaLote.Button2Click(Sender: TObject);
var    LJsonArr   : TJSONArray;
    pessoa:TPessoa;
    ObjJSon:TJSONObject;
begin
 if FDMemTable.RecordCount > 0 then
  begin
    LJsonArr := TJSONArray.Create();
    ObjJSon:=TJSONObject.Create;
    try
      FDMemTable.First;
      while not FDMemTable.Eof do
      begin
        pessoa := TPessoa.Create();
        try
          pessoa.idPessoa :=  -1;
          pessoa.flnatureza  := FDMemTable.FieldByName('flnatureza').AsInteger;
          pessoa.dsdocumento := FDMemTable.FieldByName('dsdocumento').AsString;
          pessoa.nmprimeiro  := FDMemTable.FieldByName('nmprimeiro').AsString;
          pessoa.nmsegundo   := FDMemTable.FieldByName('nmsegundo').AsString;
          pessoa.dtregistro  := FDMemTable.FieldByName('dtregistro').AsDateTime;
          pessoa.endereco.idEndereco := -1;
          pessoa.endereco.idPessoa   := FDMemTable.FieldByName('idPessoa').AsInteger;
          pessoa.endereco.dscep     := FDMemTable.FieldByName('dscep').AsString;
          pessoa.endereco.endIntegracao.cep := '';
          pessoa.endereco.endIntegracao.logradouro :=  '';
          pessoa.endereco.endIntegracao.complemento  :=  '';
          pessoa.endereco.endIntegracao.bairro :=  '';
          pessoa.endereco.endIntegracao.localidade :=  '';
          pessoa.endereco.endIntegracao.uf :=  '';
          pessoa.endereco.endIntegracao.ibge :=  '';
          pessoa.endereco.endIntegracao.gia :=  '';
          pessoa.endereco.endIntegracao.ddd :=  '';
          pessoa.endereco.endIntegracao.siafi :=  '';

          ObjJSon := TJson.ObjectToJsonObject(pessoa);
          LJsonArr.AddElement(ObjJSon);
        finally
          pessoa.Free;
        end;

        FDMemTable.Next;
      end;

     RESTRequest1.AddBody(LJsonArr.ToString, ContentTypeFromString('application/json'));
     try
       RESTRequest1.Execute;
     except on e:Exception do
       raise exception.Create(e.Message);
     end;

    finally
      FreeAndNil(LJsonArr);
    end;
  end;

end;

procedure TfrmCadPessoaLote.FormShow(Sender: TObject);
begin
  FDMemTable.CreateDataSet;
end;

end.
