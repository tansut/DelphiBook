unit Usplash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TFmSplash = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Step;
  end;


implementation

{$R *.DFM}

procedure TFmSplash.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon := Application.Icon;
end;

procedure TFmSplash.Step;
begin
  ProgressBar.StepIt;
  Refresh;
end;

end.
