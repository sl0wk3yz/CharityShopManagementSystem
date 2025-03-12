unit Video;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.MPlayer, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.OleCtrls, WMPLib_TLB, Math;

type
  TfrmVideo = class(TForm)
    bmbBack2Welcome: TBitBtn;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    procedure bmbBack2WelcomeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVideo: TfrmVideo;

implementation
uses WelcomePg; //avoiding circuit error

{$R *.dfm}

procedure TfrmVideo.bmbBack2WelcomeClick(Sender: TObject);
begin
 //Return to main form.
 frmWelcomePage.Show;
 Self.Close;
end;

procedure TfrmVideo.FormResize(Sender: TObject);
var
  ratio : double;
begin
  //resizing the components to fit the proportion of a maximized window state.
  ratio := min(ClientWidth/WindowsMediaPlayer1.Width, ClientHeight/WindowsMediaPlayer1.Height);
  WindowsMediaPlayer1.ScaleBy(Trunc(Ratio * 100), 100);
end;

end.
