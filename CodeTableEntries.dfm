object frmCodeTableEntries: TfrmCodeTableEntries
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Code Table Entries'
  ClientHeight = 509
  ClientWidth = 550
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
    Left = 11
    Top = 11
    Width = 526
    Height = 462
    Caption = 'Code Details'
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
      Top = 26
      Width = 85
      Height = 15
      Caption = 'Code Category:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 61
      Top = 359
      Width = 33
      Height = 15
      Caption = 'Code:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 28
      Top = 382
      Width = 66
      Height = 15
      Caption = 'Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 12
      Top = 54
      Width = 504
      Height = 275
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object lblRecords: TLabel
      Left = 470
      Top = 332
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = '(records)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 40
      Top = 408
      Width = 55
      Height = 15
      Caption = 'Hierarchy:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 20
      Top = 431
      Width = 75
      Height = 15
      Caption = 'Job Category:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblHierarchy: TLabel
      Left = 182
      Top = 407
      Width = 53
      Height = 14
      Caption = '[Hierarchy]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblJobCategory: TLabel
      Left = 310
      Top = 431
      Width = 70
      Height = 14
      Caption = '[Job Category]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cmbCodeCategory: TComboBox
      Left = 136
      Top = 21
      Width = 248
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      OnClick = cmbCodeCategoryClick
    end
    object gridDetails: TDBGrid
      Left = 18
      Top = 57
      Width = 493
      Height = 264
      DataSource = dSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = gridDetailsCellClick
      OnKeyUp = gridDetailsKeyUp
    end
    object txtCode: TEdit
      Left = 100
      Top = 355
      Width = 116
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object txtDescription: TEdit
      Left = 100
      Top = 379
      Width = 292
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cmbHierarchy: TComboBox
      Left = 100
      Top = 403
      Width = 75
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 15
      ParentFont = False
      TabOrder = 4
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z')
    end
    object cmbJobCategory: TComboBox
      Left = 100
      Top = 428
      Width = 205
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 5
    end
  end
  object cmdAdd: TButton
    Left = 11
    Top = 480
    Width = 75
    Height = 24
    Caption = '&ADD'
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
    Left = 86
    Top = 480
    Width = 76
    Height = 24
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
  object cmdDelete: TButton
    Left = 162
    Top = 480
    Width = 75
    Height = 24
    Caption = '&DELETE'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdDeleteClick
  end
  object cmdClose: TButton
    Left = 237
    Top = 480
    Width = 75
    Height = 24
    Caption = '&CANCEL'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = cmdCloseClick
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 448
    Top = 488
  end
  object dsCategory: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 416
    Top = 488
  end
  object dSource: TDataSource
    Left = 392
    Top = 488
  end
  object dsJobCategory: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 360
    Top = 488
  end
  object dsCategoryGrid: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 336
    Top = 488
  end
  object dsEntry: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 480
    Top = 488
  end
  object dsEntry1: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 496
    Top = 488
  end
end
