unit Utreeview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList, ToolWin, StdCtrls, ExtCtrls, ExtDlgs;

type
  TFmMain = class(TForm)
    ToolBar: TToolBar;
    ToolBarImages: TImageList;
    StatusBar: TStatusBar;
    btnNewCat: TToolButton;
    TV: TTreeView;
    Splitter1: TSplitter;
    PageControl: TPageControl;
    tsCategory: TTabSheet;
    tsNote: TTabSheet;
    tsPicture: TTabSheet;
    Panel1: TPanel;
    btnSelectPicture: TButton;
    Panel2: TPanel;
    btnSelectText: TButton;
    Editor: TMemo;
    Label1: TLabel;
    TVImages: TImageList;
    btnNewNote: TToolButton;
    btnNewPicture: TToolButton;
    PaintBox1: TPaintBox;
    ScrollBox1: TScrollBox;
    Img: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    OpenDialog: TOpenDialog;
    ToolButton1: TToolButton;
    BtnOpen: TToolButton;
    BtnCollapse: TToolButton;
    ToolButton2: TToolButton;
    BtnDelete: TToolButton;
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure btnNewCatClick(Sender: TObject);
    procedure TVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnNewNoteClick(Sender: TObject);
    procedure TVChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure btnSelectPictureClick(Sender: TObject);
    procedure btnSelectTextClick(Sender: TObject);
    procedure btnNewPictureClick(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure BtnCollapseClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure TVDeletion(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    FUpdating: Boolean;
    procedure DeleteNode(ANode: TTreeNode);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

procedure TFmMain.TVChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data = nil then
    PageControl.ActivePage := tsCategory
  else if TObject(Node.Data) is TStringList then
  begin
    Editor.Lines.Assign(TStringList(Node.Data));
    PageControl.ActivePage := tsNote
  end
  else if TObject(Node.Data) is TPicture then
  begin
    Img.Picture.Assign(TPicture(Node.Data));
    PageControl.ActivePage := tsPicture;
  end;
  btnNewNote.Enabled := Node.Data = nil;
  btnNewPicture.Enabled := Node.Data = nil;
end;

procedure TFmMain.btnNewCatClick(Sender: TObject);
var S: string;
    Item: TTreeNode;
begin
  S := 'Kategori Adý';
  Item := Tv.Items.AddChild(TV.Selected, S);
  Item.ImageIndex := 0;
  if TV.Selected <> nil then
   Tv.Selected.Expand(False);
  Tv.Selected := Item;
  Item.EditText;
end;

procedure TFmMain.TVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Item: TTreeNode;
begin
  if Button = mbRight then
  begin
    Item := TV.GetNodeAt(X, Y);
    if Item = nil then Exit;
    Tv.Selected := Item;
  end;
end;

procedure TFmMain.btnNewNoteClick(Sender: TObject);
var Item: TTreeNode;
    StringList: TStringList;
begin
  if TV.Selected = nil then Exit;
  Item := TV.Items.AddChild(TV.Selected, 'Not');
  StringList := TStringList.Create;
  Item.Data := StringList;
  Item.ImageIndex := 1;
  Item.SelectedIndex := 1;
  Tv.Selected := Item;
  FUpdating := True;
  Item.EditText;
  Editor.Lines.Clear;
end;

procedure TFmMain.TVChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if TV.Selected = nil then Exit;
  if TV.Selected.Data = nil then
  else if TObject(TV.Selected.Data) is TStringList then
  begin
    if FUpdating then
     TStringList(TV.Selected.Data).Assign(Editor.Lines);
    FUpdating := False;
  end;
end;

procedure TFmMain.btnSelectPictureClick(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
  begin
   Img.Picture.LoadFromFile(OpenPictureDialog.FileName);
   TPicture(TV.Selected.Data).Assign(Img.Picture);
  end;
end;

procedure TFmMain.btnSelectTextClick(Sender: TObject);
begin
  if OpenDialog.Execute then
   Editor.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TFmMain.btnNewPictureClick(Sender: TObject);
var Item: TTreeNode;
    Picture: TPicture;
begin
  if TV.Selected = nil then Exit;
  Item := TV.Items.AddChild(TV.Selected, 'Resim');
  Picture := TPicture.Create;
  Item.Data := Picture;
  Item.ImageIndex := 2;
  Item.SelectedIndex := 2;
  //Tv.OnChanging := nil;
  Tv.Selected := Item;
  Item.EditText;
  Img.Picture.Graphic := nil;
  //Tv.OnChanging := TVChanging;
end;

procedure TFmMain.BtnOpenClick(Sender: TObject);
begin
  if Tv.Selected = nil then Exit;
  Tv.Selected.Expand(True);
end;

procedure TFmMain.BtnCollapseClick(Sender: TObject);
begin
  if Tv.Selected = nil then Exit;
  Tv.Selected.Collapse(True);
end;

procedure TFmMain.BtnDeleteClick(Sender: TObject);
var Msg: string;
begin
  if Tv.Selected = nil then Exit;
  if Tv.Selected.Data = nil then
   Msg := 'Silmek istediðiniz bir kategori'
  else if TObject(Tv.Selected.Data) is TStringList then
   Msg := 'Silmek istediðiniz bir not'
  else if TObject(Tv.Selected.Data) is TPicture then
   Msg := 'Silmek istediðiniz bir resim';
  if MessageDlg(Msg, mtConfirmation, [mbOk, mbCancel], 0) = mrCancel then Exit;
  DeleteNode(Tv.Selected);
end;

procedure TFmMain.DeleteNode(ANode: TTreeNode);
begin
  ANode.DeleteChildren;
  ANode.Delete;
end;

procedure TFmMain.TVDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
   TObject(Node.Data).Free;
end;

procedure TFmMain.FormDestroy(Sender: TObject);
var i: integer;
begin
  with TV do
   for i := Items.Count - 1 downto 0 do
    DeleteNode(Items[i]);
end;

procedure TFmMain.PaintBox1Paint(Sender: TObject);
begin
  ToolBarImages.Draw(PaintBox1.Canvas, 0, 0, 0, True);
end;

end.
