unit udmado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

type
  TDMADO = class(TDataModule)
    KitapConn: TADOConnection;
    MakaleTable: TADOTable;
    MakaleTablea_id: TAutoIncField;
    MakaleTableowner: TWideStringField;
    MakaleTabletitle: TWideStringField;
    MakaleTablearticle: TMemoField;
    MakaleTablea_date: TDateField;
    MakaleSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMADO: TDMADO;

implementation

{$R *.DFM}

end.
