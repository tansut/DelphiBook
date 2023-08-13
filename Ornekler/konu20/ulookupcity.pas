unit ulookupcity;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Mask, DB;

type
  TFmCities = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    BtnClose: TButton;
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute;
  end;

var
  FmCities: TFmCities;

implementation

uses Ulookupdm;

{$R *.DFM}

procedure TFmCities.Execute;
begin
  ShowModal;
end;

procedure TFmCities.BtnCloseClick(Sender: TObject);
begin
  with DMLookup do
   if SehirTable.State in dsEditModes then
    SehirTable.Post;
  ModalResult := mrOk;  
end;

end.
