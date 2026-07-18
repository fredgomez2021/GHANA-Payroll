object frmExtractionBCBS: TfrmExtractionBCBS
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extraction of BCBS Project Report File'
  ClientHeight = 151
  ClientWidth = 450
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
    Left = 18
    Top = 9
    Width = 415
    Height = 133
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 17
      Width = 115
      Height = 15
      Caption = 'Select File to Extract :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 20
      Top = 41
      Width = 313
      Height = 23
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 20
      Top = 67
      Width = 377
      Height = 25
      Caption = 'EXTRACT NOW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 20
      Top = 96
      Width = 377
      Height = 23
      Color = clCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Button3: TButton
      Left = 341
      Top = 39
      Width = 55
      Height = 25
      Caption = 'OPEN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 175
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 48
    Top = 175
  end
  object ADOTable1: TADOTable
    Left = 80
    Top = 175
  end
  object ADOCommand1: TADOCommand
    Parameters = <>
    Left = 112
    Top = 175
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 144
    Top = 175
  end
  object ADOQuery2: TADOQuery
    Parameters = <>
    Left = 176
    Top = 175
  end
  object OpenDialog1: TOpenDialog
    Left = 208
    Top = 175
  end
end
