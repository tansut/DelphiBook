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
      ShowMessage('M��teri tablosu a��lamad�. Bu durumda uygulama �al��mayacakt�r.'+
                  'Hata Mesaj�:' + E.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TDM.DMDestroy(Sender: TObject);
begin
  MusteriTable.Close;
end;

end.
