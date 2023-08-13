program lookupprj;

uses
  Forms,
  Ulookup in 'Ulookup.pas' {FmMain},
  Ulookupdm in 'Ulookupdm.pas' {DMLookup: TDataModule},
  ulookupcity in 'ulookupcity.pas' {FmCities};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMLookup, DMLookup);
  Application.CreateForm(TFmCities, FmCities);
  Application.Run;
end.
