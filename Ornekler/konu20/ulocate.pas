unit ulocate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Mask, Db;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label9: TLabel;
    Label10: TLabel;
    procedure DoSearch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses ULocateDM;

{$R *.DFM}

procedure TFmMain.DoSearch(Sender: TObject);
var SearchStr: string;
    FieldName: string;
begin
  if DmLocate.MusteriTable.State in dsEditModes then
   raise Exception.Create('Veri kümesi üzerinde tamamlanmamýþ bir iþlem yapýlmakta. Önce iþlemi kaydediniz veya iptal ediniz'); 
  FieldName := TDBEdit(Sender).DataField;
  SearchStr := '';
  if not InputQuery('Arama yap', FieldName + ' üzerinden arama yapmak için deðer giriniz', SearchStr) then Exit;
  if not DmLocate.MusteriTable.Locate(FieldName, SearchStr, [loCaseInsensitive, loPartialKey]) then
   ShowMessage('Aranýlan bulunamadý');
end;

end.
