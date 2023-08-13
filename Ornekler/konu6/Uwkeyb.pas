unit Uwkeyb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    LblCtrl: TLabel;
    LblShift: TLabel;
    LblAlt: TLabel;
    Label4: TLabel;
    lblCode: TLabel;
    LblStatus: TLabel;
    Label1: TLabel;
    LblChar: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure SetPressed(ALabel: TLabel);
    procedure ClearPressed(ALabel: TLabel);
    procedure SetSpecialKeyPress(Shift: TShiftState);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ClearPressed(ALabel: TLabel);
begin
  ALabel.Font.Color := clBlack;
  ALabel.Font.Style := ALabel.Font.Style - [fsBold];
end;

procedure TForm1.SetPressed(ALabel: TLabel);
begin
  ALabel.Font.Color := clLime;
  ALabel.Font.Style := ALabel.Font.Style + [fsBold];
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LblStatus.Caption := 'Tuþ basýlý';
  LblCode.Caption := IntToStr(Key);
  SetSpecialKeyPress(Shift);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LblStatus.Caption := 'Tuþ çekildi';
  SetSpecialKeyPress(Shift);
end;

procedure TForm1.SetSpecialKeyPress(Shift: TShiftState);
begin
  if ssCtrl in Shift then
   SetPressed(LblCtrl)
  else
   ClearPressed(LblCtrl);

  if ssAlt in Shift then
   SetPressed(LblAlt)
  else
   ClearPressed(LblAlt);

  if ssShift in Shift then
   SetPressed(LblShift)
  else
   ClearPressed(LblShift);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  LblChar.Caption := Key;
end;

end.
