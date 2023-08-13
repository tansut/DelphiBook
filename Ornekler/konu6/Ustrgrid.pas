unit Ustrgrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls;

type
  TForm1 = class(TForm)
    Grid: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormCreate(Sender: TObject);
  private
    function IsNumeric(const S: string): Boolean;
    procedure Calculate; 
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.IsNumeric(const S: string): Boolean;
var IntCode, Num: Integer;
begin
  Val(S, Num, IntCode);
  Result := IntCode = 0;
end;

procedure TForm1.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Color: TColor;
    Value: Integer;
    Options: Integer;
begin
  if Grid.Cells[ACol, ARow] = '' then
   Color := clBlack
  else
  begin
    Value := StrToIntDef(Grid.Cells[ACol, ARow], 0);
    if Value > 0 then Color := clBlue
    else if Value < 0 then Color := clRed
    else Color := clBlack;
  end;
  Options := DT_NOPREFIX or
  DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly;
  if IsNumeric(Grid.Cells[ACol, ARow]) then
   Options := Options or DT_RIGHT
  else
   Options := Options or DT_LEFT;
  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.Font.Color := Color;
  InflateRect(Rect, -2, -2);
  DrawText(Grid.Canvas.Handle, PChar(Grid.Cells[ACol, ARow]), -1, Rect, Options);
end;

procedure TForm1.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if ARow = Grid.RowCount - 1 then CanSelect := False;

end;

procedure TForm1.Calculate;
var acol, arow: integer;
    Sum: Integer;
begin
  with Grid do
  begin
    for acol := 0 to ColCount - 1 do
    begin
      Sum := 0;
      for aRow := 0 to RowCount - 2 do
       if IsNumeric(Cells[aCol, aRow]) then
        Sum := Sum + StrToInt(Cells[aCol, aRow]);
      Cells[aCol, RowCount-1] := IntToStr(Sum);
    end;
  end;
end;

procedure TForm1.GridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin
  Calculate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Calculate;
end;

end.
