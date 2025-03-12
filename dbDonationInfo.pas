unit dbDonationInfo;

interface

uses
  Windows, Messages, Math, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  dmDonersDynamic_u, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Samples.Spin;

type
  TForm4 = class(TForm)
    btnSort: TButton;
    btnFilter: TButton;
    btnDonerName: TButton;
    bmbBack2Welcome: TBitBtn;
    Panel1: TPanel;
    dbgDonationInfo: TDBGrid;
    DBNavDonation: TDBNavigator;
    bmbRestore: TBitBtn;
    procedure btnSortClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    {My own procedure for dynamic spin edit}
    procedure sedAmountWhenChanged(Sender:TObject);
    procedure bmbBack2WelcomeClick(Sender: TObject);
    procedure btnDonerNameClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bmbRestoreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  sedAmount: TSpinEdit ;   {Declaring the dynamic object.}
implementation
 uses AdminPage;     {only way to connect forms both ways
                      without enducing a circular circuit Error}
{$R *.dfm}

procedure TForm4.bmbBack2WelcomeClick(Sender: TObject);
begin
  frmAdminPage.Show;
  Self.Close;
end;

procedure TForm4.bmbRestoreClick(Sender: TObject);
begin     //database restoration.
  dmDonersDynamic.RestoreDB;
  FormShow(bmbRestore);
end;

procedure TForm4.btnDonerNameClick(Sender: TObject);
begin
  with dmDonersDynamic do
  begin
   qryDonerInfo.Active := False; {Closing/Deactivating query}
   qryDonerInfo.SQL.Text := 'SELECT * FROM DonationInformation WHERE DonerInformation.ID = DOnationInformation.ID AND DonationInformation.FirstName ='+ QuotedStr(InputBox('first name','Enter first name',''))+'AND DOnationInformation.FirstName ='+ QuotedStr(InputBox('last name','Enter last name',''));
   qryDonerInfo.Open; (*Opening so that query can be run*)
  end;
end;

procedure TForm4.btnFilterClick(Sender: TObject);

begin
  { The value that is inserted int the spinedit will then be compared to
   values in the DonationAmount field, records with equal or more value will be
   displayed.}

   with dmDonersDynamic.tblDonationInfo do
  begin
    Filtered := False;
    Filter := 'DonationAmount($) >='+ QuotedSTr(FloatToStrF(StrToFloat(InputBox('Donation amount','Enter amount','')),ffFixed,9,2));
    Filtered := True;

    ShowMessage('This field contains '+IntToStr(RecordCount)+' records.')
  end;
end;

procedure TForm4.sedAmountWhenChanged(Sender: TObject);
begin
  {When btnFilter is clicked, a spinedit will be dynamically created.
   The value that is inserted int the spinedit will then be compared to
   values in the DonationAmount field, records with equal or more value will be
   displayed.}
   with dmDonersDynamic.tblDonationInfo do
  begin
    Filtered := False;
    Filter := 'DonationAmount >='+ QuotedSTr(IntToSTr(sedAmount.Value));
    Filtered := True;

    ShowMessage('This field contains '+IntToStr(RecordCount)+' records.')
  end;
end;

procedure TForm4.btnSortClick(Sender: TObject);
begin
  if MessageDlg('Ascending order(Yes) or Descending order(No)',mtConfirmation
  ,[mbYes,mbNo,mbCancel],0) = mrYes then
  begin
    with dmDonersDynamic.tblDonationInfo do
    begin
      Filtered := False;
      Filter := 'SELECT * FROM tblDonationInfo ORDER BY DonationAmount($) ASC';
      Filtered := True;
    end;
  end else
    with dmDonersDynamic.tblDonationInfo do
    begin
      Filtered := False;
      Filter := 'SELECT * FROM tblDonationInfo ORDER BY DonationAmount($) DESC';
      Filtered := True;
    end;
end;

procedure TForm4.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/Panel1.Width, ClientHeight/Panel1.Height);
  Panel1.ScaleBy(Trunc(Ratio * 100), 100);
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  dbgDonationInfo.DataSource := dmDonersDynamic.dscDonationInfo;
  DBNavDonation.DataSource := dmDonersDynamic.dscDonationInfo;
  dbgDonationInfo.Columns[0].Width := 20;
  dbgDonationInfo.Columns[1].Width := 80;
  dbgDonationInfo.Columns[2].Width := 120;
  dbgDonationInfo.Columns[3].Width := 140;
  dbgDonationInfo.Columns[4].Width := 140;
  dbgDonationInfo.Columns[5].Width := 160;
  dbgDonationInfo.Columns[6].Width := 160;
  dbgDonationInfo.Columns[7].Width := 160;
end;

end.
