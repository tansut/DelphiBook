unit Ustrobj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    LstTest: TListBox;
    Label2: TLabel;
    edname: TEdit;
    edsurname: TEdit;
    edtel: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure LstTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
type
 TPerson = class
 private
  FAName, FSurname, FTel: string;
 public
  constructor Create(AName, ASurname, ATel: string);
  property AName: string read FAName;
  property Surname: string read FSurname;
  property Tel: string read FTel;
 end;

{ TPerson }

constructor TPerson.Create(AName, ASurname, ATel: string);
begin
  FAName := AName;
  FSurname := ASurname;
  FTel := ATel;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with LstTest.Items do
  begin
    AddObject('Eleman1', TPerson.Create('Ali', 'Yilmaz', '+90 312 121 23 11'));
    AddObject('Eleman2', TPerson.Create('Veli', 'Döner', '+90 312 141 25 18'));
    AddObject('Eleman3', TPerson.Create('Hasan', 'Un', '+90 312 321 19 19'));
    AddObject('Eleman4', TPerson.Create('Cemal', 'Kal', '+90 312 226 21 61'));
  end;
  LstTestClick(Self);
end;

procedure TForm1.LstTestClick(Sender: TObject);
begin
  with LstTest.Items.Objects[LstTest.ItemIndex] as TPerson do
  begin
    edName.Text := AName;
    edsurname.Text := Surname;
    edtel.Text := Tel;
  end;
end;

end.
