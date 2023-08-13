unit ufilterdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMFilter = class(TDataModule)
    MusteriTable: TTable;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableTel1: TStringField;
    MusteriTableTel2: TStringField;
    MusteriTableAdres: TStringField;
    MusteriTableSehir: TStringField;
    MusteriTableDTarihi: TDateField;
    MusteriSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMFilter: TDMFilter;

implementation

{$R *.DFM}

end.
