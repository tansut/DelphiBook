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
  ErrorTypeStr : array[TErrorType] of string = ('Kayýt Hatasý', 'Silme Hatasý');
var
  FmDataError: TFmDataError;

implementation

{$R *.DFM}

procedure TFmDataError.FillMsg(Code: Integer; Kind: TErrorType);
begin
  MsgMemo.Lines.Add('Bu hatayý oluþturan sebep(ler):');
  with MsgMemo.Lines do
  case Kind of
  etPost:
  begin
    case Code of
    eRequiredFieldMissing:
     begin
       Add('- Boþ geçilmemesi gereken bir alaný boþ geçtiniz.');
       Add('  Öneri: Doldurmadýðýnýz alanlarý kontrol ediniz.');
     end;
    eKeyViol:
     begin
       Add('- Girmiþ olduðunuz bilgiden veri dosyasýnda zaten var.');
       Add('  Öneri: Tek olmasý gereken alanlarý kontrol ediniz.');
     end;
    eGeneralSQLError:
     begin
       Add('- Tanýmlanmamýþ bir deðeri kaydetmeye çalýþma.');
       Add('- Baðlantýlarý olan bir alanýn deðerini deðiþtirme.');
       Add('- Veri dosyasý baðlantýsý kesilmiþ olabilir.');
     end;
    end;
  end;
  etDelete:
  begin
    case Code of
    eGeneralSQLError:
     begin
       Add('- Silmek istediðiniz bu kaydýn baðlantýlarý var. Bu kaydý');
       Add('  silmek için öncelikle baðlantýlarýný silmeniz gerekiyor.');
       Add('- Veri dosyasý baðlantýsý kesilmiþ olabilir.');
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
