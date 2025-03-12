program Project1;

uses
  Forms,
  WelcomePg in 'WelcomePg.pas' {frmWelcomePage},
  clsPAT2021 in 'clsPAT2021.pas',
  DonationPg_U in 'DonationPg_U.pas' {frmDonationsPg},
  Paywall in 'Paywall.pas' {frmPayWall},
  dbDonationInfo in 'dbDonationInfo.pas' {Form4},
  dbDonerInfo in 'dbDonerInfo.pas' {form5},
  dmLogin_u in 'dmLogin_u.pas' {dmLogIn: TDataModule},
  Login_u in 'Login_u.pas' {frmLogIn},
  AdminPage in 'AdminPage.pas' {frmAdminPage},
  Video in 'Video.pas' {frmVideo},
  dmDonersDynamic_u in 'dmDonersDynamic_u.pas' {dmDonersDynamic: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcomePage, frmWelcomePage);
  Application.CreateForm(TfrmDonationsPg, frmDonationsPg);
  Application.CreateForm(TfrmPayWall, frmPayWall);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(Tform5, form5);
  Application.CreateForm(TdmLogIn, dmLogIn);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmAdminPage, frmAdminPage);
  Application.CreateForm(TfrmVideo, frmVideo);
  Application.CreateForm(TdmDonersDynamic, dmDonersDynamic);
  Application.Run;
end.
