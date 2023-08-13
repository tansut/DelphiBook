unit umasdetdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMMasDet = class(TDataModule)
    MusteriTable: TTable;
    SatisTable: TTable;
    FaturaTable: TTable;
    MusteriSource: TDataSource;
    SatisSource: TDataSource;
    FaturaSource: TDataSource;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableTel1: TStringField;
    MusteriTableTel2: TStringField;
    MusteriTableAdres: TStringField;
    MusteriTableSehir: TStringField;
    MusteriTableDTarihi: TDateField;
    MusteriTableResmi: TGraphicField;
    MusteriTableUzunAciklama: TMemoField;
    SatisTableKod: TAutoIncField;
    SatisTableMKod: TIntegerField;
    SatisTableSatisTarihi: TDateTimeField;
    SatisTableToplamMiktar: TCurrencyField;
    SatisTableFaturaNo: TStringField;
    FaturaTableKod: TAutoIncField;
    FaturaTableSKod: TIntegerField;
    FaturaTableMiktar: TCurrencyField;
    FaturaTableCins: TStringField;
    SatisTableSatisTutari: TStringField;
    procedure MusteriTableAfterOpen(DataSet: TDataSet);
    procedure SatisTableAfterOpen(DataSet: TDataSet);
    procedure DMMasDetCreate(Sender: TObject);
    procedure SatisTableNewRecord(DataSet: TDataSet);
    procedure FaturaTableBeforeEdit(DataSet: TDataSet);
    procedure FaturaTableAfterCancel(DataSet: TDataSet);
    procedure FaturaTableAfterPost(DataSet: TDataSet);
    procedure FaturaTableNewRecord(DataSet: TDataSet);
    procedure FaturaTableBeforeDelete(DataSet: TDataSet);
    procedure FaturaTableAfterDelete(DataSet: TDataSet);
    procedure MusteriTableBeforeDelete(DataSet: TDataSet);
    procedure SatisTableBeforeDelete(DataSet: TDataSet);
    procedure FaturaTableMiktarValidate(Sender: TField);
    procedure SatisTableCalcFields(DataSet: TDataSet);
  private
    OldTutar: Double;
  public
    { Public declarations }
  end;

var
  DMMasDet: TDMMasDet;

implementation

{$R *.DFM}
const
  BIRLER: array[0..9] of string=('', 'Bir', 'Iki', 'Üç', 'Dört', 'Beþ', 'Altý',
          'Yedi', 'Sekiz', 'Dokuz');
  ONLAR : array[0..9] of string=('', 'On', 'Yirmi', 'Otuz', 'Kýrk', 'Elli', 'Altmýþ',
          'Yetmiþ', 'Seksen', 'Doksan');
  DIGER : array[0..5] of string=('', 'Bin', 'Milyon', 'Milyar', 'Trilyon', 'Katrilyon');


function SmallNum(N: Integer): string;
var
  S: string[3];
begin
  Result := '';
  S := IntToStr(N);
  if (Length(S)=1) then
    S := '00' + S
  else if (Length(S)=2) then
    S := '0' + S;
  if S[1]<>'0' then
    if S[1]<>'1' then
      Result := BIRLER[StrToInt(S[1])] + 'Yüz'
    else
      Result := 'Yüz';
  Result := Result + ONLAR[StrToInt(S[2])];
  Result := Result + BIRLER[StrToInt(S[3])];
end;

function NumStr(Num: Currency): string;
var
  i, j, n, Nm: Integer;
  S, Sn: string;
begin
  S := FormatFloat('0', Num);
  Sn := '';
  if Num = 0 then
    Sn := 'Sifir'
  else if Length(S) < 4 then
    Sn := SmallNum(Round(Num))
  else
  begin
    I := 1;
    J := Length(S) mod 3;
    if J=0 then
    begin
      J := 3;
      N := Length(S) div 3 - 1;
    end
    else
      N := Length(S) div 3;
    while i<Length(S) do
    begin
      Nm := StrToInt(Copy(S, I, J));
      if (Nm=1) and (N=1) then
      begin
        Nm := 0;
        Sn := Sn + SmallNum(Nm) + Diger[N];
      end;
      if Nm<>0 then
        Sn := Sn + SmallNum(Nm) + Diger[N];
      I := I + J;
      J := 3;
      N := N - 1;
    end;
  end;
  Result := Sn;
end;


procedure TDMMasDet.MusteriTableAfterOpen(DataSet: TDataSet);
begin
  SatisTable.Open;
end;

procedure TDMMasDet.SatisTableAfterOpen(DataSet: TDataSet);
begin
  FaturaTable.Open;
end;

procedure TDMMasDet.DMMasDetCreate(Sender: TObject);
begin
  MusteriTable.Open;
  OldTutar := 0;
end;

procedure TDMMasDet.SatisTableNewRecord(DataSet: TDataSet);
begin
  SatisTableSatisTarihi.AsDateTime := Date;
  SatisTableToplamMiktar.AsFloat := 0;
end;

procedure TDMMasDet.FaturaTableBeforeEdit(DataSet: TDataSet);
begin
  OldTutar := FaturaTableMiktar.AsFloat;
end;

procedure TDMMasDet.FaturaTableAfterCancel(DataSet: TDataSet);
begin
  OldTutar := 0;
end;

procedure TDMMasDet.FaturaTableAfterPost(DataSet: TDataSet);
var Degisim: Double;
begin
  if OldTutar = 0  then Exit;
  if OldTutar < 0 then
   Degisim := FaturaTableMiktar.AsFloat
  else Degisim := FaturaTableMiktar.AsFloat - OldTutar;
  if Degisim <> 0 then
  begin
    SatisTable.Edit;
    SatisTableToplamMiktar.AsFloat := SatisTableToplamMiktar.AsFloat + Degisim;
    SatisTable.Post;
  end;
end;

procedure TDMMasDet.FaturaTableNewRecord(DataSet: TDataSet);
begin
  OldTutar := -1;
end;

procedure TDMMasDet.FaturaTableBeforeDelete(DataSet: TDataSet);
begin
  OldTutar := FaturaTableMiktar.AsFloat;
end;

procedure TDMMasDet.FaturaTableAfterDelete(DataSet: TDataSet);
begin
  SatisTable.Edit;
  SatisTableToplamMiktar.AsFloat := SatisTableToplamMiktar.AsFloat - OldTutar;
  SatisTable.Post;
end;

procedure TDMMasDet.MusteriTableBeforeDelete(DataSet: TDataSet);
begin
  SatisTable.DisableControls;
  SatisTable.First;
  try
    while not SatisTable.EOF do SatisTable.Delete;
  finally
    SatisTable.EnableControls;
  end;
end;

procedure TDMMasDet.SatisTableBeforeDelete(DataSet: TDataSet);
begin
  FaturaTable.DisableControls;
  FaturaTable.First;
  try
    while not FaturaTable.EOF do FaturaTable.Delete;
  finally
    FaturaTable.EnableControls;
  end;
end;

procedure TDMMasDet.FaturaTableMiktarValidate(Sender: TField);
begin
  if FaturaTableMiktar.AsFloat <= 0 then
   raise Exception.Create('Miktar sýfýrdan büyük olmalý');
end;

procedure TDMMasDet.SatisTableCalcFields(DataSet: TDataSet);
begin
  SatisTableSatisTutari.AsString := NumStr(SatisTableToplamMiktar.AsFloat);
end;

end.
