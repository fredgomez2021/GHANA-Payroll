object frmTimeExtraction: TfrmTimeExtraction
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'EDS Time Extraction'
  ClientHeight = 833
  ClientWidth = 901
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
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Shape3: TShape
    Left = 523
    Top = 10
    Width = 357
    Height = 138
    Brush.Color = clNavy
  end
  object Label2: TLabel
    Left = 532
    Top = 30
    Width = 338
    Height = 90
    Alignment = taCenter
    Caption = 
      'Select the range of time to extract then click on the Show Time ' +
      'button to view its details.  Click the Transfer Time button to r' +
      'efine log details from the EDS.  This will compute time-related ' +
      'fields.'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object Edit1: TEdit
    Left = 868
    Top = 246
    Width = 33
    Height = 25
    TabOrder = 0
    Visible = False
  end
  object Button3: TButton
    Left = 868
    Top = 275
    Width = 33
    Height = 32
    Caption = 'Button3'
    TabOrder = 1
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 29
    Top = 199
    Width = 848
    Height = 306
    Caption = 'TIME IN - TIME OUT FROM EDS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Shape1: TShape
      Left = 16
      Top = 31
      Width = 817
      Height = 232
      Brush.Color = clMenuHighlight
    end
    object Label1: TLabel
      Left = 18
      Top = 275
      Width = 139
      Height = 17
      Caption = 'Total Records Found:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblRecordsFound: TLabel
      Left = 192
      Top = 275
      Width = 4
      Height = 18
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGrid1: TDBGrid
      Left = 26
      Top = 42
      Width = 797
      Height = 210
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
    end
  end
  object GroupBox2: TGroupBox
    Left = 29
    Top = 510
    Width = 848
    Height = 307
    Caption = 'EXTRACTED TIME IN - TIME OUT'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object Shape2: TShape
      Left = 16
      Top = 31
      Width = 817
      Height = 232
      Brush.Color = clMenuHighlight
    end
    object lblExtractedRecords: TLabel
      Left = 192
      Top = 275
      Width = 4
      Height = 18
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 18
      Top = 275
      Width = 160
      Height = 17
      Caption = 'Total Records Extracted:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBGrid2: TDBGrid
      Left = 26
      Top = 42
      Width = 797
      Height = 210
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
    end
  end
  object GroupBox3: TGroupBox
    Left = 29
    Top = 5
    Width = 485
    Height = 189
    Color = clCream
    ParentColor = False
    TabOrder = 4
    object Label4: TLabel
      Left = 24
      Top = 24
      Width = 266
      Height = 17
      Caption = 'Choose branch database to extract from:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object optDates: TRadioButton
      Left = 24
      Top = 84
      Width = 145
      Height = 22
      Caption = 'Working Dates'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object Button1: TButton
      Left = 305
      Top = 110
      Width = 161
      Height = 33
      Caption = '&Show Time'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 305
      Top = 142
      Width = 161
      Height = 33
      Caption = '&TransferTime'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object dtDate1: TDateTimePicker
      Left = 51
      Top = 111
      Width = 243
      Height = 25
      Date = 38899.000000000000000000
      Time = 38899.000000000000000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = dtDate1Change
    end
    object dtDate2: TDateTimePicker
      Left = 51
      Top = 143
      Width = 243
      Height = 25
      Date = 38913.500000000000000000
      Time = 38913.500000000000000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object Button6: TButton
      Left = 303
      Top = 48
      Width = 159
      Height = 29
      Caption = 'Choose database...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button6Click
    end
    object txtPath: TEdit
      Left = 52
      Top = 48
      Width = 242
      Height = 25
      ReadOnly = True
      TabOrder = 6
    end
  end
  object Button7: TButton
    Left = 722
    Top = 199
    Width = 98
    Height = 32
    Caption = 'Button7'
    TabOrder = 5
    Visible = False
    OnClick = Button7Click
  end
  object Edit2: TEdit
    Left = 628
    Top = 146
    Width = 158
    Height = 25
    TabOrder = 6
    Visible = False
  end
  object Edit3: TEdit
    Left = 628
    Top = 178
    Width = 158
    Height = 25
    TabOrder = 7
    Visible = False
  end
  object Button4: TButton
    Left = 523
    Top = 157
    Width = 357
    Height = 33
    Caption = 'Eliminate excess time record(s)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 785
    Top = 115
    Width = 98
    Height = 33
    Caption = 'Button5'
    TabOrder = 9
    Visible = False
    OnClick = Button5Click
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 680
    Top = 88
  end
  object DS1: TDataSource
    Left = 680
    Top = 152
  end
  object ADODataSet: TADODataSet
    Parameters = <>
    Left = 680
    Top = 120
  end
  object ADOSQL: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 672
    Top = 368
  end
  object DataSetSQL: TADODataSet
    Parameters = <>
    Left = 672
    Top = 400
  end
  object SourceSQL: TDataSource
    Left = 672
    Top = 432
  end
  object dsSched: TADODataSet
    Parameters = <>
    Top = 392
  end
  object myDSet: TADODataSet
    Parameters = <>
    Top = 360
  end
  object dsFillBranch: TADODataSet
    Parameters = <>
    Left = 24
    Top = 640
  end
  object Open1: TOpenDialog
    Left = 608
    Top = 112
  end
  object dsEmployeeName: TADODataSet
    Parameters = <>
    Left = 672
    Top = 272
  end
  object dsLogFile: TADODataSet
    Connection = ADOSQL
    Parameters = <>
    Left = 56
    Top = 640
  end
  object dsCount: TADODataSet
    Parameters = <>
    Left = 672
    Top = 488
  end
  object dsPIN: TADODataSet
    Parameters = <>
    Left = 672
    Top = 520
  end
  object dsTime: TADODataSet
    Parameters = <>
    Left = 672
    Top = 552
  end
  object dsSummary: TADODataSet
    Connection = ADOSQL
    Parameters = <>
    Left = 672
    Top = 584
  end
  object spEmployees: TADOStoredProc
    Parameters = <>
    Left = 680
    Top = 472
  end
  object dsHoliday: TADODataSet
    Connection = ADOSQL
    Parameters = <>
    Left = 648
    Top = 112
  end
  object dsEmployees: TADODataSet
    Connection = ADOSQL
    Parameters = <>
    Left = 648
    Top = 136
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 8
    Top = 288
  end
  object ADODataSet2: TADODataSet
    Parameters = <>
    Left = 8
    Top = 192
  end
end
