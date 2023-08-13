unit uctrlenable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  case Tag of
  0: begin
       Label1.Caption := 'Üzerime týklayamazsýnýz';
       Label1.Enabled := False;
       Button1.Caption := 'Enable';
       Tag := 1;
     end;
  1: begin
       Label1.Caption := 'Üzerime týklayabilirsiniz';
       Label1.Enabled := True;
       Button1.Caption := 'Disable';
       Tag := 0;
     end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button1Click(Self);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  ShowMessage('Týkladýnýz');
end;

end.
