unit ucntthread;

interface

uses
  Classes, StdCtrls, SysUtils;

type
  TCountThread = class(TThread)
  private
    FLabel: TLabel;
    FCurrent: Integer;
    FMax: Integer;
  protected
    procedure Execute; override;
    procedure UpdateLabel; virtual;
  public
   constructor Create(ALabel: TLabel; Max: Integer);
  end;

implementation

constructor TCountThread.Create(ALabel: TLabel; Max: Integer);
begin
  FLabel := ALabel;
  FMax := Max;
  FCurrent := 0;
  FreeOnTerminate := True;
  Priority := tpHigher;
  inherited Create(False);
end;

procedure TCountThread.Execute;
begin
  while FCurrent < FMax do
  begin
    Inc(FCurrent);
    Synchronize(UpdateLabel);
    if Terminated then Exit;
  end;
end;


procedure TCountThread.UpdateLabel;
begin
  FLabel.Caption := IntToStr(FCurrent);
end;

end.
