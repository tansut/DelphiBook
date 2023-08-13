unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, MPlayer, ComCtrls, ToolWin, Menus,
  ImgList;

type
  TPlayType = (ptFiles, ptCd, ptNone);
  TFmMusicBox = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Shape1: TShape;
    Player: TMediaPlayer;
    PlayList: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusLabel: TLabel;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    Timer: TTimer;
    TimeLabel: TLabel;
    ElapsedTimeLabel: TLabel;
    Label5: TLabel;
    CdImage: TImage;
    DeviceTypeMenu: TPopupMenu;
    FileMenuItem: TMenuItem;
    CDMenuItem: TMenuItem;
    PauseBtn: TToolButton;
    PlayBtn: TToolButton;
    PreviousBtn: TToolButton;
    NextBtn: TToolButton;
    ToolButton5: TToolButton;
    SetFileBtn: TToolButton;
    SoundBtn: TToolButton;
    DeviceTypeBtn: TToolButton;
    Label3: TLabel;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    PrevBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    NoneMenuItem: TMenuItem;
    Shape2: TShape;
    FileImage: TImage;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    HotImages: TImageList;
    procedure SetFileBtnClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure SoundBtnClick(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure PreviousBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure FileMenuItemClick(Sender: TObject);
    procedure CDMenuItemClick(Sender: TObject);
    procedure NoneMenuItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    CurrentIndex: Integer;
    FPlayType: TPlayType;
    ElapsedTime: Integer;
    LastState: Integer;
    procedure SetPlayType(Value: TPlayType);
    function GetElapsedTime: string;
  public
    function OpenMedia(MediaType: TPlayType): Boolean;
    procedure CExecute;
    procedure PlayNextFile;
    procedure PlayPreviousFile;
    procedure LoadSettings;
    procedure SaveSettings;
    property PlayType: TPlayType read FPlayType write SetPlayType;
  end;

var
  FmMusicBox: TFmMusicBox;

implementation

{$R *.DFM}
uses Registry;
procedure TFmMusicBox.CExecute;
begin
  if LastState = 1 then Show;
end;
function TFmMusicBox.GetElapsedTime: string;
var H, M, S: Word;
begin
  H := ElapsedTime div 3600;
  M := (ElapsedTime - (H * 3600)) div 60;
  S := (ElapsedTime - (H * 3600) - M * 60) mod 60;
  Result := Format('%.2d:%.2d:%.2d', [H, M, S]);
end;

function TFmMusicBox.OpenMedia(MediaType: TPlayType): Boolean;
begin
  Result := False;
  case MediaType of
  ptCD:
   begin
     if Player.Mode = mpPlaying then Player.Stop;
     Player.FileName := '';
     Player.DeviceType := dtCDAudio;
     try
       Player.Open;
     except
       Exit;
     end;
   end;
  ptFiles:
   begin
     if Player.Mode = mpPlaying then Player.Stop;
     Player.DeviceType := dtAutoSelect;
     if PlayList.Items.Count > 0 then
       Player.FileName := PlayList.Items[CurrentIndex]
     else Exit;
     try
       Player.Open;
     except
       Exit;
     end;
   end;
  ptNone:
   begin
     if Player.Mode = mpPlaying then Player.Stop;
     Player.Close;
     Exit;
   end;
  end;
  Result := True;
end;

procedure TFmMusicBox.PlayNextFile;
begin
  CurrentIndex := CurrentIndex + 1;
  if CurrentIndex > PlayList.Items.Count - 1 then
    CurrentIndex := 0;
  PlayType := ptFiles;
end;

procedure TFmMusicBox.PlayPreviousFile;
begin
  CurrentIndex := CurrentIndex - 1;
  if CurrentIndex < 0 then CurrentIndex := PlayList.Items.Count - 1;
  PlayType := ptFiles;
end;

procedure TFmMusicBox.SetPlayType(Value: TPlayType);
begin
  FPlayType := Value;
  ElapsedTime := 0;
  case PlayType of
  ptFiles:  FileMenuItem.Checked := True;
  ptCd: CDMenuItem.Checked := True;
  ptNone:  NoneMenuItem.Checked := True;
  end;
  CdImage.Visible := FPlayType = ptCD;
  FileImage.Visible := FPlayType = ptFiles;
  if OpenMedia(FPlayType) then
  begin
    Player.Play;
    Timer.Enabled := True;
  end
  else
  begin
    StatusLabel.Caption := 'Durduruldu';
    Timer.Enabled := False;
  end;
end;

procedure TFmMusicBox.LoadSettings;
begin
  PlayList.Items.Clear;
end;

procedure TFmMusicBox.SaveSettings;

begin
end;

procedure TFmMusicBox.SetFileBtnClick(Sender: TObject);
begin
  Height := 255;
end;

procedure TFmMusicBox.SpeedButton3Click(Sender: TObject);
begin
  Height := 135;
  if PlayType = ptFiles then
  begin
    if CurrentIndex > PlayList.Items.Count - 1 then
    begin
      CurrentIndex := 0;
      PlayType := ptNone;
      PlayType := ptFiles;
    end;
  end else if PlayType = ptNone then
  begin
    CurrentIndex := 0;
    PlayType := ptFiles;
  end;  
end;

procedure TFmMusicBox.TimerTimer(Sender: TObject);
begin
  TimeLabel.Caption := FormatDateTime('hh:mm:ss', Now);
  if Player.Mode = mpPlaying then
  begin
    if PlayType = ptCD then StatusLabel.Caption := 'CD Audio Çalýyor'
    else if PlayType = ptFiles then if CurrentIndex < PlayList.Items.Count then StatusLabel.Caption := ExtractFileName(PlayList.Items[CurrentIndex]) + ' Çalýyor';
  end else
  begin
    case PlayType of
    PtFiles:
     begin
       ElapsedTime := 0;
       PlayNextFile;
     end;
    ptCD:
     begin
       StatusLabel.Caption := 'Durduruldu';
       Exit;
     end;
    end;
  end;
  ElapsedTime := ElapsedTime + 1;
  ElapsedTimeLabel.Caption := GetElapsedTime;
end;


procedure TFmMusicBox.FormCreate(Sender: TObject);
begin
  LoadSettings;
  if CurrentIndex > PlayList.Items.Count -1 then CurrentIndex := 0;
  ElapsedTime := 0;
  PlayType := FPlayType;
end;

procedure TFmMusicBox.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    PlayList.Items.AddStrings(OpenDialog.Files);
  end;
end;

procedure TFmMusicBox.SpeedButton2Click(Sender: TObject);
begin
  if PlayList.ItemIndex = - 1 then
  begin
    if PlayList.Items.Count > 0 then
      PlayList.ItemIndex := 0
    else Exit;
  end;
  if PlayList.ItemIndex = - 1 then
  begin
    if PlayList.Items.Count > 0 then
      PlayList.ItemIndex := 0
    else Exit;
  end;
end;

procedure TFmMusicBox.PrevBtnClick(Sender: TObject);
var S: string;
begin
  if (PlayList.ItemIndex = -1) or (PlayList.Items.Count < 1) then Exit;
  if TSpeedButton(Sender) = PrevBtn then
  begin
    if PlayList.ItemIndex = 0 then Exit;
    S := PlayList.Items[PlayList.ItemIndex];
    PlayList.Items[PlayList.ItemIndex] := PlayList.Items[PlayList.ItemIndex-1];
    PlayList.Items[PlayList.ItemIndex-1] := S;
    PlayList.ItemIndex := PlayList.ItemIndex - 1
  end else
  begin
    if PlayList.ItemIndex = PlayList.Items.Count - 1 then Exit;
    S := PlayList.Items[PlayList.ItemIndex+1];
    PlayList.Items[PlayList.ItemIndex+1] := PlayList.Items[PlayList.ItemIndex];
    PlayList.Items[PlayList.ItemIndex] := S;
    PlayList.ItemIndex := PlayList.ItemIndex + 1
  end;

end;

procedure TFmMusicBox.SoundBtnClick(Sender: TObject);
begin
  WinExec('SNDVOL32.EXE', SW_SHOWNORMAL);
end;

procedure TFmMusicBox.PauseBtnClick(Sender: TObject);
begin
  if PlayType = ptNone then Exit;
  Player.Pause;
  Timer.Enabled := False;
  StatusLabel.Caption := 'Durduruldu';
end;

procedure TFmMusicBox.PlayBtnClick(Sender: TObject);
begin
  if PlayType = ptNone then Exit;
  Player.Play;
  Timer.Enabled := True;
end;

procedure TFmMusicBox.PreviousBtnClick(Sender: TObject);
begin
  if PlayType = ptNone then Exit;
  if Player.DeviceType = dtCDAudio then Player.Previous
  else PlayPreviousFile;
end;

procedure TFmMusicBox.NextBtnClick(Sender: TObject);
begin

  if PlayType = ptNone then Exit;
  if Player.DeviceType = dtCDAudio then Player.Next
  else PlayNextFile;
end;

procedure TFmMusicBox.FileMenuItemClick(Sender: TObject);
begin
  PlayType := ptFiles;
end;

procedure TFmMusicBox.CDMenuItemClick(Sender: TObject);
begin
  PlayType := ptCD;
end;

procedure TFmMusicBox.NoneMenuItemClick(Sender: TObject);
begin
  PlayType := ptNone;
end;



procedure TFmMusicBox.FormDestroy(Sender: TObject);
begin
  if Player.Mode =mpPlaying then Player.Stop;
  if Player.Mode = mpOpen then Player.Close;
  SaveSettings;
end;

procedure TFmMusicBox.ToolButton1Click(Sender: TObject);
begin
  if Height > 45 then Height := 45
  else Height := 135;
end;

procedure TFmMusicBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //PlayType := ptNone;
  LastState := 0;
end;

procedure TFmMusicBox.ToolButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TFmMusicBox.FormShow(Sender: TObject);
begin

  LastState := 1;
end;


end.
