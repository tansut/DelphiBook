unit Uscreen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    LblActiveForm: TLabel;
    GroupBox2: TGroupBox;
    Button2: TButton;
    GroupBox3: TGroupBox;
    btnListFonts: TButton;
    Label1: TLabel;
    cmbfontlist: TComboBox;
    GroupBox4: TGroupBox;
    btnforms: TButton;
    lstForms: TListBox;
    lblFormCount: TLabel;
    GroupBox5: TGroupBox;
    btnScreenWH: TButton;
    Label2: TLabel;
    Label3: TLabel;
    lblScreenWidth: TLabel;
    lblScreenHeight: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnListFontsClick(Sender: TObject);
    procedure btnformsClick(Sender: TObject);
    procedure btnScreenWHClick(Sender: TObject);
  private
    CreateCount: Integer;
    CursorIndex: Integer;
    procedure FormChanged(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uscreen2;
{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Inc(CreateCount);
  with TForm2.Create(nil) do
  begin
    Caption := Format('Test Form %d', [CreateCount]);
    Show;
  end;
  {Form2.OnClose olay metodunu inceleyiniz}
end;

procedure TForm1.FormChanged(Sender: TObject);
begin
  if Screen.ActiveForm <> nil then
   LblActiveForm.Caption := Format('Aktif Form: %s', [Screen.ActiveForm.Caption]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CreateCount := 0;
  CursorIndex := -1;
  Screen.OnActiveFormChange := FormChanged;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Dec(CursorIndex);
  if CursorIndex < -21 then
   CursorIndex := 0;
  Screen.Cursor := TCursor(CursorIndex);
end;

procedure TForm1.btnListFontsClick(Sender: TObject);
begin
  cmbfontlist.Items := Screen.Fonts;
  cmbfontlist.ItemIndex := 0;
end;

procedure TForm1.btnformsClick(Sender: TObject);
var i: Integer;
begin
  lstForms.Items.Clear;
  for i := 0 to Screen.FormCount - 1 do
    lstForms.Items.Add(Screen.Forms[i].Caption);
  lblFormCount.Caption := IntToStr(Screen.FormCount);
end;

procedure TForm1.btnScreenWHClick(Sender: TObject);
begin
  lblScreenWidth.Caption  := Format('%d pixel', [Screen.Width]);
  lblScreenHeight.Caption := Format('%d pixel', [Screen.Height]);
end;

end.
