unit Urecyclefile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    edFile: TEdit;
    btnDelete: TButton;
    btnSelectFile: TSpeedButton;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ShellApi;

{$R *.DFM}

function SendToRecycleBin(FileToRecycle: TFilename): boolean;
var Struct: TSHFileOpStruct;
    pFromc: array[0..255] of char;
    Resultval: integer;
begin
   if not FileExists(FileToRecycle) then begin
      Result := False;
      exit;
   end
   else begin
      fillchar(pfromc,sizeof(pfromc),0);
      StrPcopy(pfromc,expandfilename(FileToRecycle)+#0#0);
      Struct.wnd := 0;
      Struct.wFunc := FO_DELETE;
      Struct.pFrom := pFromC;
      Struct.pTo   := nil;
      Struct.fFlags:= FOF_ALLOWUNDO;
      Struct.fAnyOperationsAborted := false;
      Struct.hNameMappings := nil;
      Resultval := ShFileOperation(Struct);
      Result := (Resultval = 0);
   end;
end;
procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  if edFile.Text > '' then
  begin
    if not SendToRecycleBin(edFile.Text)then
     raise Exception.Create('Dosya bulunamadý veya silinemiyor');
  end
  else btnSelectFileClick(Self);
end;

procedure TForm1.btnSelectFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
   EdFile.Text := OpenDialog.FileName;
end;

end.
