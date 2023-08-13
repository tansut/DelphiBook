unit Umdisamp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ImgList, ToolWin;

type
  TFmMain = class(TForm)
    WindowExistsMenu: TMainMenu;
    Dosya1: TMenuItem;
    NewMenuItem: TMenuItem;
    WindowMenu: TMenuItem;
    CloseMenuItem: TMenuItem;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    StatusBar1: TStatusBar;
    CloseMdiMenuItem: TMenuItem;
    procedure CloseMenuItemClick(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseMdiMenuItemClick(Sender: TObject);
  private
    procedure FormChanged(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses mdisamp, Umdiasst;

{$R *.DFM}

procedure TFmMain.CloseMenuItemClick(Sender: TObject);
begin
  Close;
end;

procedure TFmMain.NewMenuItemClick(Sender: TObject);
begin
  TFmMdiChild.Create(Application);
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  Screen.OnActiveFormChange := FormChanged;
end;

procedure TFmMain.FormChanged(Sender: TObject);
begin
  FmAssistant.TotalOpenForm := MDIChildCount;
  CloseMdiMenuItem.Enabled := MDIChildCount > 0;
end;

procedure TFmMain.ToolButton1Click(Sender: TObject);
begin
  NewMenuItemClick(Self);
end;

procedure TFmMain.ToolButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFmMain.FormShow(Sender: TObject);
begin
  FmAssistant.Left := Left + 5;
  FmAssistant.Top := Top + Height - FmAssistant.Height - 20;
  FmAssistant.Show; 
end;

procedure TFmMain.CloseMdiMenuItemClick(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;

end.
