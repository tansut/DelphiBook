unit Uctrldrag2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar: TStatusBar;
    Label1: TLabel;
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Panel1DragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TPanel;
  if Accept then
  begin
    StatusBar.Panels[0].Text := Format('X:%d, Y:%d', [X, Y]);
    StatusBar.Panels[1].Text := 'Panel sürükleniyor';
  end else
    StatusBar.Panels[1].Text := 'Reddediledi';
end;

procedure TForm1.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  TPanel(Source).Left := X;
  TPanel(Source).Top := Y;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar.Panels[0].Text := Format('X:%d, Y:%d', [X, Y]);
  StatusBar.Panels[1].Text := 'Form içinde hareket';
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar.Panels[0].Text := Format('X:%d, Y:%d', [X, Y]);
  StatusBar.Panels[1].Text := 'Panel içinde hareket';
end;

procedure TForm1.Panel1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  StatusBar.Panels[1].Text := 'Panel sürüklenmeye baþlandý';
end;

procedure TForm1.Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TLabel;
end;

procedure TForm1.Panel1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  (Source as TLabel).Parent := Panel1;
  (Source as TLabel).Left := X;
  (Source as TLabel).Top := Y;
end;

end.
