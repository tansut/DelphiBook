program filestr;

uses
  Forms,
  Ufilestr in 'Ufilestr.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
