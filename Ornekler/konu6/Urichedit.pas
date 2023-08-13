unit Urichedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    FindDialog1: TFindDialog;
    RichEdit1: TRichEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
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
  FindDialog1.Position := Point(RichEdit1.Left + RichEdit1.Width, RichEdit1.Top);
  FindDialog1.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RichEdit1.SelStart := 0;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: integer;
  Options: TSearchTypes;
begin
  with RichEdit1 do
  begin
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else
      StartPos := 0;
    ToEnd := Length(Text) - StartPos;
    Options := [];
    if frMatchCase in FindDialog1.Options then
     Include(Options, stMatchCase);
    if frWholeWord in FindDialog1.Options then
     Include(Options, stWholeWord);
    FoundAt := FindText(FindDialog1.FindText, StartPos, ToEnd, Options);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDialog1.FindText);
      ShowWindow(FindDialog1.Handle, SW_SHOWNORMAL);
    end else ShowMessage('Aradýðýnýz bulunamadý');
  end;
end;

end.
