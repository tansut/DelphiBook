program opendbprj;

uses
  Forms,
  Uopen in 'Uopen.pas' {FmMain},
  Uopendm in 'Uopendm.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
