unit Umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ImgList, ToolWin, Menus, DBTables, Grids, ComCtrls, StdCtrls;

type
  TAliasObj = class
  private
   FParams: TStringList;
   FModified: Boolean;
  public
   constructor Create(ASession: TSession; const AliasName: string);
   destructor Destroy; override;
   property Modified: Boolean read FModified write FModified;
   property Params: TStringList read FParams;
  end;

  TFmMain = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    ToolbarImages: TImageList;
    Splitter1: TSplitter;
    BtnOpen: TToolButton;
    Session1: TSession;
    TVImages: TImageList;
    AliasPopup: TPopupMenu;
    RefreshMenuItem: TMenuItem;
    StateImgs: TImageList;
    btnNew: TToolButton;
    btnDelete: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    btnAplly: TToolButton;
    btnCancel: TToolButton;
    TVAlias: TTreeView;
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure TVAliasChange(Sender: TObject; Node: TTreeNode);
    procedure TVAliasDblClick(Sender: TObject);
    procedure RefreshMenuItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TVConfDeletion(Sender: TObject; Node: TTreeNode);
    procedure FormResize(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btnNewClick(Sender: TObject);
    procedure TVAliasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TVAliasChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnApllyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    RootNode: TTreeNode;
    procedure LoadAliasList;
    function IsDatabaseOpen(const DatabaseName: string): Boolean;
    procedure OpenDatabase(const DatabaseName: string; Node: TTreeNode);
    procedure ShowAliasParams(Node: TTreeNode; Active: Boolean);
    procedure GetAliasParamsFromGrid(List: TStrings);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses Udriver;

{$R *.DFM}
{$R icon.res}

procedure TFmMain.FormCreate(Sender: TObject);
begin
  Grid.ColWidths[0] := 150;

  LoadAliasList;
end;

procedure TFmMain.LoadAliasList;
var TempNode: TTreeNode;
    AliasList: TStringList;
    I: Integer;
begin
  with TVAlias do
  begin
    Items.Clear;
    RootNode := Items.AddChild(nil, 'Veri Tabanlarý');
    RootNode.ImageIndex := 1;
    RootNode.SelectedIndex := 1;
    AliasList := TStringList.Create;
    try
      Session1.GetAliasNames(AliasList);
      for I := 0 to AliasList.Count - 1 do
      begin
        TempNode := Items.AddChild(RootNode, AliasList[i]);
        TempNode.SelectedIndex := 3;
        TempNode.Data := TAliasObj.Create(Session1, AliasList[i]);
        if IsDatabaseOpen(AliasList[i]) then
        begin
          TempNode.ImageIndex := 2;
        end;
      end;
    finally
      AliasList.Free;
    end;
    RootNode.Expand(True);
    TempNode.Selected := True;
  end;
end;

procedure TFmMain.BtnOpenClick(Sender: TObject);
var DB: TDatabase;
begin
  Db := Session1.FindDatabase(TVAlias.Selected.Text);
  if DB = nil then
  try
    OpenDatabase(TVAlias.Selected.Text, TVAlias.Selected);
  except
    BtnOpen.Down := False;
    raise;
  end else
  begin
    if DB.Connected then
    begin
      Db.Close;
      TVAlias.Selected.ImageIndex := 0;
      TVAlias.Selected.SelectedIndex := 0;
      BtnOpen.Down := False;
      TVAlias.Refresh;
    end else
    try
      OpenDatabase(TVAlias.Selected.Text, TVAlias.Selected);
    except
      BtnOpen.Down := False;
      raise;
    end;
  end;
  TVAliasChange(TVAlias, TVAlias.Selected);
end;

procedure TFmMain.TVAliasChange(Sender: TObject; Node: TTreeNode);
var IsAlias: Boolean;
begin
  IsAlias := Session1.IsAlias(Node.Text);
  BtnOpen.Enabled := IsAlias;
  BtnOpen.Down := IsDatabaseOpen(Node.Text);
  ShowAliasParams(Node, BtnOpen.Down);
end;

function TFmMain.IsDatabaseOpen(const DatabaseName: string): Boolean;
var DB: TDatabase;
begin
  DB := Session1.FindDatabase(DatabaseName);
  Result := (DB <> nil) and (DB.Connected);
end;

procedure TFmMain.OpenDatabase(const DatabaseName: string;
  Node: TTreeNode);
begin
  try
    Session1.OpenDatabase(TVAlias.Selected.Text);
    Node.ImageIndex := 2;
    Node.SelectedIndex := 2;
    TVAlias.Refresh;
  except
    raise;
  end;
end;

procedure TFmMain.ShowAliasParams(Node: TTreeNode;
  Active: Boolean);
var Params: TStringList;
    I: Integer;
begin
  if Node.Data = nil then
  begin
    Grid.RowCount := 0;
    Grid.Rows[0].Clear;
    Grid.Enabled := False;
  end else
  begin
    Params := TAliasObj(Node.Data).Params;
    Grid.Enabled := True;
    Grid.RowCount := Params.Count;
    for i := 0 to Params.Count - 1 do
    with Grid do
    begin
      Rows[i][0] := '  ' + Params.Names[i];
      Rows[i][1] := Params.Values[Params.Names[i]];
      RowHeights[i] := Canvas.TextHeight(Params.Names[i]) + 5;
    end;
    if Active then
    begin
      Grid.Font.Style := Grid.Font.Style + [fsBold];
      Grid.Options := Grid.Options - [goEditing];
    end else
    begin
      Grid.Font.Style := Grid.Font.Style - [fsBold];
      Grid.Options := Grid.Options + [goEditing];
    end;
  end;
end;

procedure TFmMain.TVAliasDblClick(Sender: TObject);
begin
  if BtnOpen.Enabled then
    BtnOpenClick(Self);
end;

procedure TFmMain.RefreshMenuItemClick(Sender: TObject);
begin
  LoadAliasList;
end;

procedure TFmMain.FormDestroy(Sender: TObject);
var I: Integer;
begin
  Session1.Close;
  for I := TVAlias.Items.Count - 1 downto 0 do
    TVAlias.Items[i].Delete;
end;

{ TAliasObj }

constructor TAliasObj.Create(ASession: TSession; const AliasName: string);
begin
  FParams := TStringList.Create;
  ASession.GetAliasParams(AliasName, FParams);
  FModified := False;
end;

destructor TAliasObj.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

procedure TFmMain.TVConfDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
   TAliasObj(Node.Data).Free;
end;

procedure TFmMain.FormResize(Sender: TObject);
begin
  Grid.ColWidths[1] := Grid.Width - Grid.ColWidths[0] - 20;
end;

procedure TFmMain.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := ACol <> 0;
end;

procedure TFmMain.GridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var NewParams: TStringList;
    DoModification: Boolean;
begin
  NewParams := TStringList.Create;
  GetAliasParamsFromGrid(NewParams);
  DoModification := not NewParams.Equals(TAliasObj(TVAlias.Selected.Data).Params);
  try
    if DoModification then
    begin
      TAliasObj(TVAlias.Selected.Data).Params.Assign(NewParams);
      if not TAliasObj(TVAlias.Selected.Data).Modified then
      begin
        TAliasObj(TVAlias.Selected.Data).Modified := True;
        TVAlias.Selected.StateIndex := 1;
        TVAlias.Refresh;
      end;
    end;
  finally
    NewParams.Free;
  end;      
end;

procedure TFmMain.GetAliasParamsFromGrid(List: TStrings);
var I: Integer;
begin
  for I := 0 to Grid.RowCount - 1 do
  begin
    List.Add(Format('%s=%s',[Trim(Grid.Cols[0][i]), Grid.Cols[1][i]]));
  end;
end;

procedure TFmMain.btnNewClick(Sender: TObject);
var NewNode: TTreeNode;
    Params: TStringList;
begin
  if FMDrivers.Execute then
  begin
    Tag := 1;
    Params := TStringList.Create;
    Session1.GetDriverParams(FMDrivers.GetDriverName, Params);
    while Session1.IsAlias(Format('Alias%d', [Tag])) do
      Tag := Tag + 1;
    try
      Session1.AddAlias(Format('Alias%d', [Tag]), FMDrivers.GetDriverName, Params);
    finally
      Params.Free;
    end;
    NewNode := TVAlias.Items.AddChild(RootNode, Format('Alias%d', [Tag]));
    NewNode.Data := TAliasObj.Create(Session1, NewNode.Text);
    NewNode.SelectedIndex := 3;
    NewNode.Selected := True;
    TAliasObj(TVAlias.Selected.Data).Modified := True;
    TVAlias.Selected.StateIndex := 1;
    TVAlias.Refresh;
    NewNode.EditText;
  end;
end;

procedure TFmMain.TVAliasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
   TVAlias.Selected.EditText;
end;

procedure TFmMain.TVAliasChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  AllowChange := Node <> RootNode;
end;

procedure TFmMain.btnDeleteClick(Sender: TObject);
begin
  if TVAlias.Selected = nil then Exit;
  if TVAlias.Selected.Data = nil then Exit;
  if MessageDlg(TVAlias.Selected.Text + ' silinsin mi ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  Session1.DeleteAlias(TVAlias.Selected.Text);
  Session1.SaveConfigFile;
  TVAlias.Selected.Delete;
end;

procedure TFmMain.btnApllyClick(Sender: TObject);
begin
  if TVAlias.Selected = nil then Exit;
  if TVAlias.Selected.Data = nil then Exit;
  if TAliasObj(TVAlias.Selected.Data).Modified then
  begin
    Session1.ModifyAlias(TVAlias.Selected.Text, TAliasObj(TVAlias.Selected.Data).Params);
    Session1.SaveConfigFile;
    TVAlias.Selected.StateIndex := 0;
    ShowMessage('Deðiþiklikler kaydedildi');
  end;
end;

procedure TFmMain.btnCancelClick(Sender: TObject);
begin
  if TVAlias.Selected = nil then Exit;
  if TVAlias.Selected.Data = nil then Exit;
  if TAliasObj(TVAlias.Selected.Data).Modified then
  begin
    TAliasObj(TVAlias.Selected.Data).Free;
    TVAlias.Selected.Data := TAliasObj.Create(Session1, TVAlias.Selected.Text);
    TVAlias.Selected.StateIndex := 0;
    ShowAliasParams(TVAlias.Selected, IsDatabaseOpen(TVAlias.Selected.Text));
    ShowMessage('Deðiþiklikler iptal edildi');
  end;
end;

end.
