unit DmDtMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    DbSession: TSession;
    DbTable: TTable;
    procedure DMCreate(Sender: TObject);
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
  DbSession.Active := True;
end;

end.
