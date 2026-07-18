object frmViewKeyedIdleTime: TfrmViewKeyedIdleTime
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Keyer Idle Time Window'
  ClientHeight = 521
  ClientWidth = 640
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 6
    Width = 617
    Height = 509
    Caption = 'IDLE TIME'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Button3: TButton
      Left = 276
      Top = 21
      Width = 133
      Height = 74
      Caption = 'PROCESS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button3Click
    end
    object GroupBox2: TGroupBox
      Left = 21
      Top = 96
      Width = 580
      Height = 329
      TabOrder = 1
      object Shape1: TShape
        Left = 10
        Top = 12
        Width = 559
        Height = 309
        Brush.Color = clMenuHighlight
      end
      object DBGrid1: TDBGrid
        Left = 16
        Top = 16
        Width = 545
        Height = 300
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
      end
    end
    object GroupBox3: TGroupBox
      Left = 21
      Top = 424
      Width = 417
      Height = 70
      TabOrder = 2
      object Label3: TLabel
        Left = 22
        Top = 44
        Width = 183
        Height = 16
        Caption = 'Total Keyed Idle Time (in mins):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 22
        Top = 18
        Width = 147
        Height = 16
        Caption = 'Total Number of Records:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalIdleTime: TLabel
        Left = 246
        Top = 42
        Width = 8
        Height = 18
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNumberOfRecords: TLabel
        Left = 246
        Top = 16
        Width = 8
        Height = 18
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox4: TGroupBox
      Left = 22
      Top = 16
      Width = 251
      Height = 81
      Caption = 'date range ...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label1: TLabel
        Left = 23
        Top = 27
        Width = 32
        Height = 15
        Caption = 'From:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 39
        Top = 52
        Width = 17
        Height = 15
        Caption = 'To:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object dtDate: TDateTimePicker
        Left = 67
        Top = 22
        Width = 129
        Height = 23
        Date = 38624.539686770840000000
        Time = 38624.539686770840000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dtDate1: TDateTimePicker
        Left = 67
        Top = 46
        Width = 129
        Height = 23
        Date = 38624.539686770840000000
        Time = 38624.539686770840000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object ADOQuery: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 24
    Top = 504
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 120
    Top = 504
  end
  object ADOConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Top = 504
  end
  object DataSource: TDataSource
    Left = 56
    Top = 496
  end
end
