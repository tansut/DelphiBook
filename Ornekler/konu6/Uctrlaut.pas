unit Uctrlaut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    edTest: TEdit;
    rgAutoSize: TRadioGroup;
    Label1: TLabel;
    edSize: TEdit;
    procedure rgAutoSizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSizeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.rgAutoSizeClick(Sender: TObject);
begin
  edTest.AutoSize := Boolean(rgAutoSize.ItemIndex);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EdSize.Text := IntToStr(edTest.Font.Size);
end;

procedure TForm1.edSizeChange(Sender: TObject);
begin
  if EdTest.Text > '' then
    EdTest.Font.Size := StrToInt(edSize.Text);
end;

end.
