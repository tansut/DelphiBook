unit Uswhint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFmMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.DFM}
type

 TMyHintWindow = class(THintWindow)
 private
  procedure Draw3DText(const Text: string; UCorner, LCorner: Integer);
 protected
  procedure Paint; override;
 public
  function CalcHintRect(MaxWidth: Integer; const AHint: string;
    AData: Pointer): TRect; override;
 end;

function TMyHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string;
  AData: Pointer): TRect;
begin
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
  Result.Bottom := Result.Bottom + 20;
end;


procedure TMyHintWindow.Draw3DText(const Text: string; UCorner, LCorner: Integer);
begin
 Canvas.Brush.Style := bsClear;
 Canvas.Font.Style := [fsBold];
 Canvas.Font.Name := 'Arial';
 Canvas.Font.Size := 15;
 Canvas.Font.Color := clRed;
 Canvas.TextOut(UCorner, LCorner, Text);
 Canvas.Font.Color := clGray;
 Canvas.TextOut(UCorner - 1, LCorner - 1, Text);
 Canvas.Font.Color := clSilver;
 Canvas.TextOut(UCorner - 2, LCorner - 2, Text);
 Canvas.Font.Color := clBlack;
 Canvas.TextOut(UCorner - 3, LCorner - 3, Text);
end;



procedure TMyHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Draw3DText('Program Adý', R.Left + 3, 1);
  Inc(R.Top, 22);
  Canvas.Font.Color := clInfoText;
  Canvas.Font.Size := 10;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  Application.HintPause := 0;
  Application.HintHidePause := -1;
  Application.OnShowHint := ShowHint;
end;

procedure TFmMain.ShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
begin
  HintInfo.ReshowTimeout := 1000;
  HintStr := Format('%s%s', [HintStr + #13#10, FormatDateTime('m mmmm yyyy dddd hh:nn:ss', Now)]);
  HintInfo.HintWindowClass := TMyHintWindow;
end;

{ TMyHintWindow }


end.
