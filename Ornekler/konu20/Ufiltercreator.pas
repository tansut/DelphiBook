unit Ufiltercreator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, ExtCtrls;

type
  TFmFilterCreator = class(TForm)
    Label1: TLabel;
    CmbFields: TComboBox;
    Label2: TLabel;
    CmbOperator: TComboBox;
    Label3: TLabel;
    edValue: TEdit;
    BtnOK: TButton;
    BtnCancel: TButton;
    OpGroup: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure edValueChange(Sender: TObject);
  private
  public
    function Execute(DataSet: TDataSet; var NewFilter: string): Boolean;
  end;

var
  FmFilterCreator: TFmFilterCreator;

implementation

{$R *.DFM}

{ TFmFilterCreator }

function TFmFilterCreator.Execute(DataSet: TDataSet; var NewFilter: string): Boolean;
const
 Criters: array[0..1] of string = (' AND ', ' OR ');

var
  I: Integer;
  FieldName, Value: string;
begin
  EdValue.Text := '';
  OpGroup.Enabled := NewFilter > '';
  CmbFields.Clear;
  for I := 0 to DataSet.FieldCount - 1 do
    CmbFields.Items.Add(DataSet.Fields[i].FieldName);
  CmbFields.ItemIndex := 0;
  Result := ShowModal = mrOK;
  if Result then
  begin
    if NewFilter > '' then NewFilter := NewFilter + Criters[OpGroup.ItemIndex];
    FieldName := CmbFields.Items[CmbFields.ItemIndex];
    if DataSet.FieldByName(FieldName).DataType = ftString then
      Value := #39 + edValue.Text + '*'#39
    else Value := edValue.Text;
    NewFilter := NewFilter + FieldName + CmbOperator.Items[CmbOperator.ItemIndex] + Value;
  end;
end;

procedure TFmFilterCreator.FormCreate(Sender: TObject);
begin
  CmbOperator.ItemIndex := 0;
end;

procedure TFmFilterCreator.edValueChange(Sender: TObject);
begin
  BtnOK.Enabled := EdValue.Text > '';
end;

end.
