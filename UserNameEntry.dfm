object frmUserNameEntry: TfrmUserNameEntry
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Supervisor Username Entry'
  ClientHeight = 500
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 32
    Top = 11
    Width = 441
    Height = 158
    Caption = 'Supervisor Details'
    TabOrder = 0
    object Label2: TLabel
      Left = 35
      Top = 28
      Width = 78
      Height = 15
      Caption = 'Project Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 35
      Top = 60
      Width = 99
      Height = 15
      Caption = 'Supervisor Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 35
      Top = 100
      Width = 109
      Height = 15
      Caption = 'Desired Username:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object label4: TLabel
      Left = 35
      Top = 124
      Width = 106
      Height = 15
      Caption = 'Desired Password:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cmbProjectName: TComboBox
      Left = 152
      Top = 25
      Width = 187
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
    object txtSupervisor: TEdit
      Left = 152
      Top = 55
      Width = 257
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object txtUsername: TEdit
      Left = 152
      Top = 95
      Width = 185
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object txtPassword: TEdit
      Left = 152
      Top = 119
      Width = 185
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cmdSave: TButton
      Left = 344
      Top = 96
      Width = 81
      Height = 46
      Caption = '&SAVE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cmdSaveClick
    end
  end
  object Button4: TButton
    Left = 335
    Top = 171
    Width = 136
    Height = 25
    Caption = '&CLOSE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button4Click
  end
  object Grid1: TDBGrid
    Left = 96
    Top = 232
    Width = 489
    Height = 249
    DataSource = ds1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 6
    Top = 453
    Width = 75
    Height = 25
    Caption = 'COPY'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object ADOUser: TADOConnection
    LoginPrompt = False
    Left = 32
    Top = 184
  end
  object DSUser: TADODataSet
    Parameters = <>
    Left = 64
    Top = 184
  end
  object DSFillProject: TADODataSet
    Parameters = <>
    Left = 96
    Top = 184
  end
  object DSProject: TADODataSet
    Parameters = <>
    Left = 152
    Top = 184
  end
  object spEmployees: TADOStoredProc
    Parameters = <>
    Left = 32
    Top = 232
  end
  object ds1: TDataSource
    DataSet = spEmployees
    Left = 64
    Top = 232
  end
  object ADOMds: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=@ptiflex#$;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=Payroll;Data Source=192.168.2.4'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 9
    Top = 381
  end
  object ADOLocal: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=momentum;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=Payroll;Data Source=192.168.1.122'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 42
    Top = 381
  end
  object dsMds: TADODataSet
    Connection = ADOMds
    Parameters = <>
    Left = 9
    Top = 414
  end
  object dsLocal: TADODataSet
    Connection = ADOLocal
    Parameters = <>
    Left = 42
    Top = 414
  end
end
