unit Uctrlcpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Caption:=COPY(Caption,2,Length(Caption)-1)+Caption[1];
  with Label1 do
   Caption:=COPY(Caption,2,Length(Caption)-1)+Caption[1];
  with Button1 do
   Caption:=COPY(Caption,2,Length(Caption)-1)+Caption[1];
end;

end.
