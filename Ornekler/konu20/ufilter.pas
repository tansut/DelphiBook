unit ufilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons;

type
  TFmMain = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Filter: TMemo;
    BtnFilterEditor: TButton;
    BtnFilter: TSpeedButton;
    BtnClear: TButton;
    Label2: TLabel;
    procedure BtnFilterClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure BtnFilterEditorClick(Sender: TObject);
    procedure FilterChange(Sender: TObject);
  private
    function GetFilter: string;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses UFilterDM, Ufiltercreator;

{$R *.DFM}

procedure TFmMain.BtnFilterClick(Sender: TObject);
begin
  if BtnFilter.Down then
  begin
    try
      DMFilter.MusteriTable.Filter := Filter.Lines.Text;
      DMFilter.MusteriTable.Filtered := True;
    except
      BtnFilter.Down := False;
      raise Exception.Create('Filtreleme işlemi başarısız');
    end;
  end
  else
  begin
    DMFilter.MusteriTable.Filtered := False;
  end;
end;

function TFmMain.GetFilter: string;
begin
  Result := Filter.Lines.Text;
  if not FmFilterCreator.Execute(DmFilter.MusteriTable, Result) then Abort;
end;

procedure TFmMain.BtnClearClick(Sender: TObject);
begin
  Filter.Clear;
end;

procedure TFmMain.BtnFilterEditorClick(Sender: TObject);
begin
  Filter.Lines.Text := GetFilter;
end;

procedure TFmMain.FilterChange(Sender: TObject);
begin
  BtnFilter.Enabled := Filter.Lines.Text > '';
end;

end.
