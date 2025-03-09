{ CL3 implementation }

// TCL3Multivector

class operator TCL3Multivector.:=(const AValue: double): TCL3Multivector;
begin
  result.fm0   := AValue;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Multivector.:=(const AValue: TCL3Multivector): double;
begin
  result := AValue;
end;

class operator TCL3Multivector.<>(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   <> ARight.fm0  ) or
            (ALeft.fm1   <> ARight.fm1  ) or
            (ALeft.fm2   <> ARight.fm2  ) or
            (ALeft.fm3   <> ARight.fm3  ) or
            (ALeft.fm12  <> ARight.fm12 ) or
            (ALeft.fm13  <> ARight.fm13 ) or
            (ALeft.fm23  <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Multivector.<>(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ALeft.fm0   <> ARight) or
            (ALeft.fm1   <>    0.0) or
            (ALeft.fm2   <>    0.0) or
            (ALeft.fm3   <>    0.0) or
            (ALeft.fm12  <>    0.0) or
            (ALeft.fm13  <>    0.0) or
            (ALeft.fm23  <>    0.0) or
            (ALeft.fm123 <>    0.0);
end;

class operator TCL3Multivector.<>(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft <> ARight.fm0  ) or
            (0.0   <> ARight.fm1  ) or
            (0.0   <> ARight.fm2  ) or
            (0.0   <> ARight.fm3  ) or
            (0.0   <> ARight.fm12 ) or
            (0.0   <> ARight.fm13 ) or
            (0.0   <> ARight.fm23 ) or
            (0.0   <> ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ARight <> ALeft.fm0  ) or
            (0.0    <> ALeft.fm1  ) or
            (0.0    <> ALeft.fm2  ) or
            (0.0    <> ALeft.fm3  ) or
            (0.0    <> ALeft.fm12 ) or
            (0.0    <> ALeft.fm13 ) or
            (0.0    <> ALeft.fm23 ) or
            (0.0    <> ALeft.fm123);
end;

class operator TCL3Multivector.=(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft = ARight.fm0  ) or
            (0.0   = ARight.fm1  ) or
            (0.0   = ARight.fm2  ) or
            (0.0   = ARight.fm3  ) or
            (0.0   = ARight.fm12 ) or
            (0.0   = ARight.fm13 ) or
            (0.0   = ARight.fm23 ) or
            (0.0   = ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   = ARight.fm0  ) or
            (ALeft.fm1   = ARight.fm1  ) or
            (ALeft.fm2   = ARight.fm2  ) or
            (ALeft.fm3   = ARight.fm3  ) or
            (ALeft.fm12  = ARight.fm12 ) or
            (ALeft.fm13  = ARight.fm13 ) or
            (ALeft.fm23  = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Multivector.+(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 + ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.+(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0 + ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Multivector.+(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   + ARight.fm0;
  result.fm1   := ALeft.fm1   + ARight.fm1;
  result.fm2   := ALeft.fm2   + ARight.fm2;
  result.fm3   := ALeft.fm3   + ARight.fm3;
  result.fm12  := ALeft.fm12  + ARight.fm12;
  result.fm13  := ALeft.fm13  + ARight.fm13;
  result.fm23  := ALeft.fm23  + ARight.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Multivector.-(const ASelf: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ASelf.fm0;
  result.fm1   := -ASelf.fm1;
  result.fm2   := -ASelf.fm2;
  result.fm3   := -ASelf.fm3;
  result.fm12  := -ASelf.fm12;
  result.fm13  := -ASelf.fm13;
  result.fm23  := -ASelf.fm23;
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Multivector.-(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 - ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.-(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft - ARight.fm0;
  result.fm1   :=       - ARight.fm1;
  result.fm2   :=       - ARight.fm2;
  result.fm3   :=       - ARight.fm3;
  result.fm12  :=       - ARight.fm12;
  result.fm13  :=       - ARight.fm13;
  result.fm23  :=       - ARight.fm23;
  result.fm123 :=       - ARight.fm123;
end;

class operator TCL3Multivector.-(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   - ARight.fm0;
  result.fm1   := ALeft.fm1   - ARight.fm1;
  result.fm2   := ALeft.fm2   - ARight.fm2;
  result.fm3   := ALeft.fm3   - ARight.fm3;
  result.fm12  := ALeft.fm12  - ARight.fm12;
  result.fm13  := ALeft.fm13  - ARight.fm13;
  result.fm23  := ALeft.fm23  - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   * ARight;
  result.fm1   := ALeft.fm1   * ARight;
  result.fm2   := ALeft.fm2   * ARight;
  result.fm3   := ALeft.fm3   * ARight;
  result.fm12  := ALeft.fm12  * ARight;
  result.fm13  := ALeft.fm13  * ARight;
  result.fm23  := ALeft.fm23  * ARight;
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Multivector.*(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft * ARight.fm0;
  result.fm1   := ALeft * ARight.fm1;
  result.fm2   := ALeft * ARight.fm2;
  result.fm3   := ALeft * ARight.fm3;
  result.fm12  := ALeft * ARight.fm12;
  result.fm13  := ALeft * ARight.fm13;
  result.fm23  := ALeft * ARight.fm23;
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=     ALeft.fm0   * ARight.fm0
                  + ALeft.fm1   * ARight.fm1
                  + ALeft.fm2   * ARight.fm2
                  + ALeft.fm3   * ARight.fm3
                  - ALeft.fm12  * ARight.fm12
                  - ALeft.fm13  * ARight.fm13
                  - ALeft.fm23  * ARight.fm23
                  - ALeft.fm123 * ARight.fm123;

  result.fm1 :=     ALeft.fm0   * ARight.fm1
                  + ALeft.fm1   * ARight.fm0
                  - ALeft.fm2   * ARight.fm12
                  - ALeft.fm3   * ARight.fm13
                  + ALeft.fm12  * ARight.fm2
                  + ALeft.fm13  * ARight.fm3
                  - ALeft.fm23  * ARight.fm123
                  - ALeft.fm123 * ARight.fm23;

  result.fm2 :=     ALeft.fm0   * ARight.fm2
                  + ALeft.fm1   * ARight.fm12
                  + ALeft.fm2   * ARight.fm0
                  - ALeft.fm3   * ARight.fm23
                  - ALeft.fm12  * ARight.fm1
                  + ALeft.fm13  * ARight.fm123
                  + ALeft.fm23  * ARight.fm3
                  + ALeft.fm123 * ARight.fm13;

  result.fm3 :=     ALeft.fm0   * ARight.fm3
                  + ALeft.fm1   * ARight.fm13
                  + ALeft.fm2   * ARight.fm23
                  + ALeft.fm3   * ARight.fm0
                  - ALeft.fm12  * ARight.fm123
                  - ALeft.fm13  * ARight.fm1
                  - ALeft.fm23  * ARight.fm2
                  - ALeft.fm123 * ARight.fm12;

  result.fm12 :=    ALeft.fm0   * ARight.fm12
                  + ALeft.fm1   * ARight.fm2
                  - ALeft.fm2   * ARight.fm1
                  + ALeft.fm3   * ARight.fm123
                  + ALeft.fm12  * ARight.fm0
                  - ALeft.fm13  * ARight.fm23
                  + ALeft.fm23  * ARight.fm13
                  + ALeft.fm123 * ARight.fm3;

  result.fm23 :=    ALeft.fm0   * ARight.fm23
                  + ALeft.fm1   * ARight.fm123
                  + ALeft.fm2   * ARight.fm3
                  - ALeft.fm3   * ARight.fm2
                  - ALeft.fm12  * ARight.fm13
                  + ALeft.fm13  * ARight.fm12
                  + ALeft.fm23  * ARight.fm0
                  + ALeft.fm123 * ARight.fm1;

  result.fm13  :=   ALeft.fm0   * ARight.fm13
                  + ALeft.fm1   * ARight.fm3
                  - ALeft.fm2   * ARight.fm123
                  - ALeft.fm3   * ARight.fm1
                  + ALeft.fm12  * ARight.fm23
                  + ALeft.fm13  * ARight.fm0
                  - ALeft.fm23  * ARight.fm12
                  - ALeft.fm123 * ARight.fm2;

  result.fm123 := + ALeft.fm0   * ARight.fm123
                  + ALeft.fm1   * ARight.fm23
                  - ALeft.fm2   * ARight.fm13
                  + ALeft.fm3   * ARight.fm12
                  + ALeft.fm12  * ARight.fm3
                  - ALeft.fm13  * ARight.fm2
                  + ALeft.fm23  * ARight.fm1
                  + ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Multivector./(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   / ARight;
  result.fm1   := ALeft.fm1   / ARight;
  result.fm2   := ALeft.fm2   / ARight;
  result.fm3   := ALeft.fm3   / ARight;
  result.fm12  := ALeft.fm12  / ARight;
  result.fm13  := ALeft.fm13  / ARight;
  result.fm23  := ALeft.fm23  / ARight;
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Multivector./(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Multivector./(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Trivector

class operator TCL3Trivector.:=(const AValue: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.:=(const AValue: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.<>(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 <> ARight.fm123;
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   <>          0.0) or
            (ALeft.fm1   <>          0.0) or
            (ALeft.fm2   <>          0.0) or
            (ALeft.fm3   <>          0.0) or
            (ALeft.fm12  <>          0.0) or
            (ALeft.fm13  <>          0.0) or
            (ALeft.fm23  <>          0.0) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         <> ARight.fm0  ) or
            (0.0         <> ARight.fm1  ) or
            (0.0         <> ARight.fm2  ) or
            (0.0         <> ARight.fm3  ) or
            (0.0         <> ARight.fm12 ) or
            (0.0         <> ARight.fm13 ) or
            (0.0         <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   =          0.0) or
            (ALeft.fm1   =          0.0) or
            (ALeft.fm2   =          0.0) or
            (ALeft.fm3   =          0.0) or
            (ALeft.fm12  =          0.0) or
            (ALeft.fm13  =          0.0) or
            (ALeft.fm23  =          0.0) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         = ARight.fm0  ) or
            (0.0         = ARight.fm1  ) or
            (0.0         = ARight.fm2  ) or
            (0.0         = ARight.fm3  ) or
            (0.0         = ARight.fm12 ) or
            (0.0         = ARight.fm13 ) or
            (0.0         = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 = ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Trivector.+(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123 + ALeft.fm123;
end;

class operator TCL3Trivector.-(const ASelf: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Trivector.-(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Trivector.-(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=             - ARight.fm12;
  result.fm13  :=             - ARight.fm13;
  result.fm23  :=             - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Trivector.*(const ALeft, ARight: TCL3Trivector): double;
begin
  result := -ALeft.fm123 * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm23  * ARight.fm123;
  result.fm2   :=  ALeft.fm13  * ARight.fm123;
  result.fm3   := -ALeft.fm12  * ARight.fm123;
  result.fm12  :=  ALeft.fm3   * ARight.fm123;
  result.fm13  := -ALeft.fm2   * ARight.fm123;
  result.fm23  :=  ALeft.fm1   * ARight.fm123;
  result.fm123 :=  ALeft.fm0   * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm123 * ARight.fm23;
  result.fm2   :=  ALeft.fm123 * ARight.fm13;
  result.fm3   := -ALeft.fm123 * ARight.fm12;
  result.fm12  :=  ALeft.fm123 * ARight.fm3;
  result.fm13  := -ALeft.fm123 * ARight.fm2;
  result.fm23  :=  ALeft.fm123 * ARight.fm1;
  result.fm123 :=  ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Trivector./(const ALeft, ARight: TCL3Trivector): double;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Trivector./(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Bivector

class operator TCL3Bivector.:=(const AValue: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := AValue.fm12;
  result.fm13  := AValue.fm13;
  result.fm23  := AValue.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.:=(const AValue: TCL3Multivector): TCL3Bivector;
begin
  result.fm12 := AValue.fm12;
  result.fm13 := AValue.fm13;
  result.fm23 := AValue.fm23;
end;

class operator TCL3Bivector.<>(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 <> ARight.fm12) or
            (ALeft.fm13 <> ARight.fm13) or
            (ALeft.fm23 <> ARight.fm23);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   <>         0.0) or
            (ALeft.fm1   <>         0.0) or
            (ALeft.fm2   <>         0.0) or
            (ALeft.fm3   <>         0.0) or
            (ALeft.fm12  <> ARight.fm12) or
            (ALeft.fm13  <> ARight.fm13) or
            (ALeft.fm23  <> ARight.fm23) or
            (ALeft.fm123 <>         0.0);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>        0.0) or
            (ARight.fm1   <>        0.0) or
            (ARight.fm2   <>        0.0) or
            (ARight.fm3   <>        0.0) or
            (ARight.fm12  <> ALeft.fm12) or
            (ARight.fm13  <> ALeft.fm13) or
            (ARight.fm23  <> ALeft.fm23) or
            (ARight.fm123 <>        0.0);
end;

class operator TCL3Bivector.=(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 = ARight.fm12) or
            (ALeft.fm13 = ARight.fm13) or
            (ALeft.fm23 = ARight.fm23);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   =         0.0) or
            (ALeft.fm1   =         0.0) or
            (ALeft.fm2   =         0.0) or
            (ALeft.fm3   =         0.0) or
            (ALeft.fm12  = ARight.fm12) or
            (ALeft.fm13  = ARight.fm13) or
            (ALeft.fm23  = ARight.fm23) or
            (ALeft.fm123 =         0.0);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =        0.0) or
            (ARight.fm1   =        0.0) or
            (ARight.fm2   =        0.0) or
            (ARight.fm3   =        0.0) or
            (ARight.fm12  = ALeft.fm12) or
            (ARight.fm13  = ALeft.fm13) or
            (ARight.fm23  = ALeft.fm23) or
            (ARight.fm123 =        0.0);
end;

class operator TCL3Bivector.+(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm13 := ALeft.fm13 + ARight.fm13;
  result.fm23 := ALeft.fm23 + ARight.fm23;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12 + ALeft.fm12;
  result.fm13  := ARight.fm13 + ALeft.fm13;
  result.fm23  := ARight.fm23 + ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 + ARight.fm12;
  result.fm13  := ALeft.fm13 + ARight.fm13;
  result.fm23  := ALeft.fm23 + ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.-(const ASelf: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := -ASelf.fm12;
  result.fm13 := -ASelf.fm13;
  result.fm23 := -ASelf.fm23;
end;

class operator TCL3Bivector.-(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=  ALeft.fm12 - ARight.fm12;
  result.fm13  :=  ALeft.fm13 - ARight.fm13;
  result.fm23  :=  ALeft.fm23 - ARight.fm23;
  result.fm123 :=             - ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.*(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft * ARight.fm12;
  result.fm13 := ALeft * ARight.fm13;
  result.fm23 := ALeft * ARight.fm23;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ARight * ALeft.fm12;
  result.fm13 := ARight * ALeft.fm13;
  result.fm23 := ARight * ALeft.fm23;
end;

class operator TCL3Bivector.*(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  := -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm13  := +ALeft.fm12 * ARight.fm23
                  -ALeft.fm23 * ARight.fm12;

  result.fm23  := -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12;

  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1 :=    ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3
                  -ALeft.fm23 * ARight.fm123;

  result.fm2 :=   -ALeft.fm12 * ARight.fm1
                  +ALeft.fm13 * ARight.fm123
                  +ALeft.fm23 * ARight.fm3;

  result.fm3 :=   -ALeft.fm12 * ARight.fm123
                  -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12 :=   ALeft.fm12 * ARight.fm0
                  -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm23 :=  -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12
                  +ALeft.fm23 * ARight.fm0;

  result.fm13 :=  +ALeft.fm12 * ARight.fm23
                  +ALeft.fm13 * ARight.fm0
                  -ALeft.fm23 * ARight.fm12;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ALeft.fm23 * ARight.fm123;
  result.fm2   :=  ALeft.fm13 * ARight.fm123;
  result.fm3   := -ALeft.fm12 * ARight.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm23 * ALeft.fm123;
  result.fm2   :=  ARight.fm13 * ALeft.fm123;
  result.fm3   := -ARight.fm12 * ALeft.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12  * ARight.fm12
                  -ALeft.fm13  * ARight.fm13
                  -ALeft.fm23  * ARight.fm23;

  result.fm1 :=   -ALeft.fm2   * ARight.fm12
                  -ALeft.fm3   * ARight.fm13
                  -ALeft.fm123 * ARight.fm23;

  result.fm2 :=    ALeft.fm1   * ARight.fm12
                  -ALeft.fm3   * ARight.fm23
                  +ALeft.fm123 * ARight.fm13;

  result.fm3 :=    ALeft.fm1   * ARight.fm13
                  +ALeft.fm2   * ARight.fm23
                  -ALeft.fm123 * ARight.fm12;

  result.fm12 :=   ALeft.fm0   * ARight.fm12
                  -ALeft.fm13  * ARight.fm23
                  +ALeft.fm23  * ARight.fm13;

  result.fm23 :=   ALeft.fm0   * ARight.fm23
                  -ALeft.fm12  * ARight.fm13
                  +ALeft.fm13  * ARight.fm12;

  result.fm13 :=   ALeft.fm0   * ARight.fm13
                  +ALeft.fm12  * ARight.fm23
                  -ALeft.fm23  * ARight.fm12;

  result.fm123 :=  ALeft.fm1   * ARight.fm23
                  -ALeft.fm2   * ARight.fm13
                  +ALeft.fm3   * ARight.fm12;
end;

class operator TCL3Bivector./(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 / ARight;
  result.fm13 := ALeft.fm13 / ARight;
  result.fm23 := ALeft.fm23 / ARight;
end;

class operator TCL3Bivector./(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TVector

class operator TVector.:=(const AValue: TVector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := AValue.fm1;
  result.fm2   := AValue.fm2;
  result.fm3   := AValue.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TVector.:=(const AValue: TCL3Multivector): TVector;
begin
  result.fm1 := AValue.fm1;
  result.fm2 := AValue.fm2;
  result.fm3 := AValue.fm3;
end;

class operator TVector.<>(const ALeft, ARight: TVector): boolean;
begin
  result := (ALeft.fm1 <> ARight.fm1) or
            (ALeft.fm2 <> ARight.fm2) or
            (ALeft.fm3 <> ARight.fm3);
end;

class operator TVector.<>(const ALeft: TCL3Multivector; const ARight: TVector): boolean;
begin
  result := (ALeft.fm0   <>        0.0) or
            (ALeft.fm1   <> ARight.fm1) or
            (ALeft.fm2   <> ARight.fm2) or
            (ALeft.fm3   <> ARight.fm3) or
            (ALeft.fm12  <>        0.0) or
            (ALeft.fm13  <>        0.0) or
            (ALeft.fm23  <>        0.0) or
            (ALeft.fm123 <>        0.0);
end;

class operator TVector.<>(const ALeft: TVector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>       0.0) or
            (ARight.fm1   <> ALeft.fm1) or
            (ARight.fm2   <> ALeft.fm2) or
            (ARight.fm3   <> ALeft.fm3) or
            (ARight.fm12  <>       0.0) or
            (ARight.fm13  <>       0.0) or
            (ARight.fm23  <>       0.0) or
            (ARight.fm123 <>       0.0);
end;

class operator TVector.=(const ALeft, ARight: TVector): boolean;
begin
  result := (ALeft.fm1 = ARight.fm1) or
            (ALeft.fm2 = ARight.fm2) or
            (ALeft.fm3 = ARight.fm3);
end;

class operator TVector.=(const ALeft: TVector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =       0.0) or
            (ARight.fm1   = ALeft.fm1) or
            (ARight.fm2   = ALeft.fm2) or
            (ARight.fm3   = ALeft.fm3) or
            (ARight.fm12  =       0.0) or
            (ARight.fm13  =       0.0) or
            (ARight.fm23  =       0.0) or
            (ARight.fm123 =       0.0);
end;

class operator TVector.=(const ALeft: TCL3Multivector; const ARight: TVector): boolean;
begin
  result := (ALeft.fm0   =        0.0) or
            (ALeft.fm1   = ARight.fm1) or
            (ALeft.fm2   = ARight.fm2) or
            (ALeft.fm3   = ARight.fm3) or
            (ALeft.fm12  =        0.0) or
            (ALeft.fm13  =        0.0) or
            (ALeft.fm23  =        0.0) or
            (ALeft.fm123 =        0.0);
end;

class operator TVector.+(const ALeft, ARight: TVector): TVector;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TVector.+(const ALeft: TVector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TVector.+(const ALeft: double; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TVector.+(const ALeft: TCL3Bivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TVector.+(const ALeft: TCL3Trivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;


class operator TVector.+(const ALeft: TVector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1 + ALeft.fm1;
  result.fm2   := ARight.fm2 + ALeft.fm2;
  result.fm3   := ARight.fm3 + ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TVector.+(const ALeft: TCL3Multivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 + ARight.fm1;
  result.fm2   := ALeft.fm2 + ARight.fm2;
  result.fm3   := ALeft.fm3 + ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TVector.-(const ASelf: TVector): TVector;
begin
  result.fm1 := -ASelf.fm1;
  result.fm2 := -ASelf.fm2;
  result.fm3 := -ASelf.fm3;
end;

class operator TVector.-(const ALeft, ARight: TVector): TVector;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TVector.-(const ALeft: TVector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TVector.-(const ALeft: double; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TVector.-(const ALeft: TCL3Bivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TVector.-(const ALeft: TCL3Trivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=            - ARight.fm0;
  result.fm1   :=  ALeft.fm1 - ARight.fm1;
  result.fm2   :=  ALeft.fm2 - ARight.fm2;
  result.fm3   :=  ALeft.fm3 - ARight.fm3;
  result.fm12  :=            - ARight.fm12;
  result.fm13  :=            - ARight.fm13;
  result.fm23  :=            - ARight.fm23;
  result.fm123 :=            - ARight.fm123;
end;

class operator TVector.-(const ALeft: TCL3Multivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 - ARight.fm1;
  result.fm2   := ALeft.fm2 - ARight.fm2;
  result.fm3   := ALeft.fm3 - ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TVector.*(const ALeft: double; const ARight: TVector): TVector;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TVector.*(const ALeft: TVector; const ARight: double): TVector;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TVector.*(const ALeft, ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm3 * ARight.fm1;

  result.fm23  :=  ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm123 :=  0.0;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;

  result.fm1   := -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TVector.*(const ALeft: TCL3Bivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3;

  result.fm2   := -ALeft.fm12 * ARight.fm1
                  +ALeft.fm23 * ARight.fm3;

  result.fm3   := -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm3 * ARight.fm123;
  result.fm13 := -ALeft.fm2 * ARight.fm123;
  result.fm23 :=  ALeft.fm1 * ARight.fm123;
end;

class operator TVector.*(const ALeft: TCL3Trivector; const ARight: TVector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm123 * ARight.fm3;
  result.fm13 := -ALeft.fm123 * ARight.fm2;
  result.fm23 :=  ALeft.fm123 * ARight.fm1;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  ALeft.fm1 * ARight.fm0
                  -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  +ALeft.fm2 * ARight.fm0
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23
                  +ALeft.fm3 * ARight.fm0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1
                  +ALeft.fm3 * ARight.fm123;

  result.fm23  :=  ALeft.fm1 * ARight.fm123
                  +ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm2 * ARight.fm123
                  -ALeft.fm3 * ARight.fm1;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TVector.*(const ALeft: TCL3Multivector; const ARight: TVector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1   * ARight.fm1
                  +ALeft.fm2   * ARight.fm2
                  +ALeft.fm3   * ARight.fm3;

  result.fm1   :=  ALeft.fm0   * ARight.fm1
                  +ALeft.fm12  * ARight.fm2
                  +ALeft.fm13  * ARight.fm3;

  result.fm2   :=  ALeft.fm0   * ARight.fm2
                  -ALeft.fm12  * ARight.fm1
                  +ALeft.fm23  * ARight.fm3;

  result.fm3   :=  ALeft.fm0   * ARight.fm3
                  -ALeft.fm13  * ARight.fm1
                  -ALeft.fm23  * ARight.fm2;

  result.fm12  :=  ALeft.fm1   * ARight.fm2
                  -ALeft.fm2   * ARight.fm1
                  +ALeft.fm123 * ARight.fm3;

  result.fm23  :=  ALeft.fm2   * ARight.fm3
                  -ALeft.fm3   * ARight.fm2
                  +ALeft.fm123 * ARight.fm1;

  result.fm13  :=  ALeft.fm1   * ARight.fm3
                  -ALeft.fm3   * ARight.fm1
                  -ALeft.fm123 * ARight.fm2;

  result.fm123 :=  ALeft.fm12  * ARight.fm3
                  -ALeft.fm13  * ARight.fm2
                  +ALeft.fm23  * ARight.fm1;
end;


class operator TVector./(const ALeft, ARight: TVector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./ (const ALeft: TVector; const ARight: double): TVector;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TVector./(const ALeft: double; const ARight: TVector): TVector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TCL3Bivector; const ARight: TVector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TCL3Trivector; const ARight: TVector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TCL3Multivector; const ARight: TVector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3MultivectorHelper

function TCL3MultivectorHelper.Dual: TCL3Multivector;
begin
  result.fm0   := -fm123;
  result.fm1   := -fm23;
  result.fm2   :=  fm13;
  result.fm3   := -fm12;
  result.fm12  :=  fm3;
  result.fm13  := -fm2;
  result.fm23  :=  fm1;
  result.fm123 :=  fm0;
end;

function TCL3MultivectorHelper.Inverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  :=  fm12;
  result.fm13  :=  fm13;
  result.fm23  :=  fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Reverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   :=  fm1;
  result.fm2   :=  fm2;
  result.fm3   :=  fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Conjugate: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 :=  fm123;
end;

function TCL3MultivectorHelper.Reciprocal: TCL3Multivector;
var
  Numerator: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    Numerator := Conjugate * Inverse * Reverse;
    result    := Numerator / (Self*Numerator).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.LeftReciprocal: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    result := (Inverse*Reverse*Conjugate) / (Self*Conjugate*Inverse*Reverse).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.Normalized: TCL3Multivector;
begin
  result := Self / Norm;
end;

function TCL3MultivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3MultivectorHelper.SquaredNorm: double;
begin
  result := fm0*fm0 +fm1*fm1 +fm2*fm2 +fm3*fm3 +fm12*fm12 +fm23*fm23 +fm13*fm13 +fm123*fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TVector): TCL3Multivector;
begin
  result.fm0   :=  fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3;

  result.fm2   :=  fm0   * AVector.fm2
                  -fm12  * AVector.fm1
                  +fm23  * AVector.fm3;

  result.fm3   :=  fm0   * AVector.fm3
                  -fm23  * AVector.fm2
                  -fm13  * AVector.fm1;

  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  0.0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23;

  result.fm1   := -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  -fm123 * AVector.fm23;

  result.fm2   :=  fm1   * AVector.fm12
                  -fm3   * AVector.fm23
                  +fm123 * AVector.fm13;

  result.fm3   :=  fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  -fm123 * AVector.fm12;

  result.fm12  :=  fm0   * AVector.fm12;
  result.fm13  :=  fm0   * AVector.fm13;
  result.fm23  :=  fm0   * AVector.fm23;
  result.fm123 :=  0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm23  * AVector.fm123;
  result.fm2   :=  fm13  * AVector.fm123;
  result.fm3   := -fm12  * AVector.fm123;
  result.fm12  :=  fm3   * AVector.fm123;
  result.fm13  := -fm2   * AVector.fm123;
  result.fm23  :=  fm1   * AVector.fm123;
  result.fm123 :=  fm0   * AVector.fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=    fm0   * AVector.fm0
                  +fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3
                  -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23
                  -fm123 * AVector.fm123;

  result.fm1 :=    fm0   * AVector.fm1
                  +fm1   * AVector.fm0
                  -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3
                  -fm23  * AVector.fm123
                  -fm123 * AVector.fm23;

  result.fm2 :=    fm0   * AVector.fm2
                  +fm1   * AVector.fm12
                  +fm2   * AVector.fm0
                  -fm3   * AVector.fm23
                  -fm12  * AVector.fm1
                  +fm13  * AVector.fm123
                  +fm23  * AVector.fm3
                  +fm123 * AVector.fm13;

  result.fm3 :=    fm0   * AVector.fm3
                  +fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  +fm3   * AVector.fm0
                  -fm12  * AVector.fm123
                  -fm13  * AVector.fm1
                  -fm23  * AVector.fm2
                  -fm123 * AVector.fm12;

  result.fm12 :=   fm0   * AVector.fm12
                  +fm3   * AVector.fm123
                  +fm12  * AVector.fm0
                  +fm123 * AVector.fm3;

  result.fm23 :=   fm0   * AVector.fm23
                  +fm1   * Avector.fm123
                  +fm23  * AVector.fm0
                  +fm123 * AVector.fm1;

  result.fm13 :=   fm0   * AVector.fm13
                  -fm2   * AVector.fm123
                  +fm13  * AVector.fm0
                  -fm123 * AVector.fm2;

  result.fm123 :=  fm0   * AVector.fm123
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TVector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm0  * AVector.fm1;
  result.fm2   :=  fm0  * AVector.fm2;
  result.fm3   :=  fm0  * AVector.fm3;

  result.fm12  :=  fm1  * AVector.fm2
                  -fm2  * AVector.fm1;

  result.fm23  :=  fm2  * AVector.fm3
                  -fm3  * AVector.fm2;

  result.fm13  := +fm1  * AVector.fm3
                  -fm3  * AVector.fm1;

  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm0 * AVector.fm12;
  result.fm23  :=  fm0 * AVector.fm23;
  result.fm13  :=  fm0 * AVector.fm13;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm0 * AVector.fm123;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm0   * AVector.fm0;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm1   * AVector.fm0;

  result.fm2   :=  fm0   * AVector.fm2
                  +fm2   * AVector.fm0;

  result.fm3   :=  fm0   * AVector.fm3
                  +fm3   * AVector.fm0;

  result.fm12  :=  fm0   * AVector.fm12
                  +fm1   * AVector.fm2
                  -fm2   * AVector.fm1
                  +fm12  * AVector.fm0;

  result.fm23  :=  fm0   * AVector.fm23
                  +fm2   * AVector.fm3
                  -fm3   * AVector.fm2
                  +fm23  * AVector.fm0;

  result.fm13  :=  fm0   * AVector.fm13
                  +fm1   * AVector.fm3
                  -fm3   * AVector.fm1
                  +fm13  * AVector.fm0;

  result.fm123 := +fm0   * AVector.fm123
                  +fm1   * AVector.fm23
                  -fm2   * AVector.fm13
                  +fm3   * AVector.fm12
                  +fm12  * AVector.fm3
                  -fm13  * AVector.fm2
                  +fm23  * AVector.fm1
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Projection(const AVector: TVector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TVector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TVector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TVector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := Math.SameValue(fm0,   AValue.fm0  ) and
            Math.SameValue(fm1,   AValue.fm1  ) and
            Math.SameValue(fm2,   AValue.fm2  ) and
            Math.SameValue(fm3,   AValue.fm3  ) and
            Math.SameValue(fm12,  AValue.fm12 ) and
            Math.SameValue(fm13,  AValue.fm13 ) and
            Math.SameValue(fm23,  AValue.fm23 ) and
            Math.SameValue(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := Math.SameValue(fm0,            0.0) and
            Math.SameValue(fm1,            0.0) and
            Math.SameValue(fm2,            0.0) and
            Math.SameValue(fm3,            0.0) and
            Math.SameValue(fm12,           0.0) and
            Math.SameValue(fm23,           0.0) and
            Math.SameValue(fm13,           0.0) and
            Math.SameValue(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := Math.SameValue(fm0,           0.0) and
            Math.SameValue(fm1,           0.0) and
            Math.SameValue(fm2,           0.0) and
            Math.SameValue(fm3,           0.0) and
            Math.SameValue(fm12,  AValue.fm12) and
            Math.SameValue(fm13,  AValue.fm13) and
            Math.SameValue(fm23,  AValue.fm23) and
            Math.SameValue(fm123,         0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TVector): boolean;
begin
  result := Math.SameValue(fm0,          0.0) and
            Math.SameValue(fm1,   AValue.fm1) and
            Math.SameValue(fm2,   AValue.fm2) and
            Math.SameValue(fm3,   AValue.fm3) and
            Math.SameValue(fm12,         0.0) and
            Math.SameValue(fm23,         0.0) and
            Math.SameValue(fm13,         0.0) and
            Math.SameValue(fm123,        0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: double): boolean;
begin
  result := Math.SameValue(fm0,   AValue) and
            Math.SameValue(fm1,      0.0) and
            Math.SameValue(fm2,      0.0) and
            Math.SameValue(fm3,      0.0) and
            Math.SameValue(fm12,     0.0) and
            Math.SameValue(fm23,     0.0) and
            Math.SameValue(fm13,     0.0) and
            Math.SameValue(fm123,    0.0);
end;

function TCL3MultivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm0,   0.0) then result := result + Fmt(fm0,   APrecision, ADigits) + ' ';
  if not Math.SameValue(fm1,   0.0) then result := result + Fmt(fm1,   APrecision, ADigits) + 'e1 ';
  if not Math.SameValue(fm2,   0.0) then result := result + Fmt(fm2,   APrecision, ADigits) + 'e2 ';
  if not Math.SameValue(fm3,   0.0) then result := result + Fmt(fm3,   APrecision, ADigits) + 'e3 ';
  if not Math.SameValue(fm12,  0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not Math.SameValue(fm23,  0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';
  if not Math.SameValue(fm13,  0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e31 ';
  if not Math.SameValue(fm123, 0.0) then result := result + Fmt(fm123, APrecision, ADigits) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm0,   0.0) then result := result + Fmt(fm0  ) + ' ';
  if not Math.SameValue(fm1,   0.0) then result := result + Fmt(fm1  ) + 'e1 ';
  if not Math.SameValue(fm2,   0.0) then result := result + Fmt(fm2  ) + 'e2 ';
  if not Math.SameValue(fm3,   0.0) then result := result + Fmt(fm3  ) + 'e3 ';
  if not Math.SameValue(fm12,  0.0) then result := result + Fmt(fm12 ) + 'e12 ';
  if not Math.SameValue(fm23,  0.0) then result := result + Fmt(fm23 ) + 'e23 ';
  if not Math.SameValue(fm13,  0.0) then result := result + Fmt(fm13 ) + 'e31 ';
  if not Math.SameValue(fm123, 0.0) then result := result + Fmt(fm123) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ExtracTCL3Multivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;
begin
  Result := NullMultivector;
  if mcm0   in AComponents then result.fm0   := fm0;
  if mcm1   in AComponents then result.fm1   := fm1;
  if mcm2   in AComponents then result.fm2   := fm2;
  if mcm3   in AComponents then result.fm3   := fm3;
  if mcm12  in AComponents then result.fm12  := fm12;
  if mcm13  in AComponents then result.fm13  := fm13;
  if mcm23  in AComponents then result.fm23  := fm23;
  if mcm123 in AComponents then result.fm123 := fm123;
end;

function TCL3MultivectorHelper.ExtracTCL3Bivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  Result := NullBivector;
  if mcm12 in AComponents then result.fm12 := fm12;
  if mcm13 in AComponents then result.fm13 := fm13;
  if mcm23 in AComponents then result.fm23 := fm23;
end;

function TCL3MultivectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TVector;
begin
  Result := NullVector;
  if mcm1 in AComponents then result.fm1 := fm1;
  if mcm2 in AComponents then result.fm2 := fm2;
  if mcm3 in AComponents then result.fm3 := fm3;
end;

function TCL3MultivectorHelper.ExtracTCL3Trivector: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3MultivectorHelper.ExtracTCL3Bivector: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3MultivectorHelper.ExtractVector: TVector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TCL3MultivectorHelper.ExtractScalar: double;
begin
  result := fm0;
end;

function TCL3MultivectorHelper.IsNull: boolean;
begin
  result := SameValue(NullMultivector);
end;

function TCL3MultivectorHelper.IsScalar: boolean;
begin
  result := (not Math.SameValue(fm0,   0.0)) and
            (    Math.SameValue(fm1,   0.0)) and
            (    Math.SameValue(fm2,   0.0)) and
            (    Math.SameValue(fm3,   0.0)) and
            (    Math.SameValue(fm12,  0.0)) and
            (    Math.SameValue(fm23,  0.0)) and
            (    Math.SameValue(fm13,  0.0)) and
            (    Math.SameValue(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsVector: boolean;
begin
  result :=  (    Math.SameValue(fm0,   0.0))  and
            ((not Math.SameValue(fm1,   0.0))  or
             (not Math.SameValue(fm2,   0.0))  or
             (not Math.SameValue(fm3,   0.0))) and
             (    Math.SameValue(fm12,  0.0))  and
             (    Math.SameValue(fm23,  0.0))  and
             (    Math.SameValue(fm13,  0.0))  and
             (    Math.SameValue(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsBiVector: boolean;
begin
  result :=  (    Math.SameValue(fm0,   0.0))  and
             (    Math.SameValue(fm1,   0.0))  and
             (    Math.SameValue(fm2,   0.0))  and
             (    Math.SameValue(fm3,   0.0))  and
            ((not Math.SameValue(fm12,  0.0))  or
             (not Math.SameValue(fm23,  0.0))  or
             (not Math.SameValue(fm13,  0.0))) and
             (    Math.SameValue(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsTrivector: boolean;
begin
  result := (    Math.SameValue(fm0,   0.0)) and
            (    Math.SameValue(fm1,   0.0)) and
            (    Math.SameValue(fm2,   0.0)) and
            (    Math.SameValue(fm3,   0.0)) and
            (    Math.SameValue(fm12,  0.0)) and
            (    Math.SameValue(fm23,  0.0)) and
            (    Math.SameValue(fm13,  0.0)) and
            (not Math.SameValue(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsA: string;
begin
  if IsNull      then Result := 'Null'       else
  if IsTrivector then Result := 'TCL3Trivector' else
  if IsBivector  then Result := 'TCL3Bivector'  else
  if IsVector    then Result := 'TVector'    else
  if IsScalar    then Result := 'TScalar'    else Result := 'TCL3Multivector';
end;

// TCL3TrivectorHelper

function TCL3TrivectorHelper.Dual: double;
begin
  // Self * e123
  result := -fm123;
end;

function TCL3TrivectorHelper.Inverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Reverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Conjugate: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3TrivectorHelper.Reciprocal: TCL3Trivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3TrivectorHelper.Normalized: TCL3Trivector;
begin
  result := Self / Norm;
end;

function TCL3TrivectorHelper.Norm: double;
begin
  result := abs(fm123);
end;

function TCL3TrivectorHelper.SquaredNorm: double;
begin
  result := fm123 * fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TVector): TCL3Bivector;
begin
  result.fm12 :=  fm123 * AVector.fm3;
  result.fm13 := -fm123 * AVector.fm2;
  result.fm23 :=  fm123 * AVector.fm1;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Bivector): TVector;
begin
  result.fm1 := -fm123 * AVector.fm23;
  result.fm2 :=  fm123 * AVector.fm13;
  result.fm3 := -fm123 * AVector.fm12;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Trivector): double;
begin
  result := -fm123 * AVector.fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm123 * AVector.fm23;
  result.fm2   :=  fm123 * AVector.fm13;
  result.fm3   := -fm123 * AVector.fm12;
  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TVector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Projection(const AVector: TVector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // inplicit ExtracTCL3Trivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TVector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TVector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TVector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := Math.SameValue(0.0,   AValue.fm0  ) and
            Math.SameValue(0.0,   AValue.fm1  ) and
            Math.SameValue(0.0,   AValue.fm2  ) and
            Math.SameValue(0.0,   AValue.fm3  ) and
            Math.SameValue(0.0,   AValue.fm12 ) and
            Math.SameValue(0.0,   AValue.fm13 ) and
            Math.SameValue(0.0,   AValue.fm23 ) and
            Math.SameValue(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := Math.SameValue(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.ToString(APrecision, ADigits: longint): string;
begin
  if not Math.SameValue(fm123, 0.0) then
    result := Fmt(fm123, APrecision, ADigits) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToString: string;
begin
  if not Math.SameValue(fm123, 0.0) then
    result := Fmt(fm123) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := fm123;
end;

// TCL3BivectorHelper

function TCL3BivectorHelper.Dual: TVector;
begin
  result.fm1 := -fm23;
  result.fm2 :=  fm13;
  result.fm3 := -fm12;
end;

function TCL3BivectorHelper.Inverse: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3BivectorHelper.Conjugate: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reverse: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reciprocal: TCL3Bivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3BivectorHelper.Normalized: TCL3Bivector;
begin
  result := Self / Norm;
end;

function TCL3BivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3BivectorHelper.SquaredNorm: double;
begin
  result := fm12*fm12 + fm13*fm13 + fm23*fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TVector): TVector;
begin
  result.fm1 :=  fm12 * AVector.fm2
                +fm13 * AVector.fm3;

  result.fm2 :=  fm23 * AVector.fm3
                -fm12 * AVector.fm1;

  result.fm3 := -fm13 * AVector.fm1
                -fm23 * AVector.fm2;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Bivector): double;
begin
  result := -fm12 * AVector.fm12
            -fm13 * AVector.fm13
            -fm23 * AVector.fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Trivector): TVector;
begin
  result.fm1 := -fm23 * AVector.fm123;
  result.fm2 :=  fm13 * AVector.fm123;
  result.fm3 := -fm12 * AVector.fm123;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm12 * AVector.fm12
                  -fm13 * AVector.fm13
                  -fm23 * AVector.fm23;

  result.fm1   :=  fm12 * AVector.fm2
                  -fm23 * AVector.fm123
                  +fm13 * AVector.fm3;

  result.fm2   := -fm12 * AVector.fm1
                  +fm13 * AVector.fm123
                  +fm23 * AVector.fm3;

  result.fm3   := -fm12 * AVector.fm123
                  -fm23 * AVector.fm2
                  -fm13 * AVector.fm1;

  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;
  result.fm123 :=  0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TVector): TCL3Trivector;
begin
  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;

  result.fm123 :=  fm12 * AVector.fm3
                  +fm23 * AVector.fm1
                  -fm13 * AVector.fm2;
end;

function TCL3BivectorHelper.Projection(const AVector: TVector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection(const AVector: TVector): TCL3Bivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TVector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TVector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := Math.SameValue(0.0,  AValue.fm0  ) and
            Math.SameValue(0.0,  AValue.fm1  ) and
            Math.SameValue(0.0,  AValue.fm2  ) and
            Math.SameValue(0.0,  AValue.fm3  ) and
            Math.SameValue(fm12, AValue.fm12 ) and
            Math.SameValue(fm13, AValue.fm13 ) and
            Math.SameValue(fm23, AValue.fm23 ) and
            Math.SameValue(0.0,  AValue.fm123);
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := Math.SameValue(fm12, AValue.fm12) and
            Math.SameValue(fm13, AValue.fm13) and
            Math.SameValue(fm23, AValue.fm23);
end;

function TCL3BivectorHelper.ExtracTCL3Bivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  Result := NullBivector;
  if mcm12 in AComponents then result.fm12 := fm12;
  if mcm13 in AComponents then result.fm13 := fm13;
  if mcm23 in AComponents then result.fm23 := fm23;
end;

function TCL3BivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm12, 0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not Math.SameValue(fm13, 0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e13 ';
  if not Math.SameValue(fm23, 0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm12, 0.0) then result := result + Fmt(fm12) + 'e12 ';
  if not Math.SameValue(fm13, 0.0) then result := result + Fmt(fm13) + 'e13 ';
  if not Math.SameValue(fm23, 0.0) then result := result + Fmt(fm23) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := fm12;
  result.fm13  := fm13;
  result.fm23  := fm23;
  result.fm123 := 0.0;
end;

// TVectorHelper

function TVectorHelper.Dual: TCL3Bivector;
begin
  result.fm12 :=  fm3;
  result.fm13 := -fm2;
  result.fm23 :=  fm1;
end;

function TVectorHelper.Inverse: TVector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TVectorHelper.Reverse: TVector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TVectorHelper.Conjugate: TVector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TVectorHelper.Reciprocal: TVector;
begin
  result := Reverse / SquaredNorm;
end;

function TVectorHelper.Normalized: TVector;
begin
  result := Self / Norm;
end;

function TVectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TVectorHelper.SquaredNorm: double;
begin
  result := fm1*fm1 + fm2*fm2 + fm3*fm3;
end;

function TVectorHelper.Dot(const AVector: TVector): double;
begin
 result :=  fm1 * AVector.fm1
           +fm2 * AVector.fm2
           +fm3 * AVector.fm3;
end;

function TVectorHelper.Dot(const AVector: TCL3Bivector): TVector;
begin
  result.fm1 := -fm3 * AVector.fm13
                -fm2 * AVector.fm12;

  result.fm2 :=  fm1 * AVector.fm12
                -fm3 * AVector.fm23;

  result.fm3 :=  fm2 * AVector.fm23
                +fm1 * AVector.fm13;
end;

function TVectorHelper.Dot(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  fm3 * AVector.fm123;
  result.fm13 := -fm2 * AVector.fm123;
  result.fm23 :=  fm1 * Avector.fm123;
end;

function TVectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm1 * AVector.fm1
                  +fm2 * AVector.fm2
                  +fm3 * AVector.fm3;

  result.fm1   :=  fm1 * AVector.fm0
                  -fm2 * AVector.fm12
                  -fm3 * AVector.fm13;

  result.fm2   :=  fm1 * AVector.fm12
                  +fm2 * AVector.fm0
                  -fm3 * AVector.fm23;

  result.fm3   :=  fm1 * AVector.fm13
                  +fm2 * AVector.fm23
                  +fm3 * AVector.fm0;

  result.fm12  :=  fm3 * AVector.fm123;
  result.fm13  := -fm2 * AVector.fm123;
  result.fm23  :=  fm1 * Avector.fm123;
  result.fm123 :=  0.0;
end;

function TVectorHelper.Wedge(const AVector: TVector): TCL3Bivector;
begin
  result.fm12 :=  fm1 * AVector.fm2
                 -fm2 * AVector.fm1;

  result.fm13 :=  fm1 * AVector.fm3
                 -fm3 * AVector.fm1;

  result.fm23 :=  fm2 * AVector.fm3
                 -fm3 * AVector.fm2;
end;

function TVectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TVectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TVectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm1 * AVector.fm0;
  result.fm2   :=  fm2 * AVector.fm0;
  result.fm3   :=  fm3 * AVector.fm0;

  result.fm12  :=  fm1 * AVector.fm2
                  -fm2 * AVector.fm1;

  result.fm13  :=  fm1 * AVector.fm3
                  -fm3 * AVector.fm1;

  result.fm23  :=  fm2 * AVector.fm3
                  -fm3 * AVector.fm2;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TVectorHelper.Projection(const AVector: TVector): TVector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Projection(const AVector: TCL3Bivector): TVector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Projection(const AVector: TCL3Trivector): TVector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Rejection(const AVector: TVector): TVector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function  TVectorHelper.Rejection(const AVector: TCL3Bivector): TVector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TVectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Reflection(const AVector: TVector): TVector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TVectorHelper.Reflection(const AVector: TCL3Bivector): TVector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TVectorHelper.Reflection(const AVector: TCL3Trivector): TVector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TVectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TVector): TVector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TVector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TVector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TVectorHelper.Cross(const AVector: TVector): TVector;
begin
  result.fm1 :=  fm2*AVector.fm3
                -fm3*AVector.fm2;

  result.fm2 :=  fm1*AVector.fm3
                -fm3*AVector.fm1;

  result.fm3 :=  fm1*AVector.fm2
                -fm2*AVector.fm1;
end;

function TVectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := Math.SameValue(0.0, AValue.fm0  ) and
            Math.SameValue(fm1, AValue.fm1  ) and
            Math.SameValue(fm2, AValue.fm2  ) and
            Math.SameValue(fm3, AValue.fm3  ) and
            Math.SameValue(0.0, AValue.fm12 ) and
            Math.SameValue(0.0, AValue.fm13 ) and
            Math.SameValue(0.0, AValue.fm23 ) and
            Math.SameValue(0.0, AValue.fm123);
end;

function TVectorHelper.SameValue(const AValue: TVector): boolean;
begin
  result := Math.SameValue(fm1, AValue.fm1) and
            Math.SameValue(fm2, AValue.fm2) and
            Math.SameValue(fm3, AValue.fm3);
end;

function TVectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TVector;
begin
  Result := NullVector;
  if mcm1 in AComponents then result.fm1 := fm1;
  if mcm2 in AComponents then result.fm2 := fm2;
  if mcm3 in AComponents then result.fm3 := fm3;
end;


function TVectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm1, 0.0) then result := result + Fmt(fm1,  APrecision, ADigits) + 'e1 ';
  if not Math.SameValue(fm2, 0.0) then result := result + Fmt(fm2,  APrecision, ADigits) + 'e2 ';
  if not Math.SameValue(fm3, 0.0) then result := result + Fmt(fm3,  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TVectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm1, 0.0) then result := result + Fmt(fm1) + 'e1 ';
  if not Math.SameValue(fm2, 0.0) then result := result + Fmt(fm2) + 'e2 ';
  if not Math.SameValue(fm3, 0.0) then result := result + Fmt(fm3) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TVectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := fm1;
  result.fm2   := fm2;
  result.fm3   := fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

// TCL3Versors

class operator TCL3Versor1.*(const AValue: double; const ASelf: TCL3Versor1): TVector;
begin
  result.fm1 := AValue;
  result.fm2 := 0.0;
  result.fm3 := 0.0;
end;

class operator TCL3Versor2.*(const AValue: double; const ASelf: TCL3Versor2): TVector;
begin
  result.fm1 := 0.0;
  result.fm2 := AValue;
  result.fm3 := 0.0;
end;

class operator TCL3Versor3.*(const AValue: double; const ASelf: TCL3Versor3): TVector;
begin
  result.fm1 := 0.0;
  result.fm2 := 0.0;
  result.fm3 := AValue;
end;

// TCL3Biversors

class operator TCL3Biversor12.*(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector;
begin
  result.fm12 := AValue;
  result.fm13 := 0.0;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor13.*(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := AValue;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor23.*(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := 0.0;
  result.fm23 := AValue;
end;

// TCL3Triversor

class operator TCL3Triversor123.*(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector;
begin
  result.fm123 := AValue;
end;


