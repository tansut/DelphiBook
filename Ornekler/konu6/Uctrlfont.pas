unit Uctrlfont;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    pnlTest: TPanel;
    cmbFont: TComboBox;
    Label1: TLabel;
    lstSize: TListBox;
    Label2: TLabel;
    btnFont: TButton;
    DlgFont: TFontDialog;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmbFontClick(Sender: TObject);
    procedure lstSizeClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  cmbFont.Items := Screen.Fonts;
  cmbFont.ItemIndex := 0;
  cmbFontClick(Self);
end;

procedure TForm1.cmbFontClick(Sender: TObject);
begin
  with CmbFont do
  begin
    PnlTest.Font.Name := Items[ItemIndex];
  end;
end;

procedure TForm1.lstSizeClick(Sender: TObject);
begin
  with LstSize do
    PnlTest.Font.Size := StrToInt(Items[ItemIndex]);
end;

procedure TForm1.btnFontClick(Sender: TObject);
begin
  DlgFont.Font := PnlTest.Font;
  if DlgFont.Execute then
  begin
    PnlTest.Font := DlgFont.Font;
    CmbFont.ItemIndex := CmbFont.Items.IndexOf(DlgFont.Font.Name);
  end;
end;

end.
