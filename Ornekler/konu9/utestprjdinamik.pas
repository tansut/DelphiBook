unit utestprjdinamik;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
var Handle: Integer;
    ShowForm: procedure;
begin
  Handle := LoadLibrary('test.dll');
  if Handle <> 0 then
  begin
    @ShowForm := GetProcAddress(Handle, 'ShowForm');
    if @ShowForm <> nil then
     ShowForm;
    FreeLibrary(Handle);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
type
 TUsAlFunc = function(i, j: integer): integer;
var Handle: Integer;
    UsBul: TUsAlFunc;
    Res: Integer;
begin
  Handle := LoadLibrary('test.dll');
  if Handle <> 0 then
  begin
    @UsBul := GetProcAddress(Handle, 'UsAl');
    if @UsBul <> nil then
     Res := UsBul(2, 3);
    ShowMessage(Format('2 üzeri 3 = %d', [Res]));
    FreeLibrary(Handle);
  end;
end;

end.
