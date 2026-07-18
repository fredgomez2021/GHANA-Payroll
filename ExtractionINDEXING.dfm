object frmExtractionINDEXING: TfrmExtractionINDEXING
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extraction of INDEXING Project Report File'
  ClientHeight = 145
  ClientWidth = 437
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
  object GroupBox1: TGroupBox
    Left = 12
    Top = 7
    Width = 409
    Height = 129
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 112
      Height = 15
      Alignment = taCenter
      Caption = 'Select File to Extract:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 20
      Top = 67
      Width = 369
      Height = 25
      Caption = 'EXTRACT NOW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 21
      Top = 41
      Width = 299
      Height = 23
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Button2: TButton
      Left = 325
      Top = 40
      Width = 63
      Height = 24
      Caption = 'OPEN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object Edit2: TEdit
      Left = 20
      Top = 95
      Width = 369
      Height = 23
      BevelInner = bvSpace
      BevelOuter = bvNone
      Color = clCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'dtaProduction'
    Left = 40
    Top = 152
  end
  object OpenDialog1: TOpenDialog
    Left = 71
    Top = 148
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 96
    Top = 144
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 120
    Top = 144
  end
end
