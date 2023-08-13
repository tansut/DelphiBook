unit Uctrldrag;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    imgRecycle: TImage;
    Label1: TLabel;
    lstTest: TListBox;
    Label2: TLabel;
    lblDeleteCount: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgRecycleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure imgRecycleDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    FDeleteCount: Integer;
    procedure SetDeleteCount(const Value: Integer);
  public
    property DeleteCount: Integer read FDeleteCount write SetDeleteCount;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  For i := 1 to 20 do
   LstTest.Items.Add(Format('Eleman %d', [i]));
  LstTest.ItemIndex := 0;
  DeleteCount := 0;
end;

procedure TForm1.imgRecycleDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source = LstTest; 
end;

procedure TForm1.imgRecycleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var OldIndex, NewIndex: Integer;
begin
  if MessageDlg(
     Format('%s elemanýný silmek istiyor musunuz ?', [LstTest.Items[LstTest.ItemIndex]]),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    OldIndex := LstTest.ItemIndex;
    LstTest.Items.Delete(OldIndex);
    if LstTest.Items.Count > 0 then
    begin
      NewIndex := OldIndex - 1;
      if NewIndex < 0 then NewIndex := 0;
      LstTest.ItemIndex := NewIndex;
      DeleteCount := DeleteCount + 1;
    end;
  end;
end;

procedure TForm1.SetDeleteCount(const Value: Integer);
begin
  FDeleteCount := Value;
  LblDeleteCount.Caption := Format('Þu ana kadar %d eleman sildiniz', [Value]);
end;


end.
