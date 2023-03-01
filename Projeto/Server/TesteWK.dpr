program TesteWK;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Principal in 'Principal.pas' {frmPrincipal},
  ServerMethods in 'ServerMethods.pas' {ServerMethods1: TDSServerModule},
  ServerContainer in 'ServerContainer.pas' {ServerContainer1: TDataModule},
  WebModule in 'WebModule.pas' {WebModule1: TWebModule},
  Pessoa in '..\classes\Pessoa.pas',
  Endereco in '..\classes\Endereco.pas',
  DMConsultaCEP in 'DMConsultaCEP.pas' {DMCEP: TDataModule},
  EnderecoIntegracao in '..\classes\EnderecoIntegracao.pas',
  dmConexao in 'dmConexao.pas' {conexao: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(Tconexao, conexao);
  Application.CreateForm(TDMCEP, DMCEP);
  Application.Run;

end.
