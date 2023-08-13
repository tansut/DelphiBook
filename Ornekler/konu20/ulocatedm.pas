unit ulocatedm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDmLocate = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableTel1: TStringField;
    MusteriTableTel2: TStringField;
    MusteriTableAdres: TStringField;
    MusteriTableSehir: TStringField;
    MusteriTableDTarihi: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmLocate: TDmLocate;

implementation

{$R *.DFM}

end.
