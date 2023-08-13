unit uvkprj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Mask, DBCtrls, ExtCtrls, ExtDlgs, DB;

type
  TFmMain = class(TForm)
    StatusBar1: TStatusBar;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    dsfsdf: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBImage1: TDBImage;
    Label5: TLabel;
    Button1: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}

uses uDMVK;

procedure TFmMain.Button1Click(Sender: TObject);
begin
  if not OpenPictureDialog.Execute then Exit;
  with DM do
  begin
    if not (MusteriTable.State in dsEditModes) then
      MusteriTable.Edit;
    MusteriTableResim.LoadFromFile(OpenPictureDialog.FileName);
    MusteriTable.Post;  
  end;
end;

end.
