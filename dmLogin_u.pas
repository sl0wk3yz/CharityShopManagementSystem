unit dmLogin_u;

interface

uses          //adding ADODB and DB library files to allow access to databases
  System.SysUtils, System.Classes, ADODB, DB;

type
  TdmLogIn = class(TDataModule)
    procedure DataModuleSetUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   conLogin : TADOConnection;     //connecting to database
   tblLogin : TADOTable;          //connecting to table in database
   dscLogin : TDataSource;
  end;

var
  dmLogIn: TdmLogIn;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmLogIn.DataModuleSetUp(Sender: TObject);
begin
 //instantiate the objects
 conLogin := TADOConnection.Create(dmLogIn);
 tblLogin := TADOTable.Create(dmLogIn);
 dscLogin := TDataSource.Create(dmLogin);
 //setting up connection
 conLogin.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=AdminLogin.mdb;Mode=ReadWrite;Persist Security Info=False';
 conLogin.LoginPrompt:=False;
 conLogin.Open;
 //setup table
 tblLogin.Connection := conLogin;
 tblLogin.TableName := 'Admin';
 //setup DataSOurce
 dscLogin.DataSet:= tblLogin;

 tblLogin.Open; //opening the table in the database
end;

end.
