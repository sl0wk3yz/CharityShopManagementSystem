unit DonationPg_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.Buttons, Paywall, clsPAT2021, dmDonersDynamic_u, Math;

type
  TfrmDonationsPg = class(TForm)
    pgcDonations: TPageControl;
    Payment: TTabSheet;
    Image1: TImage;
    btnOnceOff: TButton;
    Monthly: TButton;
    Information: TTabSheet;
    Image2: TImage;
    lblTitle: TLabel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblEMail: TLabel;
    lblContactNo: TLabel;
    lblPostCode: TLabel;
    lblAdress: TLabel;
    lblAdress2: TLabel;
    lblTownCity: TLabel;
    lblCountry: TLabel;
    edtFirstName: TEdit;
    edteMail: TEdit;
    edtLastName: TEdit;
    edtAdress2: TEdit;
    edtPostCode: TEdit;
    edtContactNo: TEdit;
    edtAdress: TEdit;
    edtTownCity: TEdit;
    cbxTitle: TComboBox;
    cbxCountry: TComboBox;
    btnNext: TButton;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    bmbBack2Welcome: TBitBtn;
    bmbBack: TBitBtn;
    btnBack: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure MonthlyClick(Sender: TObject);
    procedure btnOnceOffClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
   // procedure bmbBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MonthlyDoners:Integer;
     iMax:Integer;
     FirstName, LastName, Email: String;
  end;

var
  frmDonationsPg: TfrmDonationsPg;
  bMonthly:Boolean;
implementation
 uses WelcomePg;     {only way to connect forms both ways
                      without enducing a circular circuit Error}
{$R *.dfm}

procedure TfrmDonationsPg.BitBtn1Click(Sender: TObject);
begin
 //Return to main form.
 frmWelcomePage.Show;
 Self.Close;
end;

procedure TfrmDonationsPg.BitBtn2Click(Sender: TObject);
begin
//Closes the application.
Application.Terminate;
end;

procedure TfrmDonationsPg.BitBtn3Click(Sender: TObject);
begin
  //Clearing everything and setting focus to edtFirstName so that user can start over.
  cbxTitle.ItemIndex:= -1;
  cbxCountry.ItemIndex:= -1;
  edtFirstName.Text:= '';
  edteMail.Text:='';
  edtLastName.Text:='';
  edtAdress.Text:='';
  edtAdress2.Text:='';
  edtPostCode.Text:='';
  edtContactNo.Text := '';
  edtTownCity.Text:='';

  edtFirstName.SetFocus;
end;

procedure TfrmDonationsPg.btnBackClick(Sender: TObject);
begin
 //PageControl1.SelectNextPage(True);
 pgcDonations.TabIndex := 0;
end;

procedure TfrmDonationsPg.btnNextClick(Sender: TObject);
begin
  FirstName:= edtFirstName.Text;
  lastname:= edtLastName.Text;
  email:= edteMail.Text;
  {Finding the maximum vaue of the key field, ID, so that i can add 1 to it
  when inserting new records.}
  with dmDonersDynamic do
  begin
    iMax:= -10;

    tblDonerInfo.First;
    while NOT tblDonerInfo.Eof do
    begin
      if tblDonerInfo['ID']>iMax then
      begin
        iMax:= tblDonerInfo['ID'];
      end;
        tblDonerInfo.Next;
    end;

  end;

  if (edtFirstName.Text='')OR(edtLastName.Text='')OR(edteMail.Text='')OR
      (edtContactNo.Text='')OR(edtPostCode.Text='')OR(edtAdress.Text='')OR
      (edtTownCity.Text='')  then
      begin
        ShowMessage('Not all required information entered.');
        edtFirstName.Clear;
        edtLastName.Clear;
        edteMail.Clear;
        edtContactNo.Clear;
        edtPostCode.Clear;
        edtAdress.Clear;
        edtAdress2.Clear;
        edtTownCity.Clear;
        edtFirstName.SetFocus;
      end else
      begin
        with dmDonersDynamic do    {Adding the data to the table in the database.}
        begin
          tblDonerInfo.Insert;
          tblDonerInfo['ID']:= iMax+1;
          tblDonerInfo['Title']:= cbxTitle.Text ;
          tblDonerInfo['FirstName']:= edtFirstName.Text;
          tblDonerInfo['LastName']:= edtLastName.Text;
          tblDonerInfo['Email']:= edteMail.Text;
          tblDonerInfo['PostCode']:= edtPostCode.Text;
          tblDonerInfo['Adress']:=  edtAdress.Text;
          tblDonerInfo['Adress2']:= edtAdress2.Text;
          tblDonerInfo['Town/City']:= edtTownCity.Text;
          tblDonerInfo['Country']:= cbxCountry.Text;
          tblDonerInfo['ContactNumber']:=edtContactNo.Text;
          tblDonerInfo.Post;
        end;

        frmPayWall.Show;      {Going to the next form.}
        frmDonationsPg.Hide;
      end;


end;

procedure TfrmDonationsPg.btnOnceOffClick(Sender: TObject);
begin
  //publicly declared variable is true only when <Monthly> button is clicked
  bMonthly:= False;
  //Next tabsheet
  pgcDonations.TabIndex := 1;
end;

procedure TfrmDonationsPg.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/pgcDonations.Width, ClientHeight/pgcDonations.Height);
  pgcDonations.ScaleBy(Trunc(Ratio * 100), 100);
end;

procedure TfrmDonationsPg.MonthlyClick(Sender: TObject);
begin
  //Initiating monthly doners to zero
  MonthlyDoners:= 0;

  //publicly declared variable is true only when <Monthly> button is clicked
  bMonthly := True;

  //Next tabsheet
  pgcDonations.TabIndex := 1;

  //adding on to monthly doners everytime <Monthly> is clicked
  MonthlyDoners:= MonthlyDoners+1;
end;

end.
