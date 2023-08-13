unit hspmak;

interface

const
 opArti = '+';
 opEksi = '-';
 opCarpi = '*';
 opBolu = '/';

 DortIslemOp = [opArti, opEksi, opCarpi, opBolu];

type

  TOperator = Char;
  TOperatorSet = set of TOperator;
  THesapMakinesi = class

    private
     FOperand1, FOperand2: Integer;
     FOperator: TOperator;
    procedure SetOperand1(const Value: Integer);
    procedure SetOperand2(const Value: Integer);
    procedure SetOperator(const Value: TOperator);

    protected

    public
      constructor Create;
      property Operand1: Integer read FOperand1 write SetOperand1;
      property Operand2: Integer read FOperand2 write SetOperand2;
      property Operator: TOperator read FOperator write SetOperator;
      function Hesapla: Double; virtual;
  end;



implementation

{ THesapMakinesi }

constructor THesapMakinesi.Create;
begin
  FOperand1 := 0;
  FOperand2 := 0;
  FOperator := opArti;
end;

function THesapMakinesi.Hesapla: Double;
begin
  case FOperator of
   opArti : Result := FOperand1 + FOperand2;
   opCarpi: Result := FOperand1 * FOperand2;
   opEksi : Result := FOperand1 - FOperand2;
   opBolu : Result := FOperand1 / FOperand2;
   else Result := 0;
  end;
end;

procedure THesapMakinesi.SetOperand1(const Value: Integer);
begin
  FOperand1 := Value;
end;

procedure THesapMakinesi.SetOperand2(const Value: Integer);
begin
  FOperand2 := Value;
end;

procedure THesapMakinesi.SetOperator(const Value: TOperator);
begin
  FOperator := Value;
end;


end.

