object frmKeyerRemarksMaintenance: TfrmKeyerRemarksMaintenance
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer Remarks Maintenance'
  ClientHeight = 401
  ClientWidth = 470
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 124
    Width = 441
    Height = 237
    Caption = 'KEYER DETAILS'
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
      Left = 24
      Top = 29
      Width = 87
      Height = 16
      Caption = 'Employee PIN:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 56
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
    object Label4: TLabel
      Left = 24
      Top = 127
      Width = 54
      Height = 16
      Caption = 'Keyer ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 151
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
    object Label7: TLabel
      Left = 24
      Top = 204
      Width = 172
      Height = 16
      Caption = 'Incentive Compensation Rate:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 23
      Top = 176
      Width = 101
      Height = 16
      Caption = 'Task Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 64
      Top = 110
      Width = 329
      Height = 4
    end
    object Label11: TLabel
      Left = 25
      Top = 82
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
    object txtEmployeePIN: TEdit
      Left = 131
      Top = 23
      Width = 177
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = txtEmployeePINKeyPress
    end
    object Button3: TButton
      Left = 315
      Top = 22
      Width = 91
      Height = 25
      Caption = 'VIEW LIST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
    object txtEmployeeName: TEdit
      Left = 131
      Top = 50
      Width = 275
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
    object cmbTaskID: TComboBox
      Left = 131
      Top = 145
      Width = 179
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 3
      OnClick = cmbTaskIDClick
    end
    object txtPieceRate: TEdit
      Left = 198
      Top = 198
      Width = 73
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object txtTaskDesc: TEdit
      Left = 131
      Top = 170
      Width = 272
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object txtKeyerID: TEdit
      Left = 131
      Top = 121
      Width = 177
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object cmdKeyerList: TButton
      Left = 313
      Top = 121
      Width = 90
      Height = 25
      Caption = 'KEYER LIST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = cmdKeyerListClick
    end
    object txtPrimary_Task_ID: TEdit
      Left = 131
      Top = 75
      Width = 95
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
  end
  object cmdDelete: TButton
    Left = 171
    Top = 367
    Width = 75
    Height = 25
    Caption = '&DELETE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdDeleteClick
  end
  object cmdEdit: TButton
    Left = 93
    Top = 367
    Width = 76
    Height = 25
    Cancel = True
    Caption = '&EDIT'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = cmdEditClick
  end
  object cmdAdd: TButton
    Left = 16
    Top = 367
    Width = 75
    Height = 25
    Caption = '&ADD'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdAddClick
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 11
    Width = 441
    Height = 107
    Caption = 'CURRENT USER'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 4
    object Label8: TLabel
      Left = 21
      Top = 27
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
    object Label9: TLabel
      Left = 21
      Top = 51
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
    object Label10: TLabel
      Left = 20
      Top = 74
      Width = 71
      Height = 15
      Caption = 'Job Position:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object txtUser: TEdit
      Left = 122
      Top = 22
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
      OnKeyPress = txtEmployeePINKeyPress
    end
    object txtUser_EmployeeName: TEdit
      Left = 122
      Top = 46
      Width = 269
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
      Left = 122
      Top = 70
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
  object cmdLoadExpress: TButton
    Left = 296
    Top = 367
    Width = 161
    Height = 24
    Caption = 'Express Edition!!!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = cmdLoadExpressClick
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 496
    Top = 432
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 528
    Top = 432
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 560
    Top = 432
  end
  object dsModule: TADODataSet
    Parameters = <>
    Left = 416
    Top = 440
  end
  object dsAccess: TADODataSet
    Parameters = <>
    Left = 448
    Top = 440
  end
  object dsLogFile: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 24
    Top = 408
  end
end
