unit Umodifydata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ComCtrls, ImgList, ToolWin, Db;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    btnPrev: TToolButton;
    btnNext: TToolButton;
    btnInsert: TToolButton;
    btnCancel: TToolButton;
    BtnPost: TToolButton;
    btnDelete: TToolButton;
    BtnClose: TToolButton;
    ToolButton8: TToolButton;
    Label9: TLabel;
    Label10: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BtnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    procedure MusteriSourceStateChange(Sender: TObject);
    procedure UpdateButtons(DataSet: TDataSet);

  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation
uses modifydatadm;
{$R *.DFM}

procedure TFmMain.FormCreate(Sender: TObject);
begin
  with DMModify.MusteriSource do OnStateChange := MusteriSourceStateChange;
  MusteriSourceStateChange(DMModify.MusteriTable);
end;

procedure TFmMain.MusteriSourceStateChange(Sender: TObject);
begin
  UpdateButtons(DMModify.MusteriTable);
end;

procedure TFmMain.UpdateButtons(DataSet: TDataSet);
begin
  btnPrev.Enabled := not (DataSet.State in dsEditModes);
  btnNext.Enabled := not (DataSet.State in dsEditModes);
  btnInsert.Enabled := not (DataSet.State in dsEditModes);
  btnCancel.Enabled := DataSet.State in dsEditModes;
  BtnPost.Enabled := DataSet.State in dsEditModes;
  btnDelete.Enabled := not (DataSet.State in dsEditModes);
end;

procedure TFmMain.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFmMain.btnPrevClick(Sender: TObject);
begin
  DMModify.MusteriTable.Prior;
end;

procedure TFmMain.btnNextClick(Sender: TObject);
begin
  DMModify.MusteriTable.Next;
end;

procedure TFmMain.btnInsertClick(Sender: TObject);
begin
  DMModify.MusteriTable.Insert;
end;

procedure TFmMain.btnDeleteClick(Sender: TObject);
begin
  DMModify.MusteriTable.Delete;
end;

procedure TFmMain.BtnPostClick(Sender: TObject);
begin
  DMModify.MusteriTable.Post;
end;

procedure TFmMain.btnCancelClick(Sender: TObject);
begin
   DMModify.MusteriTable.Cancel;
end;

procedure TFmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with DMModify do
  begin
    if MusteriTable.State in dsEditModes then
    begin
      if MessageDlg('Kaydedilmemis deðiþiklikler kaydedilsin mi ?', mtWarning, [mbYes, MbNo], 0) = mrYes then
        MusteriTable.Post
      else
        MusteriTable.Cancel;  
    end;
  end;
end;

procedure TFmMain.Button1Click(Sender: TObject);
begin
  DMModify.MusteriTable.Insert;
  DMModify.MusteriTable.Post;
end;

end.
