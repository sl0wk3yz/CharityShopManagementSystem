unit AdminPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbDonerInfo, dbDonationInfo,
  Vcl.StdCtrls, Vcl.Buttons, Math, clsPAT2021,DonationPg_U, Vcl.ExtCtrls;

type
  TfrmAdminPage = class(TForm)
    btnDonationInfo: TButton;
    btnDonerInfo: TButton;
    btnUpdateCurrencies: TButton;
    gpbExRate: TGroupBox;
    lblDollar: TLabel;
    lblEuro: TLabel;
    lblPound: TLabel;
    edtRandToDollar: TEdit;
    edtEuroToDollar: TEdit;
    edtPoundToDollar: TEdit;
    lblMonthlyDoners: TLabel;
    edtNumMonthlyDoners: TEdit;
    bmbBack2Welcome: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    procedure btnDonationInfoClick(Sender: TObject);
    procedure btnDonerInfoClick(Sender: TObject);
    procedure bmbBack2WelcomeClick(Sender: TObject);
    procedure btnUpdateCurrenciesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Rand, Euro, GBP : Real;
  end;

var
  frmAdminPage: TfrmAdminPage;

implementation
 uses Login_u, Paywall;     {only way to connect forms both ways
                      without enducing a circular circuit Error}
{$R *.dfm}

procedure TfrmAdminPage.bmbBack2WelcomeClick(Sender: TObject);
begin
  {Returning to previous form}
  frmLogIn.Show;
  Self.Close;
end;

procedure TfrmAdminPage.btnDonationInfoClick(Sender: TObject);
begin
  (*Taking the admin to the DonationInformation form*)
  form4.Show;
  frmAdminPage.Hide;
end;

procedure TfrmAdminPage.btnDonerInfoClick(Sender: TObject);
begin
  //Taking the admin to the DonerInformation form
  form5.Show;
  frmAdminPage.Hide;
end;

procedure TfrmAdminPage.btnUpdateCurrenciesClick(Sender: TObject);
var oItem:TPAT2021;
begin

  {1 is divided by values to give how much of that currency to get 1 USD e.g.R14,56=$1
  Values are then displayed in the relevant Editboxes.}
  edtRandToDollar.Text := FloatToStrF((oItem.calcRand(frmPayWall.Rand)),ffFixed,7,2);
  edtEuroToDollar.Text := FloatToStrF((oItem.calcRand(frmPayWall.Euro)),ffFixed,7,2);
  edtPoundToDollar.Text := FloatToStrF((oItem.calcRand(frmPayWall.GBP)),ffFixed,7,2);
end;

procedure TfrmAdminPage.FormCreate(Sender: TObject);
var oItem : TPAT2021;
begin
 //number of monthly doners will get its value from the class
edtNumMonthlyDoners.Text := IntToStr(oItem.getMonthlyDoners(frmDonationsPg.MonthlyDoners));
end;

procedure TfrmAdminPage.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/Panel1.Width, ClientHeight/panel1.Height);
  panel1.ScaleBy(Trunc(Ratio * 100), 100);

end;

end.
