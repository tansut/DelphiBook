unit ImageU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TImageFrm = class(TForm)
    FileLabel: TLabel;
    Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImageFrm: TImageFrm;

implementation

{$R *.DFM}
uses
  Main;
procedure TImageFrm.FormCreate(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;
  FileLabel.Left := 2;
  FileLabel.Top := Screen.Height - FileLabel.Height;
end;

procedure TImageFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    ModalResult := mrOk
  else if key=#13 then
  begin
    MainFrm.NextPicture;
    Image.Picture := MainFrm.Image.Picture;
  end
  else if key=#32 then
  begin
    MainFrm.PreviousPicture;
    Image.Picture := MainFrm.Image.Picture;
  end;
end;

procedure TImageFrm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
    MainFrm.PreviousPicture
  else if Button = mbLeft then
    MainFrm.NextPicture;
  Image.Picture := MainFrm.Image.Picture;
end;

end.
