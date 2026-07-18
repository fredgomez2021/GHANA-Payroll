object frmIdleRemarksMaintenance: TfrmIdleRemarksMaintenance
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Idle Remarks File Maintenance'
  ClientHeight = 205
  ClientWidth = 334
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
    Left = 14
    Top = 7
    Width = 308
    Height = 161
    Caption = 'IDLE REMARKS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 44
      Top = 28
      Width = 58
      Height = 16
      Caption = 'Idle Code:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 55
      Width = 93
      Height = 16
      Caption = 'Idle Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object txtIdleCode: TEdit
      Left = 111
      Top = 23
      Width = 180
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 0
      OnKeyPress = txtIdleCodeKeyPress
    end
    object memIdle: TMemo
      Left = 111
      Top = 48
      Width = 179
      Height = 65
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'memIdle')
      ParentFont = False
      TabOrder = 1
    end
    object cmdAdd: TButton
      Left = 63
      Top = 125
      Width = 75
      Height = 25
      Caption = '&ADD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = cmdAddClick
    end
    object cmdEdit: TButton
      Left = 139
      Top = 125
      Width = 76
      Height = 25
      Caption = '&EDIT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cmdEditClick
    end
    object cmdDelete: TButton
      Left = 215
      Top = 125
      Width = 75
      Height = 25
      Caption = '&DELETE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cmdDeleteClick
    end
  end
  object cmdViewIdleRemarks: TButton
    Left = 158
    Top = 173
    Width = 163
    Height = 25
    Caption = '&VIEW IDLE REMARKS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdViewIdleRemarksClick
  end
  object ADOConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 176
  end
  object ADODataSet: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 64
    Top = 176
  end
  object dsLogFile: TADODataSet
    Connection = ADOConnection
    Parameters = <>
    Left = 96
    Top = 176
  end
end
