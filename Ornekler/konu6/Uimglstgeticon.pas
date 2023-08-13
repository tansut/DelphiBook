unit Uimglstgeticon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ImgList;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ImageList1.GetIcon(Tag, Image1.Picture.Icon);
  Tag := Tag + 1;
  Tag := Tag mod 4;
end;

end.
