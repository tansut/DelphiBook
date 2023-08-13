unit Uresstr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    btnText: TButton;
    LblText: TLabel;
    btnBitmap: TButton;
    Image1: TImage;
    btnIcon: TButton;
    BtnWav: TButton;
    Image2: TImage;
    Label1: TLabel;
    procedure btnTextClick(Sender: TObject);
    procedure btnBitmapClick(Sender: TObject);
    procedure btnIconClick(Sender: TObject);
    procedure BtnWavClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses MMSystem;
{$R *.DFM}

procedure TForm1.btnTextClick(Sender: TObject);
var Res: TResourceStream;
    S: string;
begin
  Res := TResourceStream.CreateFromID(HInstance, 1, 'TEXT');
  SetLength(S, Res.Size);
  try
    Res.ReadBuffer(Pointer(S)^, Res.Size);
  finally
    Res.Free;
  end;
  LblText.Caption := S;
end;

procedure TForm1.btnBitmapClick(Sender: TObject);
begin
  Image1.Picture.Bitmap.Handle := LoadBitmap(HInstance, '#1');
end;

procedure TForm1.btnIconClick(Sender: TObject);
begin
  Image2.Picture.Icon.Handle := LoadIcon(HInstance, '#1');
end;

procedure TForm1.BtnWavClick(Sender: TObject);
begin
  PlaySound('#1', HInstance, SND_RESOURCE or SND_ASYNC);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if (waveOutGetNumDevs<=0) then
  begin
    BtnWav.Caption := 'Ses kartý bulunamadý';
    BtnWav.Enabled := False;
  end;
end;

end.
