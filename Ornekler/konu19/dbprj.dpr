program dbprj;

uses
  Forms,
  Umaindb in 'Umaindb.pas' {FmMain},
  Udmdb in 'Udmdb.pas' {DMDatabase: TDataModule},
  Uconn in 'Uconn.pas' {FmDBConnect},
  udbparm in 'udbparm.pas' {FmDBParameters};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDMDatabase, DMDatabase);
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
