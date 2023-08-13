unit ubrwado;

interface

uses
  Windows, Sysutils, Forms, IniFiles, ImgList, Controls, Classes,
  ActnList, Menus, Dialogs, ComCtrls, ComObj, ToolWin, Db, ADOInt,
  Grids, DBGrids, Provider, ADODB, DBClient, DBCtrls, ExtCtrls,
  StdCtrls, Buttons, SQLEdit;


type
  TFmMain = class(TForm)
    Connection: TADOConnection;
    ImgList: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PageControl: TPageControl;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    TableList: TListView;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    DBNavigator1: TDBNavigator;
    Query: TADOQuery;
    Table: TADOTable;
    TableGrid: TDBGrid;
    Panel5: TPanel;
    Splitter3: TSplitter;
    QueryGrid: TDBGrid;
    Panel6: TPanel;
    Memo1: TMemo;
    DataSource: TDataSource;
    ImageList1: TImageList;
    btnExecSQL: TSpeedButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TableListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnExecSQLClick(Sender: TObject);
  private
    procedure FillTables;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}
uses
  OLEDB, DBLogDlg, ADOConEd;

procedure TFmMain.FillTables;
var List: TStringList;
    I: Integer;
    Item: TListItem;
begin
  List := TStringList.Create;
  try
    with TableList do
    begin
      Items.Clear;
      Connection.GetTableNames(List);
      for I := 0 to List.Count - 1 do
      begin
        Item := Items.Add;
        Item.Caption := List[I];
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TFmMain.ToolButton1Click(Sender: TObject);
begin
  if Connection.Connected then
   Connection.Close;
  if EditConnectionString(Connection) then
  begin
   Connection.Open;
   FillTables;
  end; 
end;

procedure TFmMain.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
  0: DataSource.DataSet := Table;
  1: begin
       DataSource.DataSet := Query;
       QueryGrid.Visible := Query.Active;
       btnExecSQL.Enabled := Connection.Connected;
     end;
  end;
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  PageControlChange(Self);
end;

procedure TFmMain.TableListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    Table.Close;
    Table.TableName := TableList.Selected.Caption;
    Table.Open;
  end;
end;

procedure TFmMain.btnExecSQLClick(Sender: TObject);
begin
  Query.Close;
  Query.SQL.Text := Memo1.Lines.Text;
  try
    Query.Open;
  except
    on E: Exception do
     //if not (E is ENoResultSet) then
     raise;
  end;
  PageControlChange(Self);
end;

end.
