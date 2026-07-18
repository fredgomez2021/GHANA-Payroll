object Form2: TForm2
  Left = 0
  Top = 0
  Width = 693
  Height = 155
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 16
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 48
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 16
    Width = 129
    Height = 25
    Caption = 'Transfer Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 312
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit3: TEdit
    Left = 312
    Top = 80
    Width = 305
    Height = 21
    TabOrder = 5
    Text = 'Edit3'
  end
  object Button4: TButton
    Left = 144
    Top = 24
    Width = 75
    Height = 25
    Caption = 'GET IP'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 176
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 7
    OnClick = Button5Click
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 648
    Top = 8
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 648
    Top = 40
  end
  object ADOConnection2: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 608
    Top = 8
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection2
    Parameters = <>
    Left = 608
    Top = 40
  end
  object Open1: TOpenDialog
    Left = 456
    Top = 16
  end
end
