unit Ucomb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    LastKey: Word;
    procedure GetTypedUrls(List: TStrings);
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
uses ShellApi, Registry;

procedure TForm1.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LastKey := Key;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
Var
  Srch : String;
  ix : Integer;
Begin
  Srch := combobox1.Text;
 if (LastKey = VK_BACK) or (LastKey = VK_DELETE) then
  Begin
    LastKey := 0;
    Exit;
  end;
  LastKey := 0;
  ix := combobox1.Perform(CB_FINDSTRING,-1,LongInt(PChar(Srch)));
  if ix > CB_ERR then
  Begin
    combobox1.ItemIndex := ix;
    combobox1.SelStart := Length(Srch);
    combobox1.SelLength := (Length(combobox1.Text) - Length(Srch));
  end;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ShellExecute(Handle, 'open', PChar(ComboBox1.Text), '', '', SW_SHOWNORMAL);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GetTypedUrls(ComboBox1.Items);
end;

procedure TForm1.GetTypedUrls(List: TStrings);
var i: integer;
    Reg: TRegistry;
    Adres: string;
begin
  Reg := TRegistry.Create;
  with Reg do
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Internet Explorer\TypedUrls', False) then
    begin
      i := 1;
      Adres := Reg.ReadString(Format('url%d', [i]));
      while Adres > '' do
      begin
        List.Add(Adres);
        Inc(i);
        Adres := Reg.ReadString(Format('url%d', [i]));
      end;
    end;  
  finally
    Reg.Free;
  end;
end;

end.
