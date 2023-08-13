program mdisampprj;

uses
  Forms,
  Umdisamp in 'Umdisamp.pas' {FmMain},
  mdisamp in 'mdisamp.pas' {FmMdiChild},
  Umdiasst in 'Umdiasst.pas' {FmAssistant};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmAssistant, FmAssistant);
  Application.Run;
end.
