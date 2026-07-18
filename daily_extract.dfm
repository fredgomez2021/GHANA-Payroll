object frmDailySchedExtract: TfrmDailySchedExtract
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ':: Extraction of Daily Schedule Report ::'
  ClientHeight = 203
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 17
    Top = 18
    Width = 456
    Height = 143
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 131
      Height = 16
      Caption = 'Select File to Extract :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 40
      Width = 377
      Height = 23
      Color = clBtnHighlight
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 66
      Width = 377
      Height = 25
      Caption = 'Extract Daily Schedule Report'
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
      Left = 16
      Top = 96
      Width = 377
      Height = 23
      Color = clInactiveCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Button3: TButton
      Left = 397
      Top = 40
      Width = 43
      Height = 21
      Caption = '...'
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
  object Button2: TButton
    Left = 392
    Top = 168
    Width = 81
    Height = 25
    Caption = 'CLOSE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 24
    Top = 184
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 56
    Top = 184
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 88
    Top = 184
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 120
    Top = 184
  end
end
