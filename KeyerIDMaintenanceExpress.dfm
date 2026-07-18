object frmKeyerIDMaintenanceExpress: TfrmKeyerIDMaintenanceExpress
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer ID Maintenance Express'
  ClientHeight = 282
  ClientWidth = 884
  Color = clSkyBlue
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
  object GroupBox2: TGroupBox
    Left = 9
    Top = 8
    Width = 424
    Height = 241
    Caption = 'Keyer ID details'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label12: TLabel
      Left = 41
      Top = 88
      Width = 23
      Height = 15
      Caption = 'PIN:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 15
      Top = 110
      Width = 49
      Height = 15
      Caption = 'Keyer ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 24
      Top = 172
      Width = 41
      Height = 15
      Caption = 'Project:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 27
      Top = 57
      Width = 37
      Height = 15
      Caption = 'Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 72
      Top = 146
      Width = 326
      Height = 14
      Caption = 'Add this Keyer ID to all Task type(s) on this Project/Account'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 69
      Top = 20
      Width = 326
      Height = 28
      Caption = 
        'Select a name, enter Keyer ID  and choose which project to add t' +
        'his ID and click '#39'Insert into Keyer ID table'#39' button.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label5: TLabel
      Left = 69
      Top = 199
      Width = 324
      Height = 28
      Caption = 
        'Selecting a Name and Project only would view all Keyer IDs under' +
        ' this Project in the grid provided.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object txtPIN: TEdit
      Left = 69
      Top = 82
      Width = 88
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
    object txtKeyerID: TEdit
      Left = 69
      Top = 107
      Width = 208
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cmbName: TComboBox
      Left = 69
      Top = 52
      Width = 328
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 2
      OnClick = cmbNameClick
    end
    object cmbProject: TComboBox
      Left = 70
      Top = 166
      Width = 328
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 3
      OnClick = cmbProjectClick
    end
  end
  object cmdInsert: TButton
    Left = 10
    Top = 253
    Width = 191
    Height = 24
    Caption = 'Insert into Keyer ID table'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdInsertClick
  end
  object GroupBox1: TGroupBox
    Left = 437
    Top = 7
    Width = 436
    Height = 266
    Caption = 'Keyer ID List'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 6
      Top = 17
      Width = 423
      Height = 224
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object lblRecords: TLabel
      Left = 328
      Top = 244
      Width = 102
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '(records)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object gridKeyerID: TDBGrid
      Left = 9
      Top = 20
      Width = 416
      Height = 216
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
  object dsEmployees: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 248
    Top = 248
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 320
    Top = 248
  end
  object dsProjects: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 296
    Top = 248
  end
  object dsTask: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 344
    Top = 248
  end
  object dsTask1: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 360
    Top = 248
  end
  object dSourceKeyerID: TDataSource
    Left = 216
    Top = 248
  end
  object dsKeyerList: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 392
    Top = 248
  end
  object dsKeyerList1: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 392
    Top = 248
  end
end
