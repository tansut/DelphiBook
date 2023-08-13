unit dbase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,
  DBTables, FileCtrl, ComCtrls;

type
  TDbaseForm = class(TForm)
    Bevel1: TBevel;
    okBtn: TButton;
    CancelBtn: TButton;
    PageControl: TPageControl;
    DirTab: TTabSheet;
    AliasTab: TTabSheet;
    FileListBox1: TFileListBox;
    DirList: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    Label1: TLabel;
    AliasList: TListBox;
    procedure AliasListDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Execute: Boolean;
    function GetDatabaseName: string;
  end;

function ExecuteDBaseForm(var DatabaseName: string): Boolean;

implementation

uses DmDtMod;

{$R *.DFM}

function ExecuteDBaseForm(var DatabaseName: string): Boolean;
begin
  with TDbaseForm.Create(nil) do
  try
    Result := Execute;
    if Result then DatabaseName := GetDataBaseName;
  finally
    Free;
  end;
end;

function TDbaseForm.Execute: Boolean;
begin
  with Dm do DbSession.GetAliasNames(AliasList.Items);
  AliasList.ItemIndex := 0;
  Result := ShowModal = mrOk;
end;

function TDbaseForm.GetDatabaseName: string;
begin
  if PageControl.ActivePage = DirTab then
   Result := DirList.Directory
  else Result := AliasList.Items[AliasList.ItemIndex];
end;

procedure TDbaseForm.AliasListDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
