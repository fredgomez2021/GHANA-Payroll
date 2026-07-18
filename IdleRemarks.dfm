object frmIdleRemarks: TfrmIdleRemarks
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Idle Remarks'
  ClientHeight = 280
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 21
    Top = 8
    Width = 409
    Height = 233
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 14
      Width = 385
      Height = 209
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object DBGrid1: TDBGrid
      Left = 18
      Top = 17
      Width = 371
      Height = 201
      DataSource = DataSource1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object cmdRefresh: TButton
    Left = 339
    Top = 246
    Width = 91
    Height = 25
    Caption = '&REFRESH'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdRefreshClick
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 248
  end
  object DataSource1: TDataSource
    Left = 56
    Top = 248
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 88
    Top = 248
  end
end
