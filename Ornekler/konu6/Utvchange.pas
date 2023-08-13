unit Utvchange;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ComCtrls, ImgList;

type
  TFmMain = class(TForm)
    TV: TTreeView;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure TVChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
  private
    procedure CreateDrives(ParentNode: TTreeNode);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

function VolumeID(DriveChar: Char): string;
var
  OldErrorMode: Integer;
  NotUsed, VolFlags: DWORD;
  Buf: array [0..MAX_PATH] of Char;
begin
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    Buf[0] := #$00;
    if GetVolumeInformation(PChar(DriveChar + ':\'), Buf, DWORD(sizeof(Buf)),
      nil, NotUsed, VolFlags, nil, 0) then
      SetString(Result, Buf, StrLen(Buf))
    else Result := '';  
    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
    Result := Format('[%s]',[Result]);
  finally
    SetErrorMode(OldErrorMode);
  end;
end;

function NetworkVolume(DriveChar: Char): string;
var
  Buf: Array [0..MAX_PATH] of Char;
  DriveStr: array [0..3] of Char;
  BufferSize: DWORD;
begin
  BufferSize := sizeof(Buf);
  DriveStr[0] := UpCase(DriveChar);
  DriveStr[1] := ':';
  DriveStr[2] := #0;
  if WNetGetConnection(DriveStr, Buf, BufferSize) = WN_SUCCESS then
  begin
    SetString(Result, Buf, BufferSize);
    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
  end
  else
    Result := VolumeID(DriveChar);
end;

procedure TFmMain.CreateDrives(ParentNode: TTreeNode);
var
  DriveNum: Integer;
  DriveChar: Char;
  DriveType: TDriveType;
  DriveBits: set of 0..25;

  procedure AddDrive(const VolName: string; ImageIndex: Integer);
  var Node: TTreeNode;
  begin
    Node := TV.Items.AddChild(ParentNode, Format('%s: %s', [DriveChar, VolName]));
    Node.ImageIndex := ImageIndex;
    Node.SelectedIndex := ImageIndex;
  end;

begin
  Integer(DriveBits) := GetLogicalDrives;
  for DriveNum := 0 to 25 do
  begin
    if not (DriveNum in DriveBits) then Continue;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := TDriveType(GetDriveType(PChar(DriveChar + ':\')));
    case DriveType of
      dtFloppy:   AddDrive('', 1);
      dtFixed:    AddDrive(VolumeID(DriveChar), 2);
      dtNetwork:  AddDrive(NetworkVolume(DriveChar), 3);
      dtCDROM:    AddDrive(VolumeID(DriveChar), 4);
      dtRAM:      AddDrive(VolumeID(DriveChar), 5);
    end;
  end;

end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  CreateDrives(TV.Items.Add(nil, 'Sistem Sürücüleri'));
end;

procedure TFmMain.TVChange(Sender: TObject; Node: TTreeNode);
begin
  StatusBar.Panels[0].Text := Node.Text;
end;

procedure TFmMain.TVChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  AllowChange := Node <> TV.Items[0];
  if not AllowChange then
    StatusBar.Panels[0].Text := 'Seçme iþlemi iptal edildi';
end;

end.
