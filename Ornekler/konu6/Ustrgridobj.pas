unit Ustrgridobj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls;

type
  TFmMain = class(TForm)
    Grid: TStringGrid;
    btnAdd: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
  private
    NewIndex: Integer;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses tstrgridobjadd;

{$R *.DFM}
type
 TPerson = class
 private
   FName, FSurname: string;
   FPicture: TPicture;
    function GetGraphic: TGraphic;
 public
   constructor Create(const AName, ASurname, FileName: string);
   destructor Destroy; override;
   property Name: string read FName write FName;
   property SurName: string read FSurName write FSurName;
   property Picture: TGraphic read GetGraphic;
 end;

procedure TFmMain.btnAddClick(Sender: TObject);
var Row, Col: Integer;
begin
  if FmAddObj.Execute then
  begin
    Col := NewIndex mod Grid.ColCount;
    Row := NewIndex div Grid.ColCount;
    Inc(NewIndex);
    Grid.Objects[Col, Row] := TPerson.Create(FmAddObj.EdName.Text, FmAddObj.edSurName.Text, FmAddObj.OpenPictureDialog.FileName);
    Grid.Invalidate;
  end;
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  NewIndex := 0;
end;

{ TPerson }

constructor TPerson.Create(const AName, ASurname, FileName: string);
begin
  FName := AName;
  FSurName := ASurName;
  FPicture := TPicture.Create;
  FPicture.LoadFromFile(FileName);
end;

destructor TPerson.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;


function TPerson.GetGraphic: TGraphic;
begin
  Result := FPicture.Graphic;
end;


procedure TFmMain.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with Grid do
  begin
    if Objects[ACol, ARow] = nil then Exit;
    Canvas.FillRect(Rect);
    InflateRect(Rect, -2, -2);
    with Objects[ACol, ARow] as TPerson do
    begin
      Canvas.Draw(Rect.Left, Rect.Top, Picture);
      Inc(Rect.Top, Picture.Height+22);
      DrawText(Canvas.Handle, PChar(Name + #13#10 + SurName), -1, Rect, DT_NOPREFIX or
       DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly );
    end;
  end;
end;

procedure TFmMain.FormDestroy(Sender: TObject);
var acol, arow: Integer;
begin
  for acol := 0 to Grid.ColCount - 1 do
   for arow := 0 to Grid.RowCount - 1 do
    if Grid.Objects[acol, arow] <> nil then
     Grid.Objects[acol, arow].Free;
end;

end.
