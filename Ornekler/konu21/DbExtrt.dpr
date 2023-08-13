program DbExtrt;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  dbase in 'dbase.pas' {DbaseForm},
  DmDtMod in 'DmDtMod.pas' {DM: TDataModule},
  prnopt in 'prnopt.pas' {PrnOptionsForm},
  data in 'data.pas' {Dataform},
  tbllst in 'tbllst.pas' {TableListForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Tablo Yapý Gösterici';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPrnOptionsForm, PrnOptionsForm);
  Application.CreateForm(TDataform, Dataform);
  Application.CreateForm(TTableListForm, TableListForm);
  MainForm.Show;
  MainForm.Update;
  MainForm.DatabaseBtnClick(Application);
  Application.Run;
end.
