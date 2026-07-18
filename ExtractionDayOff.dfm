object frmDayOffExtraction: TfrmDayOffExtraction
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer day-off extraction ...'
  ClientHeight = 144
  ClientWidth = 434
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
    Height = 131
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 20
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
    object btnExtract: TButton
      Left = 20
      Top = 62
      Width = 369
      Height = 25
      Caption = 'Extract Day-off Details'
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
      Top = 38
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
      Left = 349
      Top = 36
      Width = 40
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
      Top = 90
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
  end
  object OpenDialog1: TOpenDialog
    Left = 80
    Top = 144
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 16
    Top = 144
  end
  object dsDayOff: TADODataSet
    Parameters = <>
    Left = 48
    Top = 144
  end
end
