unit DataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables;

type
  TCacheData = class(TDataModule)
    CacheDS: TDataSource;
    CacheDB: TDatabase;
    CacheQuery: TQuery;
    UpdateSQL: TUpdateSQL;
    CacheQueryUYE_KODU: TAutoIncField;
    CacheQueryADI: TStringField;
    CacheQueryUpdateStatus: TStringField;
    procedure UpdateErrorHandler(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure CacheQueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CacheData: TCacheData;

implementation

uses CachedUp, ErrForm;

{$R *.DFM}


procedure TCacheData.UpdateErrorHandler(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  UpdateAction := UpdateErrorForm.HandleError(DataSet, E, UpdateKind);
end;



procedure TCacheData.CacheQueryCalcFields(DataSet: TDataSet);
const
  UpdateStatusStr: array[TUpdateStatus] of string = ('Deðiþmemiþ', 'Deðiþmiþ',
   'Eklenmiþ', 'Silinmiþ');
begin
  if CacheQuery.CachedUpdates then
    CacheQueryUpdateStatus.Value := UpdateStatusStr[CacheQuery.UpdateStatus];
end;

end.

