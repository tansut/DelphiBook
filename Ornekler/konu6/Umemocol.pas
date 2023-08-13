unit Umemocol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
function RichRow(m:TMemo) : LongInt;
begin
  Result:=SendMessage(m.Handle,EM_LINEFROMCHAR,m.SelStart,0);
end;

function RichCol(m:TMemo) : LongInt;
begin
  Result:=m.SelStart-SendMessage(m.handle,EM_LINEINDEX,SendMessage(m.Handle,EM_LINEFROMCHAR,m.SelStart,0),0);
end;

procedure TForm1.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Label1.Caption:= Format('%d : %d',[RichCol(Memo1),RichRow(Memo1)]);
end;

procedure TForm1.Memo1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Label1.Caption:= Format('%d : %d',[RichCol(Memo1),RichRow(Memo1)]);
end;

end.
