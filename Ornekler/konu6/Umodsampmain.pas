unit Umodsampmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
 USERDEFINEDRESULT = 100;
   
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

uses umodsamp;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var S: string;
begin
  case Form2.ShowModal of
  mrYes: S := 'Evet';
  mrNo : S := 'Hay�r';
  mrCancel: S := '�ptal';
  mrRetry : S := 'Tekrar dene';
  USERDEFINEDRESULT: S := 'Programc� tan�ml� sonu�';
  else S := 'Hi�biri';
  end;
  Label1.Caption := S;
end;

end.
