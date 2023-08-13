unit Uimglstgetbitmap;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    imglist: TImageList;
    Label1: TLabel;
    rgDrawStyle: TRadioGroup;
    edIndex: TEdit;
    Image1: TImage;
    Label3: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure rgDrawStyleClick(Sender: TObject);
    procedure edIndexChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormPaint(Sender: TObject);
var i, x: integer;

begin
  x := 25;
  for i := 0 to ImgList.Count - 1 do
  begin
    ImgList.Draw(Canvas, X, 40, i);
    X := x + ImgList.Width + 5;
  end;
end;

procedure TForm1.rgDrawStyleClick(Sender: TObject);
begin
  ImgList.DrawingStyle := TDrawingStyle(rgDrawStyle.ItemIndex);
  InValidate;
end;

procedure TForm1.edIndexChange(Sender: TObject);
var Index: Integer;
begin
  Index := StrToIntDef(edIndex.Text, 0);
  Image1.Picture.Graphic := nil;
  ImgList.GetBitmap(Index, Image1.Picture.Bitmap);
  Image1.Invalidate;
  edIndex.SelectAll;
end;

end.
