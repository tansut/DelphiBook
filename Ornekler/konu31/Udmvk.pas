unit Udmvk;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
    CityTable: TTable;
    CityTableKod: TIntegerField;
    CityTableSehir: TStringField;
    CitySource: TDataSource;
    MusteriTableKod: TAutoIncField;
    MusteriTableAd: TStringField;
    MusteriTableSoyad: TStringField;
    MusteriTableSehirKod: TIntegerField;
    MusteriTableDTarih: TDateField;
    MusteriTableSonGiris: TTimeField;
    MusteriTableMaas: TCurrencyField;
    MusteriTableResim: TGraphicField;
    MusteriTableSes: TBlobField;
    MusteriTableAciklama: TMemoField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.DFM}

end.
