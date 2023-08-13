unit Udmdb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables;

type
  TDMDatabase = class(TDataModule)
    DB: TDatabase;
    procedure DMDatabaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDatabase: TDMDatabase;

implementation

uses Uconn;

{$R *.DFM}

procedure TDMDatabase.DMDatabaseCreate(Sender: TObject);
var Aborted: Boolean;
begin
  Aborted := False;
  repeat
    with TFMDBConnect.Create(nil) do
    try
      Execute(DB, DB.Params);
    finally
      Free;
    end;
    try
      Db.Connected := True;
    except
     Aborted := MessageDlg('Veri tabanýna baðlanma iþlemi baþarýsýz. Tekrar denemek ister misiniz ?', mtWarning, [mbYes, mbNo], 0) = mrNo;
    end;
  until Aborted or (Db.Connected);
  if not DB.Connected then Application.Terminate;
end;

end.
