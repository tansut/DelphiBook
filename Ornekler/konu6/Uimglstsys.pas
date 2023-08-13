unit Uimglstsys;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ExtCtrls, StdCtrls, ExtDlgs, Menus;

type
  TForm1 = class(TForm)
    ListBox: TListBox;
    Label1: TLabel;
    imglist: TImageList;
    PopupMenu1: TPopupMenu;
    KAydet1: TMenuItem;
    SavePictureDialog: TSavePictureDialog;
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure KAydet1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses commctrl, shellapi;
{$R *.DFM}

procedure TForm1.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with ListBox, Canvas do
  begin
    FillRect(Rect);
    InflateRect(Rect, -2, -2);
    ImgList.Draw(Canvas, (Rect.Left+Rect.Right) div 2 - ImgList.Width div 2, Rect.Top, index, True);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  SysIL: HImageList;
  SFI: TSHFileInfo;
  i: integer;
begin
  SysIL := SHGetFileInfo('', 0, SFI, SizeOf(SFI),
  SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
  if SysIL <> 0 then
  begin
    ImgList.Handle := SysIL;
    ImgList.ShareImages := TRUE; // <- önemli
  end;
  for i := 0 to imglist.Count - 1 do
   ListBox.Items.Add('');
end;

procedure TForm1.KAydet1Click(Sender: TObject);
var Picture: TPicture;
begin
  if SavePictureDialog.Execute then
  begin
    Picture := TPicture.Create;
    try
      imglist.GetIcon(ListBox.ItemIndex, Picture.Icon);
      Picture.SaveToFile(SavePictureDialog.FileName);
    finally
      Picture.Free;
    end;
  end;
end;

end.
