unit ucreatetable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, ImgList, DBTables, Db, Grids, DBGrids,
  DBCtrls;

type
  TNodeEvent = procedure(Sender: TObject; Before: Boolean) of object;
  TNodeObject = class
    PageIndex: Integer;
    ValidateMethod: TNodeEvent;
    constructor Create(APageIndex: Integer; AValidateMethod: TNodeEvent);
  end;
  TFmMain = class(TForm)
    Bevel1: TBevel;
    btnHelp: TButton;
    NB: TNotebook;
    TV: TTreeView;
    LblStatus: TLabel;
    btnNext1: TButton;
    Image1: TImage;
    Label1: TLabel;
    ImgList: TImageList;
    AliasList: TListBox;
    Label2: TLabel;
    btnDatabase: TButton;
    Session: TSession;
    LblAliasName: TLabel;
    Shape1: TShape;
    FieldList: TListView;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CreateTable: TTable;
    Shape2: TShape;
    LblAliasIndex: TLabel;
    IndexList: TListView;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label3: TLabel;
    edTableName: TEdit;
    Image2: TImage;
    Label4: TLabel;
    Button10: TButton;
    DBGrid1: TDBGrid;
    CreateTableSource: TDataSource;
    DBNavigator1: TDBNavigator;
    btnNewTable: TButton;
    Label5: TLabel;
    CmbIndexes: TComboBox;
    ListImg: TImageList;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TVCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure TVChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure btnNext1Click(Sender: TObject);
    procedure btnDatabaseClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure btnNewTableClick(Sender: TObject);
    procedure CmbIndexesClick(Sender: TObject);
    procedure AliasListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    procedure DoAliasPage(Sender: TObject; Before: Boolean);
    procedure DoFieldsPage(Sender: TObject; Before: Boolean);
    procedure DoIndexPage(Sender: TObject; Before: Boolean);
    procedure DoTableCreate(Sender: TObject; Before: Boolean);
    procedure DoTableName(Sender: TObject; Before: Boolean);
    procedure DoCreateTable(Sender: TObject; Before: Boolean);

    procedure CreateNodes;
    function CreateNode(ParentNode: TTreeNode; const ACaption: string; NodeObject: TNodeObject): TTreeNode;
    procedure FindAndClickNode(PageIndex: Integer);
    procedure Initialize;
    procedure ShowFieldDef(AField: TFieldDef);
    procedure ShowIndexDef(AIndex: TIndexDef);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses Ufldedit, uindexedit;

{$R *.DFM}

const
 BoolStr: array[Boolean] of string = ('Hayýr', 'Evet');

function TFmMain.CreateNode(ParentNode: TTreeNode; const ACaption: string;
  NodeObject: TNodeObject): TTreeNode;
var Node: TTreeNode;
begin
  Node := TV.Items.AddChild(ParentNode, ACaption);
  Node.Data := NodeObject;
  Node.ImageIndex := 0;
  Node.SelectedIndex := 1;
  Result := Node;
end;

procedure TFmMain.CreateNodes;
var Node: TTreeNode;
begin
  Node := CreateNode(nil, 'Tablo Yaratma Ýþlemleri', TNodeObject.Create(0, DoCreateTable));
  CreateNode(Node, 'Veri Tabaný Seç', TNodeObject.Create(1, DoAliasPage));
  CreateNode(Node, 'Alanlarý Belirle', TNodeObject.Create(2, DoFieldsPage));
  CreateNode(Node, 'Ýndeksleri Belirle', TNodeObject.Create(3, DoIndexPage));
  CreateNode(Node, 'Tabloyu yarat', TNodeObject.Create(4, DoTableCreate));
  CreateNode(Node, 'Tabloya veri ekle', TNodeObject.Create(5, DoTableName));
  Node.Expand(True);
  //Node.Selected := True;

  //Node := CreateNode(nil, 'Tablo Boþaltma Ýþlemleri', TNodeObject.Create(6, nil));
  //Node := CreateNode(nil, 'Tablo Silme Ýþlemleri', TNodeObject.Create(6, nil));

end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  CreateNodes;
  FindAndClickNode(0);
  Initialize;
end;

{ TNodeObject }

constructor TNodeObject.Create(APageIndex: Integer;
  AValidateMethod: TNodeEvent);
begin
  inherited Create;
  PageIndex := APageIndex;
  ValidateMethod := AValidateMethod;
end;

procedure TFmMain.TVCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := False;
end;

procedure TFmMain.TVChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if Assigned(TNodeObject(Node.Data).ValidateMethod) then
  try
    TNodeObject(Node.Data).ValidateMethod(Node, True);
  except
    on E: Exception do
    begin
      AllowChange := False;
      if not (E is EAbort) then MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;    
end;

procedure TFmMain.TVChange(Sender: TObject; Node: TTreeNode);
begin
  NB.PageIndex := TNodeObject(Node.Data).PageIndex;
  LblStatus.Caption := Node.Text;
  if Assigned(TNodeObject(Node.Data).ValidateMethod) then
    TNodeObject(Node.Data).ValidateMethod(Node, False);
end;

procedure TFmMain.btnNext1Click(Sender: TObject);
begin
  FindAndClickNode(1);
end;

procedure TFmMain.FindAndClickNode(PageIndex: Integer);
var I: Integer;
begin
  for I := 0 to TV.Items.Count - 1 do
   if TNodeObject(Tv.Items[i].Data).PageIndex = PageIndex then
   begin
     Tv.Items[i].Selected := True;
     Break;
   end;
end;

procedure TFmMain.btnDatabaseClick(Sender: TObject);
begin
  FindAndClickNode(TButton(Sender).Tag);
end;

procedure TFmMain.Initialize;
begin
  CreateTable.DatabaseName := '';
end;

procedure TFmMain.DoAliasPage(Sender: TObject; Before: Boolean);
begin
  if Before then
  try
   Session.GetAliasNames(AliasList.Items);
   AliasList.ItemIndex := AliasList.Items.IndexOf(CreateTable.DatabaseName);
  except
    on E: Exception do
     raise Exception.CreateFmt('Sisteminizde alias isimleri alýnamadý. Büyük olasýlýkla BDE yüklenmememiþ. Hata Mesajý:%s', [E.Message]);
  end;   
end;

procedure TFmMain.DoFieldsPage(Sender: TObject; Before: Boolean);
var I: Integer;
begin
  if Before then
  begin
    if CreateTable.Active then Abort;
    if (AliasList.ItemIndex < 0) or (AliasList.Items.Count <= 0) then
      raise Exception.Create('Geçerli bir alias seçiniz');
  end else
  begin
    CreateTable.DatabaseName := AliasList.Items[AliasList.ItemIndex];
    LblAliasName.Caption := 'Veri Tabaný: ' + CreateTable.DatabaseName;
    FieldList.Items.Clear;
    for I := 0 to CreateTable.FieldDefs.Count - 1 do
     ShowFieldDef(CreateTable.FieldDefs[I]);
  end;
end;

procedure TFmMain.Button2Click(Sender: TObject);
var NewField: TFieldDef;
begin
  NewField := CreateTable.FieldDefs.AddFieldDef;
  if not FmFieldEditor.Execute('Alan Ekle', NewField) then
  begin
    NewField.Free;
  end else
  begin
    ShowFieldDef(NewField);
  end;
end;

procedure TFmMain.Button3Click(Sender: TObject);
var AField: TFieldDef;
    Item: TListItem;
begin
  Item := FieldList.Selected;
  if Item = nil then Exit;
  AField := CreateTable.FieldDefs.Find(FieldList.Selected.Caption);
  if FmFieldEditor.Execute('Alan Düzenle', AField) then
  with AField do
  begin
    Item.Caption := Name;
    Item.SubItems[0] := FmFieldEditor.GetDataTypeStr(DataType);
    Item.SubItems[1] := IntToStr(Size);
    Item.SubItems[2] := BoolStr[faRequired in Attributes];
  end;
end;

procedure TFmMain.ShowFieldDef(AField: TFieldDef);
var Item: TListItem;
begin
  Item := FieldList.Items.Add;
  with AField do
  begin
    Item.Caption := Name;
    Item.SubItems.Add(FmFieldEditor.GetDataTypeStr(DataType));
    Item.SubItems.Add(IntToStr(Size));
    Item.SubItems.Add(BoolStr[faRequired in Attributes]);
  end;
end;

procedure TFmMain.DoIndexPage(Sender: TObject; Before: Boolean);
var I: Integer;
begin
  if Before then
  begin
    if CreateTable.Active then Abort;
    if FieldList.Items.Count <= 0 then
     raise Exception.Create('En az bir adet alan tanýmý yapýlmalýdýr');
  end
  else
  begin
    LblAliasIndex.Caption := 'Veri Tabaný: ' + CreateTable.DatabaseName;
    IndexList.Items.Clear;
    for I := 0 to CreateTable.IndexDefs.Count - 1 do
     ShowIndexDef(CreateTable.IndexDefs[I]);
  end;

end;

procedure TFmMain.Button5Click(Sender: TObject);
begin
  FindAndClickNode(3);
end;

procedure TFmMain.Button4Click(Sender: TObject);
var AField: TFieldDef;
    Item: TListItem;
begin
  Item := FieldList.Selected;
  if Item = nil then Exit;
  AField := CreateTable.FieldDefs.Find(FieldList.Selected.Caption);
  if MessageDlg('Bu iþlem alan tanýmýný silecektir.', mtConfirmation, [mbOk, mbCancel], 0) <> mrOk then Exit;
  FieldList.Items.Delete(FieldList.Items.IndexOf(Item));
  AField.Free;
end;

procedure TFmMain.Button6Click(Sender: TObject);
var NewIndex: TIndexDef;
begin
  NewIndex := CreateTable.IndexDefs.AddIndexDef;
  if not FmIndexEditor.Execute('Ýndeks Ekle', NewIndex, CreateTable) then
  begin
    NewIndex.Free;
  end else
  begin
    ShowIndexDef(NewIndex);
  end;
end;

procedure TFmMain.ShowIndexDef(AIndex: TIndexDef);
var Item: TListItem;
begin
  Item := IndexList.Items.Add;
  with AIndex do
  begin
    Item.Caption := Name;
    Item.SubItems.Add(AIndex.Fields);
  end;
end;

procedure TFmMain.Button7Click(Sender: TObject);
var AIndex: TIndexDef;
    Item: TListItem;
begin
  Item := IndexList.Selected;
  if Item = nil then Exit;
  AIndex := CreateTable.IndexDefs.Find(IndexList.Selected.Caption);
  if FmIndexEditor.Execute('Ýndeks üzenle', AIndex, CreateTable) then
  with AIndex do
  begin
    Item.Caption := Name;
    Item.SubItems[0] := AIndex.Fields;
  end;
end;

procedure TFmMain.Button8Click(Sender: TObject);
var AIndex: TIndexDef;
    Item: TListItem;
begin
  Item := IndexList.Selected;
  if Item = nil then Exit;
  AIndex := CreateTable.IndexDefs.Find(IndexList.Selected.Caption);
  if MessageDlg('Bu iþlem indeks tanýmýný silecektir.', mtConfirmation, [mbOk, mbCancel], 0) <> mrOk then Exit;
  IndexList.Items.Delete(IndexList.Items.IndexOf(Item));
  AIndex.Free;
end;

procedure TFmMain.Button9Click(Sender: TObject);
begin
  FindAndClickNode(4);
end;

procedure TFmMain.DoTableCreate(Sender: TObject; Before: Boolean);
begin
  if Before then
  begin
    if CreateTable.Active then Abort;
    if CreateTable.FieldDefs.Count <= 0 then
     raise Exception.Create('Tablo alan tanýmlarý yapýlmamýþ'); 
    edTableName.Text := CreateTable.TableName;

  end;
end;

procedure TFmMain.Button10Click(Sender: TObject);
begin
  FindAndClickNode(5);
end;

procedure TFmMain.DoTableName(Sender: TObject; Before: Boolean);
begin
  if Before then
  begin
    if CreateTable.Active then Exit;
    if Trim(edTableName.Text) = '' then
     raise Exception.Create('Geçersiz tablo adý');
    CreateTable.TableName := edTableName.Text;
    try
     CreateTable.CreateTable;
    except
     on E: Exception do
      raise Exception.CreateFmt('Tablo yaratma iþlemi baþarýsýz. Hata Mesajý: %s', [E.Message])
    end;
  end else
  begin
    try
     CreateTable.Open;
     CreateTable.GetIndexNames(CmbIndexes.Items);
    except
     on E: Exception do
      raise Exception.CreateFmt('Tablo açma iþlemi baþarýsýz. Hata Mesajý: %s', [E.Message])
    end;
  end;
end;

procedure TFmMain.btnNewTableClick(Sender: TObject);
begin
   CreateTable.Close;
   CreateTable.DatabaseName := '';
   CreateTable.TableName := '';
   CreateTable.FieldDefs.Clear;
   CreateTable.IndexDefs.Clear;
   FindAndClickNode(0);
end;

procedure TFmMain.CmbIndexesClick(Sender: TObject);
begin
  with CmbIndexes do
  begin
    CreateTable.IndexName := Items[ItemIndex];
  end;  
end;

procedure TFmMain.DoCreateTable(Sender: TObject; Before: Boolean);
begin
  btnDatabase.Tag := 2;
end;

procedure TFmMain.AliasListDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control AS TListBox, Canvas DO
    begin
      FillRect(Rect);
      InflateRect(Rect, -1, -1);
      with Rect do Rectangle(Left, Top, Right, Bottom);
      InflateRect(Rect, -3, -3);
      ListImg.Draw(Canvas, Rect.Left, Rect.Top + 1, 0, True);
      Inc(Rect.Left, 40);
      DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
   end;
end;

end.
