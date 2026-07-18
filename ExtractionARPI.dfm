object frmExtractionARPI: TfrmExtractionARPI
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extraction of ARPI, AMS, IEHP Project Report File'
  ClientHeight = 152
  ClientWidth = 444
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
  object Label2: TLabel
    Left = 421
    Top = 8
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'Label2'
    Color = clActiveBorder
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 220
    Top = 8
    Width = 36
    Height = 14
    Caption = 'Label3'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 18
    Top = 9
    Width = 409
    Height = 133
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 17
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
      Top = 66
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
      Top = 38
      Width = 315
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
      Left = 343
      Top = 38
      Width = 49
      Height = 22
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
      Top = 96
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
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 193
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    Left = 88
    Top = 193
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 120
    Top = 193
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 216
    Top = 201
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 240
    Top = 201
  end
  object OpenDialog1: TOpenDialog
    Left = 151
    Top = 196
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 193
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 184
    Top = 200
  end
end
