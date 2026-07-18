object frmExtractionUHRC: TfrmExtractionUHRC
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'UHRC Allocation Extractor'
  ClientHeight = 148
  ClientWidth = 446
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 18
    Top = 8
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
    Left = 167
    Top = 140
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 56
    Top = 136
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 96
    Top = 136
  end
  object ADOTable1: TADOTable
    Left = 136
    Top = 136
  end
end
