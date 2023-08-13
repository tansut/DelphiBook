unit Uqueryprj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFmMain = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Editor: TMemo;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    btnExec: TButton;
    Query: TQuery;
    DataSource1: TDataSource;
    Session: TSession;
    Label1: TLabel;
    cmbAlias: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

procedure TFmMain.FormCreate(Sender: TObject);
begin
  Session.GetAliasNames(cmbAlias.Items);
end;

procedure TFmMain.btnExecClick(Sender: TObject);
begin
  with Query, cmbAlias do
  begin
    if ItemIndex < 0 then
     raise Exception.Create('Veri tabaný seçiniz');
    Query.Close;
    Query.DatabaseName := Items[ItemIndex];
    Sql.Text := Editor.Lines.Text;
    try
      Query.Open;
    except
      on E: Exception do
      begin
        if E is ENoResultSet then
         ShowMessage(Format('Ýþlemden etkilenen satýr sayýsý: %d', [RowsAffected]))
        else
         raise;
      end;
    end;
  end;
end;

end.
