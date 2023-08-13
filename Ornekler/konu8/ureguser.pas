unit ureguser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TRegUserInfo = record
   Name, Company: string;
  end;

  TForm1 = class(TForm)
    Label1: TLabel;
    lblName: TLabel;
    lblCompany: TLabel;
    btnGetInf: TButton;
    procedure btnGetInfClick(Sender: TObject);
  private
    procedure GetRegUserInfo(var RegUserInfo: TRegUserInfo);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }
uses Registry;

procedure TForm1.GetRegUserInfo(var RegUserInfo: TRegUserInfo);
begin
  with TRegistry.Create, RegUserInfo do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('Software\Microsoft\Windows\CurrentVersion', True) then
    begin
      Name := ReadString('RegisteredOwner');
      Company := ReadString('RegisteredOrganization');
    end else raise Exception.Create('Anahtar açýlamadý');
  finally
    Free;
  end;
end;

procedure TForm1.btnGetInfClick(Sender: TObject);
var UserInf: TRegUserInfo;
begin
  try
    GetRegUserInfo(UserInf);
    with UserInf do
    begin
      LblName.Caption := Name;
      lblCompany.Caption := Company;
    end;
  except
    LblName.Caption := 'ALINAMADI';
    lblCompany.Caption := 'ALINAMADI';
  end;
end;

end.
