unit udbparm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DbTables;

type
  TFmDBParameters = class(TForm)
    CmbAlias: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CmbDriver: TComboBox;
    LblDBName: TLabel;
    Params: TMemo;
    Button1: TButton;
    Button2: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure CmbAliasChange(Sender: TObject);
    procedure CmbDriverChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FDatabase: TDatabase;
  public
    function Execute(ADatabase: TDatabase; LoginParams: TStrings): Boolean;
  end;

var
  FmDBParameters: TFmDBParameters;

implementation

{$R *.DFM}

procedure TFmDBParameters.btnOKClick(Sender: TObject);
begin
  if (CmbAlias.Text = '') and (CmbDriver.Text = '') then
   raise Exception.Create('Alias veya sürücü giriniz');
  ModalResult := mrOK;
end;

function TFmDBParameters.Execute(ADatabase: TDatabase; LoginParams: TStrings): Boolean;
begin
  LblDBName.Caption := ADatabase.DatabaseName;
  CmbAlias.Text := ADatabase.AliasName;
  CmbDriver.Text := ADatabase.DriverName;
  ADatabase.Session.GetAliasNames(CmbAlias.Items);
  ADatabase.Session.GetDriverNames(CmbDriver.Items);
  Params.Lines.Assign(LoginParams);
  FDatabase := ADatabase;
  Result := ShowModal = mrOk;
  if Result then
   with ADatabase do
   begin
     if CmbAlias.Text > '' then
     begin
       AliasName := CmbAlias.Text;
     end else
     begin
       DriverName := CmbDriver.Text;
     end;
     LoginParams.Assign(Self.Params.Lines);
   end;
end;

procedure TFmDBParameters.CmbAliasChange(Sender: TObject);
begin
  if CmbAlias.Text > '' then
   CmbDriver.Text := '';
end;

procedure TFmDBParameters.CmbDriverChange(Sender: TObject);
begin
  if CmbDriver.Text > '' then
   CmbAlias.Text := '';
end;

procedure TFmDBParameters.Button1Click(Sender: TObject);
begin
  if CmbAlias.Text > '' then
    FDatabase.Session.GetAliasParams(CmbAlias.Text, Params.Lines)
  else if CmbDriver.Text > '' then
    FDatabase.Session.GetDriverParams(CmbDriver.Text, Params.Lines);
end;

procedure TFmDBParameters.Button2Click(Sender: TObject);
begin
  Params.Clear;
end;

end.
