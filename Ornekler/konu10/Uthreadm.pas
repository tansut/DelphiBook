unit Uthreadm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UCntThread,
  StdCtrls;

type
  TForm1 = class(TForm)
    BtnCreateThread: TButton;
    LblTotal: TLabel;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    procedure BtnCreateThreadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTotalThreads: Integer;
    LabelY: Integer;
    procedure SetTotalThreads(const Value: Integer);
    procedure ThreadTerminated(Sender: TObject);
    function CreateNewLabel: TLabel;
  public
    property TotalThreads: Integer read FTotalThreads write SetTotalThreads;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SetTotalThreads(const Value: Integer);
begin
  FTotalThreads := Value;
  LblTotal.Caption := IntToStr(Value);
end;

procedure TForm1.BtnCreateThreadClick(Sender: TObject);
begin
  TotalThreads := TotalThreads  + 1;
  with TCountThread.Create(CreateNewLabel, 5000) do
   OnTerminate := ThreadTerminated;
end;

procedure TForm1.ThreadTerminated(Sender: TObject);
begin
  TotalThreads := TotalThreads  - 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LabelY := 5;
  //BtnCreateThreadClick(Self);
  //BtnCreateThreadClick(Self);
  //BtnCreateThreadClick(Self);
end;

function TForm1.CreateNewLabel: TLabel;
begin
  Result := TLabel.Create(Self);
  with  Result do
  begin
    Left := 5;
    Top := LabelY;
    Parent := ScrollBox;
    Inc(LabelY, Canvas.TextHeight('A') + 2);
  end;
end;

end.
