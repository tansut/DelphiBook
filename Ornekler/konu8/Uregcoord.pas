unit Uregcoord;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LoadSettings;
    procedure SaveSettings;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
uses Registry;

const
 REGISTRYPATH = 'Software\Programim\1.0\Screen';

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadSettings;
end;

procedure TForm1.LoadSettings;
begin
  with TRegistry.Create do
  try
    if OpenKey(REGISTRYPATH, False) then
    begin
       Left := ReadInteger('Left');
       Top := ReadInteger('Top');
       Width := ReadInteger('Width');
       Height := ReadInteger('Height');
    end;
  finally
    Free;
  end;
end;

procedure TForm1.SaveSettings;
begin
  with TRegistry.Create do
  try
    if OpenKey(REGISTRYPATH, True) then
    begin
      WriteInteger('Left', Left);
      WriteInteger('Top', Top);
      WriteInteger('Width', Width);
      WriteInteger('Height', Height);
    end;
  finally
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveSettings;
end;

end.
