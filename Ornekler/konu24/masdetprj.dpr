program masdetprj;

uses
  Forms,
  Umdmain in 'Umdmain.pas' {FmMain},
  Umddm in 'Umddm.pas' {DMMasDet: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMMasDet, DMMasDet);
  Application.Run;
end.
