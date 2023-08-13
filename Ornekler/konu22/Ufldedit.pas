unit Ufldedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UCreateTable, DB,
  StdCtrls, ExtCtrls;

type
  TFieldTypeObj = class
   DataType: TFieldType;
   DefSize: Integer;
   constructor Create(ADataType: TFieldType; ADefSize: Integer);
  end;

  TFmFieldEditor = class(TForm)
    Label1: TLabel;
    edFieldName: TEdit;
    Label2: TLabel;
    CmbDataType: TComboBox;
    Label3: TLabel;
    edSize: TEdit;
    Label4: TLabel;
    CmbRequired: TComboBox;
    Bevel1: TBevel;
    btnOk: TButton;
    BtnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CmbDataTypeChange(Sender: TObject);
  private
    FField: TFieldDef;
    procedure Validate;
    function FindDataType(ADateType: TFieldType): Integer;
  public
    function Execute(const ACaption: string; AField: TFieldDef): Boolean;
    function GetDataTypeStr(ADataType: TFieldType): string;
  end;

var
  FmFieldEditor: TFmFieldEditor;

implementation

{$R *.DFM}

{ TFmFieldEditor }

function TFmFieldEditor.Execute(const ACaption: string;
  AField: TFieldDef): Boolean;
begin
  Caption := ACaption;
  EdFieldName.Text := AField.Name;
  edSize.Text := IntToStr(AField.Size);
  CmbRequired.ItemIndex := Integer(faRequired in AField.Attributes);
  CmbDataType.ItemIndex := FindDataType(AField.DataType);
  FField := AField;
  Result := ShowModal = mrOk;
end;

procedure TFmFieldEditor.btnOkClick(Sender: TObject);
begin
  Validate;
  try
    with FField do
    begin
      Name := edFieldName.Text;
      DataType := TFieldTypeObj(CmbDataType.Items.Objects[CmbDataType.ItemIndex]).DataType;
      Size := StrToInt(edSize.Text);
      if CmbRequired.ItemIndex = 0 then
       Attributes := Attributes - [faRequired]
      else
       Attributes := Attributes + [faRequired]
    end;
  except
    raise Exception.Create('Girilen alan ismiyle ayný isme sahip alan tanýmý önceden yapýlmýþ durumda.'); 
  end;
  ModalResult := mrOk;
end;

procedure TFmFieldEditor.Validate;
begin
  if CmbDataType.ItemIndex < 0 then
  begin
    CmbDataType.SetFocus;
    raise Exception.Create('Veri tipi seçiniz');
  end;

  try
    StrToInt(edSize.Text);
  except
    raise Exception.Create('Geçersiz boyut');
  end;

  if Trim(edFieldName.Text) = '' then
   raise Exception.Create('Alan adý giriniz');

end;

procedure TFmFieldEditor.FormCreate(Sender: TObject);
begin
  with CmbDataType.Items do
  begin
    AddObject('Alfa Nümerik - string', TFieldTypeObj.Create(ftstring, 20));
    AddObject('Tamsayý - Integer', TFieldTypeObj.Create(ftInteger, 0));
    AddObject('Küçük Tamsayý - ShortInt', TFieldTypeObj.Create(ftSmallint, 0));
    AddObject('Tarih - Date', TFieldTypeObj.Create(ftDate, 0));
    AddObject('Saat - Time', TFieldTypeObj.Create(ftTime, 0));
    AddObject('Tarih/Saat', TFieldTypeObj.Create(ftDateTime, 0));
    AddObject('Otomatik Artan Sayý - AutoInc', TFieldTypeObj.Create(ftAutoInc, 0));
    AddObject('Ondalýklý Sayý - Float', TFieldTypeObj.Create(ftFloat, 0));
    AddObject('Ýkili veri - Blob', TFieldTypeObj.Create(ftBlob, 0));
    AddObject('Metin veri - Memo', TFieldTypeObj.Create(ftMemo, 0));
    AddObject('Mantýksal veri - Boolean', TFieldTypeObj.Create(ftBoolean, 0));
  end;
end;

function TFmFieldEditor.FindDataType(ADateType: TFieldType): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to CmbDataType.Items.Count - 1 do
  begin
    if TFieldTypeObj(CmbDataType.Items.Objects[I]).DataType = ADateType then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TFmFieldEditor.GetDataTypeStr(ADataType: TFieldType): string;
var I: Integer;
begin
  Result := '';
  for I := 0 to CmbDataType.Items.Count - 1 do
  begin
    if TFieldTypeObj(CmbDataType.Items.Objects[I]).DataType = ADataType then
    begin
      Result := CmbDataType.Items[I];
      Break;
    end;
  end;
end;

{ TFieldTypeObj }

constructor TFieldTypeObj.Create(ADataType: TFieldType; ADefSize: Integer);
begin
  inherited Create;
  DataType := ADataType;
  DefSize := ADefSize;
end;

procedure TFmFieldEditor.CmbDataTypeChange(Sender: TObject);
begin
  if CmbDataType.ItemIndex >= 0 then
  begin
    edSize.Text := IntToStr(TFieldTypeObj(CmbDataType.Items.Objects[CmbDataType.ItemIndex]).DefSize);
    edSize.Enabled := edSize.Text <> '0'; 
  end;
end;

end.
