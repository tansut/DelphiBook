unit Umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, mxgrid, TeEngine, Series, Db, DBTables, ExtCtrls, TeeProcs, Chart,
  mxgraph, mxDB, mxstore, mxpivsrc, mxtables, ComCtrls, ImgList, ToolWin,
  ExtDlgs, Menus;

type
  TFmMain = class(TForm)
    Cube: TDecisionCube;
    DQuery1: TDecisionQuery;
    StatusBar1: TStatusBar;
    Grid: TDecisionGrid;
    Pivot: TDecisionPivot;
    DSource: TDecisionSource;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SavePicture: TSavePictureDialog;
    OptionsPopup: TPopupMenu;
    KararKpAyarlar1: TMenuItem;
    SparseRowsMenuItem: TMenuItem;
    SparseColsMenuItem: TMenuItem;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure KararKpAyarlar1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure SparseRowsMenuItemClick(Sender: TObject);
    procedure SparseColsMenuItemClick(Sender: TObject);
  private
    procedure SaveGridAsBitmap(const FileName: string);
    function GetWindowAsBitmap(Wnd: HWnd; Bitmap: TBitmap): Boolean;
    function GetDcAsBitmap(DC: HDC; Bitmap: TBitmap; W, H: Cardinal): Boolean;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses ugraph, ShellApi;

{$R *.DFM}

function TFmMain.GetDcAsBitmap(DC: HDC; Bitmap: TBitmap; W, H: Cardinal): Boolean;
var
  hdcCompatible: HDC;
  hbmScreen: HBitmap;
begin
  Result := False;
  if DC = 0 then Exit;
  hdcCompatible := CreateCompatibleDC(DC);
  hbmScreen := CreateCompatibleBitmap(DC, W, H);
  if (hbmScreen = 0) then Exit;
  if (SelectObject(hdcCompatible, hbmScreen)=0) then Exit;
  if not(BitBlt(hdcCompatible, 0,0, W, H, DC, 0,0, SRCCOPY)) then
    Exit;
  Bitmap.Handle := HbmScreen;
  Bitmap.Dormant;
  Result := True;
end;

function TFmMain.GetWindowAsBitmap(Wnd: HWnd; Bitmap: TBitmap): Boolean;
var
  Rect: TRect;
begin
  GetWindowRect(Wnd, Rect);
  Result := GetDCAsBitmap(GetWindowDC(Wnd), Bitmap,
            Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
end;

procedure TFmMain.ToolButton1Click(Sender: TObject);
begin
  with TFmGraph.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFmMain.ToolButton5Click(Sender: TObject);
begin
  Close;
end;

procedure TFmMain.ToolButton4Click(Sender: TObject);
begin
  if SavePicture.Execute then
   SaveGridAsBitmap(SavePicture.FileName);
end;

procedure TFmMain.SaveGridAsBitmap(const FileName: string);
var Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
   GetWindowAsBitmap(Grid.Handle, Bitmap);
   Bitmap.SaveToFile(FileName);
  finally
   Bitmap.Free;
  end;
end;

procedure TFmMain.ToolButton3Click(Sender: TObject);
begin
  SaveGridAsBitmap('temp.bmp');
  ShellExecute(Handle, 'print', 'temp.bmp', '', '', SW_HIDE);
end;

procedure TFmMain.KararKpAyarlar1Click(Sender: TObject);
begin
  Cube.ShowCubeDialog;
end;

procedure TFmMain.ToolButton2Click(Sender: TObject);
begin
 Cube.ShowCubeDialog;
end;

procedure TFmMain.SparseRowsMenuItemClick(Sender: TObject);
begin
  SparseRowsMenuItem.Checked := not SparseRowsMenuItem.Checked;
  DSource.SparseRows := SparseRowsMenuItem.Checked;
end;

procedure TFmMain.SparseColsMenuItemClick(Sender: TObject);
begin
  SparseColsMenuItem.Checked := not SparseColsMenuItem.Checked;
  DSource.SparseCols := SparseColsMenuItem.Checked;
end;

end.
