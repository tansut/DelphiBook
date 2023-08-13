unit data;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ToolWin, ComCtrls, Grids, DBGrids, Menus, DbTables, ImgList;

type
  TDataform = class(TForm)
    DataSource: TDataSource;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    StatusBar: TStatusBar;
    DBGrid1: TDBGrid;
    TableBtn: TToolButton;
    PopupMenu: TPopupMenu;
    procedure TableBtnClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  private
    FTable: TTable;
    procedure MenuClick(Sender: TObject);
    procedure ShowTableData(const ATableName: string);
  public
    procedure Execute(ATable: TTable; AllTables: TListItems);
  end;

var
  Dataform: TDataform;

implementation

uses tbllst;

{$R *.DFM}
procedure TDataform.ShowTableData(const ATableName: string);
begin
  if FTable.Active then FTable.Close;
  FTable.TableName := ATableName;
  try
    FTable.Open;
  except
    Caption := Format('%s açýlamadý', [FTable.TableName]);
    StatusBar.Panels[0].Text := '';
    raise;
  end;
  Caption := Format('%s', [FTable.TableName]);
end;

procedure TDataform.MenuClick(Sender: TObject);
begin
  ShowTableData(TMenuItem(Sender).Caption);
end;

procedure TDataform.Execute(ATable: TTable; AllTables: TListItems);
var I: Integer;
    MenuItem: TMenuItem;
begin
  FTable := ATable;
  DataSource.DataSet := ATable;
  while PopupMenu.Items.Count > 0 do PopupMenu.Items.Delete(0);
  TableListForm.TableList.Items.Clear;
  for I := 0 to AllTables.Count - 1 do
  begin
    MenuItem := TMenuItem.Create(PopupMenu);
    MenuItem.Caption := AllTables[I].Caption;
    MenuItem.OnClick := MenuClick;
    PopupMenu.Items.Add(MenuItem);
    TableListForm.TableList.Items.Add(AllTables[I].Caption);
  end;
  ShowTableData(FTable.TableName);
  if AllTables.Count > 15 then
  begin
    TableBtn.OnClick := TableBtnClick;
    TableBtn.DropdownMenu := nil;
  end else
  begin
    TableBtn.OnClick := nil;
    TableBtn.DropdownMenu := PopupMenu;
  end;
  try
    ShowModal;
  finally
    if FTable.Active then FTable.Close;
  end;
end;

procedure TDataform.TableBtnClick(Sender: TObject);
begin
  if TableListForm.Execute(FTable.TableName) then
    ShowTableData(TableListForm.TableList.Items[TableListForm.TableList.ItemIndex]);
end;

procedure TDataform.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  with DataSource do
   if Dataset.Active then
    StatusBar.Panels[0].Text := Format('%d of %d', [Dataset.RecNo, DataSet.RecordCount]);
end;

end.
