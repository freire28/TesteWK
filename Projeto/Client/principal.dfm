object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 319
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 360
    Top = 96
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Pessoa1: TMenuItem
        Caption = 'Pessoa'
        OnClick = Pessoa1Click
      end
      object CadastroemLote1: TMenuItem
        Caption = 'Cadastro em Lote'
        OnClick = CadastroemLote1Click
      end
    end
  end
end
