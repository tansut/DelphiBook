unit Umdtmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses urptmd;

{$R *.DFM}

procedure TFmMain.Button1Click(Sender: TObject);
begin
  With TFmMDReport.Create(nil) do
  try
    Report.PreviewModal;
  finally
    Free;
  end;
end;

end.
