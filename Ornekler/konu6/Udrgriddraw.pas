unit Udrgriddraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Buttons, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Grid: TDrawGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    StatusBar: TStatusBar;
    Label2: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FFileList: TStringList;
    procedure ShowPictures;
    procedure FillFileList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses FileCtrl;
{$R *.DFM}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var Result: string;
begin
  if not SelectDirectory('Klasor Sec', '', Result) then Exit;
  Edit1.Text := Result;
  ShowPictures;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Edit1.Text := ExtractFilePath(Application.ExeName);
  FFileList := TStringList.Create;
  ShowPictures;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FFileList.Free;
end;

procedure TForm1.FillFileList;
var
  SR: TSearchRec;
  IsFound: Boolean;
  StartDir: string;
 procedure AddToList(FileMask: string);
 begin
  IsFound := FindFirst(StartDir+FileMask, faAnyFile-faDirectory, SR) = 0;
  while IsFound do begin
    FFileList.Add(StartDir + SR.Name);
    IsFound := FindNext(SR) = 0;
  end;
  FindClose(SR);
 end;
begin
  StartDir := Edit1.Text;
  if StartDir[length(StartDir)] <> '\' then
    StartDir := StartDir + '\';
  FFileList.Clear;
  AddToList('*.bmp');
  AddToList('*.ico');
end;

procedure TForm1.ShowPictures;
begin
  FillFileList;
  with Grid do
  begin
    if FFileList.Count > 0 then
    begin
      ColCount := Width div DefaultColWidth;
      RowCount := FFileList.Count div ColCount + 1;
    end else
    begin
      ColCount := 0;
      RowCount := 0;
    end;
  end;
  Grid.Invalidate;
end;

procedure TForm1.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var FileName: string;
    FileIndex: Integer;
    Picture: TPicture;
begin
  FileIndex := ARow * Grid.ColCount + ACol ;
  if (FileIndex >= FFileList.Count) then Exit;
  FileName := FFileList[FileIndex];
  InflateRect(Rect, -2, -2);
  Picture := TPicture.Create;
  try
   Picture.LoadFromFile(FileName);
   if (Rect.Right - Rect.Left < Picture.Graphic.Width) or
      (Rect.Bottom - Rect.Top < Picture.Graphic.Height) then
    Grid.Canvas.StretchDraw(Rect, Picture.Graphic)
   else
     Grid.Canvas.Draw((Rect.Left + Rect.Right) div 2 - Picture.Graphic.Width div 2, Rect.Top, Picture.Graphic);
   Inc(Rect.Top, Picture.Graphic.Height + 5);
   DrawText(Grid.Canvas.Handle, PChar(ExtractFileName(FileName)), -1, Rect, DT_NOPREFIX or DT_CENTER or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
  finally
    Picture.Free;
  end;
end;

procedure TForm1.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var FileIndex: Integer;
begin
  FileIndex := ARow * Grid.ColCount + ACol ;
  if (FileIndex >= FFileList.Count) then CanSelect := False;
  if CanSelect then
  begin
    StatusBar.Panels[0].Text := Format('Sütun: %d, Satýr: %d', [ACol + 1, ARow + 1]);
    StatusBar.Panels[1].Text := FFileList[FileIndex];
  end;
end;

end.
