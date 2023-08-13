unit Udatamod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDmMusteri = class(TDataModule)
    MusteriSource: TDataSource;
    MusteriTable: TTable;
    MusteriTableKodu: TAutoIncField;
    MusteriTableAdi: TStringField;
    MusteriTableSoyadi: TStringField;
    MusteriTableTel1: TStringField;
    MusteriTableTel2: TStringField;
    MusteriTableAdres: TStringField;
    MusteriTableSehir: TStringField;
    MusteriTableDTarihi: TDateField;
    MusteriTableResmi: TGraphicField;
    MusteriTableUzunAciklama: TMemoField;
  private
    function GetMusteriTableInEditMode: Boolean;
    { Private declarations }
  public
    property MusteriTableInEditMode: Boolean read GetMusteriTableInEditMode;
  end;

var
  DmMusteri: TDmMusteri;

implementation

{$R *.DFM}

{ TDmMusteri }

function TDmMusteri.GetMusteriTableInEditMode: Boolean;
begin
  Result := MusteriTable.State in dsEditModes;
end;

end.
