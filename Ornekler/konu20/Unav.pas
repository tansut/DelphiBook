unit Unav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBNavigator1: TDBNavigator;
    btnFirst: TSpeedButton;
    BtnPrior: TSpeedButton;
    BtnNext: TSpeedButton;
    BtnLast: TSpeedButton;
    DBGrid1: TDBGrid;
    procedure btnFirstClick(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses UNavDM;

{$R *.DFM}

procedure TForm1.btnFirstClick(Sender: TObject);
begin
  with DMNav do
  begin
    if MusteriTable.BOF then
     ShowMessage('Ýlk kayýt aktif kayýt')
    else MusteriTable.First;
  end;
end;

procedure TForm1.BtnPriorClick(Sender: TObject);
begin
  with DMNav do
  begin
    if MusteriTable.BOF then
     ShowMessage('Ýlk kayýt aktif kayýt')
    else MusteriTable.Prior;
  end;
end;

procedure TForm1.BtnNextClick(Sender: TObject);
begin
  with DMNav do
  begin
    if MusteriTable.EOF then
     ShowMessage('Son kayýt aktif kayýt')
    else MusteriTable.Next;
  end;
end;

procedure TForm1.BtnLastClick(Sender: TObject);
begin
  with DMNav do
  begin
    if MusteriTable.EOF then
     ShowMessage('Son kayýt aktif kayýt')
    else MusteriTable.Last;
  end;
end;

end.
