unit udmsession;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TDMSession = class(TDataModule)
    Table1: TTable;
    Session1: TSession;
    DataSource1: TDataSource;
    Table1Kod: TAutoIncField;
    Table1Ad: TStringField;
    procedure Session1Password(Sender: TObject; var Continue: Boolean);
    procedure DMSessionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMSession: TDMSession;

implementation

{$R *.DFM}

procedure TDMSession.Session1Password(Sender: TObject;
  var Continue: Boolean);
var PassWd: string;
begin
  PassWd := 'deneme';
  Continue := InputQuery('Þifre giriniz.', 'Þifre:', PassWd);
  if Continue then
    Session1.AddPassword(PassWd); 
end;

procedure TDMSession.DMSessionCreate(Sender: TObject);
begin
  try
    Table1.Open;
  except
    on E: Exception do
    begin
      ShowMessage('Tablo açýlamadý. Uygulama çalýþmaya devam edemez. Sistem Mesajý:' + E.Message);
      Application.Terminate;
    end;
  end;  
end;

end.
