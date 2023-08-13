program bookmarkprj;

uses
  Forms,
  Ubookmark in 'Ubookmark.pas' {FmMain},
  ubookmarkdm in 'ubookmarkdm.pas' {DMBookmark: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDMBookmark, DMBookmark);
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
