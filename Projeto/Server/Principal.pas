unit Principal;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, IdGlobal, Web.HTTPApp,
  Vcl.ExtCtrls, DMConsultaCEP;

type
  TDBThread = class(TThread)
  protected
    procedure Execute; override;
  end;

type
  TfrmPrincipal = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    TimerThread: TTimer;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure TimerThreadTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    FligaDesligaThread: Boolean;
    procedure StartServer;
    procedure SetligaDesligaThread(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property ligaDesligaThread: Boolean read FligaDesligaThread
      write SetligaDesligaThread;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TfrmPrincipal.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TfrmPrincipal.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TfrmPrincipal.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TfrmPrincipal.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TfrmPrincipal.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    TimerThread.Enabled := true
  else
    TimerThread.Enabled := False;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  ligaDesligaThread := true;
end;

procedure TfrmPrincipal.SetligaDesligaThread(const Value: Boolean);
begin
  FligaDesligaThread := Value;
end;

procedure TfrmPrincipal.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := true;
  end;
end;

procedure TfrmPrincipal.TimerThreadTimer(Sender: TObject);
var
  oThread1: TDBThread;
begin
  if ligaDesligaThread then
  begin
    oThread1 := TDBThread.Create(False);
    oThread1.WaitFor;
    oThread1.Free;
  end;
end;

{ TDBThread }

procedure TDBThread.Execute;
// var dm:TDMCEP ;
begin

  FreeOnTerminate := False;

  // dm := TDMCEP.Create(nil);
  try
    DMCEP.ConsultaCEP;
  finally
    // FreeAndNil(dm);
  end;

end;

end.
