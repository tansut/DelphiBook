unit tbllst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TTableListForm = class(TForm)
    TableList: TListBox;
    okBtn: TButton;
    CancelBtn: TButton;
    procedure TableListDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Execute(const ATableName: string): Boolean;
  end;

var
  TableListForm: TTableListForm;

implementation

{$R *.DFM}
function TTableListForm.Execute(const ATableName: string): Boolean;
begin
  TableList.ItemIndex := TableList.Items.IndexOf(ATableName);
  Result := ShowModal = mrOk;
end;

procedure TTableListForm.TableListDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
 