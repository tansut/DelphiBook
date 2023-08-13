unit Uimglstdraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, ExtCtrls, ExtDlgs;

type
  TForm1 = class(TForm)
    imglist: TImageList;
    ListBox: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    dlgOP: TOpenPictureDialog;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button1Click(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 0 to ImgList.Count - 1 do
   ListBox.Items.Add(Format('%d', [i]));
end;

procedure TForm1.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox, Canvas do
  begin
    FillRect(Rect);
    InflateRect(Rect, -1, -1);
    ImgList.Draw(Canvas, (Rect.Left+Rect.Right) div 2 - ImgList.Width div 2, Rect.Top, index, True);
    Inc(Rect.Top, ImgList.Height + 2);
    DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or DT_CENTER or
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var Picture: TPicture;
begin
  if DlgOp.Execute then
  begin
    Picture := TPicture.Create;
    try
      Picture.LoadFromFile(DlgOP.FileName);
      if imglist.AddIcon(Picture.Icon) < 0 then
       ShowMessage('Simge eklenemedi')
      else
       ListBox.Items.Add(IntToStr(ListBox.Items.Count));
    finally
      Picture.Free;
    end;
  end;
end;

procedure TForm1.ListBoxClick(Sender: TObject);
begin
  // if ListBox.ItemIndex = 4 then Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if ListBox.ItemIndex < 0 then
   ShowMessage('Önce elemaný seçiniz')
  else
  begin
    ImgList.Delete(ListBox.ItemIndex);
    ListBox.Items.Delete(ListBox.ItemIndex);
  end;
end;

end.
