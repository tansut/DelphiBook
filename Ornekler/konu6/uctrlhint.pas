unit uctrlhint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    lemler1: TMenuItem;
    Kaydet1: TMenuItem;
    Sil1: TMenuItem;
    Ekle1: TMenuItem;
    N1: TMenuItem;
    Programdank1: TMenuItem;
    StatusBar: TStatusBar;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Programdank1Click(Sender: TObject);
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
begin
  Application.OnHint := ShowHint;
end;

procedure TForm1.ShowHint(Sender: TObject);
begin
  StatusBar.SimpleText := Application.Hint;
end;

procedure TForm1.Programdank1Click(Sender: TObject);
begin
  Close;
end;

end.
