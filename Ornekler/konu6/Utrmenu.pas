unit Utrmenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    ProgramMenuItem: TMenuItem;
    k1: TMenuItem;
    N1: TMenuItem;
    EdApp: TEdit;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    OpenDialog: TOpenDialog;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure MenuItemClicked(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var Item: TMenuItem;
begin
  Item := TMenuItem.Create(Self);
  Item.Caption := EdApp.Text;
  Item.OnClick := MenuItemClicked;
  ProgramMenuItem.Add(Item);
end;

procedure TForm1.MenuItemClicked(Sender: TObject);
begin
  ShowMessage((Sender as TMenuItem).Caption);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
   EdApp.Text := OpenDialog.Filename;
end;

end.
