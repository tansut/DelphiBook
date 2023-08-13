unit Upasswd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPassForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edUser: TEdit;
    edPasswd: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    gr: TGroupBox;
  private
    { Private declarations }
  public
    function Execute(const UserName, Password: String): Boolean;
  end;

function ExecuteUserPasswordBox(Username, PassWord: PChar): Boolean;

implementation

{$R *.DFM}

function ExecuteUserPasswordBox(Username, PassWord: PChar): Boolean;
var PassWordForm: TPassForm;
begin
  PassWordForm := TPassForm.Create(nil);
  try
    Result := PassWordForm.Execute(UserName, Password);
    if Result then
    begin
      StrPCopy(UserName, PassWordForm.edUser.Text);
      StrPCopy(Password, PassWordForm.edPasswd.Text);
    end;
  finally
    PassWordForm.Free;
  end;
end;

function TPassForm.Execute(const UserName, Password: String): Boolean;
begin
  edUser.Text := '';
  edPasswd.Text := '';
  Result := ShowModal = mrOk;

end;

end.
