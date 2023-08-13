unit Umddm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMMasDet = class(TDataModule)
    YazarlarQuery: TQuery;
    YazarlarQueryYazarKodu: TIntegerField;
    YazarlarQueryYazarAdi: TStringField;
    KitaplarQuery: TQuery;
    YazarlarSource: TDataSource;
    KitaplarQueryKitapKodu: TIntegerField;
    KitaplarQueryYazarKodu: TIntegerField;
    KitaplarQueryKitapAdi: TStringField;
    KiralayanQuery: TQuery;
    KitaplarSource: TDataSource;
    KiralayanSource: TDataSource;
    procedure DMMasDetCreate(Sender: TObject);
    procedure DMMasDetDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMMasDet: TDMMasDet;

implementation

{$R *.DFM}

procedure TDMMasDet.DMMasDetCreate(Sender: TObject);
begin
  YazarlarQuery.Prepare;
  KitaplarQuery.Prepare;
  KiralayanQuery.Prepare;

  YazarlarQuery.Open;
  KitaplarQuery.Open;
  KiralayanQuery.Open;
end;

procedure TDMMasDet.DMMasDetDestroy(Sender: TObject);
begin
  KiralayanQuery.Close;
  KitaplarQuery.Close;
  YazarlarQuery.Close;
end;

end.
