unit Urecorder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, MPlayer;

type
  TFmRecorder = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    MP: TMediaPlayer;
    procedure btnCancelClick(Sender: TObject);
    procedure MPClick(Sender: TObject; Button: TMPBtnType;
      var DoDefault: Boolean);
  private

  public
    function Execute(Dataset: TDataset; BlobField: TBlobField): Boolean;
  end;

var
  FmRecorder: TFmRecorder;

implementation

{$R *.DFM}

function TFmRecorder.Execute(Dataset: TDataset;
  BlobField: TBlobField): Boolean;
begin
  Mp.FileName := '';
  Mp.Open;
  Mp.FileName := 'temp.wav';
  BtnSave.Enabled := False;
  Result := ShowModal = mrOk;
  if Result then
  begin
    try
      try
        MP.Save;
        Mp.Close;
        DataSet.Edit;
        BlobField.LoadFromFile(MP.FileName);
        DeleteFile(MP.FileName);
        DataSet.Post;
      except
        on E: Exception do
         raise Exception.CreateFmt('Ýþlem sýrasýnda hata: %s', [E.Message]);
      end;
    finally
      Mp.Close;
      Mp.FileName := '';
      BtnSave.Enabled := True;
    end;
  end;
end;

procedure TFmRecorder.btnCancelClick(Sender: TObject);
begin
  Mp.Close;
end;

procedure TFmRecorder.MPClick(Sender: TObject; Button: TMPBtnType;
  var DoDefault: Boolean);
begin
  btnSave.Enabled := Button = btStop; 
end;

end.
