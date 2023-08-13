unit Umemopage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Procedure ScrollMemo(Memo : TMemo; Direction : char);
begin
  case direction of
    'a': begin
           SendMessage(Memo.Handle,
                WM_VSCROLL,
                SB_PAGEDOWN,
                0)
         end;

     'y' : begin
             SendMessage(Memo.Handle,
                WM_VSCROLL,
                SB_PAGEUP,
                0);
           end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ScrollMemo(Memo1, 'y');
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ScrollMemo(Memo1, 'a');
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Memo1.Selstart := Length (Memo1.Text);
  Memo1.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  Memo1.SelStart := 0;
  Memo1.Perform(EM_SCROLLCARET, 0, 0);
end;

end.
