object frmCadPessoa: TfrmCadPessoa
  Left = 0
  Top = 0
  Caption = 'Cad. Pessoa'
  ClientHeight = 524
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 35
    Align = alTop
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    object btnNovo: TButton
      Left = 8
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnAlterar: TButton
      Left = 84
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 160
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnSalvar: TButton
      Left = 404
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 3
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 479
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 35
    Width = 585
    Height = 466
    Align = alClient
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 583
      Height = 99
      Align = alTop
      Caption = 'Dados Pessoa'
      TabOrder = 0
      object Label1: TLabel
        Left = 29
        Top = 19
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label3: TLabel
        Left = 3
        Top = 72
        Width = 54
        Height = 13
        Caption = 'Documento'
      end
      object Label4: TLabel
        Left = 32
        Top = 46
        Width = 30
        Height = 13
        Caption = 'Nome '
      end
      object Label5: TLabel
        Left = 331
        Top = 46
        Width = 54
        Height = 13
        Caption = 'Sobrenome'
      end
      object Label6: TLabel
        Left = 319
        Top = 18
        Width = 66
        Height = 13
        Caption = 'Data Registro'
      end
      object DBECodigo: TDBEdit
        Left = 77
        Top = 16
        Width = 68
        Height = 21
        DataField = 'idpessoa'
        DataSource = dsPessoa
        Enabled = False
        TabOrder = 0
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 151
        Top = 5
        Width = 153
        Height = 33
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = 'Natureza'
        Columns = 2
        Ctl3D = True
        DataField = 'flnatureza'
        DataSource = dsPessoa
        Items.Strings = (
          'Fisica'
          'Jur'#237'dica')
        ParentCtl3D = False
        TabOrder = 1
        Values.Strings = (
          '0'
          '1')
      end
      object dbeNome: TDBEdit
        Left = 78
        Top = 43
        Width = 226
        Height = 21
        DataField = 'nmprimeiro'
        DataSource = dsPessoa
        TabOrder = 2
      end
      object dbeDocumento: TDBEdit
        Left = 78
        Top = 70
        Width = 68
        Height = 21
        DataField = 'dsdocumento'
        DataSource = dsPessoa
        TabOrder = 3
      end
      object dbeSobrenome: TDBEdit
        Left = 391
        Top = 43
        Width = 162
        Height = 21
        DataField = 'nmsegundo'
        DataSource = dsPessoa
        TabOrder = 4
      end
      object dtpDataCadastro: TDateTimePicker
        Left = 391
        Top = 16
        Width = 162
        Height = 21
        Date = 44985.000000000000000000
        Time = 0.412294097222911700
        TabOrder = 5
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 100
      Width = 583
      Height = 101
      Align = alTop
      Caption = 'Dados Endere'#231'o'
      TabOrder = 1
      object Label2: TLabel
        Left = 53
        Top = 19
        Width = 23
        Height = 13
        Caption = 'CEP.'
      end
      object Label7: TLabel
        Left = 63
        Top = 44
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object Label8: TLabel
        Left = 118
        Top = 44
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label9: TLabel
        Left = 299
        Top = 44
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label10: TLabel
        Left = 21
        Top = 74
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label11: TLabel
        Left = 299
        Top = 74
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label12: TLabel
        Left = 156
        Top = 17
        Width = 127
        Height = 13
        Caption = '* Preencher apenas o CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object DBEdit1: TDBEdit
        Left = 82
        Top = 17
        Width = 68
        Height = 21
        DataField = 'dscep'
        DataSource = dsPessoa
        TabOrder = 0
      end
      object DBEdit3: TDBEdit
        Left = 157
        Top = 44
        Width = 126
        Height = 21
        Color = clMenuBar
        DataField = 'nmcidade'
        DataSource = dsPessoa
        Enabled = False
        TabOrder = 1
      end
      object DBEdit4: TDBEdit
        Left = 368
        Top = 40
        Width = 120
        Height = 21
        Color = clMenuBar
        DataField = 'nmbairro'
        DataSource = dsPessoa
        Enabled = False
        TabOrder = 2
      end
      object DBEdit5: TDBEdit
        Left = 82
        Top = 70
        Width = 201
        Height = 21
        Color = clMenuBar
        DataField = 'nmlogradouro'
        DataSource = dsPessoa
        Enabled = False
        TabOrder = 3
      end
      object DBEdit6: TDBEdit
        Left = 370
        Top = 70
        Width = 118
        Height = 21
        Color = clMenuBar
        DataField = 'dscomplemento'
        DataSource = dsPessoa
        Enabled = False
        TabOrder = 4
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 201
      Width = 583
      Height = 264
      Align = alClient
      TabOrder = 2
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 581
        Height = 262
        Align = alClient
        DataSource = dsPessoa
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'idpessoa'
            Title.Caption = 'C'#243'd.'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'flnatureza'
            Title.Caption = 'Natureza'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dsdocumento'
            Title.Caption = 'Documento'
            Width = 63
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmprimeiro'
            Title.Caption = 'Primeiro Nome'
            Width = 207
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmsegundo'
            Title.Caption = 'Segundo Nome'
            Width = 185
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dtregistro'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'idendereco'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'dscep'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'dsuf'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nmcidade'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nmbairro'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nmlogradouro'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'dscomplemento'
            Visible = False
          end>
      end
    end
  end
  object DBEdit2: TDBEdit
    Left = 83
    Top = 178
    Width = 30
    Height = 21
    Color = clMenuBar
    DataField = 'dsuf'
    DataSource = dsPessoa
    Enabled = False
    TabOrder = 2
  end
  object Panel4: TPanel
    Left = 0
    Top = 501
    Width = 585
    Height = 23
    Align = alBottom
    TabOrder = 3
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
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:211/datasnap/rest/TServerMethods/Pessoas'
    ContentType = 'application/json'
    Params = <>
    Left = 77
    Top = 292
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body74F5134587C549009F6113CB1BE9F988'
        Value = 
          '  {'#13#10'    "idPessoa":1,'#13#10'    "flnatureza": 0,'#13#10'    "nmprimeiro": ' +
          '"DENIS FREIRE DE ALMEIDA",'#13#10'    "dtregistro": "2023-02-25T23:01:' +
          '39.584Z",'#13#10'    "nmsegundo": "Almeida",'#13#10'    "dsdocumento": "RG",' +
          #13#10'    "endereco": {'#13#10'      "idEndereco": 1,'#13#10'      "dscep": "868' +
          '08030",'#13#10'      "idPessoa": 1'#13#10'    }'#13#10'  }'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    Left = 109
    Top = 292
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 141
    Top = 292
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = RESTResponse1
    TypesMode = Rich
    Left = 173
    Top = 292
  end
  object FDMemTable: TFDMemTable
    BeforeEdit = FDMemTableBeforeEdit
    AfterPost = FDMemTableAfterPost
    AfterScroll = FDMemTableAfterScroll
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
    object FDMemTabledsuf: TStringField
      FieldName = 'dsuf'
      Size = 10
    end
    object FDMemTablenmcidade: TStringField
      FieldName = 'nmcidade'
      Size = 60
    end
    object FDMemTablenmbairro: TStringField
      FieldName = 'nmbairro'
      Size = 60
    end
    object FDMemTablenmlogradouro: TStringField
      FieldName = 'nmlogradouro'
      Size = 60
    end
    object FDMemTabledscomplemento: TStringField
      FieldName = 'dscomplemento'
      Size = 60
    end
  end
  object dsPessoa: TDataSource
    DataSet = FDMemTable
    OnStateChange = dsPessoaStateChange
    Left = 465
    Top = 108
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 529
    Top = 116
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 204
    Top = 293
    object LinkPropertyToFieldCaption: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = RESTResponse1
      FieldName = 'Content'
      Component = lbResultado
      ComponentProperty = 'Caption'
    end
  end
end
