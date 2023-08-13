unit Uappactive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    lblStatus: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    ActivateCount: Integer;
    procedure Activated(Sender: TObject);
    procedure DeActivated(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Activated(Sender: TObject);
begin
  lblStatus.Caption := Format('Uygulama %d kere aktif oldu', [ActivateCount]);
  Inc(ActivateCount);
end;

procedure TForm1.DeActivated(Sender: TObject);
begin
  lblStatus.Caption := 'Uygulama aktif deðil';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ActivateCount := 1;
  Application.OnActivate := Activated;
  Application.OnDeactivate := DeActivated;
end;

end.
