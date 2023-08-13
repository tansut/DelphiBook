unit utestprjstatik;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure ShowFormFromDLL; external 'test.dll' name 'ShowForm';
function UsBul(i, j: Integer): Integer; external 'test.dll' name 'UsAl';

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowFormFromDLL;
  ShowMessage(IntToStr(UsBul(2, 3)));
end;

end.
