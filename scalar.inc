{ Quantity interface }

type

  // TQuantity

  {$IFNDEF ADIMOFF}
  TQuantity = record
  private
    FID: longint;
    FValue: double;
  public
    class operator + (const ASelf: TQuantity): TQuantity;
    class operator + (const ALeft, ARight: TQuantity): TQuantity;
    class operator - (const ASelf: TQuantity): TQuantity;
    class operator - (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: double): TQuantity;
    class operator / (const ALeft, ARight: TQuantity): TQuantity;
    class operator / (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator / (const ALeft: TQuantity; const ARight: double): TQuantity;

    class operator = (const ALeft, ARight: TQuantity): boolean;
    class operator < (const ALeft, ARight: TQuantity): boolean;
    class operator > (const ALeft, ARight: TQuantity): boolean;
    class operator <=(const ALeft, ARight: TQuantity): boolean;
    class operator >=(const ALeft, ARight: TQuantity): boolean;
    class operator <>(const ALeft, ARight: TQuantity): boolean;
    class operator :=(const AValue: double): TQuantity;

    // Complex
    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator *(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
    class operator *(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;

    // Matrix
    class operator * (const ALeft: TQuantity; const ARight: TC2MatrixQuantity): TC2MatrixQuantity;
    class operator * (const ALeft: TC2MatrixQuantity; const ARight: TQuantity): TC2MatrixQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TC3MatrixQuantity): TC3MatrixQuantity;
    class operator * (const ALeft: TC3MatrixQuantity; const ARight: TQuantity): TC3MatrixQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TC4MatrixQuantity): TC4MatrixQuantity;
    class operator * (const ALeft: TC4MatrixQuantity; const ARight: TQuantity): TC4MatrixQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR2MatrixQuantity): TR2MatrixQuantity;
    class operator * (const ALeft: TR2MatrixQuantity; const ARight: TQuantity): TR2MatrixQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR3MatrixQuantity): TR3MatrixQuantity;
    class operator * (const ALeft: TR3MatrixQuantity; const ARight: TQuantity): TR3MatrixQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR4MatrixQuantity): TR4MatrixQuantity;
    class operator * (const ALeft: TR4MatrixQuantity; const ARight: TQuantity): TR4MatrixQuantity;

    // vector
    class operator * (const ALeft: TQuantity; const ARight: TC2VecQuantity): TC2VecQuantity;
    class operator * (const ALeft: TC2VecQuantity; const ARight: TQuantity): TC2VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TC2VecQuantity): TC2VecQuantity;
    class operator / (const ALeft: TC2VecQuantity; const ARight: TQuantity): TC2VecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TC3VecQuantity): TC3VecQuantity;
    class operator * (const ALeft: TC3VecQuantity; const ARight: TQuantity): TC3VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TC3VecQuantity): TC3VecQuantity;
    class operator / (const ALeft: TC3VecQuantity; const ARight: TQuantity): TC3VecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TC4VecQuantity): TC4VecQuantity;
    class operator * (const ALeft: TC4VecQuantity; const ARight: TQuantity): TC4VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TC4VecQuantity): TC4VecQuantity;
    class operator / (const ALeft: TC4VecQuantity; const ARight: TQuantity): TC4VecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR2VecQuantity): TR2VecQuantity;
    class operator * (const ALeft: TR2VecQuantity; const ARight: TQuantity): TR2VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TR2VecQuantity): TR2VecQuantity;
    class operator / (const ALeft: TR2VecQuantity; const ARight: TQuantity): TR2VecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
    class operator * (const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
    class operator / (const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TR4VecQuantity): TR4VecQuantity;
    class operator * (const ALeft: TR4VecQuantity; const ARight: TQuantity): TR4VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TR4VecQuantity): TR4VecQuantity;
    class operator / (const ALeft: TR4VecQuantity; const ARight: TQuantity): TR4VecQuantity;

    // CL3
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator <>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator = (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    class operator + (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

