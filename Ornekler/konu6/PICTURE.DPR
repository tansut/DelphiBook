program Picture;

uses
  Forms,
  main in 'main.pas' {MainFrm},
  ImageU in 'ImageU.pas' {ImageFrm},
  AboutU in 'AboutU.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Picture Viewer';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TImageFrm, ImageFrm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
