unit urptgroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, QuickRpt, Qrctrls, Db, DBTables, ExtCtrls;

type
  TFmGroupReport = class(TForm)
    Report: TQuickRep;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRGroup1: TQRGroup;
    Query1: TQuery;
    QRExpr1: TQRExpr;
    QRDBText2: TQRDBText;
    ChildBand1: TQRChildBand;
    QRBand3: TQRBand;
    QRExpr2: TQRExpr;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    Query1Kod: TIntegerField;
    Query1Sehir: TStringField;
    SummaryBand1: TQRBand;
    QRSysData4: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

end.
