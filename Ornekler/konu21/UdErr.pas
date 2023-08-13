unit UdErr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, DBTables, StdCtrls, Buttons;

const
  eKeyViol = 9729;
  eRequiredFieldMissing = 9732;
  eForeignKey = 9733;
  eDetailsExist = 9734;
  eGeneralSQLError = 13059;

type
  TErrorType = (etPost, etDelete);
  TFmDataError = class(TForm)
    Label1: TLabel;
    Table1: TTable;
    ErrorTypeLabel: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Label6: TLabel;
    DatabaseLabel: TLabel;
    SysMsgMemo: TMemo;
    Label8: TLabel;
    MsgMemo: TMemo;
    Label9: TLabel;
    RetryBtn: TBitBtn;
    IgnoreBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label2: TLabel;
    ErrorCodeLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ErrorTypeLabelClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Execute(Err: EDatabaseError; Dataset: TDataset; ErrType: TErrorType): TDataAction;
    procedure FillMsg(Code: Integer; Kind: TErrorType);
  end;
const
  ErrorTypeStr : array[TErrorType] of string = ('Kay�t Hatas�', 'Silme Hatas�');
var
  FmDataError: TFmDataError;

implementation

{$R *.DFM}

procedure TFmDataError.FillMsg(Code: Integer; Kind: TErrorType);
begin
  MsgMemo.Lines.Add('Bu hatay� olu�turan sebep(ler):');
  with MsgMemo.Lines do
  case Kind of
  etPost:
  begin
    case Code of
    eRequiredFieldMissing:
     begin
       Add('- Bo� ge�ilmemesi gereken bir alan� bo� ge�tiniz.');
       Add('  �neri: Doldurmad���n�z alanlar� kontrol ediniz.');
     end;
    eKeyViol:
     begin
       Add('- Girmi� oldu�unuz bilgiden veri dosyas�nda zaten var.');
       Add('  �neri: Tek olmas� gereken alanlar� kontrol ediniz.');
     end;
    eGeneralSQLError:
     begin
       Add('- Tan�mlanmam�� bir de�eri kaydetmeye �al��ma.');
       Add('- Ba�lant�lar� olan bir alan�n de�erini de�i�tirme.');
       Add('- Veri dosyas� ba�lant�s� kesilmi� olabilir.');
     end;
    end;
  end;
  etDelete:
  begin
    case Code of
    eGeneralSQLError:
     begin
       Add('- Silmek istedi�iniz bu kayd�n ba�lant�lar� var. Bu kayd�');
       Add('  silmek i�in �ncelikle ba�lant�lar�n� silmeniz gerekiyor.');
       Add('- Veri dosyas� ba�lant�s� kesilmi� olabilir.');
     end;
    end;
  end;
 end;
end;

function TFmDataError.Execute(Err: EDatabaseError; Dataset: TDataset; ErrType: TErrorType): TDataAction;
var E: EDbEngineError;
begin
  E := EDbEngineError(Err);
  SysMsgMemo.Lines.Clear;
  MsgMemo.Lines.Clear;
  SysMsgMemo.Lines.Add(E.Message);
  ErrorCodeLabel.Caption := Format('#%d', [E.Errors[0].ErrorCode]);
  ErrorTypeLabel.Caption := ErrorTypeStr[ErrType];
  DatabaseLabel.Caption := Dataset.Name;
  CancelBtn.Enabled := (Dataset is TTable) and (ErrType = etPost) and (TTable(Dataset).State in dsEditModes);
  FillMsg(E.Errors[0].ErrorCode, ErrType);
  try
    ModalResult := ShowModal;
  except
    Result := daAbort;
    Exit;
  end;
  case ModalResult of
  mrIgnore: Result := daAbort;
  mrRetry: Result := daRetry;
  mrCancel:
   begin
     TTable(Dataset).Cancel;
     Result := daAbort;
   end;
  end;
end;

procedure TFmDataError.FormShow(Sender: TObject);
begin
  IgnoreBtn.SetFocus;
end;

procedure TFmDataError.ErrorTypeLabelClick(Sender: TObject);
begin
  close;
end;

end.
