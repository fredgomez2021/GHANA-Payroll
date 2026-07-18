object frmIdleEntry2: TfrmIdleEntry2
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Idle Time Entry Form'
  ClientHeight = 441
  ClientWidth = 802
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
  object GroupBox2: TGroupBox
    Left = 506
    Top = 247
    Width = 278
    Height = 153
    Caption = 'CURRENT USER'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label8: TLabel
      Left = 14
      Top = 16
      Width = 64
      Height = 15
      Caption = 'User Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 12
      Top = 61
      Width = 92
      Height = 15
      Caption = 'Employee Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 12
      Top = 105
      Width = 68
      Height = 15
      Caption = 'Job Position'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object txtUser: TEdit
      Left = 13
      Top = 35
      Width = 177
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object txtUser_EmployeeName: TEdit
      Left = 13
      Top = 77
      Width = 257
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtJobPosition: TEdit
      Left = 13
      Top = 122
      Width = 177
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 14
    Top = 9
    Width = 770
    Height = 233
    Caption = 'IDLE TIME'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label6: TLabel
      Left = 503
      Top = 29
      Width = 97
      Height = 16
      Caption = 'Primary Task ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 17
      Top = 27
      Width = 97
      Height = 16
      Caption = 'Production Date:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cmbPrimaryTaskID: TComboBox
      Left = 606
      Top = 24
      Width = 147
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
      OnChange = cmbPrimaryTaskIDChange
    end
    object dtDate: TDateTimePicker
      Left = 120
      Top = 23
      Width = 110
      Height = 24
      Date = 38624.000000000000000000
      Time = 38624.000000000000000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = dtDateChange
    end
    object DBGrid1: TDBGrid
      Left = 14
      Top = 53
      Width = 740
      Height = 164
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGrid1CellClick
      OnKeyUp = DBGrid1KeyUp
    end
  end
  object cmdAdd: TButton
    Left = 16
    Top = 406
    Width = 90
    Height = 25
    Caption = 'ADD'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = cmdAddClick
  end
  object cmdEdit: TButton
    Left = 109
    Top = 406
    Width = 90
    Height = 25
    Caption = 'EDIT'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdEditClick
  end
  object cmdDelete: TButton
    Left = 203
    Top = 406
    Width = 89
    Height = 25
    Caption = 'DELETE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = cmdDeleteClick
  end
  object cmdSave: TButton
    Left = 296
    Top = 406
    Width = 89
    Height = 25
    Caption = 'SAVE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = cmdSaveClick
  end
  object cmdCancel: TButton
    Left = 389
    Top = 406
    Width = 89
    Height = 25
    Caption = 'CANCEL'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = cmdCancelClick
  end
  object GroupBox3: TGroupBox
    Left = 14
    Top = 247
    Width = 488
    Height = 153
    Caption = 'EMPLOYEE INFO'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 7
    object Label4: TLabel
      Left = 9
      Top = 35
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
    object Label3: TLabel
      Left = 53
      Top = 71
      Width = 56
      Height = 16
      Caption = 'Idle Time:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 215
      Top = 73
      Width = 54
      Height = 16
      Caption = 'minute(s)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 51
      Top = 96
      Width = 58
      Height = 16
      Caption = 'Idle Code:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 53
      Top = 121
      Width = 56
      Height = 16
      Caption = 'Remarks:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblMode: TLabel
      Left = 387
      Top = 7
      Width = 99
      Height = 18
      AutoSize = False
      Caption = ' Mode :'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 385
      Top = 35
      Width = 25
      Height = 16
      Caption = 'PIN:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cmbEmp_Name: TComboBox
      Left = 119
      Top = 31
      Width = 254
      Height = 24
      Style = csDropDownList
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = cmbEmp_NameClick
    end
    object txtIdleTime: TEdit
      Left = 119
      Top = 67
      Width = 89
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cmbIdleCode: TComboBox
      Left = 119
      Top = 92
      Width = 257
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
    end
    object txtRemarks: TEdit
      Left = 119
      Top = 118
      Width = 353
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object txtEmp_PIN: TEdit
      Left = 412
      Top = 29
      Width = 65
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object btnLoadExtraction: TButton
    Left = 507
    Top = 404
    Width = 277
    Height = 25
    Caption = 'Load idle time extraction module ...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btnLoadExtractionClick
  end
  object ADODataSet6: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 490
    Top = 28
  end
  object ADODataSet5: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 467
    Top = 28
  end
  object ADODataSet4: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 456
    Top = 28
  end
  object ADODataSet3: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 421
    Top = 28
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    Left = 389
    Top = 28
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 357
    Top = 31
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 267
    Top = 28
  end
  object DataSource1: TDataSource
    Left = 296
    Top = 28
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 328
    Top = 28
  end
  object dsLogFile: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 520
  end
end
