unit udm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    KisiTable: TTable;
    KisiSource: TDataSource;
    KisiTableKod: TAutoIncField;
    KisiTableAd: TStringField;
    KisiTableSoyad: TStringField;
    KisiTableSehirKod: TIntegerField;
    KisiTableDTarih: TDateField;
    KisiTableMaas: TCurrencyField;
    KisiTableResim: TGraphicField;
    KisiTableSes: TBlobField;
    KisiTableAciklama: TMemoField;
    SehirTable: TTable;
    SehirTableKod: TIntegerField;
    SehirTableSehir: TStringField;
    KisiTableSehirAdi: TStringField;
    KisiTableYas: TIntegerField;
    KisiTableSonGiris: TTimeField;
    procedure KisiTableCalcFields(DataSet: TDataSet);
    procedure KisiTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure KisiTableDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure KisiTableSonGirisValidate(Sender: TField);
    procedure KisiTableBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses UdErr;



{$R *.DFM}

procedure TDM.KisiTableCalcFields(DataSet: TDataSet);
var
 Year, PresentYear, Month, Day: Word;
begin
  if KisiTableDTarih.IsNull then
   KisiTableYas.AsInteger := 0
  else
  begin
    DecodeDate(Now, PresentYear, Month, Day);
    DecodeDate(KisiTableDTarih.Value, Year, Month, Day);
    KisiTableYas.AsInteger := PresentYear - Year;
  end;
end;

procedure TDM.KisiTablePostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  Action := FmDataError.Execute(E, DataSet, etPost);
end;

procedure TDM.KisiTableDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  Action := FmDataError.Execute(E, DataSet, etDelete);
end;

procedure TDM.KisiTableSonGirisValidate(Sender: TField);
begin
  if (not Sender.IsNull) and (Sender.AsDateTime > Time) then
  begin
    raise Exception.CreateFmt('Son giriþ saati þu andan büyük olamaz. Þu anki saat: %s', [FormatDateTime('hh:mm', Now)]);
  end;
end;

procedure TDM.KisiTableBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Kayýt silinsin mi ?', mtWarning, [mbYes, mbNo], 0) = mrNo then
    Abort; 
end;

end.
