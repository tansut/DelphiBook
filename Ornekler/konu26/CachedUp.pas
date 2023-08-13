unit CachedUp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, Grids, DBGrids, TypInfo, StdCtrls, Menus, ExtCtrls, DBCtrls,
  Buttons;

type
  TFmMain = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    UnmodifiedCB: TCheckBox;
    ModifiedCB: TCheckBox;
    InsertedCB: TCheckBox;
    DeletedCB: TCheckBox;
    Panel1: TPanel;
    UseUpdateSQL: TCheckBox;
    Panel2: TPanel;
    ApplyUpdatesBtn: TButton;
    CancelUpdatesBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure ApplyUpdatesBtnClick(Sender: TObject);
    procedure ToggleUpdateMode(Sender: TObject);
    procedure CancelUpdatesBtnClick(Sender: TObject);
    procedure UpdateRecordsToShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UseUpdateSQLClick(Sender: TObject);
  private
    { Private declarations }
    FDataSet: TDBDataSet;
    procedure SetControlStates(Enabled: Boolean);
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

uses
  ErrForm, DataMod;


procedure TFmMain.SetControlStates(Enabled: Boolean);
begin
  ApplyUpdatesBtn.Enabled := Enabled;
  CancelUpdatesBtn.Enabled := Enabled;
  UnmodifiedCB.Enabled := Enabled;
  ModifiedCB.Enabled := Enabled;
  InsertedCB.Enabled := Enabled;
  DeletedCB.Enabled := Enabled;
  UseUpdateSQL.Enabled := Enabled;
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  FDataSet := CacheData.CacheDS.DataSet as TDBDataSet;
  FDataSet.CachedUpdates := True;
  SetControlStates(FDataSet.CachedUpdates);
  FDataSet.Open;
end;

procedure TFmMain.ToggleUpdateMode(Sender: TObject);
begin
  FDataSet.CachedUpdates := not FDataSet.CachedUpdates;
  SetControlStates(FDataSet.CachedUpdates);
end;

procedure TFmMain.ApplyUpdatesBtnClick(Sender: TObject);
begin
  FDataSet.Database.ApplyUpdates([FDataSet]);
end;

procedure TFmMain.CancelUpdatesBtnClick(Sender: TObject);
begin
 FDataSet.CancelUpdates;
end;

procedure TFmMain.UpdateRecordsToShow(Sender: TObject);
var
  UpdRecTypes : TUpdateRecordTypes;
begin
  UpdRecTypes := [];
  if UnModifiedCB.Checked then
    Include(UpdRecTypes, rtUnModified);
  if ModifiedCB.Checked then
    Include(UpdRecTypes, rtModified);
  if InsertedCB.Checked then
    Include(UpdRecTypes, rtInserted);
  if DeletedCB.Checked then
    Include(UpdRecTypes, rtDeleted);
  FDataSet.UpdateRecordTypes := UpdRecTypes;
end;

procedure TFmMain.UseUpdateSQLClick(Sender: TObject);
begin
  FDataSet.Close;
  if UseUpdateSQL.Checked then
    FDataSet.UpdateObject := CacheData.UpdateSQL
  else
    FDataSet.UpdateObject := nil;
  FDataSet.Open;
end;

end.
