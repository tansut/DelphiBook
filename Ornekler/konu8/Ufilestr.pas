unit Ufilestr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, ImgList;

const
  FileName = 'adresler.dat';

type
  TPerson = record
   Ad, Soyad: string[50];
   EMail: string[127];
   Telefon: string[20];
   Adres: string[200];
  end;

  TFmMain = class(TForm)
    Panel1: TPanel;
    btnAdd: TButton;
    pnlLeft: TPanel;
    lstPerson: TListBox;
    Splitter1: TSplitter;
    PnlData: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edName: TEdit;
    edSurname: TEdit;
    edTel: TEdit;
    edMail: TEdit;
    MemAdres: TMemo;
    lblStatus: TLabel;
    ImgList: TImageList;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstPersonClick(Sender: TObject);
    procedure lstPersonDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FileStream: TFileStream;
    procedure AddToList(APerson: TPerson);
    procedure SaveCurrentPerson;
    procedure ReadFileContents;
    function ReadPersonFromFile(Index: Integer): TPerson;
    procedure ValidateData;
    function GetPersonInf: TPerson;
    procedure ShowPerson(APerson: TPerson);
    procedure ClearEdits(Edits: array of TEdit);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

procedure TFmMain.btnAddClick(Sender: TObject);
begin
  case btnAdd.Tag of
  0:
   begin
     btnAdd.Tag := 1;
     lblStatus.Caption := 'Yeni kayýt ekleniyor';
     EdName.SetFocus;
     lstPerson.Enabled := False;
     btnAdd.Caption := 'Kaydet';
     ClearEdits([edName, edSurname, edTel, edMail]);
     MemAdres.Lines.Clear;
   end;
  1:
   begin
     ValidateData;
     SaveCurrentPerson;
     lblStatus.Caption := '';
     btnAdd.Tag := 0;
     btnAdd.Caption := 'Ekle ...';
     lstPerson.Enabled := True;
   end;
  end;
end;

function TFmMain.GetPersonInf: TPerson;
begin
  with Result do
  begin
    Ad := edName.Text;
    SoyAd := edSurname.Text;
    EMail := edMail.Text;
    Telefon := edTel.Text;
    Adres := MemAdres.Lines.Text;
  end;
end;

procedure TFmMain.ShowPerson(APerson: TPerson);
begin
  with APerson do
  begin
    edName.Text := Ad;
    edSurname.Text := SoyAd;
    edMail.Text := EMail;
    edTel.Text := Telefon;
    MemAdres.Lines.Text := Adres;
  end;
end;

procedure TFmMain.ValidateData;
begin
  if edName.Text = '' then
  begin
    edName.SetFocus;
    raise Exception.Create('Adý boþ olmaz');
  end;
  if edSurname.Text = '' then
  begin
    edSurname.SetFocus;
    raise Exception.Create('Soyadý boþ olmaz');
  end;
end;


procedure TFmMain.FormCreate(Sender: TObject);
begin
  if not FileExists(FileName) then
  begin
    try
      FileStream := TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    finally
      FileStream.Free;
    end;
  end;
  FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyWrite);
  ReadFileContents;
  if lstPerson.Items.Count > 0 then
  begin
    lstPerson.ItemIndex := 0;
    lstPersonClick(lstPerson);
  end;  
end;

procedure TFmMain.FormDestroy(Sender: TObject);
begin
  FileStream.Free;
end;

procedure TFmMain.ReadFileContents;
var
 i: integer;
 APerson: TPerson;
begin
  i := 0;
  with FileStream do
  begin
     Position := 0;
     while Position < Size do
     begin
       APerson := ReadPersonFromFile(i);
       AddToList(APerson);
       Inc(i);
     end;
  end;
end;

function TFmMain.ReadPersonFromFile(Index: Integer): TPerson;
begin
  FileStream.Seek(Index * SizeOf(TPerson), soFromBeginning);
  FileStream.ReadBuffer(Result, SizeOf(TPerson));
end;

procedure TFmMain.SaveCurrentPerson;
var APerson: TPerson;
begin
  APerson := GetPersonInf;
  FileStream.Seek(0, soFromEnd);
  FileStream.WriteBuffer(APerson, SizeOf(TPerson));
  AddToList(APerson);
  lstPerson.ItemIndex := lstPerson.Items.Count - 1;
end;

procedure TFmMain.AddToList(APerson: TPerson);
begin
  lstPerson.Items.Add(Format('%s %s', [APerson.Ad, APerson.Soyad]) + #13#10 + APerson.EMail);
end;

procedure TFmMain.ClearEdits(Edits: array of TEdit);
var i: integer;
begin
  for i := Low(Edits) to High(Edits) do
   Edits[i].Text := '';
end;

procedure TFmMain.lstPersonClick(Sender: TObject);
var APerson: TPerson;
begin
  APerson := ReadPersonFromFile(lstPerson.ItemIndex);
  ShowPerson(APerson);
end;

procedure TFmMain.lstPersonDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control AS TListBox, Canvas DO
    begin
      FillRect(Rect);
      InflateRect(Rect, -1, -1);
      with Rect do Rectangle(Left, Top, Right, Bottom);
      InflateRect(Rect, -2, -2);
      ImgList.Draw(Canvas, Rect.Left, Rect.Top + 1, 0, True);
      Inc(Rect.Left, 35);
      DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
    end;
end;

procedure TFmMain.Splitter1Moved(Sender: TObject);
begin
  lstPerson.Invalidate;
end;

procedure TFmMain.FormResize(Sender: TObject);
begin
  lstPerson.Invalidate;
end;

procedure TFmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (btnAdd.Tag = 0) or
              (MessageDlg('Programdan çýkmanýz durumunda eklemek istediðiniz kayýt yapýlmayacaktýr.', mtWarning, [mbOk, mbCancel], 0) = mrOk);
end;

end.
