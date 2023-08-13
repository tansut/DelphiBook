unit uctrlrefresh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    LblTest: TLabel;
    chkUseRefresh: TCheckBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FCurrent: Integer;
    procedure SetCurrent(const Value: Integer);
    { Private declarations }
  public
    property Current: Integer read FCurrent write SetCurrent;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Current := 0;
end;

procedure TForm1.SetCurrent(const Value: Integer);
begin
  FCurrent := Value;
  LblTest.Caption := IntToStr(Value);
  if ChkUseRefresh.Checked then
   LblTest.Refresh;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
begin
  Current := 1;
  Refresh;
  for i := 1 to 5000 do Current := i;
end;

end.
