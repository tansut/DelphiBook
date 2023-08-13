program rptgroup;

uses
  Forms,
  urptgroup in 'urptgroup.pas' {FmGroupReport},
  urptmain in 'urptmain.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
