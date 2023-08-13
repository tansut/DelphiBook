program dbsamp;

uses
  Forms,
  Umain in 'Umain.pas' {FmMain},
  Udatamod in 'Udatamod.pas' {DmMusteri: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TDmMusteri, DmMusteri);
  Application.Run;
end.
