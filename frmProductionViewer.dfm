object ProductionViewer: TProductionViewer
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Production Viewer'
  ClientHeight = 744
  ClientWidth = 1049
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 20
    Top = 8
    Width = 1021
    Height = 723
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label4: TLabel
      Left = 20
      Top = 132
      Width = 884
      Height = 7
      AutoSize = False
      Color = clMaroon
      ParentColor = False
    end
    object Label6: TLabel
      Left = 37
      Top = 649
      Width = 114
      Height = 17
      Caption = 'Total Documents:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 35
      Top = 680
      Width = 112
      Height = 17
      Caption = 'Total Time Taken:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalDocs: TLabel
      Left = 192
      Top = 649
      Width = 8
      Height = 18
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTimeTaken: TLabel
      Left = 192
      Top = 680
      Width = 8
      Height = 18
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 510
      Top = 649
      Width = 113
      Height = 17
      Caption = 'Total KeyStrokes:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalKS: TLabel
      Left = 658
      Top = 649
      Width = 8
      Height = 18
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 17
      Width = 213
      Height = 107
      Caption = 'Date Range'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 33
        Width = 39
        Height = 17
        Caption = 'From:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 35
        Top = 68
        Width = 19
        Height = 17
        Caption = 'To:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object dtDate1: TDateTimePicker
        Left = 68
        Top = 29
        Width = 126
        Height = 25
        Date = 38869.000000000000000000
        Time = 38869.000000000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dtDate2: TDateTimePicker
        Left = 68
        Top = 64
        Width = 126
        Height = 25
        Date = 38898.500000000000000000
        Time = 38898.500000000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 581
      Top = 18
      Width = 428
      Height = 106
      Caption = 'Filter by Keyer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object cmbEmployees: TComboBox
        Left = 105
        Top = 54
        Width = 312
        Height = 25
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        Sorted = True
        TabOrder = 3
        OnChange = cmbEmployeesChange
      end
      object chkEmployeeName: TCheckBox
        Left = 9
        Top = 56
        Width = 88
        Height = 22
        Caption = 'Name:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkEmployeeNameClick
      end
      object chkLocation: TCheckBox
        Left = 9
        Top = 24
        Width = 88
        Height = 22
        Caption = 'Location:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkLocationClick
      end
      object cboLocation: TComboBox
        Left = 105
        Top = 22
        Width = 312
        Height = 25
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnChange = cboLocationChange
        Items.Strings = (
          'MDEPI'
          'MDEPI-Subic')
      end
    end
    object GroupBox4: TGroupBox
      Left = 20
      Top = 146
      Width = 989
      Height = 476
      Caption = 'Production Detail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object dGridProduction: TDBGrid
        Left = 20
        Top = 27
        Width = 844
        Height = 429
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
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
    object GroupBox5: TGroupBox
      Left = 235
      Top = 18
      Width = 343
      Height = 106
      Caption = 'Filter by Task ID'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label10: TLabel
        Left = 17
        Top = 29
        Width = 107
        Height = 17
        Caption = 'Primary Task ID:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object cmbPrimaryTaskID: TComboBox
        Left = 143
        Top = 22
        Width = 184
        Height = 25
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        TabOrder = 0
        OnChange = cmbPrimaryTaskIDChange
      end
      object cmbTaskID: TComboBox
        Left = 143
        Top = 58
        Width = 184
        Height = 25
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        TabOrder = 1
        OnChange = cmbTaskIDChange
      end
      object chkTaskID: TCheckBox
        Left = 52
        Top = 63
        Width = 87
        Height = 22
        Caption = 'Task ID:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkTaskIDClick
      end
    end
  end
  object dSourceProd: TDataSource
    Left = 15
    Top = 564
  end
  object ADOProd: TADOConnection
    ConnectionTimeout = 0
    LoginPrompt = False
    Left = 63
    Top = 564
  end
  object dsProd: TADODataSet
    Connection = ADOProd
    CommandTimeout = 0
    Parameters = <>
    Left = 90
    Top = 564
  end
  object dsEmployees: TADODataSet
    Connection = ADOProd
    CommandTimeout = 0
    Parameters = <>
    Left = 117
    Top = 564
  end
  object dsTaskID: TADODataSet
    Connection = ADOProd
    CommandTimeout = 0
    Parameters = <>
    Left = 156
    Top = 564
  end
  object dsPrimaryTaskID: TADODataSet
    Connection = ADOProd
    CommandTimeout = 0
    Parameters = <>
    Left = 183
    Top = 564
  end
  object dsEmpName: TADODataSet
    Connection = ADOProd
    CommandTimeout = 0
    Parameters = <>
    Left = 210
    Top = 564
  end
end
