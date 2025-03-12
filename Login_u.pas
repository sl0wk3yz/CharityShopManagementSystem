unit Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dmLogin_u,
  Vcl.Imaging.pngimage, Vcl.Buttons, AdminPage, Math;

type
  TfrmLogIn = class(TForm)
    lblLogIn: TLabel;
    Username: TLabel;
    Password: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogIn: TButton;
    lblCreateAcc: TLabel;
    pnlLogin: TPanel;
    Image1: TImage;
    bmbBack2Welcome: TBitBtn;
    procedure btnLogInClick(Sender: TObject);
    procedure lblCreateAccClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bmbBack2WelcomeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogIn: TfrmLogIn;

implementation

{$R *.dfm}

uses WelcomePg;     {only way to connect forms both ways
                      without enducing a circular circuit Error}

procedure TfrmLogIn.bmbBack2WelcomeClick(Sender: TObject);
begin
  //Going to previous form
  frmWelcomePage.Show;
  Self.Close;
end;

procedure TfrmLogIn.btnLogInClick(Sender: TObject);
var
  Username, Password: String;
  bFound: Boolean;
begin
  Username := edtUsername.Text;
  Password := edtPassword.Text;
  bFound := False;
  with dmLogin do
  begin
   tblLogin.First;
   while (NOT tblLogin.Eof) AND (bFOund=False) do
   begin             {Username AND password are found in the database, allow access}
    if (tblLogin['Username'] = Username) AND (tblLogin['Password'] = Password) then
    begin       //Fun-Cattle7838                        M@r3tao
      bFound := True;
    end else
   tblLogin.Next;
   end;
  end;

  if bFound=False then       {The username or password does not exist}
  ShowMessage('Username/password is incorrect.');
  if bFound<>False then
  begin
    with dmLogin do
    begin
      MessageDlg('Welcome back '+tblLogin['FirstName']+' '+tblLogin['Surname'],
      mtInformation,[mbOK],0);
    end;

    frmAdminPage.Show;
    frmLogin.Hide;
  end;

end;

procedure TfrmLogIn.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/pnlLogin.Width, ClientHeight/pnlLogin.Height);
  pnlLogin.ScaleBy(Trunc(Ratio * 100), 100);
end;

procedure TfrmLogIn.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {password is shown and the image to hide the password is displayed}
  edtPassword.PasswordChar := #0;
  Image1.Picture.LoadFromFile('SeePassword.png');
end;

procedure TfrmLogIn.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (*password is hidden and the image to see the password is displayed*)
  edtPassword.PasswordChar := '*';
  Image1.Picture.LoadFromFile('passwordcropped.png');
  Image1.Stretch := True;
end;

procedure TfrmLogIn.lblCreateAccClick(Sender: TObject);
begin
//Relevant message is displayed for users without an account.
ShowMessage('All admins have accounts, please return to home page:)');
end;

end.
