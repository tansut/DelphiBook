object FMMain: TFMMain
  Left = 181
  Top = 185
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ADO Örneði - Delphi Programcýlýðý ve SQL'
  ClientHeight = 500
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 120
    Width = 52
    Height = 13
    Caption = 'Makale No'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 144
    Top = 120
    Width = 27
    Height = 13
    Caption = 'Yazar'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 160
    Width = 28
    Height = 13
    Caption = 'Baþlýk'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 8
    Top = 200
    Width = 28
    Height = 13
    Caption = 'article'
    FocusControl = DBMemo1
  end
  object Label5: TLabel
    Left = 272
    Top = 120
    Width = 24
    Height = 13
    Caption = 'Tarih'
    FocusControl = DBEdit4
  end
  object Label7: TLabel
    Left = 8
    Top = 48
    Width = 571
    Height = 13
    Caption = 
      'Uygulama BDE kullanmamakta, OLE DB saðlayýcýsý olarak '#39'Microsoft' +
      '.Jet.OLEDB.4.0'#39' kullanmaktadýr. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 8
    Top = 64
    Width = 673
    Height = 2
  end
  object Label8: TLabel
    Left = 8
    Top = 72
    Width = 212
    Height = 13
    Caption = 'Delphi Türk (www.delphiturk.com) Makaleler:'
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 136
    Width = 64
    Height = 21
    DataField = 'a_id'
    DataSource = DMADO.MakaleSource
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 144
    Top = 136
    Width = 76
    Height = 21
    DataField = 'owner'
    DataSource = DMADO.MakaleSource
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 176
    Width = 361
    Height = 21
    DataField = 'title'
    DataSource = DMADO.MakaleSource
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 8
    Top = 216
    Width = 665
    Height = 273
    DataField = 'article'
    DataSource = DMADO.MakaleSource
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 272
    Top = 136
    Width = 64
    Height = 21
    DataField = 'a_date'
    DataSource = DMADO.MakaleSource
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 681
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    TabOrder = 5
    object Label6: TLabel
      Left = 8
      Top = 8
      Width = 630
      Height = 22
      Caption = 
        'ADO veri bileþenleri kullanýlarak geliþtirilmiþ veri tabaný uygu' +
        'lamasý. '
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 88
    Width = 240
    Height = 25
    DataSource = DMADO.MakaleSource
    TabOrder = 6
  end
end
