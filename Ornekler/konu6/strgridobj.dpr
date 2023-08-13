program strgridobj;

uses
  Forms,
  Ustrgridobj in 'Ustrgridobj.pas' {FmMain},
  tstrgridobjadd in 'tstrgridobjadd.pas' {FmAddObj};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmAddObj, FmAddObj);
  Application.Run;
end.
