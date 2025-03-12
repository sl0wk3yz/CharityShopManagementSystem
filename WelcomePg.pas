unit WelcomePg;     {17300 Lwazi Selepe}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, clsPAT2021, ExtCtrls, StdCtrls, Buttons, pngimage, ComCtrls,
  DonationPg_U, Vcl.Imaging.jpeg, dmLogin_u, Login_u, dmDonersDynamic_u, Video;
{     ^                                       ^         
      ^                                       ^
[to connect to donation form]       [To take admin to login page]}                                    
type
  TfrmWelcomePage = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    AboutUs: TTabSheet;
    Image1: TImage;
    Label1: TLabel;
   // cbxAboutUs: TComboBox;
    cbxGetInvolved: TComboBox;
    btnDonate: TButton;
    bmbHelp: TBitBtn;
    bmbClose: TBitBtn;
    Image2: TImage;
    lblMission: TLabel;
    Line1: TLinkLabel;
    Line2: TLabel;
    lblValues: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnAbout: TButton;
    Back: TButton;
    Label4: TLabel;
    Image3: TImage;
    lblEmai: TLabel;
    lblTel: TLabel;
    procedure FormResize(Sender: TObject);
    procedure Shape1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure btnDonateClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure cbxGetInvolvedChange(Sender: TObject);
    //procedure cbxAboutUsSelect(Sender: TObject);
    {procedure lblAboutMouseEnter(Sender: TObject);
    procedure lblAboutMouseLeave(Sender: TObject);
    procedure lblAboutClick(Sender: TObject); }
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcomePage: TfrmWelcomePage;

implementation

{$R *.dfm}

procedure TfrmWelcomePage.BackClick(Sender: TObject);
begin
  {First tab sheet to be visible when program is launched}
  PageControl1.TabIndex:= 0;
end;

procedure TfrmWelcomePage.btnAboutClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
 (*dynamically create contact info pic and contact information.*)
end;

procedure TfrmWelcomePage.btnDonateClick(Sender: TObject);
begin
  (*When Donate button is clicked, user is taken to the relevant form*)
  frmDonationsPg.Show;
  //making sure that the first tab sheet of the form is shown to user.
   frmDonationsPg.pgcDonations.TabIndex := 0;
   frmWelcomePage.Hide;
end;

procedure TfrmWelcomePage.cbxGetInvolvedChange(Sender: TObject);
begin
     //Contact info is chosen
  if cbxGetInvolved.ItemIndex=1 then
  begin
    {Go to relevant tabsheet}
    PageControl1.TabIndex:= 1;
    {Make all contact information components visible}
    Image3.Visible := True;
    lblEmai.Visible := True;
    lblTel.Visible := True;
  end;

  if cbxGetInvolved.ItemIndex=0 then
  begin
    frmVideo.Show;
    frmWelcomePage.Hide;
    frmVideo.WindowsMediaPlayer1.Controls.Play;
  end;

end;

{procedure TfrmWelcomePage.cbxAboutUsSelect(Sender: TObject);
begin
 dynamically create contact info pic and contact information.
end; }

procedure TfrmWelcomePage.FormActivate(Sender: TObject);
begin
   {When project is launched, the main tabsheet mst be visible to the user}
  PageControl1.TabIndex:= 0;
   {Making the database table active so they can be interacted with by the program}
  with dmDonersDynamic do
  begin
    tblDonerInfo.Active := True;
    tblDonationInfo.Active := True;
  end;
end;

procedure TfrmWelcomePage.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/PageControl1.Width, ClientHeight/PageControl1.Height);
  PageControl1.ScaleBy(Trunc(Ratio * 100), 100);
end;


procedure TfrmWelcomePage.Label4Click(Sender: TObject);
begin
   {When 'A', the admin prompt, is clicked. Then user is taken to an admin login}
  frmLogin.Show;
  frmWelcomePage.Hide;
end;

procedure TfrmWelcomePage.Shape1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
 showmessage(' h');
end;

end.
