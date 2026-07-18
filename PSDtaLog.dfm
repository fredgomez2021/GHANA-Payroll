object frmLogFile: TfrmLogFile
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Log File Viewer'
  ClientHeight = 509
  ClientWidth = 950
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnPrint: TButton
    Left = 854
    Top = 477
    Width = 81
    Height = 25
    Caption = 'PRINT'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object GroupBox1: TGroupBox
    Left = 15
    Top = 10
    Width = 289
    Height = 81
    Caption = 'DATE RANGE'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object lblFrom: TLabel
      Left = 20
      Top = 24
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
    object TLabel
      Left = 240
      Top = 16
      Width = 3
      Height = 14
    end
    object lblTo: TLabel
      Left = 20
      Top = 48
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
    object dtpFrom: TDateTimePicker
      Left = 67
      Top = 21
      Width = 145
      Height = 23
      Date = 38657.900594814810000000
      Time = 38657.900594814810000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = dtpFromChange
    end
    object dtpTo: TDateTimePicker
      Left = 67
      Top = 45
      Width = 145
      Height = 23
      Date = 38671.900594814810000000
      Time = 38671.900594814810000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 15
    Top = 94
    Width = 919
    Height = 378
    Caption = 'RESULT'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 885
      Height = 346
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object DBGrid1: TDBGrid
      Left = 22
      Top = 29
      Width = 873
      Height = 332
      DataSource = DataSource1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object GroupBox3: TGroupBox
    Left = 313
    Top = 10
    Width = 621
    Height = 81
    Caption = 'FILTER BY'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object lblUser: TLabel
      Left = 16
      Top = 23
      Width = 67
      Height = 15
      Caption = 'User Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblCommand: TLabel
      Left = 17
      Top = 48
      Width = 62
      Height = 15
      Caption = 'Command:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 264
      Top = 23
      Width = 43
      Height = 15
      Caption = 'Module:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cboUserName: TComboBox
      Left = 90
      Top = 19
      Width = 163
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
    end
    object cboCommand: TComboBox
      Left = 90
      Top = 46
      Width = 163
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 1
    end
    object cboModule: TComboBox
      Left = 312
      Top = 19
      Width = 296
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
    object btnFilter: TButton
      Left = 527
      Top = 46
      Width = 81
      Height = 25
      Caption = 'Filter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnFilterClick
    end
    object btnExport: TButton
      Left = 399
      Top = 46
      Width = 123
      Height = 25
      Caption = 'Export to Excel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnExportClick
    end
  end
  object btnProcess: TButton
    Left = 246
    Top = 37
    Width = 51
    Height = 44
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnProcessClick
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Top = 224
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Top = 192
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Top = 256
  end
  object ADODataSet3: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Top = 160
  end
  object ADODataSet4: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Top = 288
  end
  object DataSource2: TDataSource
    DataSet = ADODataSet4
    Top = 320
  end
end
