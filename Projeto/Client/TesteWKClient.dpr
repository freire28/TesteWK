program TesteWKClient;

uses
  Vcl.Forms,
  principal in 'principal.pas' {Form5},
  CadPessoa in 'CadPessoa.pas' {frmCadPessoa},
  Pessoa in '..\classes\Pessoa.pas',
  Endereco in '..\classes\Endereco.pas',
  EnderecoIntegracao in '..\classes\EnderecoIntegracao.pas',
  CadPessoaLote in 'CadPessoaLote.pas' {frmCadPessoaLote};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TfrmCadPessoa, frmCadPessoa);
  Application.CreateForm(TfrmCadPessoaLote, frmCadPessoaLote);
  Application.Run;
end.
