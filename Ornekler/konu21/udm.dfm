�
 TDM 0i  TPF0TDMDMOldCreateOrderLeftITop� Height� Width�  TTable	KisiTableActive	BeforeDeleteKisiTableBeforeDeleteOnCalcFieldsKisiTableCalcFieldsOnDeleteErrorKisiTableDeleteErrorOnPostErrorKisiTablePostErrorDatabaseName
Delphiturk	TableName	kisiex.dbLeftTop TAutoIncFieldKisiTableKod	FieldNameKodReadOnly	  TStringFieldKisiTableAd	FieldNameAd  TStringFieldKisiTableSoyad	FieldNameSoyad  TIntegerFieldKisiTableSehirKod	FieldNameSehirKod  
TDateFieldKisiTableDTarih	FieldNameDTarihDisplayFormatd/m/yyyy dddEditMask!99/99/0000;1;_  TCurrencyFieldKisiTableMaasCustomConstraint(Value > 0) OR (Value is NULL)ConstraintErrorMessage1Girilen de�er CustomConstaint �zelli�ini ge�emedi	FieldNameMaas  TGraphicFieldKisiTableResim	FieldNameResimBlobType	ftGraphic  
TBlobFieldKisiTableSes	FieldNameSesBlobTypeftBlob  
TMemoFieldKisiTableAciklama	FieldNameAciklamaBlobTypeftMemoSize  TStringFieldKisiTableSehirAdi	FieldKindfkLookup	FieldNameSehirAdiLookupDataSet
SehirTableLookupKeyFieldsKodLookupResultFieldSehir	KeyFieldsSehirKodLookup	  TIntegerFieldKisiTableYas	FieldKindfkCalculated	FieldNameYasDisplayFormat(;'Ya� s�f�rdan k���k';'Ya� s�f�r olamaz'
Calculated	  
TTimeFieldKisiTableSonGiris	FieldNameSonGiris
OnValidateKisiTableSonGirisValidateDisplayFormathh:mmEditMask
!90:00;1;_   TDataSource
KisiSourceDataSet	KisiTableLeft`Top  TTable
SehirTableActive	DatabaseName
Delphiturk	TableNamesehir.dbLeftTop@ TIntegerFieldSehirTableKod	FieldNameKod  TStringFieldSehirTableSehir	FieldNameSehirRequired	    