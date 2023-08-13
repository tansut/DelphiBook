program sessionprj;

uses
  Forms,
  usession in 'usession.pas' {FmMain},
  udmsession in 'udmsession.pas' {DMSession: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDMSession, DMSession);
  Application.Run;
end.
