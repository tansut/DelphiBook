unit Uhspmak;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses hspmak, bhspmak;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  HesapMakinem: TBilimselHesapMakinesi;
  Sonuc: Double;
begin
  HesapMakinem := TBilimselHesapMakinesi.Create;
  HesapMakinem.Operand1 := 2;
  HesapMakinem.Operand2 := 3;
  HesapMakinem.Operator := opUs;
  Sonuc := HesapMakinem.Hesapla;
  HesapMakinem.Free;
  ShowMessage('Bilimsel hesap makinesi ile hesaplanan 2^3 iþleminin sonucu: ' + FloatToStr(Sonuc));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  HesapMakinem: THesapMakinesi;
  Sonuc: Double;
begin
  HesapMakinem := TBilimselHesapMakinesi.Create;
  HesapMakinem.Operand1 := 2;
  HesapMakinem.Operand2 := 3;
  HesapMakinem.Operator := opCarpi;
  Sonuc := HesapMakinem.Hesapla;
  HesapMakinem.Free;
  ShowMessage('Hesap makinesi ile hesaplanan 2x3 iþleminin sonucu: ' + FloatToStr(Sonuc));
end;

end.
