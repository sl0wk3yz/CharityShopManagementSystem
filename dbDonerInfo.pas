unit dbDonerInfo;

interface

uses
  Windows, Math, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmDonersDynamic_u, Data.DB, DateUtils, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons;

type
  Tform5 = class(TForm)
    btnDelete: TButton;
    btnFilter: TButton;
    btnLocate: TButton;
    btnSort: TButton;
    bmbBack2Welcome: TBitBtn;
    Panel1: TPanel;
    DBNavDonor: TDBNavigator;
    DBGDonorInfo: TDBGrid;
    procedure btnSortClick(Sender: TObject);
    procedure btnLocateClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure bmbBack2WelcomeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form5: Tform5;

implementation
 uses AdminPage;     {only way to connect forms both ways
                      without enducing a circular circuit Error}
{$R *.dfm}

procedure Tform5.bmbBack2WelcomeClick(Sender: TObject);
begin
  frmAdminPage.Show;
  Self.Close;
end;

procedure Tform5.btnSortClick(Sender: TObject);
begin
  dmDonersDynamic.tblDonerInfo.Sort := InputBox('Sort by...','Enter field name','Country')+' ASC';
end;

procedure Tform5.btnLocateClick(Sender: TObject);
var
  Find, Field:String;
  Amount : Real;
begin
  Field := InputBox('Field name','Enter the field you are looking for.','LastName');
  Find := InputBox('Search','Enter your search.','');

  with dmDonersDynamic do
  begin
    if tblDonerInfo.Locate(Field,Find,[loCaseInsensitive,loPartialKey])=True then
   begin
    ShowMessage('Found.');
    if (Field = 'LastName') OR (Field='FirstName') then
      begin
        if MessageDlg('Donation Amount?',mtConfirmation,mbYesNo,0) = mrYes then
        begin
          tblDonationInfo.Filtered := False;
          tblDonationInfo.Filter:= 'ID ='+ QuotedStr(IntToStr(tblDonerInfo['ID']) );
          tblDonationInfo.Filtered := True;

          if tblDonationInfo['MonthlyDonation']='True' then
          begin
           Amount := StrToFloat(tblDonationInfo['DonationAmount']) *
                    (StrToDate(tblDonationInfo['DateOfDonation']) * MonthsBetween(Date(),StrToDate(tblDonationInfo['DateOfDonation'])) +1);

           ShowMessage(tblDonerInfo['FirstName']+' '+tblDonerInfo['LastName']+' has donated $'
            + FloatToStr(Amount) );
          end else
            ShowMessage(tblDonerInfo['FirstName']+' '+tblDonerInfo['LastName']+' has donated '
            +tblDonationInfo['DonationAmount']);
        end;
      end;

   end else
    MessageDlg('Not Found',mtError,[mbCancel],0);
  end;
end;

procedure Tform5.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete this record?',mtConfirmation,mbYesNo,0)=mrYes then
  begin
    if MessageDlg('Deleting a record is irreversible and will affect other table(s).',mtConfirmation,mbOKCancel,0)=mrOK then
    begin
      with dmDonersDynamic do
      begin
        tblDonationInfo.Filtered := False;
        tblDonationInfo.Filter:= 'ID ='+ QuotedStr(IntToStr(tblDonerInfo['ID']) );
        tblDonationInfo.Filtered := True;

        tblDonationInfo.Delete;
        tblDonationInfo.Filtered := False;

        tblDonerInfo.Delete;
        MessageDlg('Record was deleted along with corresponding record in other table(s).',mtInformation,[mbOK],0);
      end;
    end;
  end;
end;

procedure Tform5.btnFilterClick(Sender: TObject);
var
  Country:String;
begin
  Country:= InputBox('Country','Enter the name of the country you are looking for','');
  with dmDonersDynamic.tblDonerInfo do
  begin
    Filtered := False;
    Filter := 'Country ='+ QuotedStr(Country);
    Filtered := True;

    ShowMessage('This field contains '+IntToStr(RecordCount)+' record(s).')
  end;
end;

procedure Tform5.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/Panel1.Width, ClientHeight/Panel1.Height);
  Panel1.ScaleBy(Trunc(Ratio * 100), 100);
end;

procedure Tform5.FormShow(Sender: TObject);
begin
  dbgDonorInfo.DataSource := dmDonersDynamic.dscDonerInfo;
  DBNavDonor.DataSource := dmDonersDynamic.dscDonerInfo;

  dbgDonorInfo.Columns[0].Width := 20;
  dbgDonorInfo.Columns[1].Width := 50;
  dbgDonorInfo.Columns[2].Width := 160;
  dbgDonorInfo.Columns[3].Width := 160;
  dbgDonorInfo.Columns[4].Width := 260;
  dbgDonorInfo.Columns[5].Width := 100;
  dbgDonorInfo.Columns[6].Width := 180;
  dbgDonorInfo.Columns[7].Width := 180;
  dbgDonorInfo.Columns[8].Width := 140;
  dbgDonorInfo.Columns[9].Width := 180;
  dbgDonorInfo.Columns[10].Width := 260;
end;

end.
