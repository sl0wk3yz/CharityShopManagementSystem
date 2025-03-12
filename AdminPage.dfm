object frmAdminPage: TfrmAdminPage
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Admin Page'
  ClientHeight = 462
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 465
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    object lblMonthlyDoners: TLabel
      Left = 72
      Top = 387
      Width = 154
      Height = 18
      Caption = 'Number of monthly doners'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object gpbExRate: TGroupBox
      Left = 56
      Top = 31
      Width = 260
      Height = 146
      Caption = 'Exchange Rate to $'
      TabOrder = 0
      object lblDollar: TLabel
        Left = 16
        Top = 32
        Width = 25
        Height = 13
        Caption = 'Rand'
      end
      object lblEuro: TLabel
        Left = 16
        Top = 80
        Width = 22
        Height = 13
        Caption = 'Euro'
      end
      object lblPound: TLabel
        Left = 16
        Top = 120
        Width = 69
        Height = 13
        Caption = 'Sterling Pound'
      end
      object Label1: TLabel
        Left = 208
        Top = 32
        Width = 25
        Height = 13
        Caption = 'per $'
      end
      object Label2: TLabel
        Left = 208
        Top = 80
        Width = 25
        Height = 13
        Caption = 'per $'
      end
      object Label3: TLabel
        Left = 208
        Top = 113
        Width = 25
        Height = 13
        Caption = 'per $'
      end
      object edtRandToDollar: TEdit
        Left = 96
        Top = 29
        Width = 89
        Height = 21
        TabOrder = 0
        Text = '14.91'
      end
      object edtEuroToDollar: TEdit
        Left = 96
        Top = 77
        Width = 89
        Height = 21
        TabOrder = 1
        Text = '0.86'
      end
      object edtPoundToDollar: TEdit
        Left = 96
        Top = 113
        Width = 89
        Height = 21
        TabOrder = 2
        Text = '0.74'
      end
    end
    object btnDonerInfo: TButton
      Left = 75
      Top = 288
      Width = 190
      Height = 30
      Caption = 'Doner Information'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDonerInfoClick
    end
    object btnUpdateCurrencies: TButton
      Left = 72
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 2
      Visible = False
      OnClick = btnUpdateCurrenciesClick
    end
    object btnDonationInfo: TButton
      Left = 75
      Top = 240
      Width = 190
      Height = 30
      Caption = 'Donation Information'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnDonationInfoClick
    end
    object bmbBack2Welcome: TBitBtn
      Left = 0
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Back'
      Kind = bkIgnore
      NumGlyphs = 2
      TabOrder = 4
      OnClick = bmbBack2WelcomeClick
    end
    object edtNumMonthlyDoners: TEdit
      Left = 72
      Top = 411
      Width = 127
      Height = 21
      TabOrder = 5
    end
  end
end
