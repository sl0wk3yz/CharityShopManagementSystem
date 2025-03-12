unit Paywall;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, clsPAT2021, DateUtils, Math, dmDonersDynamic_u, Vcl.Buttons;
                    {Path to the class}    {To access the monthly donation boolean}
type
  TfrmPayWall = class(TForm)
    TabControl1: TTabControl;
    lblPayment: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCardNumber: TEdit;
    edtExpiration: TEdit;
    edtSecurityNumber: TEdit;
    edtNameOnCard: TEdit;
    cbxCountryRegion: TComboBox;
    lblEmail: TLabel;
    edtEmail: TEdit;
    Image1: TImage;
    Button1: TButton;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    BackBtn: TButton;
    cbxCurrencies: TComboBox;
    SubmitReview: TButton;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SubmitReviewClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DollarPrice: Real;
    Rand, Euro, GBP : Real;
  end;

var
  frmPayWall: TfrmPayWall;

implementation
uses DonationPg_u, AdminPage, dmDoners_u;    {only way to connect forms both ways
                      without enducing a circular circuit Error}
var
  arrCompliments: array[1..4] of String =('Your thoughtfulness is a gift they will always treasure',
                                            'You are the best!',
                                            'Sometimes the simplest things mean the most.',
                                            'We are truly greatful.');
      {Defaulted compliments stored in a string array with an index of 4 }
  oItem : TPAT2021;
{$R *.dfm}

procedure TfrmPayWall.BackBtnClick(Sender: TObject);
begin
 //frmPayWall.Close;
 frmDonationsPg.Show;
 Self.Close;
end;

procedure TfrmPayWall.FormCreate(Sender: TObject);
var oItem : TPAT2021;
begin
   {Instantiating the object.}
  oItem := TPAT2021.Create(frmDonationsPg.FirstName,frmDonationsPg.LastName,
                           frmDonationsPg.eMail);
  edtEmail.Text := oItem.getEmail(frmDonationsPg.Email) ;
end;

procedure TfrmPayWall.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/TabControl1.Width, ClientHeight/TabControl1.Height);
  TabControl1.ScaleBy(Trunc(Ratio * 100), 100);
end;

procedure TfrmPayWall.BitBtn1Click(Sender: TObject);
begin
//Closes the application.
Application.Terminate;
end;

procedure TfrmPayWall.Button1Click(Sender: TObject);
 begin
                           //updating foreign exchange at random
  Rand := RandomRange(60,79)/1000;   {R1 may range anywhere between $0,06 to $0,079}
  Euro := RandomRange(107,123)/100;  //1EURO may range anywhere betwwen $1,07 to $1,23
  GBP := RandomRange(121,167)/100;   (*1GBP may range anywhere between $1,21 and $1,67*)

  case cbxCurrencies.ItemIndex of
    0 : DollarPrice :=  GBP*SpinEdit1.Value;
    1 : DollarPrice :=  Euro*SpinEdit1.Value;
    2 : DollarPrice :=  Rand*SpinEdit1.Value;
    3 : DollarPrice :=  SpinEdit1.Value;
  end;

    {Displaying suitable message if not all mandatory data is entered}
  if (edtCardNumber.Text='') OR (SpinEdit1.Value=0) then
 begin
   MessageDLg('Invalid input',mtError,[mbOK],0);
 end else
 begin   {Validation checking for card number, security number and expiration date.}

   if (edtExpiration.Text[1] IN ['0'..'9']) AND (edtExpiration.Text[2] IN ['0'..'9'])
   AND (edtExpiration.Text[4] IN ['0'..'9']) AND (edtExpiration.Text[5] IN ['0'..'9'])
   AND (edtExpiration.Text[3] = '/') AND (Length(edtExpiration.Text) = 5) then
   begin
     if Length(edtSecurityNumber.Text)=3 then
     begin
       if Length(edtCardNumber.Text)=12  then
       begin    {save their information to the database}
            with dmDonersDynamic do
        begin
          tblDonationInfo.Insert;
          tblDonationInfo['ID']:=frmDonationsPg.iMax+1;
          tblDonationInfo['DonationAmount($)']:=FloatToStrF(DollarPrice,ffFixed,8,2);
          tblDonationInfo['DateOfDonation']:=DateToStr(Date);
          tblDonationInfo['TimeOfDonation']:=TimeToSTr(Time);
          tblDonationInfo['ExpirationDate']:= edtExpiration.Text;
          tblDonationInfo['CardNumber']:= edtCardNumber.Text;
          tblDonationInfo['SecurityNumber']:= edtSecurityNumber.Text;
           if bMonthly = True then
          begin
           tblDonationInfo['MonthlyDonation']:=True;
         end else
         tblDonationInfo['MonthlyDonation']:=False;
           tblDonationInfo.Post;
         end;  //end of with
           MessageDlg(arrCompliments[RandomRange(1,4)],mtInformation,[mbOK], 0);

            ShowMessage(oItem.toString(frmDonationsPg.FirstName,frmDonationsPg.LastName) );
            SubmitReview.Visible := True;

       end else
       ShowMessage('Card number not correct. Make sure it consists of 12 digits without spaces in between');
     end else
       MessageDlg('Invalid Security number.',mtError,[mbOK],0);
   end else
   MessageDlg('Invalid expiration date.',mtError,[mbOK],0);


 end;

 
end;

procedure TfrmPayWall.SubmitReviewClick(Sender: TObject);
var
  Review: String;
  ReviewFile : Textfile;
begin
  Review := InputBox('Write a review','Please tell us what you think about the program','');

  AssignFile(ReviewFile,'Reviews.txt') ;

  if FileExists( 'Reviews.txt' ) = True then
   Append(ReviewFile)
  else
   Rewrite(ReviewFile);

   Writeln(ReviewFile,frmDonationsPg.FirstName +' '+ frmDonationsPg.LastName);
   Writeln(ReviewFile,' "'+Review+'" '+#13);
   CloseFile(ReviewFile);

   ShowMessage('Thank you for your input.');


end;

end.
