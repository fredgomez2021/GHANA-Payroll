object frmExtractionsList: TfrmExtractionsList
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extractions to Load'
  ClientHeight = 311
  ClientWidth = 379
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 18
    Top = 7
    Width = 343
    Height = 294
    Caption = 'EXTRACTIONS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 20
      Width = 203
      Height = 15
      Caption = 'Select what Project Extraction to load:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 17
      Top = 39
      Width = 309
      Height = 214
      AutoSize = False
      Color = clHotLight
      ParentColor = False
    end
    object lsExtractions: TListBox
      Left = 24
      Top = 45
      Width = 297
      Height = 201
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
    end
    object cmdLoad: TButton
      Left = 251
      Top = 257
      Width = 75
      Height = 25
      Caption = 'LOAD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cmdLoadClick
    end
  end
  object ADOProjects: TADOConnection
    LoginPrompt = False
    Left = 392
    Top = 120
  end
  object dsProjects: TADODataSet
    Connection = ADOProjects
    Parameters = <>
    Left = 392
    Top = 152
  end
end
