unit modifydatadm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMModify = class(TDataModule)
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
    procedure MusteriTableBeforeDelete(DataSet: TDataSet);
    procedure MusteriTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure MusteriTableDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMModify: TDMModify;

implementation

uses UdErr;

{$R *.DFM}

procedure TDMModify.MusteriTableBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Kayýt silinsin mi ?', mtWarning, [mbYes, mbNo], 0) = mrNo then
    Abort; 
end;

procedure TDMModify.MusteriTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Action := FmDataError.Execute(E, DataSet, etPost);
end;

procedure TDMModify.MusteriTableDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Action := FmDataError.Execute(E, DataSet, etDelete);
end;

end.
