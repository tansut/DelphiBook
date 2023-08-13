program masdetprj;

uses
  Forms,
  umasdet in 'umasdet.pas' {FmMain},
  umasdetdm in 'umasdetdm.pas' {DMMasDet: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMMasDet, DMMasDet);
  Application.Run;
end.
