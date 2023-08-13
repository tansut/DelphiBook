unit Uctrlmouse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Sx, Sy, Cx, Cy: Integer;
    FDraw: Boolean;
    procedure DrawRect(FillRect: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DrawRect(FillRect: Boolean);
begin
  if FillRect then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Brush.Style := bsDiagCross;
    Canvas.Brush.Color := clRed;
  end else
  begin
    Canvas.Pen.Style := psDash;
    Canvas.Brush.Style := bsClear;
  end;
  Refresh;
  Canvas.Rectangle(Sx, Sy, Cx, Cy);
  Canvas.Ellipse(Sx, Sy, Cx, Cy);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDraw := Button = mbLeft;
  if FDraw then
  begin
    Sx := X;
    Sy := Y;
  end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if FDraw then
  begin
    Cx := X;
    Cy := Y;
    DrawRect(False);
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDraw := False;
  DrawRect(True);
end;

end.
