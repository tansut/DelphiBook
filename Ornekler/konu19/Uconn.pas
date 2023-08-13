unit Uconn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DbTables;

type
  TFmDBConnect = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    edUser: TEdit;
    edPassword: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    FDatabase: TDatabase;
    FLoginParams: TStrings;
  public
    function Execute(ADatabase: TDatabase; LoginParams: TStrings): Boolean;
  end;

var
  FmDBConnect: TFmDBConnect;

implementation

uses udbparm;

{$R *.DFM}

function TFmDBConnect.Execute(ADatabase: TDatabase; LoginParams: TStrings): Boolean;
begin
  with ADatabase do
  begin
    edUser.Text := Params.Values['USER NAME'];
    edPassword.Text := Params.Values['PASSWORD'];
  end;
  FDatabase := ADatabase;
  FLoginParams := LoginParams;
  Result := ShowModal = mrOk;
  if Result then
  begin
    LoginParams.Values['USER NAME'] := edUser.Text;
    LoginParams.Values['PASSWORD'] := edPassword.Text;
  end;
end;

procedure TFmDBConnect.btnOKClick(Sender: TObject);
begin
  if edUser.Text = '' then
  begin
    edUser.SetFocus;
    raise Exception.Create('Geçerli bir kullanýcý adý giriniz');
  end;
  ModalResult := mrOk;
end;

procedure TFmDBConnect.Label3Click(Sender: TObject);
begin
  with TFmDbParameters.Create(nil) do
  try
    if Execute(FDatabase, FLoginParams) then
    begin
      edUser.Text := FLoginParams.Values['USER NAME'];
      edPassword.Text := FLoginParams.Values['PASSWORD'];
    end;
  finally
    Free;
  end;

end;

end.
