unit dmDonersDynamic_u;

interface

uses
  System.SysUtils, System.Classes, ADODB, DB, Windows;
                                   //Database library files to connect.
type
  TdmDonersDynamic = class(TDataModule)
    procedure DataModuleSetUp(Sender: TObject);
     //procedure to dynamically create query
    procedure DataModuleQuerySetUp(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //Declare my objects.
    conDoner : TADOConnection;    {Connects to the database}

    {Connects to the tables in the database.}
    tblDonerInfo: TADOTable;
    tblDonationInfo: TADOTable;
    {Connects components to tables.}
    dscDonerInfo: TDataSource;
    dscDonationInfo: TDataSource;

    //Dynamic creation of ADOQueries to be used for SQL statements.
    qryDonerInfo : TADOQuery; //for ADOQuery setup
    dscQueryDonerInfo: TDataSource;

    //restoring database
    procedure RestoreDB;
  end;

var
  dmDonersDynamic: TdmDonersDynamic;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDonersDynamic.DataModuleQuerySetUp(Sender: TObject);
begin
  //Create the ADOQuery objects
  qryDonerInfo := TADOQuery.Create(dmDonersDynamic);
  dscQueryDonerInfo.Create(dmDonersDynamic);

  //connect ADOQUery to connection
  qryDonerInfo.Connection := conDoner;

  //connect DataSource to the ADOQuery
  dscQueryDonerInfo.DataSet := qryDonerInfo;
end;

procedure TdmDonersDynamic.DataModuleSetUp(Sender: TObject);
begin
//Instantiating the objects.
conDoner := TADOConnection.Create(dmDonersDynamic) ;
tblDonerInfo := TADOTable.Create(dmDonersDynamic) ;
tblDonationInfo := TADOTable.Create(dmDonersDynamic) ;
dscDonerInfo := TDataSource.Create(dmDonersDynamic) ;
dscDonationInfo := TDataSource.Create(dmDonersDynamic) ;

//Setting up the connection
conDoner.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=DonorsInformation.mdb;Mode=ReadWrite;Persist Security Info=False' ;
conDoner.LoginPrompt := FALSE;
conDoner.Open;

//Setting up the tables.
tblDonerInfo.Connection := conDoner;
tblDonationInfo.Connection := conDoner;

tblDonerInfo.TableName := 'DonerInformation';
tblDonationInfo.TableName := 'DonationInformation';

//Setup the DataSource
dscDonerInfo.DataSet := tblDonerInfo;
tblDonerInfo.Open;
dscDonationInfo.DataSet := tblDonationInfo;
tblDonationInfo.Open;
end;

procedure TdmDonersDynamic.RestoreDB;
var bFail: Boolean;
begin
  (*restoring the database*)
  conDoner.Close;
  tblDonerInfo.Destroy;
  tblDonationInfo.Destroy;
  DeleteFile('DonorsInformation.mdb');
  CopyFile('DonorsInformationBackUp.mdb','DonorsInformation.mdb',bFail);

  DataModuleSetUp(dmDonersDynamic);
end;

end.
