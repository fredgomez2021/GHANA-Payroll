object frmKeyerSchedule: TfrmKeyerSchedule
  Left = 0
  Top = 0
  Width = 594
  Height = 586
  Caption = 'Keyer Schedule'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 8
    Width = 537
    Height = 161
    Caption = 'Employee'
    TabOrder = 0
    object cmbName: TComboBox
      Left = 146
      Top = 71
      Width = 319
      Height = 23
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
    end
    object cmdSearch: TButton
      Left = 375
      Top = 30
      Width = 89
      Height = 25
      Caption = 'SEARCH'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cmdSearchClick
    end
    object grpPeriod: TGroupBox
      Left = 22
      Top = 101
      Width = 443
      Height = 41
      Caption = 'Period'
      Enabled = False
      TabOrder = 2
      object cmbMonth: TComboBox
        Left = 33
        Top = 14
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'January'
          'February'
          'March'
          'April'
          'May'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
      end
      object opt115: TRadioButton
        Left = 159
        Top = 16
        Width = 49
        Height = 17
        Caption = '1-15'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object opt1631: TRadioButton
        Left = 213
        Top = 16
        Width = 49
        Height = 17
        Caption = '16-31'
        TabOrder = 2
      end
      object cmbYear: TComboBox
        Left = 279
        Top = 13
        Width = 94
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = '2005'
        Items.Strings = (
          '2005'
          '2006'
          '2007'
          '2008'
          '2009'
          '2010'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015')
      end
    end
    object optWorkingDate: TRadioButton
      Left = 24
      Top = 35
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
      TabOrder = 3
      TabStop = True
      OnClick = optWorkingDateClick
    end
    object dtDate: TDateTimePicker
      Left = 136
      Top = 31
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
      TabOrder = 4
    end
    object optEmpName: TRadioButton
      Left = 20
      Top = 76
      Width = 113
      Height = 17
      Caption = 'Employee Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = optEmpNameClick
    end
  end
  object grpSchedule: TGroupBox
    Left = 24
    Top = 176
    Width = 537
    Height = 337
    Caption = 'Schedule'
    TabOrder = 1
    object dbSchedule: TDBGrid
      Left = 23
      Top = 27
      Width = 489
      Height = 289
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = dsSched
    Left = 24
    Top = 520
  end
  object ADOSched: TADOConnection
    LoginPrompt = False
    Left = 56
    Top = 520
  end
  object dsSched: TADODataSet
    Connection = ADOSched
    Parameters = <>
    Left = 88
    Top = 520
  end
  object dsEmployees: TADODataSet
    Connection = ADOSched
    Parameters = <>
    Left = 120
    Top = 520
  end
end
