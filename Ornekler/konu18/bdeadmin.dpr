program bdeadmin;

uses
  Forms,
  Umain in 'Umain.pas' {FmMain},
  Udriver in 'Udriver.pas' {FmDrivers};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'AliasYöneticisi';
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmDrivers, FmDrivers);
  Application.Run;
end.
