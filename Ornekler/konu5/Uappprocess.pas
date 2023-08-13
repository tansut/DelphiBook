unit Uappprocess;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
    S: string;
begin
  for i := 1 to 10000 do
  begin
    S := IntToStr(i*5);
    Label4.Caption := S;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i: integer;
    S: string;
begin
  for i := 1 to 10000 do
  begin
    S := IntToStr(i*5);
    Label4.Caption := S;
    Application.ProcessMessages;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i: integer;
    S: string;
begin
  for i := 1 to 10000 do
  begin
    S := IntToStr(i*5);
    Label4.Caption := S;
    Application.ProcessMessages;
    if Application.Terminated then Break;
  end;
end;

end.
