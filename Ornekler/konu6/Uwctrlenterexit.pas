unit Uwctrlenterexit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Edit1Enter(Sender: TObject);
begin
  Label1.Caption := Format('%s ''e giriþ', [(Sender as TEdit).Name]);
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  Label2.Caption := Format('%s ''den çýkýþ', [(Sender as TEdit).Name]);
end;

end.
