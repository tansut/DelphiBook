�
 TFMMDREPORT 0�:  TPF0TFmMDReport
FmMDReportLeft� Top� WidthHeight�Caption
FmMDReportColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderScaledPixelsPerInch`
TextHeight 	TQuickRepReportLeft Top WidthHeightcFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightDataSetAnaTabloFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style Functions.Strings
PAGENUMBERCOLUMNNUMBERREPORTTITLE Functions.DATA00'' OptionsFirstPageHeaderLastPageFooter Page.ColumnsPage.Orientation
poPortraitPage.PaperSizeA4Page.Values       �@      ��
@       �@      @�
@       �@       �@           PrinterSettings.CopiesPrinterSettings.DuplexPrinterSettings.FirstPage PrinterSettings.LastPage PrinterSettings.OutputBinAutoPrintIfEmpty	ReportTitle�ye Taksit �demeleri
SnapToGrid	UnitsMMZoomd TQRBandDetailBand1Left&TopAWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclSilverForceNewColumnForceNewPageSize.Values     @�@������v�	@ BandTyperbDetail 	TQRDBText	QRDBText1Left`TopWidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@       �@UUUUUUU�@������j�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetAnaTablo	DataFieldADIFont.CharsetTURKISH_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparent	WordWrap	FontSize
  	TQRDBText	QRDBText2LeftTopWidthFHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@       �@UUUUUUU�@UUUUUU5�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetAnaTablo	DataFieldUYE_KODUFont.CharsetTURKISH_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparent	WordWrap	FontSize
   TQRBandPageFooterBand1Left&Top� Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@������v�	@ BandTyperbPageFooter 
TQRSysData
QRSysData2Left TopWidthkHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������J�@                 �@UUUUUU��@ 	AlignmenttaLeftJustifyAlignToBand	AutoSize	ColorclWhiteDataqrsPageNumberText
Sayfa No: TransparentFontSize
   TQRBandPageHeaderBand1Left&Top&Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style ForceNewColumnForceNewPage
ParentFontSize.Values      ��@������v�	@ BandTyperbPageHeader 
TQRSysData
QRSysData1Left,TopWidthuHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������J�@      p�@       �@      Ț@ 	AlignmenttaCenterAlignToBand	AutoSize	ColorclWhiteDataqrsReportTitleFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontTransparentFontSize   TQRBandSummaryBand1Left&Top� Width�HeightFrame.ColorclBlackFrame.DrawTop	Frame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@������v�	@ BandType	rbSummary TQRExprQRExpr5Left0TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUU�@UUUUUUU�@      ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameArial
Font.Style ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression)FORMATNUMERIC('#,',SUM(DetayTablo.kalan))FontSize
  TQRExprQRExpr7Left�TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@UUUUUUU�@UUUUUU=�@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclRedFont.Height�	Font.NameArial
Font.Style ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression.FORMATNUMERIC('#,',SUM(DetayTablo.FAIZMIKTAR))FontSize
  TQRExprQRExpr2Left� TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@UUUUUUU�@������g�@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclTealFont.Height�	Font.NameArial
Font.Style ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression+FORMATNUMERIC('#,',SUM(DetayTablo.OMIKTAR))FontSize
  TQRExprQRExpr8Left	TopWidth-HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@      ��@UUUUUUU�@�������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclBlueFont.Height�	Font.NameArial
Font.Style ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
ExpressionCOUNTFontSize
   TQRSubDetailQRSubDetail1Left&TopvWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values      ��@������v�	@ MasterReportDataSet
DetayTablo
FooterBandGroupFooterBand1
HeaderBandGroupHeaderBand1PrintBeforePrintIfEmpty	 	TQRDBText	QRDBText3Left TopWidth+HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@          UUUUUUU� @��������@ 	AlignmenttaLeftJustifyAlignToBand	AutoSize	AutoStretchColorclWhiteDataSet
DetayTablo	DataFieldOTARIHFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText4Left� TopWidth2HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@UUUUUUU� @������J�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSet
DetayTablo	DataFieldOMIKTARFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText5Left0TopWidth$HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUU�@UUUUUUU� @      ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSet
DetayTablo	DataFieldKALANFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText6Left�TopWidthGHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@UUUUUUU� @������ڻ@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSet
DetayTablo	DataField
FAIZMIKTARFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTransparentWordWrap	FontSize   TQRBandGroupHeaderBand1Left&TophWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottom	Frame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style ForceNewColumnForceNewPageLinkBandQRSubDetail1
ParentFontSize.Values������*�@������v�	@ BandTyperbGroupHeader TQRLabelQRLabel3Left Top WidthUHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@                    UUUUUU��@ 	AlignmenttaLeftJustifyAlignToBand	AutoSize	AutoStretchCaption�deme TarihiColorclWhiteTransparentWordWrap	FontSize  TQRLabelQRLabel4Left� Top Width\HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@          ������j�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaption�denen MiktarColorclWhiteTransparentWordWrap	FontSize  TQRLabelQRLabel5Left0Top WidthUHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUU�@          UUUUUU��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionKalan MiktarColorclWhiteTransparentWordWrap	FontSize  TQRLabelQRLabel6Left�Top WidthUHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@          UUUUUU��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaption��leyen FaizColorclWhiteTransparentWordWrap	FontSize   TQRBandGroupFooterBand1Left&Top� Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold ForceNewColumnForceNewPage
ParentFontSize.Values��������@������v�	@ BandTyperbGroupFooter TQRExprQRExpr3Left� Top Width� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@          ������g�@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclTealFont.Height�	Font.NameArial
Font.StylefsBold ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression+FORMATNUMERIC('#,',SUM(DetayTablo.OMIKTAR))FontSize
  TQRExprQRExpr4Left�Top Width� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@          UUUUUU=�@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclRedFont.Height�	Font.NameArial
Font.StylefsBold ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression.FORMATNUMERIC('#,',SUM(DetayTablo.FAIZMIKTAR))FontSize
  TQRExprQRExpr6Left0Top Width� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUU�@                ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSizeAutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameArial
Font.StylefsBold ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
Expression)FORMATNUMERIC('#,',SUM(DetayTablo.kalan))FontSize
  TQRExprQRExpr1Left	TopWidth.HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@      ��@UUUUUUU� @������j�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchFont.CharsetTURKISH_CHARSET
Font.ColorclBlueFont.Height�	Font.NameArial
Font.StylefsBold ColorclWhiteMasterQRSubDetail1
ParentFontResetAfterPrint	TransparentWordWrap	
ExpressionCOUNTFontSize
   TQRChildBand
ChildBand1Left&TopVWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold ForceNewColumnForceNewPage
ParentFontSize.Values      ��@������v�	@ 
ParentBandDetailBand1 TQRLabelQRLabel1LeftTopWidthYHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUUU�@UUUUUUU� @������z�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaption�deme Say�s�ColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclBlueFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize
  TQRLabelQRLabel2Left� TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@UUUUUUU� @UUUUUU%�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionToplam �denen MiktarColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclTealFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize
  TQRLabelQRLabel7Left0TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@UUUUUU�@UUUUUUU� @�������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionToplam Kalan MiktarColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize
  TQRLabelQRLabel8Left�TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@UUUUUUU� @      ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionToplam ��leyen FaizColorclWhiteFont.CharsetTURKISH_CHARSET
Font.ColorclRedFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize
    TTableAnaTabloActive	DatabaseName
Delphiturk	TableNameUYE.DBTop TAutoIncFieldAnaTabloUYE_KODU	FieldNameUYE_KODUReadOnly	  TStringFieldAnaTabloADI	FieldNameADIRequired	   TTable
DetayTabloActive	DatabaseName
Delphiturk	IndexNameUYE_IDXMasterFieldsUYE_KODUMasterSource	AnaSource	TableName	TAKSIT.DBTop( TAutoIncFieldDetayTabloKOD	FieldNameKODReadOnly	  TIntegerFieldDetayTabloUYEKOD	FieldNameUYEKODRequired	  
TDateFieldDetayTabloOTARIH	FieldNameOTARIHDisplayFormatdd mmmm yyyy  TCurrencyFieldDetayTabloOMIKTAR	FieldNameOMIKTAR  TCurrencyFieldDetayTabloFAIZMIKTAR	FieldName
FAIZMIKTAR  TCurrencyFieldDetayTabloKALAN	FieldNameKALAN   TDataSource	AnaSourceDataSetAnaTabloTopH   