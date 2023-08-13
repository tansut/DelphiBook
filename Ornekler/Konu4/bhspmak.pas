unit bhspmak;

interface

uses HspMak;

const
 opUs = '^';
 GelismisOperatorler = DortIslemOp + [opUs];

type

 TBilimselHesapMakinesi = class(THesapMakinesi)

  private

  protected

  public
    function Hesapla: Double; override;
end;

implementation

uses Math;

{ TBilimselHesapMakinesi }

function TBilimselHesapMakinesi.Hesapla: Double;
begin
  if Operator in DortIslemOp then
   Result := inherited Hesapla
  else
  case operator of
  opUs: Result := Power(Operand1, Operand2);
  end;
end;

end.
