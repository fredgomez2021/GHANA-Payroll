object frmExtractionUHGLatest: TfrmExtractionUHGLatest
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'UHG Extraction'
  ClientHeight = 145
  ClientWidth = 438
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
    Left = 15
    Top = 5
    Width = 409
    Height = 131
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
      Top = 64
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
      Width = 304
      Height = 23
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Button2: TButton
      Left = 330
      Top = 38
      Width = 60
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
      Color = clInactiveCaption
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 194
    Top = 149
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 15
    Top = 145
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 44
    Top = 145
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    Left = 73
    Top = 144
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 102
    Top = 145
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 129
    Top = 147
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 156
    Top = 147
  end
end
