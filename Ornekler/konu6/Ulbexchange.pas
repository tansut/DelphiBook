unit Ulbexchange;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure UpdateListBox(ListBox: TListBox; CurrentIndex, UpDown: Integer);
    function SetListBox(ListBox: TListBox): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.SetListBox(ListBox: TListBox): Boolean;
begin
  Result := ListBox.ItemIndex <> -1;
  if (ListBox.Items.Count > 0) and (not Result) then ListBox.ItemIndex := 0;
end;


procedure TForm1.UpdateListBox(ListBox: TListBox; CurrentIndex, UpDown: Integer);
var NextIndex: Integer;
begin
  NextIndex:= CurrentIndex + UpDown;
  if (NextIndex >= 0) and (NextIndex < ListBox.Items.Count) then
  begin
    if SetListBox(ListBox) then
    begin
      ListBox.Items.Exchange(CurrentIndex, NextIndex);
      ListBox.ItemIndex := NextIndex;
    end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  UpdateListBox(ListBox1, ListBox1.ItemIndex, -1);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  UpdateListBox(ListBox1, ListBox1.ItemIndex, 1);
end;

end.
