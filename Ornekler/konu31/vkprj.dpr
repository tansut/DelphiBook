program vkprj;

uses
  Forms,
  uvkprj in 'uvkprj.pas' {FmMain},
  Udmvk in 'Udmvk.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
