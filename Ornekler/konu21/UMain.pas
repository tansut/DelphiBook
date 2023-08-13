unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Mask, MPlayer, Buttons, ComCtrls, ExtDlgs,
  Menus, Db;

type
  TFmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBImage1: TDBImage;
    Label4: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    Label9: TLabel;
    Label10: TLabel;
    btnSelectPicture: TButton;
    btnPlay: TSpeedButton;
    btnRecord: TSpeedButton;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    btnClose: TButton;
    DatePick: TMonthCalendar;
    OpenPicture: TOpenPictureDialog;
    PopupMenu: TPopupMenu;
    ClearPictureMenuItem: TMenuItem;
    Label11: TLabel;
    procedure DatePickExit(Sender: TObject);
    procedure DatePickDblClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnRecordClick(Sender: TObject);
    procedure btnSelectPictureClick(Sender: TObject);
    procedure ClearPictureMenuItemClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

uses UDM, Urecorder, MMSystem;

procedure TFmMain.DatePickExit(Sender: TObject);
begin
  DatePick.Visible := False;
end;

procedure TFmMain.DatePickDblClick(Sender: TObject);
begin
  with DM do
  begin
    KisiTable.Edit;
    KisiTableDTarih.AsDateTime := DatePick.Date;
    DatePick.Visible := False;
  end;
end;

procedure TFmMain.Label5Click(Sender: TObject);
begin
  if not DM.KisiTableDTarih.IsNull then
   DatePick.Date := DM.KisiTableDTarih.AsDateTime;
  DatePick.Visible := True;
  DatePick.SetFocus;
end;

procedure TFmMain.Panel1Click(Sender: TObject);
begin
  DatePick.Visible := False;
end;

procedure TFmMain.btnPlayClick(Sender: TObject);
var MemStream: TMemoryStream;
begin
  with DM do
  begin
    if KisiTableSes.BlobSize <= 0 then
     raise Exception.Create('Bu kiþi için ses kaydý yapýlmamýþ');
    MemStream := TMemoryStream.Create;
    try
      KisiTableSes.SaveToStream(MemStream);
      PlaySound(MemStream.Memory, 0, SND_SYNC or SND_MEMORY); 
    finally
      MemStream.Free;
    end;
  end;
end;

procedure TFmMain.btnRecordClick(Sender: TObject);
begin
  FmRecorder.Execute(Dm.KisiTable, Dm.KisiTableSes);
end;

procedure TFmMain.btnSelectPictureClick(Sender: TObject);
begin
  if OpenPicture.Execute then
  with DM do
  try
    KisiTable.Edit;
    KisiTableResim.LoadFromFile(OpenPicture.FileName);
  except
    on E: Exception do
     raise Exception.CreateFmt('Sistemde hata: %s', [E.Message]);
  end;
end;

procedure TFmMain.ClearPictureMenuItemClick(Sender: TObject);
begin
  with Dm do
  begin
    KisiTable.Edit;
    KisiTableResim.Clear;
  end;
end;

procedure TFmMain.PopupMenuPopup(Sender: TObject);
begin
  ClearPictureMenuItem.Enabled := Dm.KisiTableResim.BlobSize > 0;
end;

procedure TFmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with DM do
  begin
    if KisiTable.State in dsEditModes then
    begin
      if MessageDlg('Kaydedilmemis deðiþiklikler kaydedilsin mi ?', mtWarning, [mbYes, MbNo], 0) = mrYes then
        KisiTable.Post
      else
        KisiTable.Cancel;
    end;
  end;

end;

end.
