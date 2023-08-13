unit Usysmenuadd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
        procedure SysCommand(var Msg: TMessage); message wm_SysCommand;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  SysMenu: hMenu;
begin
  SysMenu := GetSystemMenu(Handle, False);
  ModifyMenu(SysMenu, sc_Close, mf_ByCommand, sc_Close, '&Programý Kapat'#9'Alt+F4');
  DeleteMenu(SysMenu, 0, mf_ByPosition);
  AppendMenu(SysMenu, mf_Separator, 0, #0);
  AppendMenu(SysMenu, mf_ByCommand, 666, '&Hakkýnda...');
end;


procedure TForm1.SysCommand(var Msg: TMessage);
begin
  inherited;
  if Msg.wParam = 666 then
   ShowMessage('Program hakkinda');
end;

end.
