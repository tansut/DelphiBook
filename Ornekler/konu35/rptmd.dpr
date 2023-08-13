program rptmd;

uses
  Forms,
  Umdtmain in 'Umdtmain.pas' {FmMain},
  urptmd in 'urptmd.pas' {FmMDReport};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
