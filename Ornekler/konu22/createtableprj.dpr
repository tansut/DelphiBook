program createtableprj;

uses
  Forms,
  ucreatetable in 'ucreatetable.pas' {FmMain},
  Ufldedit in 'Ufldedit.pas' {FmFieldEditor},
  uindexedit in 'uindexedit.pas' {FmIndexEditor};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Tablo Yaratýcý';
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmFieldEditor, FmFieldEditor);
  Application.CreateForm(TFmIndexEditor, FmIndexEditor);
  Application.Run;
end.
