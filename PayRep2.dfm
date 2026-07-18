object frmPayRep2: TfrmPayRep2
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'SSS ( EPF & MCL )'
  ClientHeight = 189
  ClientWidth = 443
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
    Left = 13
    Top = 10
    Width = 415
    Height = 171
    Caption = 'PAYROLL PERIOD'
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
      Left = 32
      Top = 24
      Width = 44
      Height = 19
      Caption = 'Year:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 200
      Top = 24
      Width = 57
      Height = 19
      Caption = 'Month:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 80
      Top = 59
      Width = 157
      Height = 19
      Caption = 'Transmission Date:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Button1: TButton
      Left = 32
      Top = 113
      Width = 353
      Height = 25
      Caption = 'GENERATE TEXTFILE NOW'
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
      Left = 32
      Top = 141
      Width = 353
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
    object ComboBox1: TComboBox
      Left = 88
      Top = 21
      Width = 93
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
      Text = 'ComboBox1'
    end
    object ComboBox2: TComboBox
      Left = 272
      Top = 21
      Width = 113
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 3
      Text = 'ComboBox1'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 248
      Top = 59
      Width = 105
      Height = 22
      Date = 38814.908960127320000000
      Time = 38814.908960127320000000
      TabOrder = 4
    end
    object CheckBox1: TCheckBox
      Left = 96
      Top = 93
      Width = 249
      Height = 17
      Caption = 'Check if you want to investigate the text file...'
      TabOrder = 5
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 208
    Top = 232
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 232
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Payroll;Data Source=8R1'
    Parameters = <>
    Left = 64
    Top = 232
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 104
    Top = 232
  end
  object SaveDialog1: TSaveDialog
    Left = 240
    Top = 232
  end
  object ADODataSet2: TADODataSet
    Parameters = <>
    Left = 136
    Top = 232
  end
end
