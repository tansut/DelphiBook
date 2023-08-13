unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, DbTables, ImgList;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    DatabaseBtn: TToolButton;
    Tables: TListView;
    Label1: TLabel;
    Fields: TListView;
    Label2: TLabel;
    Indexes: TListView;
    Label3: TLabel;
    TableCntLabel: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ProgressBar: TProgressBar;
    ToolButton10: TToolButton;
    SaveDialog: TSaveDialog;
    DataBtn: TToolButton;
    ToolButton11: TToolButton;
    procedure DatabaseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TablesClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure TablesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure DataBtnClick(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    CurrentDatabase: string;
    procedure FillInformation;
    procedure ShowFieldInformation(const ATableName: string);
    procedure ShowIndexInformation(const ATableName: string);
    function PrintToTextFile(const FileName: string): Boolean;
  public

  end;

var
  MainForm: TMainForm;

implementation

uses dbase, DmDtMod, Db, prnopt, ShellApi, data;

const RequiredDefs : array[Boolean] of string = ('Hayýr', 'Evet');
      FieldTypeStr : array[TFieldType] of string = (
      'Bilinmiyor',
      'String',
      'SmallInt',
      'Integer',
      'Word',
      'Boolean',
      'Float',
      'Currency',
      'BCD',
      'Date',
      'Time',
      'DateTime',
      'Byte',
      'AutoInc',
      'varBytes',
      'Blob',
      'Memo',
      'Graphic',
      'FmtMemo',
      'ParadoxOle',
      'DBaseOle',
      'TypedBinary',
      'Cursor',
      'FixedChar',
      'WideString',
      'LargeInt',
      'ADT',
      'Array',
      'Reference',
      'Dataset');


{$R *.DFM}
function ReplaceBy(S: string; F, R: Char): string;
var I: Integer;
begin
  Result := S;
  for I := 1 to Length(Result) do
   if Result[I] = F then Result[I] := R;
end;


function TMainForm.PrintToTextFile(const FileName: string): Boolean;
const NullDefs : array[Boolean] of string = ('Boþ geçilebilir', 'Boþ GEÇÝLEMEZ');
var f: TextFile;
    i, j, k: integer;
    s: string;
begin
  Result := True;
  AssignFile(F, FileName);
  try
   ReWrite(f);
  except
   Result := False;
   Exit;
  end;
  for i := 0 to Tables.Items.Count - 1 do
  begin
    if PrnOptionsForm.SecChk.Checked and (not Tables.Items[i].checked) then
      continue;
    with Dm do
    begin
      DbTable.TableName := Tables.Items[I].Caption;
      DbTable.FieldDefs.Update;
      DbTable.IndexDefs.Update;
      S:= Format('%-20s: %s', ['Tablo Adý', DbTable.TableName]);
      Writeln(F, S);
      for j := 0 to DbTable.FieldDefs.Count - 1 do
      begin
        S := Format(' %-25s: %-12s %-5d %-10s',
                    [DbTable.FieldDefs[J].Name,
                     FieldTypeStr[DbTable.FieldDefs[J].DataType],
                     DbTable.FieldDefs[J].Size,
                     NullDefs[DbTable.FieldDefs[J].Required]]);
        WriteLn(F, S);
      end;
      if PrnOptionsForm.IndexChk.Checked then
      begin
        if DbTable.IndexDefs.Count > 0 then
        begin
          WriteLn(F, 'Indexler');
          S := Format(' %-25s: %-40s %-10s %-5s', ['Index Adý', 'Alanlar', 'Primary ?', 'Tek ?']);
          WriteLn(F, S);
        end;
        for k := 0 to DbTable.IndexDefs.Count - 1 do
        begin
          S := Format(' %-25s: %-40s %-10s %-5s',
                      [DbTable.IndexDefs[k].Name,
                      DbTable.IndexDefs[k].Fields,
                      RequiredDefs[ixPrimary in DbTable.IndexDefs[k].Options],
                      RequiredDefs[ixUnique in DbTable.IndexDefs[k].Options]]);
        WriteLn(F, S);
        end;
      end;
      WriteLn(F, '--------------------------------------------------');
    end;
  end;
  CloseFile(F);
end;


procedure TMainForm.ShowIndexInformation(const ATableName: string);
var I: Integer;
    ListItem: TListItem;
begin
  with Dm do
  begin
    DbTable.IndexDefs.Update;
    Indexes.Items.Clear;
    for I := 0 to DbTable.IndexDefs.Count - 1 do
    begin
      ListItem := Indexes.Items.Add;
      ListItem.Caption := DbTable.IndexDefs[I].Name;
      ListItem.SubItems.Add(DbTable.IndexDefs[I].Fields);
      ListItem.SubItems.Add(RequiredDefs[ixPrimary in DbTable.IndexDefs[I].Options]);
      ListItem.SubItems.Add(RequiredDefs[ixUnique in DbTable.IndexDefs[I].Options]);
    end;
  end;
end;

procedure TMainForm.ShowFieldInformation(const ATableName: string);
var I: Integer;
    ListItem: TListItem;
begin
  with Dm do
  begin
    DbTable.TableName := ATableName;
    DbTable.FieldDefs.Update;
    Fields.Items.Clear;
    for I := 0 to DbTable.FieldDefs.Count - 1 do
    begin
      ListItem := Fields.Items.Add;
      ListItem.Caption := DbTable.FieldDefs[I].Name;
      ListItem.SubItems.Add(FieldTypeStr[DbTable.FieldDefs[I].DataType]);
      ListItem.SubItems.Add(IntToStr(DbTable.FieldDefs[I].Size));
      ListItem.SubItems.Add(RequiredDefs[DbTable.FieldDefs[I].Required]);
    end;
  end;
end;

procedure TMainForm.FillInformation;
var I: Integer;
    List: TStrings;
    ListItem: TListItem;
begin
  List := TStringList.Create;
  with Dm do
  try
    DbTable.DatabaseName := CurrentDatabase;
    DbSession.GetTableNames(CurrentDatabase, '', True, False, List);
    StatusBar.Panels[0].Text := CurrentDatabase;
    Tables.Items.Clear;
    Fields.Items.Clear;
    Indexes.Items.Clear;
    for I := 0 to List.Count - 1 do
    begin
      ProgRessBar.StepIt;
      ProgRessBar.Update;
      ListItem := Tables.Items.Add;
      ListItem.Caption := List[I];
    end;
    if Tables.Items.Count > 0 then
    begin
      Tables.Items[0].Selected := True;
      TablesClick(Self);
    end;
  finally
    TableCntLabel.Caption := Format('Toplam Adet: %d', [List.Count]);
    List.Free;
  end;
end;

procedure TMainForm.DatabaseBtnClick(Sender: TObject);
begin
  if ExecuteDBaseForm(CurrentDatabase) then
  begin
    Statusbar.Panels[0].Text := '';
    ProgRessBar.Visible := True;
    ProgRessBar.Position := 0;
    try
      FillInformation;
    finally
      ProgRessBar.Visible := False;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TableCntLabel.Caption := '';
  Statusbar.Panels[0].Text := '';
end;

procedure TMainForm.TablesClick(Sender: TObject);
begin
  if Assigned(Tables.Selected) then
  begin
    StatusBar.Panels[0].Text := Format('%s:%s', [CurrentDatabase, Tables.Selected.Caption]);
    ShowFieldInformation(Tables.Selected.Caption);
    ShowIndexInformation(Tables.Selected.Caption);
  end;
end;

procedure TMainForm.ToolButton2Click(Sender: TObject);
var I: Integer;
begin
  for I := 0 to Tables.Items.Count - 1 do
   Tables.Items[I].Checked := True;
end;

procedure TMainForm.TablesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TablesClick(Self);
end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
begin
  //PrnOptionsForm.SecChk.Checked := Tables.SelCount > 1;
  if PrnOptionsForm.Execute('Yazdýrma Seçenekleri') then
  begin
    if PrintToTextFile('~tmp~1.txt') then
     ShellExecute(Handle, 'print', '~tmp~1.txt', '', '', SW_HIDE);
  end;
end;

procedure TMainForm.ToolButton6Click(Sender: TObject);
begin
  if not PrnOptionsForm.Execute('Kaydetme Seçenekleri') then Exit;
  if SaveDialog.Execute then
   if PrintToTextFile(SaveDialog.FileName) then
    ShellExecute(Handle, 'open', PChar(SaveDialog.FileName) , '', '', SW_SHOWNORMAL);
end;

procedure TMainForm.DataBtnClick(Sender: TObject);
begin
  DataForm.Execute(Dm.DbTable, Tables.Items);
end;

procedure TMainForm.ToolButton8Click(Sender: TObject);
begin
  ShowMessage('www.delphikitabi.com');
end;

end.
