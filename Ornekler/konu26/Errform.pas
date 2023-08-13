unit ErrForm;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DB, DBTables, Buttons;

type
  TUpdateErrorForm = class(TForm)
    ErrorText: TLabel;
    UpdateType: TLabel;
    RetryBtn: TBitBtn;
    IgnoreBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UpdateDataSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
  private
    FDataFields: TStringList;
  public
    function HandleError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind): TUpdateAction;
  end;

var
  UpdateErrorForm: TUpdateErrorForm;

implementation

{$R *.DFM}

{ Public and Private Methods }


function TUpdateErrorForm.HandleError(DataSet: TDataSet; E: EDatabaseError;
  UpdateKind: TUpdateKind): TUpdateAction;
const
  UpdateKindStr: array[TUpdateKind] of string = ('Deðiþtirilmiþ', 'Eklenmiþ',
    'Silinmiþ');
begin
  UpdateType.Caption := UpdateKindStr[UpdateKind];
  ErrorText.Caption := E.Message;
  ShowModal;
  case ModalResult of
    mrRetry:
      begin
        Result := uaRetry;
      end;
    mrIgnore:
      Result := uaSkip;
    else
      Result := uaAbort;
  end;
end;




procedure TUpdateErrorForm.FormCreate(Sender: TObject);
begin
  FDataFields := TStringList.Create;
end;

procedure TUpdateErrorForm.FormDestroy(Sender: TObject);
begin
  FDataFields.Free;
end;

procedure TUpdateErrorForm.UpdateDataSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  FDataFields[ARow - 1] := '*';
end;

end.
