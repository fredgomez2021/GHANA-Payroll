object frmKeyerRemarks: TfrmKeyerRemarks
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer Remarks'
  ClientHeight = 468
  ClientWidth = 523
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 17
    Top = 128
    Width = 491
    Height = 329
    Caption = 'KEYER ID'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 13
      Top = 57
      Width = 459
      Height = 259
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 48
      Height = 16
      Caption = 'Task ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBGrid1: TDBGrid
      Left = 19
      Top = 62
      Width = 444
      Height = 248
      DataSource = DataSource1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
    end
    object cmbTaskID: TComboBox
      Left = 77
      Top = 24
      Width = 185
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
      OnSelect = cmbTaskIDSelect
    end
  end
  object GroupBox2: TGroupBox
    Left = 17
    Top = 9
    Width = 491
    Height = 112
    Caption = 'CURRENT USER'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label8: TLabel
      Left = 45
      Top = 29
      Width = 69
      Height = 16
      Caption = 'User Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 45
      Top = 53
      Width = 100
      Height = 16
      Caption = 'Employee Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 46
      Top = 76
      Width = 75
      Height = 16
      Caption = 'Job Position:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object txtUser: TEdit
      Left = 152
      Top = 24
      Width = 177
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object txtUser_EmployeeName: TEdit
      Left = 152
      Top = 48
      Width = 257
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtJobPosition: TEdit
      Left = 152
      Top = 72
      Width = 177
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object DataSource1: TDataSource
    Left = 72
    Top = 464
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 464
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 104
    Top = 464
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 136
    Top = 464
  end
end
