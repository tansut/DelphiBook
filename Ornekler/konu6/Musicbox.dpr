program Musicbox;

uses
  Forms,
  UMain in 'UMain.pas' {FmMusicBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'M�zik Kutusu';
  Application.CreateForm(TFmMusicBox, FmMusicBox);
  Application.Run;
end.
