unit Udriver;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFmDrivers = class(TForm)
    GroupBox1: TGroupBox;
    CmbDriver: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure CmbDriverDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
  private
  public
    function Execute: Boolean;
    function GetDriverName: string;
    { Public declarations }
  end;

var
  FmDrivers: TFmDrivers;

implementation

uses Umain;

{$R *.DFM}

procedure TFmDrivers.CmbDriverDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TComboBox, Canvas do
    begin
      FillRect(Rect);
      InflateRect(Rect, -3, -3);
      DrawIcon(Handle, Rect.Left, Rect.Top + 1, LoadIcon(HInstance, '#1'));
      Inc(Rect.Left, 40);
      DrawText(Canvas.Handle, PChar(Items[index]), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
    end;

end;

function TFmDrivers.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TFmDrivers.FormCreate(Sender: TObject);
begin
  FmMain.Session1.GetDriverNames(CmbDriver.Items);
  CmbDriver.ItemIndex := 0;
end;

function TFmDrivers.GetDriverName: string;
begin
  with CmbDriver do
   Result := Items[ItemIndex];
end;

end.
