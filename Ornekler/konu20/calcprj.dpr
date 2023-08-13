program calcprj;

uses
  Forms,
  ucalc in 'ucalc.pas' {FmMain},
  ucalcdm in 'ucalcdm.pas' {DMCalc: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMCalc, DMCalc);
  Application.Run;
end.
