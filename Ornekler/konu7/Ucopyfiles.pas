unit Ucopyfiles;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    edSource: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edDest: TEdit;
    btnCopy: TButton;
    procedure btnCopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses ShellApi;

function CopyFile(von,zieldir: String): boolean;
var
 fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc := FO_COPY;
    fFlags := FOF_FILESONLY;
    pFrom := PChar(von+#0);
    pTo := PChar(zieldir)
  end;
  Result:=(0=ShFileOperation(fos));
end;

procedure TForm1.btnCopyClick(Sender: TObject);
begin
  if not CopyFile(edSource.Text, edDest.Text) then
   raise Exception.Create('Kopyalama hatasý');
end;

end.
