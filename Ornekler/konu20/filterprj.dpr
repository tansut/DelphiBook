program filterprj;

uses
  Forms,
  ufilter in 'ufilter.pas' {FmMain},
  ufilterdm in 'ufilterdm.pas' {DMFilter: TDataModule},
  Ufiltercreator in 'Ufiltercreator.pas' {FmFilterCreator};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMFilter, DMFilter);
  Application.CreateForm(TFmFilterCreator, FmFilterCreator);
  Application.Run;
end.
