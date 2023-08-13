unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, FileCtrl, StdCtrls, Menus;

type
  TMainFrm = class(TForm)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    DirectoryListBox1: TDirectoryListBox;
    FilterComboBox1: TFilterComboBox;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    FullViewBtn: TButton;
    Image: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Options1: TMenuItem;
    FileLabelMenuItem: TMenuItem;
    DefaultIcon: TImage;
    Image2: TImage;
    Bevel1: TBevel;
    procedure FileListBox1Click(Sender: TObject);
    procedure FullViewBtnClick(Sender: TObject);
    procedure ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure FileLabelMenuItemClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procedure NextPicture;
    procedure PreviousPicture;
    procedure LoadFile(const F: string);
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

uses ImageU, AboutU;

{$R *.DFM}


procedure TMainFrm.LoadFile(const F: string);
begin
  try
    Image.Picture.LoadfromFile(F);
    Image2.Picture := Image.Picture;
    MainFrm.Caption := 'Picture Viewer - ' + ExtractFileName(f);
    ImageFrm.FileLabel.Caption := F;
    if ExtractFileExt(F)='.ICO' then
      Application.Icon.LoadFromFile(f)
    else
      Application.Icon := DefaultIcon.Picture.Icon;
  except
    raise;
  end;
end;

procedure TMainFrm.NextPicture;
begin
  try
    with FileListBox1 do
    begin
      if ItemIndex=Items.Count-1 then
        ItemIndex := 0
      else
        ItemIndex := ItemIndex + 1;
      FileListBox1Click(Self);
    end;
  except
  end;
end;
procedure TMainFrm.PreviousPicture;
begin
  try
    with FileListBox1 do
    begin
      if ItemIndex=0 then
        ItemIndex := Items.Count - 1
      else
        ItemIndex := ItemIndex - 1;
      FileListBox1Click(Self);
    end;
  except
  end;
end;
procedure TMainFrm.FileListBox1Click(Sender: TObject);
begin
  LoadFile(FileListBox1.FileName);
end;

procedure TMainFrm.FullViewBtnClick(Sender: TObject);
begin
  ImageFrm.Image.Picture := Image.Picture;
  ImageFrm.ShowModal;
end;

procedure TMainFrm.ScrollBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FileListBox1.Items.Count=0 then Exit;
  if Button=mbRight then
    PreviousPicture
  else if Button = mbLeft then
    NextPicture;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  FileListBox1.Mask := FilterComboBox1.Mask;
  if ParamCount>0 then
  try
    LoadFile(ParamStr(1));
    DirectoryListBox1.Directory := ExtractFilePath(ParamStr(1));
    FileListBox1.FileName := ParamStr(1);
  except
  end;
end;

procedure TMainFrm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainFrm.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainFrm.Copy1Click(Sender: TObject);
begin
  try
    {Image.Picture.CopyToClipBoard;}
  except
    raise Exception.Create('Unable to copy the image');
  end;
end;

procedure TMainFrm.FileListBox1Change(Sender: TObject);
begin
  FullViewBtn.Enabled := FileListBox1.Items.Count<>0;
end;

procedure TMainFrm.FileLabelMenuItemClick(Sender: TObject);
begin
  FileLabelMenuItem.Checked := not FileLabelMenuItem.Checked;
  ImageFrm.FileLabel.Visible := FileLabelMenuItem.Checked;
end;

procedure TMainFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#27) and (FullViewBtn.Enabled) then
    FullViewBtnClick(Self);
end;

end.
