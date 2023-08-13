unit Uwordprj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComObj, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edDoc: TEdit;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Bevel1: TBevel;
    ListBox1: TListBox;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Editor: TRichEdit;
    Button10: TButton;
    LblStatus: TLabel;
    RichEdit1: TRichEdit;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
  private
    WinWord, Document: Variant;
    procedure CreateWinWord;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.CreateWinWord;
begin
  if VarIsEmpty(WinWord) then
  try
   WinWord := CreateOleObject('Word.Application');
   WinWord.Visible := True;
  except
   raise Exception.Create('Word açýlamadý');
  end
  else WinWord.Visible := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CreateWinWord;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  WinWord.Quit;
  WinWord := UnAssigned;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  CreateWinWord;
  Document := WinWord.Documents.Open(edDoc.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edDoc.Text := ExtractFilePath(Application.ExeName) + 'doctest.doc';
end;

procedure TForm1.Button3Click(Sender: TObject);
var i: Integer;
    s: string;
    Doc: Variant;
begin
  CreateWinWord;
  ListBox1.Items.Clear;
  for i := 1 to Winword.Documents.Count do
  begin
    Doc := Winword.Documents.Item(i);
    S := Doc.name;
    ListBox1.Items.Add(S);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  CreateWinWord;
  Document := Winword.Documents.Add;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if VarIsEmpty(Document) then
   raise Exception.Create('Önce yeni döküman yaratýnýz');
  Document.SaveAs('C:\deneme.doc');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  if VarIsEmpty(Document) then
   raise Exception.Create('Önce yeni döküman yaratýnýz');
  Document.Close;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  I: Integer;
  Size: Integer;
  Doc: Variant;
begin
  CreateWinWord;
  Doc := WinWord.ActiveDocument;
  Size := Doc.Words.Count;
  Editor.Clear;
  for i := 1 to Size do
  begin
   Editor.Lines.Add(Doc.Words.Item(i));
   LblStatus.Caption := Format('%d / %d', [i, Size]);
   Application.ProcessMessages;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  I: Integer;
  Size: Integer;
  Doc: Variant;
begin
  CreateWinWord;
  Doc := WinWord.ActiveDocument;
  Size := Doc.Sentences.Count;
  Editor.Clear;
  for i := 1 to Size do
  begin
   Editor.Lines.Add(Doc.Sentences.Item(i));
   LblStatus.Caption := Format('%d / %d', [i, Size]);
   Application.ProcessMessages;
  end;
end;


procedure TForm1.Button10Click(Sender: TObject);
var
  Doc: Variant;
begin
  CreateWinWord;
  Doc := WinWord.ActiveDocument;
  Editor.Lines.Text := Doc.Content;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then
  begin
    try
      WinWord.Documents.Item(ListBox1.Items[ListBox1.ItemIndex]).Activate;
      Editor.Lines.Text := WinWord.ActiveDocument.Content;
    except
     Abort;
    end;
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  WinWord.ActiveDocument.Select;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  Winword.Selection.Copy;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

end.
