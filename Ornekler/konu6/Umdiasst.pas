unit Umdiasst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFmAssistant = class(TForm)
    LblStatus: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FTotalOpenForm: Integer;
    procedure SetTotalOpenForm(const Value: Integer);
    { Private declarations }
  public
    property TotalOpenForm: integer read FTotalOpenForm write SetTotalOpenForm;
  end;

var
  FmAssistant: TFmAssistant;

implementation

{$R *.DFM}

procedure TFmAssistant.FormCreate(Sender: TObject);
begin
  TotalOpenForm := 0;
  
end;

procedure TFmAssistant.SetTotalOpenForm(const Value: Integer);
begin
  FTotalOpenForm := Value;
  LblStatus.Caption := Format('Açýk Form: %d', [Value]);
end;

end.
