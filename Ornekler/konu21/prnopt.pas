unit prnopt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TPrnOptionsForm = class(TForm)
    SecChk: TCheckBox;
    IndexChk: TCheckBox;
    BtnOK: TButton;
    BtnCancel: TButton;
  private
    { Private declarations }
  public
    function Execute(const ACaption: string): Boolean;
  end;

var
  PrnOptionsForm: TPrnOptionsForm;

implementation

{$R *.DFM}
function TPrnOptionsForm.Execute(const ACaption: string): Boolean;
begin
  Caption := ACaption;
  Result := ShowModal = mrOk;
end;

end.
