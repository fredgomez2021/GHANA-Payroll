object frmOvertimeValidation: TfrmOvertimeValidation
  Left = 0
  Top = 0
  Width = 825
  Height = 683
  Caption = 'DAILY TIME RECORD - Overtime Validation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 17
    Top = 237
    Width = 785
    Height = 371
    Caption = 'Daily Time Record'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 7
      Top = 56
      Width = 770
      Height = 277
      Brush.Color = clMenuHighlight
    end
    object lblRecordsFound: TLabel
      Left = 141
      Top = 340
      Width = 3
      Height = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 343
      Width = 103
      Height = 14
      Caption = 'Total Records Found:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblName: TLabel
      Left = 11
      Top = 24
      Width = 5
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox3: TGroupBox
      Left = 333
      Top = 8
      Width = 217
      Height = 41
      TabOrder = 0
      Visible = False
      object btnClear: TButton
        Left = 9
        Top = 11
        Width = 97
        Height = 25
        Caption = 'Clear All'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnClearClick
      end
      object btnCheckAll: TButton
        Left = 112
        Top = 11
        Width = 97
        Height = 25
        Caption = 'Check All'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnCheckAllClick
      end
    end
    object Button3: TButton
      Left = 637
      Top = 22
      Width = 139
      Height = 25
      Caption = 'DO NOT AUTHORIZE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Grid: TDBGrid
    Left = 32
    Top = 296
    Width = 754
    Height = 267
    DataSource = DataSource1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = GridCellClick
    OnColExit = GridColExit
    OnDrawColumnCell = GridDrawColumnCell
    OnKeyPress = GridKeyPress
  end
  object chck1: TDBCheckBox
    Left = 0
    Top = 232
    Width = 25
    Height = 17
    TabOrder = 2
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
    OnClick = chck1Click
  end
  object Button1: TButton
    Left = 422
    Top = 616
    Width = 123
    Height = 25
    Caption = 'UPDATE DTR'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 136
    Width = 593
    Height = 97
    Caption = 'Query by Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 10
      Top = 27
      Width = 66
      Height = 15
      Caption = 'Select Date:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 59
      Width = 50
      Height = 15
      Caption = 'Location:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 255
      Top = 62
      Width = 45
      Height = 15
      Caption = 'Task ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object dtDate: TDateTimePicker
      Left = 82
      Top = 24
      Width = 209
      Height = 23
      CalAlignment = dtaRight
      Date = 38626.566891041660000000
      Time = 38626.566891041660000000
      DateFormat = dfLong
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnShow: TButton
      Left = 472
      Top = 23
      Width = 105
      Height = 58
      Caption = 'Display DTR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnShowClick
    end
    object cmbBranch: TComboBox
      Left = 81
      Top = 56
      Width = 113
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 2
    end
    object cmbTaskID: TComboBox
      Left = 309
      Top = 55
      Width = 153
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 16
      ParentFont = False
      TabOrder = 3
    end
  end
  object btnClose: TButton
    Left = 683
    Top = 616
    Width = 121
    Height = 25
    Caption = '&CLOSE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnCloseClick
  end
  object Button2: TButton
    Left = 620
    Top = 142
    Width = 184
    Height = 91
    Caption = 'EMPLOYEE LIST'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button2Click
  end
  object GroupBox5: TGroupBox
    Left = 16
    Top = 11
    Width = 593
    Height = 118
    Caption = 'Current User'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Label12: TLabel
      Left = 24
      Top = 24
      Width = 79
      Height = 18
      Caption = 'User Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 24
      Top = 54
      Width = 112
      Height = 18
      Caption = 'Employee Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 25
      Top = 83
      Width = 53
      Height = 18
      Caption = 'Position:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object txtUser: TEdit
      Left = 146
      Top = 22
      Width = 177
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object txtUser_EmployeeName: TEdit
      Left = 146
      Top = 52
      Width = 257
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtJobPosition: TEdit
      Left = 146
      Top = 82
      Width = 177
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 584
  end
  object dsName: TADODataSet
    Parameters = <>
    Top = 584
  end
  object dsFillBranch: TADODataSet
    Parameters = <>
    Left = 32
    Top = 584
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 112
    Top = 576
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 
      'select Employee_PIN, Time_In, Time_Out, Time_Interval, OT, Remar' +
      'ks, AuthorizeOT from TimeInterval'
    Parameters = <>
    Left = 152
    Top = 584
  end
  object dsFilter: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 184
    Top = 584
  end
  object dsLogFile: TADODataSet
    Parameters = <>
    Left = 232
    Top = 576
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 624
    Top = 96
  end
end
