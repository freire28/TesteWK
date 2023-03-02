object frmPrincipal: TfrmPrincipal
  Left = 271
  Top = 114
  Caption = 'Servidor WK'
  ClientHeight = 88
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 42
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 107
    Height = 25
    Caption = 'Iniciar Servidor'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 137
    Top = 8
    Width = 112
    Height = 25
    Caption = 'Parar Servidor '
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 64
    Top = 39
    Width = 43
    Height = 21
    TabOrder = 2
    Text = '211'
  end
  object CheckBox1: TCheckBox
    Left = 137
    Top = 39
    Width = 176
    Height = 17
    Caption = 'ThRead Atualiza Endere'#231'o'
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 304
    Top = 8
  end
  object TimerThread: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerThreadTimer
    Left = 248
  end
end
