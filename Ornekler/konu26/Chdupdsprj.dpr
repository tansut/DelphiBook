program Chdupdsprj;

uses
  Forms,
  CachedUp in 'CachedUp.pas' {FmMain},
  ErrForm in 'Errform.pas' {UpdateErrorForm},
  DataMod in 'DataMod.pas' {CacheData: TDataModule};

{$R *.RES}

begin
  Application.CreateForm(TCacheData, CacheData);
  Application.CreateForm(TFmMain, FmMain);
  Application.CreateForm(TUpdateErrorForm, UpdateErrorForm);
  Application.Run;
end.
