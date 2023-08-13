library test;

uses

  Utest in 'Utest.pas' {Form1};

var
  SaveExit: Pointer;

function UsAl(Sayi, Us: Integer): Integer;
var
 I: Integer;
begin
  Result := Sayi;
  for i := 2 to Us do
   Result := Result * Sayi;
end;

procedure LibExit;
begin
  // DLL kullan�m� sona erdi�inde
  // �al��t�r�lacak kod
  ExitProc := SaveExit;
end;

exports
 UsAl index 1,
 ShowForm index 2;

begin
  // DLL y�klendi�inde yap�lacak
  // i�lemler
  SaveExit := ExitProc;
  ExitProc := @LibExit;
end.
