object frmPayRep1: TfrmPayRep1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Payroll Data and Summary Export to EXCEL'
  ClientHeight = 180
  ClientWidth = 398
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
    Left = 12
    Top = 8
    Width = 373
    Height = 161
    Caption = 'payroll detail'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 27
      Top = 71
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
      Left = 204
      Top = 71
      Width = 16
      Height = 15
      Caption = 'To:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 14
      Top = 18
      Width = 345
      Height = 41
      Brush.Color = clMoneyGreen
      Pen.Style = psClear
    end
    object Label1: TLabel
      Left = 28
      Top = 31
      Width = 76
      Height = 15
      Caption = 'Project name:'
      Color = clMoneyGreen
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Button1: TButton
      Left = 27
      Top = 99
      Width = 326
      Height = 25
      Caption = 'EXPORT NOW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 27
      Top = 127
      Width = 326
      Height = 23
      Color = clInactiveCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DateTimePicker1: TDateTimePicker
      Left = 66
      Top = 66
      Width = 122
      Height = 22
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      TabOrder = 2
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker2: TDateTimePicker
      Left = 230
      Top = 66
      Width = 123
      Height = 22
      Date = 38625.396023657410000000
      Time = 38625.396023657410000000
      Enabled = False
      TabOrder = 3
    end
    object cboProject: TComboBox
      Left = 114
      Top = 27
      Width = 237
      Height = 22
      ItemHeight = 14
      TabOrder = 4
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 144
    Top = 184
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 184
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Payroll;Data Source=8R1'
    Parameters = <>
    Left = 64
    Top = 184
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 104
    Top = 184
  end
  object SaveDialog1: TSaveDialog
    Left = 184
    Top = 184
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 222
    Top = 183
  end
  object dsFillBranch: TADODataSet
    Parameters = <>
    Left = 272
    Top = 184
  end
end
