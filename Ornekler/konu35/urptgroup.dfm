�
 TFMGROUPREPORT 0Q  TPF0TFmGroupReportFmGroupReportLeft� TopwWidth}HeightCaptionFmGroupReportColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderScaledPixelsPerInch`
TextHeight 	TQuickRepReportLeftTop WidthHeightcFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightDataSetQuery1Font.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.Style Functions.Strings
PAGENUMBERCOLUMNNUMBERREPORTTITLEQRSTRINGSBAND1 Functions.DATA00'''' OptionsFirstPageHeaderLastPageFooter Page.ColumnsPage.Orientation
poPortraitPage.PaperSizeA4Page.Values       �@      ��
@       �@      @�
@       �@       �@       �@ PrinterSettings.CopiesPrinterSettings.DuplexPrinterSettings.FirstPage PrinterSettings.LastPage PrinterSettings.OutputBinAutoPrintIfEmpty	ReportTitle�ehir Listesi
SnapToGrid	UnitsMMZoomd TQRBandQRBand2Left&Top� Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.ValuesUUUUUU�@������v�	@ BandTyperbPageFooter 
TQRSysData
QRSysData2Left TopWidthmHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@                 �@������2�@ 	AlignmenttaLeftJustifyAlignToBand	AutoSize	ColorclWhiteDataqrsPageNumberText
Sayfa No: TransparentFontSize  
TQRSysData
QRSysData3LeftTopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@��������	@       �@      �@ 	AlignmenttaRightJustifyAlignToBand	AutoSize	ColorclWhiteDataqrsDateTimeTextRapor Bas�m Tarihi: TransparentFontSize   TQRBandQRBand4Left&Top&Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values      ��@������v�	@ BandTyperbPageHeader 
TQRSysData
QRSysData1Left9TopWidth[HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.ValuesUUUUUU�@UUUUUU	�@UUUUUUU�@TUUUUU��@ 	AlignmenttaCenterAlignToBand	AutoSize	ColorclWhiteDataqrsReportTitleFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTransparentFontSize   TQRBandQRBand1Left&TopfWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values������*�@UUUUUUu�@ BandTyperbDetail 	TQRDBText	QRDBText1Left(Top WidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@��������@          ������
�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetQuery1	DataFieldSehirTransparentWordWrap	FontSize  	TQRDBText	QRDBText2Left Top WidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@                    ������j�@ 	AlignmenttaLeftJustifyAlignToBand	AutoSize	AutoStretchColorclWhiteDataSetQuery1	DataFieldKodTransparentWordWrap	FontSize   TQRGroupQRGroup1Left&TopAWidth� Height#Frame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameArial
Font.Style ForceNewColumnForceNewPage
ParentFontSize.ValuesUUUUUU5�@UUUUUUu�@ 
ExpressionCOPY(Query1.Sehir,1,1)
FooterBandQRBand3MasterReportReprintOnNewPage	 TQRExprQRExpr1Left TopWidth-Height!Frame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values      ��@                 �@UUUUUU�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteResetAfterPrintTransparentWordWrap	
ExpressionCOPY(Query1.Sehir,1,1)FontSize   TQRChildBand
ChildBand1Left&TopdWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclInactiveCaptionForceNewColumnForceNewPageSize.ValuesUUUUUUU�@UUUUUUu�@ 
ParentBandQRGroup1  TQRBandQRBand3Left&ToptWidth� HeightFrame.ColorclBlackFrame.DrawTop	Frame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageLinkBandQRBand1Size.Values      @�@UUUUUUu�@ BandTyperbGroupFooter TQRExprQRExpr2Left TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@          ��������@��������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteMasterReportResetAfterPrint	TransparentWordWrap	
Expression'Toplam �ehir: ' +  COUNTFontSize   TQRBandSummaryBand1Left&Top� Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@������v�	@ BandType	rbSummary 
TQRSysData
QRSysData4Left TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@          UUUUUUU�@TUUUUU��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	ColorclWhiteDataqrsDetailCountFont.CharsetTURKISH_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTextGenel Toplam: TransparentFontSize    TQueryQuery1Active	DatabaseName
DelphiturkSQL.Stringsselect * from sehirorder by sehir LeftTop TIntegerField	Query1Kod	FieldNameKodOriginDELPHITURK."sehir.DB".Kod  TStringFieldQuery1Sehir	FieldNameSehirOriginDELPHITURK."sehir.DB".Sehir    