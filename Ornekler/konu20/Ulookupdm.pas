unit Ulookupdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMLookup = class(TDataModule)
    KisiTable: TTable;
    SehirTable: TTable;
    SehirTableKod: TIntegerField;
    SehirTableSehir: TStringField;
    KisiTableKod: TAutoIncField;
    KisiTableAd: TStringField;
    KisiTableSoyad: TStringField;
    KisiTableMeslek: TStringField;
    KisiTableAdres: TStringField;
    KisiTablePostakod: TStringField;
    KisiTableSehirkod: TIntegerField;
    KisiTableSehirAdi: TStringField;
    KisiSource: TDataSource;
    SehirSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMLookup: TDMLookup;

implementation

{$R *.DFM}

end.
