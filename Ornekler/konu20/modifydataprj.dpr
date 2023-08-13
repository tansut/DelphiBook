program modifydataprj;

uses
  Forms,
  Umodifydata in 'Umodifydata.pas' {FmMain},
  modifydatadm in 'modifydatadm.pas' {DMModify: TDataModule},
  UdErr in 'UdErr.pas' {FmDataError};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDMModify, DMModify);
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TFmDataError, FmDataError);
  Application.Run;
end.
