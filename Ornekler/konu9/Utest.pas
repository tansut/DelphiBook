unit Utest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type

  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowForm; 

implementation

{$R *.DFM}

procedure ShowForm;
var MyForm: TForm1;
begin
  MyForm := TForm1.Create(nil);
  with MyForm do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function GetAsNumber(S: PChar): Integer;
begin
  Result := StrToInt(S);
end;

end.
