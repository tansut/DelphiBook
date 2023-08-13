unit uindexedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db;

type
  TFmIndexEditor = class(TForm)
    Label1: TLabel;
    edIndexName: TEdit;
    Label2: TLabel;
    edFields: TComboBox;
    Bevel1: TBevel;
    chkPrimary: TCheckBox;
    ChkUnique: TCheckBox;
    ChkDescending: TCheckBox;
    ChkCase: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    FIndex: TIndexDef;
  public
    function Execute(const ACaption: string; AIndex: TIndexDef; Dataset: TDataSet): Boolean;
    procedure Valdate;
  end;

var
  FmIndexEditor: TFmIndexEditor;

implementation

{$R *.DFM}

{ TFmIndexEditor }

function TFmIndexEditor.Execute(const ACaption: string;
  AIndex: TIndexDef; Dataset: TDataSet): Boolean;
var I: Integer;
begin
  Caption := ACaption;
  FIndex := AIndex;
  edIndexName.Text := AIndex.Name;
  edFields.Text := AIndex.Fields;
  chkPrimary.Checked := ixPrimary in AIndex.Options;
  ChkUnique.Checked := ixUnique in AIndex.Options;
  ChkDescending.Checked := ixDescending in AIndex.Options;
  ChkCase.Checked := ixCaseInsensitive in AIndex.Options;
  edFields.Items.Clear;
  for I := 0 to Dataset.FieldDefs.Count - 1 do
   edFields.Items.Add(Dataset.FieldDefs[I].Name);
  Result := ShowModal = mrOK;
end;

procedure TFmIndexEditor.btnOkClick(Sender: TObject);
begin
  Valdate;
  ModalResult := mrOk;
end;

procedure TFmIndexEditor.Valdate;
begin
  if edFields.Text = '' then
   raise Exception.Create('Alan giriniz');
  with FIndex do
  try
    Name := edIndexName.Text;
    Fields := edFields.Text;
    if chkPrimary.Checked then
     Options := Options + [ixPrimary]
    else
     Options := Options - [ixPrimary];

    if ChkUnique.Checked then
     Options := Options + [ixUnique]
    else
     Options := Options - [ixUnique];

    if ChkDescending.Checked then
     Options := Options + [ixDescending]
    else
     Options := Options - [ixDescending];

    if ChkCase.Checked then
     Options := Options + [ixCaseInsensitive]
    else
     Options := Options - [ixCaseInsensitive];
  except
    raise;
  end;
end;

end.
