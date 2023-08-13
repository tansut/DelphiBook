unit usplashmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

procedure TFmMain.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 1 to 10000 do
  begin
   Label1.Caption := IntToStr(i);
   Application.ProcessMessages;
  end;
end;

end.
