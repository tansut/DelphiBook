program adoprj;

uses
  Forms,
  Umain in 'Umain.pas' {FMMain},
  udmado in 'udmado.pas' {DMADO: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMMain, FMMain);
  Application.CreateForm(TDMADO, DMADO);
  Application.Run;
end.
