object DMCEP: TDMCEP
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 258
  Width = 295
  object RESTClient1: TRESTClient
    BaseURL = 'https://viacep.com.br/ws/80620250/json'
    Params = <>
    Left = 24
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body60A3A7FC56264891B38751AA9ACD6F1C'
        Value = 
          '{'#13#10'  "idPessoa": 2,'#13#10'  "flnatureza": 0,'#13#10'  "nmprimeiro": "teste"' +
          ','#13#10'  "dtregistro": "2023-02-25T23:01:39.584Z",'#13#10'  "nmsegundo": "' +
          'teste 2",'#13#10'  "dsdocumento": "CPF",'#13#10'  "endereco": {'#13#10'    "idEnde' +
          'reco": 1,'#13#10'    "dscep": "80620250",'#13#10'    "idPessoa": 1'#13#10'  }'#13#10'}'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    Left = 88
    Top = 16
  end
  object RESTResponse1: TRESTResponse
    Left = 56
    Top = 16
  end
  object conexaoThRead: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=postgres'
      'Password=denisdes'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 72
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 72
    Top = 72
  end
  object FDQAuxCEP1: TFDQuery
    Connection = conexaoThRead
    Left = 32
    Top = 136
  end
  object FDQEnderecoIntegracao: TFDQuery
    CachedUpdates = True
    Connection = conexaoThRead
    SQL.Strings = (
      
        'SELECT idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscom' +
        'plemento'
      #9'FROM public.endereco_integracao'
      'where 1 = -1')
    Left = 72
    Top = 136
    object FDQEnderecoIntegracaoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQEnderecoIntegracaodsuf: TWideStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object FDQEnderecoIntegracaonmcidade: TWideStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object FDQEnderecoIntegracaonmbairro: TWideStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object FDQEnderecoIntegracaonmlogradouro: TWideStringField
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object FDQEnderecoIntegracaodscomplemento: TWideStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
end
