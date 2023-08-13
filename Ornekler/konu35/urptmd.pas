unit urptmd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, Db, DBTables, ExtCtrls;

type
  TFmMDReport = class(TForm)
    Report: TQuickRep;
    AnaTablo: TTable;
    DetayTablo: TTable;
    AnaSource: TDataSource;
    DetayTabloKOD: TAutoIncField;
    DetayTabloUYEKOD: TIntegerField;
    DetayTabloOTARIH: TDateField;
    DetayTabloOMIKTAR: TCurrencyField;
    DetayTabloFAIZMIKTAR: TCurrencyField;
    DetayTabloKALAN: TCurrencyField;
    AnaTabloUYE_KODU: TAutoIncField;
    AnaTabloADI: TStringField;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    GroupHeaderBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel3: TQRLabel;
    GroupFooterBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr1: TQRExpr;
    QRSysData2: TQRSysData;
    QRExpr5: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr8: TQRExpr;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

end.
