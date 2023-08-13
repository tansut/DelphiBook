unit ugraph;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList, ToolWin, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  mxgraph;

type
  TFmGraph = class(TForm)
    Graph: TDecisionGraph;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses Umain;

{$R *.DFM}

end.
