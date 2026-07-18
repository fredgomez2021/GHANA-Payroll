object frmExtractionAFLAC: TfrmExtractionAFLAC
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Extraction of AFLAC Project Report File'
  ClientHeight = 149
  ClientWidth = 438
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
    Left = 17
    Top = 7
    Width = 410
    Height = 135
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 115
      Height = 15
      Caption = 'Select File to Extract :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 40
      Width = 313
      Height = 23
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 68
      Width = 377
      Height = 25
      Caption = 'EXTRACT NOW'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 16
      Top = 99
      Width = 377
      Height = 23
      Color = clCaptionText
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Button3: TButton
      Left = 337
      Top = 38
      Width = 56
      Height = 25
      Caption = 'OPEN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 32
    Top = 152
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 72
    Top = 152
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Payroll;Data Source=8R1'
    Parameters = <>
    Left = 104
    Top = 152
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 128
    Top = 152
  end
end
