object frmEmployeeWorkDays: TfrmEmployeeWorkDays
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Employee days of work per period'
  ClientHeight = 498
  ClientWidth = 379
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 357
    Height = 57
    Caption = 'payroll period'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 11
      Top = 27
      Width = 32
      Height = 15
      Caption = 'From:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 188
      Top = 27
      Width = 17
      Height = 15
      Caption = 'To:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object dtPickerFrom: TDateTimePicker
      Left = 50
      Top = 22
      Width = 122
      Height = 22
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      TabOrder = 0
      OnChange = dtPickerFromChange
    end
    object dtPickerTo: TDateTimePicker
      Left = 214
      Top = 22
      Width = 123
      Height = 22
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      Enabled = False
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 66
    Width = 357
    Height = 81
    Caption = 'employee'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 25
      Width = 93
      Height = 15
      Caption = 'Employee name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 52
      Width = 132
      Height = 15
      Caption = 'Number of days of work:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cboEmployeeName: TComboBox
      Left = 105
      Top = 20
      Width = 245
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
      OnChange = cboEmployeeNameChange
    end
    object txtNumDays: TEdit
      Left = 143
      Top = 47
      Width = 75
      Height = 24
      Color = clHighlightText
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Text = '0'
      OnChange = txtNumDaysChange
    end
    object btnSaveEntry: TButton
      Left = 225
      Top = 46
      Width = 123
      Height = 25
      Caption = 'SAVE ENTRY'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaveEntryClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 12
    Top = 147
    Width = 357
    Height = 344
    Caption = 'details'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object lblRecords: TLabel
      Left = 13
      Top = 318
      Width = 59
      Height = 15
      Caption = 'lblRecords'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object dbGridDetails: TDBGrid
      Left = 13
      Top = 16
      Width = 330
      Height = 297
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      OnCellClick = dbGridDetailsCellClick
    end
    object btnRefresh: TButton
      Left = 247
      Top = 315
      Width = 94
      Height = 22
      Caption = '&REFRESH'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object btnDelete: TButton
      Left = 150
      Top = 315
      Width = 94
      Height = 22
      Caption = '&DELETE'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  object ADODays: TADOConnection
    LoginPrompt = False
    Left = 8
    Top = 504
  end
  object dsDays: TADODataSet
    Connection = ADODays
    Parameters = <>
    Left = 40
    Top = 504
  end
  object dsEmployees: TADODataSet
    Connection = ADODays
    Parameters = <>
    Left = 72
    Top = 504
  end
  object sourceDays: TDataSource
    Left = 144
    Top = 504
  end
end
