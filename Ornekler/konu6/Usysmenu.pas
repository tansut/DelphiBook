unit Usysmenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
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
var
  H : hMenu;
  N : Integer;
begin
  H := GetSystemMenu(Handle, False);
  for N := GetMenuItemCount(H)-1 downto 0 do
    case GetMenuItemID(H, N) of
      SC_CLOSE,
      SC_MOVE,
      SC_MINIMIZE : ;
      else RemoveMenu(H, N, MF_BYPOSITION);
    end;
end;

end.
