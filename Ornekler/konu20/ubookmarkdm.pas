unit ubookmarkdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMBookmark = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableDTarihi: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMBookmark: TDMBookmark;

implementation

{$R *.DFM}

end.
