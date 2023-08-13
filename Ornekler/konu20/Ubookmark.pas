unit Ubookmark;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, DB, ExtCtrls, DBCtrls;

type
  TFmMain = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBNavigator1: TDBNavigator;
    LblAgeAvg: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    BookMark: TBookMark;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation
uses UBookmarkDM;
{$R *.DFM}

procedure TFmMain.FormCreate(Sender: TObject);
begin
  BookMark := nil;
end;

procedure TFmMain.Button1Click(Sender: TObject);
begin
  BookMark := DMBookmark.MusteriTable.GetBookmark; 
end;

procedure TFmMain.Button2Click(Sender: TObject);
begin
  if DMBookmark.MusteriTable.BookmarkValid(BookMark) then
   DMBookmark.MusteriTable.GotoBookmark(BookMark)
  else raise Exception.Create('Bookmark geçersiz');
end;

procedure TFmMain.Button3Click(Sender: TObject);
var
 TotalAge, Age: Double;
 TotalRec: Integer;
 Year, PresentYear, Month, Day, Hour: Word;
begin
  TotalAge := 0.0;
  TotalRec := 0;
  DecodeDate(Now, PresentYear, Month, Day);
  with DMBookmark do
  begin
    BookMark := MusteriTable.GetBookmark;
    if (Sender as TButton).Tag = 0 then MusteriTable.DisableControls;
    try
      MusteriTable.First;
      while not MusteriTable.EOF do
      begin
        if not MusteriTable.FieldbyName('DTARIHI').IsNull then
        begin
          DecodeDate(MusteriTableDTarihi.Value, Year, Month, Day);
          Age := PresentYear - Year;
          TotalAge := TotalAge + Age;
          Inc(TotalRec);
        end;
        MusteriTable.Next;
      end;
    finally
      MusteriTable.GotoBookmark(BookMark);
      if (Sender as TButton).Tag = 0 then MusteriTable.EnableControls;
      MusteriTable.FreeBookmark(Bookmark);
    end;
  end;
  LblAgeAvg.Caption := Format('Toplam %d müþteri üzerinde yapýlan hesaplamada yaþ ortalamasý %f çýkmýþtýr', [TotalRec, TotalAge / TotalRec]);
end;

end.
