object frmTaskRemarks: TfrmTaskRemarks
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Task Remarks'
  ClientHeight = 281
  ClientWidth = 410
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
    Left = 14
    Top = 7
    Width = 379
    Height = 236
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 21
      Width = 48
      Height = 16
      Caption = 'Task-ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 348
      Height = 177
      AutoSize = False
      Color = clHighlight
      ParentColor = False
    end
    object DBGrid1: TDBGrid
      Left = 19
      Top = 51
      Width = 339
      Height = 169
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object txtTaskID: TEdit
      Left = 76
      Top = 16
      Width = 285
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = txtTaskIDChange
    end
  end
  object cmdRefresh: TButton
    Left = 302
    Top = 248
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
    Left = 56
    Top = 264
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 24
    Top = 264
  end
  object DataSource1: TDataSource
    Left = 88
    Top = 264
  end
end
