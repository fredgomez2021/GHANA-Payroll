object frmExtractionGENERIC: TfrmExtractionGENERIC
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extraction of GENERIC Project Report File'
  ClientHeight = 186
  ClientWidth = 581
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object Label2: TLabel
    Left = 561
    Top = 0
    Width = 47
    Height = 18
    Alignment = taRightJustify
    Caption = 'Label2'
    Color = clActiveBorder
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 288
    Top = 10
    Width = 47
    Height = 18
    Caption = 'Label3'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 12
    Width = 538
    Height = 166
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 22
      Width = 138
      Height = 17
      Alignment = taCenter
      Caption = 'Select File to Extract:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 26
      Top = 86
      Width = 483
      Height = 33
      Caption = 'EXTRACT NOW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 27
      Top = 50
      Width = 412
      Height = 25
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Button2: TButton
      Left = 443
      Top = 50
      Width = 66
      Height = 28
      Caption = '. . .'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object Edit2: TEdit
      Left = 26
      Top = 126
      Width = 483
      Height = 25
      BevelInner = bvSpace
      BevelOuter = bvNone
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
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
