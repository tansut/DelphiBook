unit Uapphint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    Label1: TLabel;
    shpRed: TShape;
    ShpBlue: TShape;
    ShpYellow: TShape;
    btnRed: TSpeedButton;
    btnBlue: TSpeedButton;
    btnYellow: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnRedClick(Sender: TObject);
    procedure btnBlueClick(Sender: TObject);
    procedure btnYellowClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure ShowHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  Application.OnHint := ShowHint;
  for i := 0 to ComponentCount - 1 do
   if Components[i] is TControl then
    TControl(Components[i]).Hint :=
     Format('Üzerinde bulunduðunuz bileþenin adý %s ve sýnýfý %s', [Components[i].Name, Components[i].ClassName]);
end;

procedure TForm1.ShowHint(Sender: TObject);
begin
  Label1.Color := Application.HintColor;
  Label1.Caption := Application.Hint;
end;

procedure TForm1.btnRedClick(Sender: TObject);
begin
  Application.HintColor := clRed;
end;

procedure TForm1.btnBlueClick(Sender: TObject);
begin
  Application.HintColor := clBlue;
end;

procedure TForm1.btnYellowClick(Sender: TObject);
begin
  Application.HintColor := clYellow;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Application.HintColor := clInfoBk;
end;

end.
