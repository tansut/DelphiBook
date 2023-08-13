program splash;

uses
  Forms,
  Usplash in 'Usplash.pas' {FmSplash},
  usplashmain in 'usplashmain.pas' {FmMain},
  usplash1 in 'usplash1.pas' {Form2},
  usplash2 in 'usplash2.pas' {Form3};

{$R *.RES}
var FmSplash: TFmSplash;
begin
  FmSplash := TFmSplash.Create(nil);
  FmSplash.Show;
  FmSplash.Refresh;
  Application.Initialize;

  Application.CreateForm(TFmMain, FmMain);
  FmSplash.Step;

  Application.CreateForm(TForm2, Form2);
  FmSplash.Step;

  Application.CreateForm(TForm3, Form3);
  FmSplash.Step;

  FmSplash.Hide;
  FmSplash.Free;

  Application.Run;
end.
