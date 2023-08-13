unit ucalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls;

type
  TFmMain = class(TForm)
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses UCalcDM;

{$R *.DFM}

end.
