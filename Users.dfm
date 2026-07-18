object frmUsers: TfrmUsers
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Users Master File'
  ClientHeight = 342
  ClientWidth = 481
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 14
    Top = 8
    Width = 449
    Height = 161
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object cmdAdd: TButton
    Left = 15
    Top = 310
    Width = 75
    Height = 25
    Caption = 'Add'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdAddClick
  end
  object cmdEdit: TButton
    Left = 90
    Top = 310
    Width = 75
    Height = 25
    Caption = 'Edit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = cmdEditClick
  end
  object cmdDelete: TButton
    Left = 166
    Top = 310
    Width = 75
    Height = 25
    Caption = 'Delete'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdDeleteClick
  end
  object cmdSave: TButton
    Left = 241
    Top = 310
    Width = 75
    Height = 25
    Caption = 'Save'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = cmdSaveClick
  end
  object cmdCancel: TButton
    Left = 316
    Top = 310
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = cmdCancelClick
  end
  object btnDecrypt: TButton
    Left = 9
    Top = 390
    Width = 75
    Height = 25
    Caption = 'DeCrypt'
    TabOrder = 6
    OnClick = btnDecryptClick
  end
  object GroupBox1: TGroupBox
    Left = 15
    Top = 171
    Width = 451
    Height = 136
    Color = clCream
    ParentColor = False
    TabOrder = 7
    object Label3: TLabel
      Left = 21
      Top = 25
      Width = 81
      Height = 15
      Caption = 'Employee PIN:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 52
      Width = 95
      Height = 15
      Caption = 'Employee Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 32
      Top = 79
      Width = 70
      Height = 15
      Caption = 'User Name :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 103
      Width = 62
      Height = 15
      Caption = 'Password :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblMode: TLabel
      Left = 321
      Top = 19
      Width = 117
      Height = 24
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
      Visible = False
    end
    object txtPassword: TEdit
      Left = 107
      Top = 98
      Width = 307
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
    end
    object txtUserName: TEdit
      Left = 108
      Top = 74
      Width = 307
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object txtEmpNo: TEdit
      Left = 108
      Top = 20
      Width = 129
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = txtEmpNoChange
    end
    object cmdOk: TButton
      Left = 241
      Top = 19
      Width = 75
      Height = 25
      Caption = 'OK'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cmdOkClick
    end
    object dbEmployeeList: TDBLookupComboBox
      Left = 108
      Top = 48
      Width = 323
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = dbEmployeeListClick
    end
    object txtEmpName: TEdit
      Left = 108
      Top = 48
      Width = 308
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object DataSource1: TDataSource
    Left = 440
    Top = 64
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 440
    Top = 96
  end
  object ADODataSet2: TADODataSet
    Parameters = <>
    Left = 440
    Top = 32
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 440
    Top = 128
  end
  object ADOTable1: TADOTable
    Left = 440
    Top = 160
  end
  object DataSource2: TDataSource
    Left = 40
    Top = 120
  end
  object ADODataSet3: TADODataSet
    CursorType = ctStatic
    Parameters = <>
    Left = 72
    Top = 120
  end
  object ADODataSet4: TADODataSet
    CursorType = ctStatic
    Parameters = <>
    Left = 104
    Top = 120
  end
  object ADODataSet5: TADODataSet
    CursorType = ctStatic
    Parameters = <>
    Left = 136
    Top = 120
  end
  object ADODataSet6: TADODataSet
    CursorType = ctStatic
    Parameters = <>
    Left = 168
    Top = 120
  end
  object dsLogFile: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 432
    Top = 304
  end
end
