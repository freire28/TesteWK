object frmCadPessoaLote: TfrmCadPessoaLote
  Left = 0
  Top = 0
  Caption = 'Frm. Importar Arquivo'
  ClientHeight = 535
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 773
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 24
      Top = 10
      Width = 169
      Height = 25
      Caption = 'Carregar Arquivo'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 208
      Top = 10
      Width = 169
      Height = 25
      Caption = 'Gravar informa'#231#245'es'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 773
    Height = 494
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 771
      Height = 469
      Align = alClient
      DataSource = dsPessoa
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'flnatureza'
          Title.Caption = 'Natureza'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dsdocumento'
          Title.Caption = 'Documento'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmprimeiro'
          Title.Caption = 'Primeiro Nome'
          Width = 166
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmsegundo'
          Title.Caption = 'Segundo Nome'
          Width = 193
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtregistro'
          Title.Caption = 'Data Registro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscep'
          Title.Caption = 'CEP'
          Width = 97
          Visible = True
        end>
    end
    object Panel4: TPanel
      Left = 1
      Top = 470
      Width = 771
      Height = 23
      Align = alBottom
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 501
      ExplicitWidth = 585
      object lbResultado: TLabel
        Left = 13
        Top = 1
        Width = 4
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 241
  end
  object FDMemTable: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 433
    Top = 108
    object FDMemTableidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object FDMemTableflnatureza: TIntegerField
      FieldName = 'flnatureza'
    end
    object FDMemTabledsdocumento: TStringField
      FieldName = 'dsdocumento'
    end
    object FDMemTablenmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Size = 60
    end
    object FDMemTablenmsegundo: TStringField
      FieldName = 'nmsegundo'
      Size = 60
    end
    object FDMemTabledtregistro: TDateTimeField
      FieldName = 'dtregistro'
    end
    object FDMemTableidendereco: TIntegerField
      FieldName = 'idendereco'
    end
    object FDMemTabledscep: TStringField
      FieldName = 'dscep'
    end
  end
  object dsPessoa: TDataSource
    DataSet = FDMemTable
    Left = 465
    Top = 108
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost:211/datasnap/rest/TServerMethods/InsertEmLote'
    Params = <>
    Left = 520
    Top = 184
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body387DE3BA91774B08BE5B0A7B8C16BF60'
        Value = 
          '['#13#10'  {'#13#10'    "idPessoa":1,'#13#10'    "flnatureza": 0,'#13#10'    "nmprimeiro' +
          '": "DENIS",'#13#10'    "dtregistro": "2023-02-25T23:01:39.584Z",'#13#10'    ' +
          '"nmsegundo": "Almeida",'#13#10'    "dsdocumento": "CPF",'#13#10'    "enderec' +
          'o": {'#13#10'      "idEndereco": 1,'#13#10'      "dscep": "86808030",'#13#10'     ' +
          ' "idPessoa": 1'#13#10'    }'#13#10'  },'#13#10'  {'#13#10'    "idPessoa": 2,'#13#10'    "flnat' +
          'ureza": 0,'#13#10'    "nmprimeiro": "DENIS",'#13#10'    "dtregistro": "2023-' +
          '02-25T23:01:39.584Z",'#13#10'    "nmsegundo": "Almeida",'#13#10'    "dsdocum' +
          'ento": "CPF",'#13#10'    "endereco": {'#13#10'      "idEndereco": 2,'#13#10'      ' +
          '"dscep": "86808030",'#13#10'      "idPessoa": 2'#13#10'    }'#13#10'  }'#13#10']'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    Left = 456
    Top = 184
  end
  object RESTResponse1: TRESTResponse
    Left = 488
    Top = 184
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 500
    Top = 109
    object LinkPropertyToFieldCaption: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = RESTResponse1
      FieldName = 'Content'
      Component = lbResultado
      ComponentProperty = 'Caption'
    end
  end
end
