object DMADO: TDMADO
  OldCreateOrder = False
  Left = 166
  Top = 121
  Height = 480
  Width = 696
  object KitapConn: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";User ID=Admin;Data ' +
      'Source=kitap.mdb;Mode=Share Deny None;Extended Properties="";Jet' +
      ' OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:D' +
      'atabase Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database L' +
      'ocking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glob' +
      'al Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OL' +
      'EDB:Create System Database=False;Jet OLEDB:Encrypt Database=Fals' +
      'e;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact' +
      ' Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 24
  end
  object MakaleTable: TADOTable
    Active = True
    Connection = KitapConn
    CursorType = ctStatic
    TableName = 'articles'
    Left = 24
    Top = 96
    object MakaleTablea_id: TAutoIncField
      FieldName = 'a_id'
    end
    object MakaleTableowner: TWideStringField
      FieldName = 'owner'
      Size = 12
    end
    object MakaleTabletitle: TWideStringField
      FieldName = 'title'
      Required = True
      Size = 100
    end
    object MakaleTablearticle: TMemoField
      FieldName = 'article'
      Required = True
      BlobType = ftMemo
    end
    object MakaleTablea_date: TDateField
      FieldName = 'a_date'
    end
  end
  object MakaleSource: TDataSource
    DataSet = MakaleTable
    Left = 112
    Top = 96
  end
end
