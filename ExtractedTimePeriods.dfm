object frmExtractedTimePeriods: TfrmExtractedTimePeriods
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extracted Time Periods'
  ClientHeight = 391
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 16
    Width = 529
    Height = 329
    Caption = 'Periods'
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 21
      Width = 505
      Height = 297
      AutoSize = False
      Color = clHotLight
      ParentColor = False
    end
    object dbTime: TDBGrid
      Left = 20
      Top = 28
      Width = 486
      Height = 283
      DataSource = dsourceTime
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Button1: TButton
    Left = 480
    Top = 354
    Width = 75
    Height = 25
    Caption = 'CLOSE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object dsourceTime: TDataSource
    DataSet = dsTime
    Left = 552
    Top = 16
  end
  object dsTime: TADODataSet
    Connection = ADOTime
    Parameters = <>
    Left = 552
    Top = 48
  end
  object ADOTime: TADOConnection
    LoginPrompt = False
    Left = 552
    Top = 80
  end
end
