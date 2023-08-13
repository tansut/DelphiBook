program locateprj;

uses
  Forms,
  ulocate in 'ulocate.pas' {FmMain},
  ulocatedm in 'ulocatedm.pas' {DmLocate: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDmLocate, DmLocate);
  Application.Run;
end.
