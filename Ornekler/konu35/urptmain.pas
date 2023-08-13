unit urptmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFmMain = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses urptgroup;

{$R *.DFM}

procedure TFmMain.Button1Click(Sender: TObject);
begin
  with TFmGroupReport.Create(nil) do
  try
    Report.PreviewModal;
  finally
    Free;
  end;
end;

end.
