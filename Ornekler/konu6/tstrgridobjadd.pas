unit tstrgridobjadd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtDlgs, StdCtrls, ExtCtrls;

type
  TFmAddObj = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    edSurname: TEdit;
    Img: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
  private
  public
    function Execute: Boolean;
  end;

var
  FmAddObj: TFmAddObj;

implementation

{$R *.DFM}

function TFmAddObj.Execute: Boolean;
begin
  edName.Text := '';
  edSurname.Text := '';
  Img.Picture.Graphic := nil;
  ActiveControl := EdName;
  Result := ShowModal = mrOk;
end;

procedure TFmAddObj.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
   Img.Picture.LoadFromFile(OpenPictureDialog.FileName);
end;

end.
