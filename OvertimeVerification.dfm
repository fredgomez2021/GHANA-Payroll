object frmOvertimeVerification: TfrmOvertimeVerification
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Overtime Verification'
  ClientHeight = 533
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 16
    Width = 537
    Height = 121
    TabOrder = 0
    object cmdSearch: TButton
      Left = 375
      Top = 21
      Width = 138
      Height = 74
      Caption = 'SEARCH'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cmdSearchClick
    end
    object optWorkingDate: TRadioButton
      Left = 24
      Top = 75
      Width = 97
      Height = 17
      Caption = 'Working Date'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
    end
    object dtDate: TDateTimePicker
      Left = 136
      Top = 71
      Width = 233
      Height = 23
      CalAlignment = dtaRight
      Date = 38657.566891041660000000
      Time = 38657.566891041660000000
      DateFormat = dfLong
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 24
      Top = 16
      Width = 345
      Height = 49
      Caption = 'Query by'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object optOvertime: TRadioButton
        Left = 24
        Top = 22
        Width = 137
        Height = 17
        Caption = 'Overtime Verification'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object optLogTime: TRadioButton
        Left = 184
        Top = 22
        Width = 137
        Height = 17
        Caption = 'Log Time Verification'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object grpSchedule: TGroupBox
    Left = 24
    Top = 144
    Width = 537
    Height = 337
    Caption = 'Logged Overtime'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 17
      Top = 48
      Width = 497
      Height = 276
      AutoSize = False
      Color = clHotLight
      ParentColor = False
    end
    object dbOvertime: TDBGrid
      Left = 24
      Top = 56
      Width = 480
      Height = 260
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnCellClick = dbOvertimeCellClick
    end
    object btnVerify: TButton
      Left = 424
      Top = 19
      Width = 89
      Height = 25
      Caption = 'VERIFY'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnVerifyClick
    end
  end
  object btnClose: TButton
    Left = 472
    Top = 494
    Width = 89
    Height = 25
    Caption = 'CLOSE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object ADOOvertime: TADOConnection
    LoginPrompt = False
    Left = 576
    Top = 224
  end
  object dsOvertime: TADODataSet
    Connection = ADOOvertime
    Parameters = <>
    Left = 576
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = dsOvertime
    Left = 576
    Top = 320
  end
  object dsVerify: TADODataSet
    Connection = ADOOvertime
    Parameters = <>
    Left = 24
    Top = 440
  end
end
