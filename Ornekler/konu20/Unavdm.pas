unit Unavdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMNav = class(TDataModule)
    MusteriTable: TTable;
    MusteriSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMNav: TDMNav;

implementation

{$R *.DFM}

end.
