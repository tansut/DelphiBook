unit uregexp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ImgList, Registry;

type

  TKey = class
  public
   Root: HKEY;
   Path: string;
  end;

  TFmMain = class(TForm)
    TV: TTreeView;
    Splitter1: TSplitter;
    LV: TListView;
    StatusBar: TStatusBar;
    TVImgList: TImageList;
    LVImgLst: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure TVExpanded(Sender: TObject; Node: TTreeNode);
    procedure TVCollapsed(Sender: TObject; Node: TTreeNode);
    procedure TVDeletion(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
  private
    procedure AddKey(Node: TTreeNode; const ACaption: string; KeyInfo: TKey; CalculateSubKeys: Boolean);
    procedure Initialize;
    procedure FindSubKeys(Item: TTreeNode);
    procedure ShowValues(Key: TKey);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

{ TFmMain }

procedure TFmMain.AddKey(Node: TTreeNode; const ACaption: string;
  KeyInfo: TKey; CalculateSubKeys: Boolean);
var Item: TTreeNode;
begin
  Item := TV.Items.AddChild(Node, ACaption);
  Item.ImageIndex := 1;
  Item.SelectedIndex := 2;
  Item.Data := KeyInfo;
  if CalculateSubKeys then FindSubKeys(Item);
end;

procedure TFmMain.FindSubKeys(Item: TTreeNode);
var ParentKey, NewKey: TKey;
    List: TStrings;
    I: Integer;
begin
  if Item.Data = nil then Exit;
  ParentKey := TKey(Item.Data);
  List := nil;
  with TRegistry.Create do
  try
    RootKey := ParentKey.Root;
    if OpenKey(ParentKey.Path, False) then
    begin
      if HasSubKeys then
      begin
        List := TStringList.Create;
        GetKeyNames(List);
        for i := 0 to List.Count - 1 do
        begin
          NewKey := TKey.Create;
          NewKey.Root := RootKey;
          NewKey.Path := ParentKey.Path + '\' + List[i];
          AddKey(Item, List[i], NewKey, False);
        end;
      end;
    end;
  finally
    Free;
    if Assigned(List) then List.Free;
  end;
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TFmMain.Initialize;
var Key: TKey;
begin
  Key := TKey.Create;
  Key.Root := HKEY_CURRENT_USER;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_CURRENT_USER', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_LOCAL_MACHINE;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_LOCAL_MACHINE', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_CLASSES_ROOT;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_CLASSES_ROOT', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_USERS;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_USERS', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_DYN_DATA;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_DYN_DATA', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_CURRENT_CONFIG;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_CURRENT_CONFIG', Key, True);

  Key := TKey.Create;
  Key.Root := HKEY_PERFORMANCE_DATA;
  Key.Path := '';
  AddKey(Tv.Items[0], 'HKEY_PERFORMANCE_DATA', Key, True);
end;

procedure TFmMain.TVChange(Sender: TObject; Node: TTreeNode);
begin
  LV.Items.Clear;
  if Node.Data = nil then Exit;
   StatusBar.SimpleText := TKey(Node.Data).Path;
  ShowValues(TKey(Node.Data));
end;

procedure TFmMain.TVExpanded(Sender: TObject; Node: TTreeNode);
var i: integer;
begin
  if Node.Data = nil then Exit;
  for i := 0 to Node.Count - 1 do
   FindSubKeys(Node.Item[i]);
end;

procedure TFmMain.TVCollapsed(Sender: TObject; Node: TTreeNode);
var i: integer;
begin
  if Node.Data = nil then Exit;
  for i := 0 to Node.Count - 1 do
  begin
    Node.Item[i].DeleteChildren;
  end;
end;

procedure TFmMain.TVDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
   TKey(Node.Data).Free;
end;

procedure TFmMain.FormDestroy(Sender: TObject);
var i: integer;
begin
  Exit;
  with TV do
   for i := Items.Count - 1 downto 0 do
   begin
     Items[i].DeleteChildren;
     Items[i].Delete;
   end;
end;

procedure TFmMain.ShowValues(Key: TKey);
var ListItem: TListItem;
    Values: TStrings;
    j: Integer;
    R: TRegistry;
 procedure AddValue(ValueName: string);
 var
   RegData: TRegDataType;
   Data: string;
 begin
   RegData := R.GetDataType(ValueName);
   case RegData of
   rdUnknown: Data := '(Bilinmiyor)';
   rdString, rdExpandString : Data := '"' + R.ReadString(ValueName) + '"';
   rdInteger: Data := IntToStr(R.ReadInteger(ValueName));
   rdBinary: Data := '(Binary)';
   end;
   ListItem := LV.Items.Add;
   ListItem.Caption := ValueName;
   ListItem.SubItems.Add(Data);
 end;
begin
  Values := nil;
  R := TRegistry.Create;
  with R, LV do
  try
    RootKey := Key.Root;
    if OpenKey(Key.Path, False) then
    begin
      Values := TStringList.Create;
      GetValueNames(Values);
      for j := 0 to Values.Count - 1 do
       AddValue(Values[j]);
    end;
  finally
    R.Free;
    if Assigned(Values) then Values.Free;
  end;
end;

end.
