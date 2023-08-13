unit Ulblpos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label3: TLabel;
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  p:TPoint;
begin
  p.x:=x;
  p.y:=y;
  try
    Label1.Caption :=ListBox1.Items[ListBox1.ItemAtPos(P,False)];
  except
    Label1.Caption := '';
  end;    
end;

end.
