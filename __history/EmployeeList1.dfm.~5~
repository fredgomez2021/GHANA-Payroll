object frmEmployeeList1: TfrmEmployeeList1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extract employee list'
  ClientHeight = 194
  ClientWidth = 386
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 17
    Top = 5
    Width = 359
    Height = 180
    Caption = 'employee details'
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label9: TLabel
      Left = 29
      Top = 33
      Width = 81
      Height = 16
      Caption = 'Project name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 37
      Top = 57
      Width = 73
      Height = 16
      Caption = 'Job position:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 68
      Top = 82
      Width = 42
      Height = 16
      Caption = 'Status:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 57
      Top = 105
      Width = 53
      Height = 16
      Caption = 'Location:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblName: TLabel
      Left = 24
      Top = 133
      Width = 313
      Height = 5
      AutoSize = False
      Color = clMoneyGreen
      ParentColor = False
    end
    object btnGenerate: TButton
      Left = 24
      Top = 141
      Width = 313
      Height = 28
      Caption = 'generate report'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGenerateClick
    end
    object cmbProject: TComboBox
      Left = 118
      Top = 29
      Width = 211
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
    end
    object cmbPosition: TComboBox
      Left = 118
      Top = 53
      Width = 211
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
    end
    object cmbStatus: TComboBox
      Left = 118
      Top = 77
      Width = 147
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 3
    end
    object cmbLocation: TComboBox
      Left = 118
      Top = 101
      Width = 147
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 4
    end
  end
  object ADOConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 386
    Top = 5
  end
  object dsCombo: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 386
    Top = 34
  end
  object dsResult: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 384
    Top = 72
  end
end
