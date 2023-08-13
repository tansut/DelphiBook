unit Umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, ExtDlgs;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    DBEdit7: TDBEdit;
    Label7: TLabel;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    DBEdit9: TDBEdit;
    Label9: TLabel;
    DBImage1: TDBImage;
    Label10: TLabel;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    BtnSelectPicture: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    Label11: TLabel;
    procedure BtnSelectPictureClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses UDataMod;

{$R *.DFM}

procedure TFmMain.BtnSelectPictureClick(Sender: TObject);
begin
  if not OpenPictureDialog.Execute then Exit;
  with DmMusteri do
  begin
    if not MusteriTableInEditMode then
      MusteriTable.Edit;
    MusteriTableResmi.LoadFromFile(OpenPictureDialog.FileName);
  end;
end;

end.
