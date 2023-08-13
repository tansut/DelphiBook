unit ulistview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, FileCtrl, ExtCtrls, ImgList, Menus, ToolWin;

type
  TFileSort = (fsName, fsSize, fsType, fsAttr);
  
  TFmMain = class(TForm)
    Panel1: TPanel;
    cmbDrive: TDriveComboBox;
    StatusBar1: TStatusBar;
    LV: TListView;
    LargeImgs: TImageList;
    ToolBar: TToolBar;
    ToolbarImgs: TImageList;
    ToolButton1: TToolButton;
    PopView: TPopupMenu;
    Liste1: TMenuItem;
    BykResimler1: TMenuItem;
    KkSimgeler1: TMenuItem;
    Detaylar1: TMenuItem;
    SmallImgs: TImageList;
    btnFind: TToolButton;
    FindDialog: TFindDialog;
    Label1: TLabel;
    procedure cmbDriveChange(Sender: TObject);
    procedure Detaylar1Click(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LVColumnClick(Sender: TObject; Column: TListColumn);
    procedure LVCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure btnFindClick(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
  private
    FDir: string;
    FileSort: TFileSort;
    procedure ShowDirectory(Directory: string; UpdateOldDir: Boolean);
    procedure ShowDirectoryItems(const Directory: string);
    function CreateDirectoryItem(SR: TSearchRec): TListItem;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

procedure TFmMain.cmbDriveChange(Sender: TObject);
begin
  FDir := cmbDrive.Drive + ':\';
  ShowDirectory(cmbDrive.Drive, False);
end;


function TFmMain.CreateDirectoryItem(SR: TSearchRec): TListItem;

 function GetAttrStr: string;
 begin
   Result := '';
   if faReadOnly and SR.Attr > 0 then
    Result := Result + 'R';
   if faArchive and SR.Attr > 0 then
    Result := Result + 'A';
   if faHidden and SR.Attr > 0 then
    Result := Result + 'H';
   if faSysFile and SR.Attr > 0 then
    Result := Result + 'S';
 end;

begin
  Result := nil;
  if SR.Name = '.' then Exit;
  Result := LV.Items.Add;
  with Result, Sr do
  begin
    Caption := Name;
    if faDirectory and Attr > 0 then
    begin
      ImageIndex := 0;
      SubItems.Add('');
      SubItems.Add('Klasör');
    end
    else
    begin
      ImageIndex := 1;
      SubItems.Add(Format('%d', [Size div 1024]));
      SubItems.Add(ExtractFileExt(Name) + ' dosyasý');
    end;
    SubItems.Add(GetAttrStr);
  end;
end;

procedure TFmMain.ShowDirectory(Directory: string;
  UpdateOldDir: Boolean);
begin
  LV.Items.Clear;
  if UpdateOldDir then
  begin
    FDir := FDir + Directory + '\';
  end;
  ShowDirectoryItems(FDir);
end;

procedure TFmMain.ShowDirectoryItems(const Directory: string);
var SR: TSearchRec;
    IsFound: Boolean;
begin
  with LV do
  begin
    IsFound := FindFirst(Directory + '*.*', faAnyFile, SR) = 0;
    while IsFound do
    begin
      CreateDirectoryItem(SR);
      IsFound := FindNext(SR) = 0;
    end;
    FindClose(SR);
  end;
end;

procedure TFmMain.Detaylar1Click(Sender: TObject);
begin
  LV.ViewStyle := TViewStyle((Sender as TMenuItem).Tag);
  (Sender as TMenuItem).Checked := True;
end;

procedure TFmMain.LVDblClick(Sender: TObject);
begin
  if LV.Selected = nil then Exit;
  if LV.Selected.SubItems[0] = '' then
   ShowDirectory(LV.Selected.Caption, True);
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  FileSort := fsName;
end;

procedure TFmMain.LVColumnClick(Sender: TObject; Column: TListColumn);
begin
  FileSort := TFileSort(Column.Index);
  if not LV.AlphaSort then
   ShowMessage('Sýralama iþlemi baþarýsýz');
end;

procedure TFmMain.LVCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var S1, S2: string;
begin
  case FileSort of
  fsName:
  begin
   S1 := Item1.Caption;
   S2 := Item2.Caption;
  end;
  fsSize:
  begin
   S1 := Format('%10d', [StrToIntDef(Item1.SubItems[0], 0)]);
   S2 := Format('%10d', [StrToIntDef(Item2.SubItems[0], 0)]);
  end;
  fsType:
  begin
   S1 := Item1.SubItems[1];
   S2 := Item2.SubItems[1];
  end;
  fsAttr:
  begin
   S1 := Item1.SubItems[2];
   S2 := Item2.SubItems[2];
  end;
  end;
  if  S1 > S2 then
    Compare := 1
  else if S1 < S2 then
    Compare := -1
  else Compare := 0;
end;

procedure TFmMain.btnFindClick(Sender: TObject);
begin
  FindDialog.Tag := -1;
  FindDialog.Execute;
end;

procedure TFmMain.FindDialogFind(Sender: TObject);
var Partial: Boolean;
    Inclusive: Boolean;
    Item: TListItem;
begin
  Partial := not (frWholeWord in FindDialog.Options);
  Inclusive := FindDialog.Tag = -1;
  if Inclusive then FindDialog.Tag := 0;
  Item := LV.FindCaption(FindDialog.Tag, FindDialog.FindText, Partial, Inclusive, False);
  if Item = nil then
   ShowMessage(Format('%s bulunamadý', [FindDialog.FindText]))
  else
  begin
    FindDialog.Tag := Item.Index;
    Lv.Selected := Item;
  end;  
end;

end.
