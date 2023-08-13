unit Uctrlcolor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    cmbColor: TComboBox;
    lblColor: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const
  ColorsCount = 16;
  ColorValues: array [0..ColorsCount - 1] of TColor = (
    clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
    clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  ColorNames: array[0..ColorsCount - 1] of string = (
    'Siyah', 'Viþne Rengi', 'Yeþil', 'Zeytin Yeþili', 'Koyu Mavi', 'Mor', 'Turkuvaz', 'Gri',
    'Gümüþ', 'Kýrmýzý', 'Açýk Yeþil', 'Sarý', 'Mavi', 'Pembe', 'Boncuk Mavi', 'Beyaz');

procedure TForm1.Button2Click(Sender: TObject);
var I: Integer;
begin
  Randomize;
  for I := 0 to ComponentCount - 1 do
   if Components[i] is TEdit then
     TEdit(Components[i]).Color := ColorValues[Random(ColorsCount)];
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 0 to ColorsCount - 1 do
    CmbColor.Items.Add(ColorNames[i]);
  CmbColor.ItemIndex := 0;
end;

procedure TForm1.cmbColorClick(Sender: TObject);
begin
  with CmbColor do
  begin
    lblColor.Font.Color := ColorValues[ItemIndex];
    lblColor.Caption := Items[ItemIndex];
  end;
end;

end.
