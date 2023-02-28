unit principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, CadPessoa,
  CadPessoaLote;

type
  TForm5 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Pessoa1: TMenuItem;
    CadastroemLote1: TMenuItem;
    procedure Pessoa1Click(Sender: TObject);
    procedure CadastroemLote1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.CadastroemLote1Click(Sender: TObject);
var frmCadPessoaLote : TfrmCadPessoaLote;
begin
  Application.CreateForm(TfrmCadPessoaLote,frmCadPessoaLote);
  frmCadPessoaLote.ShowModal;
  frmCadPessoaLote.free;
end;

procedure TForm5.Pessoa1Click(Sender: TObject);
var frmCadPessoa : TfrmCadPessoa;
begin
  Application.CreateForm(TfrmCadPessoa,frmCadPessoa);
  frmCadPessoa.ShowModal;
  frmCadPessoa.free;
end;

end.
