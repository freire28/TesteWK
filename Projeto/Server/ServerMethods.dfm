object ServerMethods: TServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 547
  Width = 653
  object conexao: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=postgres'
      'Password=denisdes'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 72
    Top = 48
  end
  object FDQPessoa: TFDQuery
    AfterPost = FDQPessoaAfterPost
    AfterDelete = FDQPessoaAfterDelete
    CachedUpdates = True
    Connection = conexao
    SQL.Strings = (
      
        'SELECT idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo,' +
        ' dtregistro'
      '  FROM pessoa where idpessoa = :idpessoa')
    Left = 32
    Top = 104
    ParamData = <
      item
        Name = 'IDPESSOA'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQPessoaidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQPessoaflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object FDQPessoadsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object FDQPessoanmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object FDQPessoanmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object FDQPessoadtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FDQEndereco: TFDQuery
    AfterPost = FDQEnderecoAfterPost
    AfterDelete = FDQEnderecoAfterDelete
    CachedUpdates = True
    Connection = conexao
    SQL.Strings = (
      'SELECT idendereco, idpessoa, dscep'
      #9'FROM endereco'
      'where idpessoa= :idpessoa')
    Left = 32
    Top = 152
    ParamData = <
      item
        Name = 'IDPESSOA'
        ParamType = ptInput
      end>
    object FDQEnderecoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQEnderecoidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
    end
    object FDQEnderecodscep: TWideStringField
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
  end
  object FDQEnderecoIntegracao: TFDQuery
    AfterDelete = FDQEnderecoIntegracaoAfterDelete
    CachedUpdates = True
    Connection = conexao
    SQL.Strings = (
      
        'SELECT idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscom' +
        'plemento'
      #9'FROM endereco_integracao'
      'where idendereco = :idendereco')
    Left = 184
    Top = 152
    ParamData = <
      item
        Name = 'IDENDERECO'
        DataType = ftInteger
        ParamType = ptInput
      end>
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
  object FDQAux: TFDQuery
    Connection = conexao
    Left = 32
    Top = 200
  end
  object FDUpdPessoa: TFDUpdateSQL
    Connection = conexao
    InsertSQL.Strings = (
      'INSERT INTO pessoa'
      '(idpessoa, flnatureza, dsdocumento, nmprimeiro, '
      '  nmsegundo, dtregistro)'
      
        'VALUES (:new_idpessoa, :new_flnatureza, :new_dsdocumento, :new_n' +
        'mprimeiro, '
      '  :new_nmsegundo, :new_dtregistro)')
    ModifySQL.Strings = (
      'UPDATE pessoa'
      
        'SET flnatureza = :new_flnatureza, dsdocumento = :new_dsdocumento' +
        ', '
      '  nmprimeiro = :new_nmprimeiro, nmsegundo = :new_nmsegundo, '
      '  dtregistro = :new_dtregistro'
      'WHERE idpessoa = :old_idpessoa')
    DeleteSQL.Strings = (
      'DELETE FROM pessoa'
      'WHERE idpessoa = :old_idpessoa')
    FetchRowSQL.Strings = (
      
        'SELECT idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo,' +
        ' dtregistro'
      'FROM ('
      'select * from pessoa'
      ') '
      'WHERE idpessoa = :old_idpessoa')
    Left = 120
    Top = 104
  end
  object FDQInserePessoaEmLote: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'INSERT INTO pessoa('
      
        #9'idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtreg' +
        'istro)'
      
        #9'VALUES (:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nms' +
        'egundo, :dtregistro)')
    Left = 32
    Top = 264
    ParamData = <
      item
        Name = 'IDPESSOA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'FLNATUREZA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DSDOCUMENTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NMPRIMEIRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NMSEGUNDO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DTREGISTRO'
        DataType = ftDateTime
        ParamType = ptInput
      end>
  end
  object FDQInsereEnderecoEmLote: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'INSERT INTO public.endereco('
      #9'idendereco, idpessoa, dscep)'
      #9'VALUES (:idendereco, :idpessoa, :dscep);')
    Left = 32
    Top = 312
    ParamData = <
      item
        Name = 'IDENDERECO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'IDPESSOA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'DSCEP'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQDadosPessoa: TFDQuery
    AfterPost = FDQPessoaAfterPost
    CachedUpdates = True
    Connection = conexao
    SQL.Strings = (
      
        'SELECT a.idpessoa, a.flnatureza, a.dsdocumento, a.nmprimeiro, a.' +
        'nmsegundo, a.dtregistro ,b.idendereco, b.dscep, c.dsuf ,c.nmcida' +
        'de'
      '      ,c.nmbairro,c.nmlogradouro,c.dscomplemento'
      #9'FROM pessoa a'
      #9'inner join endereco b on a.idpessoa = b.idpessoa '
      #9'left join endereco_integracao c on c.idendereco = b.idendereco')
    Left = 216
    Top = 232
    object FDQDadosPessoaidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQDadosPessoaflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object FDQDadosPessoadsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object FDQDadosPessoanmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object FDQDadosPessoanmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object FDQDadosPessoadtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
    object FDQDadosPessoaidendereco: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco'
      Origin = 'idendereco'
    end
    object FDQDadosPessoadscep: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object FDQDadosPessoadsuf: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object FDQDadosPessoanmcidade: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object FDQDadosPessoanmbairro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object FDQDadosPessoanmlogradouro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object FDQDadosPessoadscomplemento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
end
