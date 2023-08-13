unit Upasstest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LblUser: TLabel;
    LblPassword: TLabel;
    Label3: TLabel;
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
function ExecutePassWordForm(Username, PassWord: PChar): Boolean; external 'passwd.dll' name 'ExecuteUserPasswordBox';

procedure TForm1.Button1Click(Sender: TObject);
var Res: Boolean;
    UserName, Password: String;
begin
  SetLength(Username, 100);
  SetLength(Password, 100);
  Res := ExecutePassWordForm(PChar(UserName), PChar(Password));
  if Res then
  begin
    LblUser.Caption := UserName;
    LblPassword.Caption := Password;
  end else ShowMessage('Ýptal edildi');
end;

end.
