program treeview;

uses
  Forms,
  Utreeview in 'Utreeview.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
