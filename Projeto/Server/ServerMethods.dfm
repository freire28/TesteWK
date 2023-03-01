object ServerMethods: TServerMethods
  OldCreateOrder = False
  Height = 327
  Width = 324
  object FDQPessoa: TFDQuery
    AfterPost = FDQPessoaAfterPost
    AfterDelete = FDQPessoaAfterDelete
    CachedUpdates = True
    Connection = dmdConexao.conexao
    SQL.Strings = (
      
        'SELECT idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo,' +
        ' dtregistro'
      '  FROM pessoa where idpessoa = :idpessoa')
    Left = 16
    Top = 8
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
    Connection = dmdConexao.conexao
    SQL.Strings = (
      'SELECT idendereco, idpessoa, dscep'
      #9'FROM endereco'
      'where idpessoa= :idpessoa')
    Left = 16
    Top = 56
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
    Connection = dmdConexao.conexao
    SQL.Strings = (
      
        'SELECT idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscom' +
        'plemento'
      #9'FROM endereco_integracao'
      'where idendereco = :idendereco')
    Left = 104
    Top = 56
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
    Connection = dmdConexao.conexao
    Left = 16
    Top = 104
  end
  object FDUpdPessoa: TFDUpdateSQL
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
    Left = 104
    Top = 8
  end
  object FDQInserePessoaEmLote: TFDQuery
    Connection = dmdConexao.conexao
    SQL.Strings = (
      'INSERT INTO pessoa('
      
        #9'idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtreg' +
        'istro)'
      
        #9'VALUES (:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nms' +
        'egundo, :dtregistro)')
    Left = 16
    Top = 168
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
    Connection = dmdConexao.conexao
    SQL.Strings = (
      'INSERT INTO public.endereco('
      #9'idendereco, idpessoa, dscep)'
      #9'VALUES (:idendereco, :idpessoa, :dscep);')
    Left = 16
    Top = 216
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
    Connection = dmdConexao.conexao
    SQL.Strings = (
      
        'SELECT a.idpessoa, a.flnatureza, a.dsdocumento, a.nmprimeiro, a.' +
        'nmsegundo, a.dtregistro ,b.idendereco, b.dscep, c.dsuf ,c.nmcida' +
        'de'
      '      ,c.nmbairro,c.nmlogradouro,c.dscomplemento'
      #9'FROM pessoa a'
      #9'inner join endereco b on a.idpessoa = b.idpessoa '
      #9'left join endereco_integracao c on c.idendereco = b.idendereco')
    Left = 104
    Top = 112
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
