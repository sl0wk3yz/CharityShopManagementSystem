unit dmDoners_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmDoners = class(TDataModule)
    conDoner: TADOConnection;
    tblDonerInfo: TADOTable;
    dscDonerInfo: TDataSource;
    tblDonationInfo: TADOTable;
    dscDonationInfo: TDataSource;
    //procedure to dynamically create query
    procedure DataModuleQuerySetUp(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //DYnamic creation of ADOQueries to be used for SQL statements.
    qryDonerInfo : TADOQuery; //for ADOQuery setup
    dscQueryDonerInfo: TDataSource;
  end;

var
  dmDoners: TdmDoners;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TdmDoners }

procedure TdmDoners.DataModuleQuerySetUp(Sender: TObject);
begin
  //Create the ADOQuery objects
  qryDonerInfo := TADOQuery.Create(dmDOners);
  dscQueryDonerInfo.Create(dmDoners);

  //connect ADOQUery to connection
  qryDonerInfo.Connection := conDoner;

  //connect DataSource to the ADOQuery
  dscQueryDonerInfo.DataSet := qryDonerInfo;
end;

end.
