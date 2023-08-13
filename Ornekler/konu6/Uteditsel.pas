unit Uteditsel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    edTest: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure edTestKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edTestChange(Sender: TObject);
  private
    LastKey: Word;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var S: string;
begin
  if InputQuery('Bilgi', 'Bilgi giriniz:', S) then
   ListBox1.Items.Add(S);
end;

procedure TForm1.edTestKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LastKey := Key;
end;

procedure TForm1.edTestChange(Sender: TObject);
var Search, RepText: string;
    I: Integer;
begin
  Search := edTest.Text;
  if LastKey = 8 then
  begin
    LastKey := 0;
    Exit;
  end;
  RepText := '';
  for i := 0 to ListBox1.Items.Count - 1 do
    if Copy(ListBox1.Items[i], 1, Length(Search)) = Search then
    begin
      RepText := ListBox1.Items[i];
      Break;
    end;
  if RepText > '' then
  begin
    edTest.OnChange := nil;
    edTest.Text := RepText;
    edTest.SelStart := Length(Search);
    edTest.SelLength := (Length(RepText) - Length(Search));
    edTest.OnChange := edTestChange;
  end;
end;

end.
