object frmProductionDocuments: TfrmProductionDocuments
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'MDEPI Production Documents'
  ClientHeight = 501
  ClientWidth = 737
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
    Left = 16
    Top = 6
    Width = 706
    Height = 483
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label4: TLabel
      Left = 15
      Top = 101
      Width = 676
      Height = 5
      AutoSize = False
      Color = clMaroon
      ParentColor = False
    end
    object Label6: TLabel
      Left = 383
      Top = 40
      Width = 95
      Height = 15
      Caption = 'Total documents:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalDocs: TLabel
      Left = 489
      Top = 40
      Width = 7
      Height = 15
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 402
      Top = 64
      Width = 75
      Height = 15
      Caption = 'Total records:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblRecords: TLabel
      Left = 489
      Top = 64
      Width = 7
      Height = 15
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox2: TGroupBox
      Left = 15
      Top = 13
      Width = 202
      Height = 82
      Caption = 'Date Range'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 25
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
      object Label2: TLabel
        Left = 27
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
      object dtDate1: TDateTimePicker
        Left = 52
        Top = 22
        Width = 133
        Height = 23
        Date = 38869.000000000000000000
        Time = 38869.000000000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = dtDate1Change
      end
      object dtDate2: TDateTimePicker
        Left = 52
        Top = 49
        Width = 133
        Height = 23
        Date = 38898.500000000000000000
        Time = 38898.500000000000000000
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object GroupBox4: TGroupBox
      Left = 15
      Top = 112
      Width = 676
      Height = 364
      Caption = 'Production Detail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object dGridProduction: TDBGrid
        Left = 15
        Top = 21
        Width = 646
        Height = 328
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
      end
    end
    object btnViewDocuments: TButton
      Left = 220
      Top = 20
      Width = 141
      Height = 73
      Caption = 'view DOCUMENTS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnViewDocumentsClick
    end
  end
  object dSourceProd: TDataSource
    Left = 15
    Top = 492
  end
  object ADOProd: TADOConnection
    LoginPrompt = False
    Left = 71
    Top = 492
  end
  object dsProd: TADODataSet
    Connection = ADOProd
    Parameters = <>
    Left = 98
    Top = 492
  end
  object dsProdGrid: TADODataSet
    Connection = ADOProd
    Parameters = <>
    Left = 122
    Top = 492
  end
end
