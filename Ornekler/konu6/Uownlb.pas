unit Uownlb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList;

type
  TForm1 = class(TForm)
    imglist: TImageList;
    ListBox1: TListBox;
    LblSelected: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Click(Sender: TObject);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
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
  for i := 0 to imglist.Count - 1 do
  begin
    ListBox1.Items.Add(Format('Eleman %d: Elemanýn metin uzunluðu büyüdükçe alta satýra otomatik atlayacaktýr.', [i]));
    ComboBox1.Items.Add(Format('Eleman %d: Daha kýsa eleman.', [i]));
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure TForm1.ListBox1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height := 40 + Random(80);
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control AS TListBox, Canvas DO
    begin
      FillRect(Rect);
      InflateRect(Rect, -1, -1);
      with Rect do Rectangle(Left, Top, Right, Bottom);
      InflateRect(Rect, -3, -3);
      ImgList.Draw(Canvas, Rect.Left, Rect.Top + 1, index, True);
      Inc(Rect.Left, 40);
      if Index < Screen.Fonts.Count then
       Canvas.Font.Name := Screen.Fonts[index];
      DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
    end;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  lblSelected.Caption := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TForm1.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TComboBox, Canvas do
    begin
      FillRect(Rect);
      InflateRect(Rect, -3, -3);
      ImgList.Draw(Canvas, Rect.Left, Rect.Top + 1, index, True);
      Inc(Rect.Left, 40);
      DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
    end;
end;

procedure TForm1.ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height := 40;
end;

end.
