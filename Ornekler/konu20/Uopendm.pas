unit Uopendm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
    procedure DMCreate(Sender: TObject);
    procedure DMDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.DFM}

procedure TDM.DMCreate(Sender: TObject);
begin
  try
    MusteriTable.Open;
  except
    on E: Exception do
    begin
      ShowMessage('Müþteri tablosu açýlamadý. Bu durumda uygulama çalýþmayacaktýr.'+
                  'Hata Mesajý:' + E.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TDM.DMDestroy(Sender: TObject);
begin
  MusteriTable.Close;
end;

end.
