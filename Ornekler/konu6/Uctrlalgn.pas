unit Uctrlalgn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
begin
  Label1.Align := alTop;
  Label1.AutoSize := False;
  Label1.AutoSize := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Label1.Align := alBottom;
  Label1.AutoSize := False;
  Label1.AutoSize := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Label1.Align := alLeft;
  Label1.AutoSize := False;
  Label1.AutoSize := True;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Label1.Align := alRight;
  Label1.AutoSize := False;
  Label1.AutoSize := True;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Label1.Align := alClient;
  Label1.AutoSize := False;
  Label1.AutoSize := True;
end;

end.
