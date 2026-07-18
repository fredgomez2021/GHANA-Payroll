object frmAccess: TfrmAccess
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Access Rights Maintenance'
  ClientHeight = 385
  ClientWidth = 536
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 15
    Top = 8
    Width = 505
    Height = 73
    Caption = 'USERS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 20
      Width = 59
      Height = 15
      Caption = 'Username'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 224
      Top = 16
      Width = 273
      Height = 49
      AutoSize = False
      Color = clCream
      ParentColor = False
    end
    object lblEmployee_Name: TLabel
      Left = 232
      Top = 32
      Width = 4
      Height = 18
      Alignment = taCenter
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object cmbUsername: TComboBox
      Left = 14
      Top = 38
      Width = 196
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      Text = 'cmbUsername'
      OnClick = cmbUsernameClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 15
    Top = 84
    Width = 505
    Height = 262
    Caption = 'ACCESS RIGHTS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 17
      Top = 22
      Width = 47
      Height = 15
      Caption = 'Modules'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 281
      Top = 22
      Width = 123
      Height = 15
      Caption = 'Current Access Rights'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object listAccessRights: TListBox
      Left = 16
      Top = 40
      Width = 209
      Height = 209
      ItemHeight = 14
      TabOrder = 0
      OnClick = listAccessRightsClick
    end
    object listUserAccess: TListBox
      Left = 280
      Top = 40
      Width = 209
      Height = 209
      ItemHeight = 14
      TabOrder = 1
      OnClick = listUserAccessClick
    end
    object btnMoveAll: TButton
      Left = 232
      Top = 128
      Width = 41
      Height = 25
      Caption = '>>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnMoveAllClick
    end
    object btnBackAll: TButton
      Left = 232
      Top = 160
      Width = 41
      Height = 25
      Caption = '<<'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnBackAllClick
    end
    object btnMove1: TButton
      Left = 232
      Top = 40
      Width = 41
      Height = 25
      Caption = '>'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnMove1Click
    end
    object btnBack1: TButton
      Left = 232
      Top = 72
      Width = 41
      Height = 25
      Caption = '<'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnBack1Click
    end
  end
  object btnSaveAccessRights: TButton
    Left = 352
    Top = 352
    Width = 168
    Height = 25
    Caption = '&SAVE ACCESS RIGHTS'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnSaveAccessRightsClick
  end
  object ADOUser: TADOConnection
    LoginPrompt = False
    Left = 24
    Top = 392
  end
  object dsUser: TADODataSet
    Parameters = <>
    Left = 56
    Top = 392
  end
  object dsEmployee: TADODataSet
    Parameters = <>
    Left = 88
    Top = 392
  end
  object dsRights: TADODataSet
    Parameters = <>
    Left = 128
    Top = 392
  end
  object dsModule: TADODataSet
    Connection = ADOUser
    Parameters = <>
    Left = 192
    Top = 392
  end
  object dsLogFile: TADODataSet
    Connection = ADOUser
    Parameters = <>
    Left = 16
    Top = 344
  end
end
