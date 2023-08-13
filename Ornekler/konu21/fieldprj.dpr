program fieldprj;

uses
  Forms,
  UMain in 'UMain.pas' {FmMain},
  udm in 'udm.pas' {DM: TDataModule},
  UdErr in 'UdErr.pas' {FmDataError},
  Urecorder in 'Urecorder.pas' {FmRecorder};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmDataError, FmDataError);
  Application.CreateForm(TFmRecorder, FmRecorder);
  Application.Run;
end.
