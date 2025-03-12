unit clsPAT2021;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Math;
type
  TPAT2021 = class(TObject)
   private
    fMonDoners:Integer;
    fFirstName, fLastName, fEmail :String;
   public
   constructor Create(sFirstName, sLastName, sEmail:String);
   function toString(A,B:String): String;
   function getMonthlyDoners(Number:Integer) : Integer;
   function getEmail(this:String): String;
   function calcRand(Variable:Real) : Real;
   function calcPound(Variable2:Real) : Real;
   function calcEuro(Variable3:Real) : Real;
end;
implementation

{ TPAT2021 }


function TPAT2021.calcEuro(Variable3: Real): Real;
begin
  Result := 1/Variable3;
end;

function TPAT2021.calcPound(Variable2: Real): Real;
begin
  Result := 1/Variable2;
end;

function TPAT2021.calcRand(Variable: Real): Real;
begin
  Result := 1/Variable;
end;

constructor TPAT2021.Create(sFirstName, sLastName, sEmail: String);
begin
  fFirstName := sFirstName;
  fLastName := sLastName;
  fEmail := sEmail;
end;

function TPAT2021.getEmail(this:String): String;
begin
  Result := this+#9;
end;

function TPAT2021.getMonthlyDoners(Number: Integer): Integer;
begin
  Result := Number;
end;

function TPAT2021.toString(A,B:String): String;
begin
  Result := 'Thank you for your support '+A +' '+B +#13+
             'Write us a review of the program.';
end;

end.
