unit Uexcelprj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, StdCtrls, ExtCtrls, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edBook: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Bevel1: TBevel;
    SourceGrid: TStringGrid;
    Button7: TButton;
    Button8: TButton;
    DestGrid: TStringGrid;
    Button9: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LblRow: TLabel;
    LblCol: TLabel;
    Button10: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    Excel: Variant;
    WorkBook: Variant;
  public
    procedure CreateExcelApp;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.CreateExcelApp;
begin
  if VarIsEmpty(Excel) then
  begin
    try
      Excel := CreateOleObject('Excel.Application');
      Excel.Visible := True;
    except
     on E: Exception do
      raise Exception.Create('Excel açýlamadý. Excel meþgul olabilir veya sistemde yüklü deðil. Sistem Mesajý:'#13#10 + E.Message)
    end;
  end else Excel.Visible := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CreateExcelApp;
end;

procedure TForm1.Button2Click(Sender: TObject);
var Book: Variant;
begin
  CreateExcelApp;
  if FileExists(edBook.Text) then
  begin
    Book := Excel.WorkBooks.Open(edBook.Text);
  end else
   raise Exception.CreateFmt('Dosya bulunamadý. %s', [edBook.Text]);
end;

procedure TForm1.FormCreate(Sender: TObject);
var Colm, Rowm: Integer;
begin
  edBook.Text := ExtractFilePath(Application.ExeName) + 'kitap.xls';
  with SourceGrid do
  begin
    Cols[0].Text := 'X'#13'SAT1'#13'SAT2'#13'SAT3'#13'SAT4';
    Rows[0].Text := 'X'#13'SÜT1'#13'SÜT2'#13'SÜT3'#13'SÜT4';
    for Colm := 1 to ColCount - 1 do
     for Rowm := 1 to RowCount - 1 do
      Cells[Colm, Rowm] := IntToStr(Colm * Rowm);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var Book: Variant;
    FileName: string;
begin
  CreateExcelApp;
  repeat
    FileName := Excel.GetOpenFileName;
  until FileName <> '0';
  Book := Excel.WorkBooks.Open(FileName);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  CreateExcelApp;
  WorkBook := Excel.WorkBooks.Add;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if VarIsEmpty(WorkBook) then
   raise Exception.Create('Önce çalýþma kitabý yaratýnýz');
  try
    WorkBook.SaveAs('C:\deneme.xls');
  except
   raise Exception.Create('Ýþlem baþarýsýz');
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if VarIsEmpty(WorkBook) then
   raise Exception.Create('Önce çalýþma kitabý yaratýnýz');
  WorkBook.Close;
end;

procedure TForm1.Button7Click(Sender: TObject);
var Colm, Rowm: Integer;
    Sheet: Variant;
begin
  Button4Click(self);
  Sheet := WorkBook.WorkSheets[1];
  with SourceGrid do
  begin
    for Colm := 0 to ColCount - 1 do
      for Rowm := 0 to RowCount - 1 do
       Sheet.Cells[Rowm + 1, Colm + 1] := Cells[Colm, Rowm];
    for Colm := 1 to ColCount - 1 do
    begin
      Sheet.Cells[RowCount+1, Colm + 1].Formula := Format('=Sum(%s%d:%s%d)', [Chr(Ord('B') + Colm-1), 2, Chr(Ord('B') + Colm-1), RowCount]);
      Sheet.Cells[RowCount+1, Colm + 1].Font.Bold := True;
    end;
  end;
  Button8Click(Self);
end;

procedure TForm1.Button8Click(Sender: TObject);
var FCell, R: Variant;
    RowC, ColC: Integer;
begin
  CreateExcelApp;
  try
    R := Excel.ActiveWorkBook.WorkSheets[1].UsedRange;
  except
    raise Exception.Create('Açýk kitap yok');
  end;
  with DestGrid do
  begin
    ColCount := 0;
    RowCount := 0;
    ColCount := R.Columns.Count;
    RowCount := R.Rows.Count;
    for ColC := 0 to ColCount - 1 do
     for RowC := 0 to RowCount - 1 do
     begin
       FCell := Excel.ActiveWorkBook.WorkSheets[1].Cells[RowC+1, ColC+1];
       Cells[ColC, RowC] := FCell.Value;
     end;
  end;

end;

procedure TForm1.Button9Click(Sender: TObject);
var
 R: Variant;
begin
  if VarIsEmpty(WorkBook) then
   raise Exception.Create('Önce çalýþma kitabý yaratýnýz');
  R := WorkBook.WorkSheets[1].UsedRange;
  LblRow.Caption := R.Rows.Count;
  LblCol.Caption := R.Columns.Count;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Excel.Quit;
  Excel := Unassigned;
end;

end.
