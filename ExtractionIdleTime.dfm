object frmIdleTimeExtraction: TfrmIdleTimeExtraction
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer idle time extraction ...'
  ClientHeight = 181
  ClientWidth = 432
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
    Left = 14
    Top = 5
    Width = 409
    Height = 164
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 57
      Width = 107
      Height = 15
      Alignment = taCenter
      Caption = 'Select file to extract:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 20
      Width = 209
      Height = 15
      Alignment = taCenter
      Caption = 'Select starting payroll period to extract:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 20
      Top = 45
      Width = 367
      Height = 5
      AutoSize = False
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -7
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnExtract: TButton
      Left = 20
      Top = 99
      Width = 369
      Height = 25
      Caption = 'Extract Idle Time Details'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnExtractClick
    end
    object txtFile: TEdit
      Left = 21
      Top = 75
      Width = 324
      Height = 23
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object btnOpen: TButton
      Left = 348
      Top = 73
      Width = 41
      Height = 24
      Caption = '. . .'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnOpenClick
    end
    object txtProgress: TEdit
      Left = 20
      Top = 127
      Width = 369
      Height = 23
      BevelInner = bvSpace
      BevelOuter = bvNone
      Color = clCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object dtPeriod: TDateTimePicker
      Left = 232
      Top = 16
      Width = 107
      Height = 23
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = dtPeriodChange
    end
    object dtTo: TDateTimePicker
      Left = 344
      Top = 16
      Width = 54
      Height = 23
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 160
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Top = 160
  end
  object dsIdleTime: TADODataSet
    Parameters = <>
    Left = 24
    Top = 160
  end
  object dsPeriod: TADODataSet
    Parameters = <>
    Left = 80
    Top = 160
  end
end
