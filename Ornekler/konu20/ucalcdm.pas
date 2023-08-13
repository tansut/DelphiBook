unit ucalcdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMCalc = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableDTarihi: TDateField;
    MusteriTableYas: TIntegerField;
    procedure MusteriTableCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCalc: TDMCalc;

implementation

{$R *.DFM}

procedure TDMCalc.MusteriTableCalcFields(DataSet: TDataSet);
var
 Year, PresentYear, Month, Day: Word;
begin
  if MusteriTable.FieldbyName('DTARIHI').IsNull then
   MusteriTableYas.AsInteger := 0
  else
  begin
    DecodeDate(Now, PresentYear, Month, Day);
    DecodeDate(MusteriTableDTarihi.Value, Year, Month, Day);
    MusteriTableYas.AsInteger := PresentYear - Year;
  end;
end;

end.
