object frmIdleEntry: TfrmIdleEntry
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Idle Entry Form'
  ClientHeight = 390
  ClientWidth = 444
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
    Left = 16
    Top = 7
    Width = 415
    Height = 204
    Caption = 'KEYER INFO'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 27
      Width = 97
      Height = 16
      Caption = 'Production Date:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 37
      Top = 66
      Width = 87
      Height = 16
      Caption = 'Employee PIN:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 25
      Top = 93
      Width = 100
      Height = 16
      Caption = 'Employee Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 72
      Top = 120
      Width = 54
      Height = 16
      Caption = 'Keyer ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 78
      Top = 147
      Width = 48
      Height = 16
      Caption = 'Task ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 25
      Top = 173
      Width = 101
      Height = 16
      Caption = 'Task Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 249
      Top = 146
      Width = 68
      Height = 16
      Caption = 'Piece Rate:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object txtEmployeePIN: TEdit
      Left = 138
      Top = 62
      Width = 177
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = txtEmployeePINKeyPress
    end
    object txtEmployeeName: TEdit
      Left = 138
      Top = 88
      Width = 257
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtPieceRate: TEdit
      Left = 321
      Top = 140
      Width = 73
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object txtTaskDesc: TEdit
      Left = 138
      Top = 168
      Width = 257
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object dtDate: TDateTimePicker
      Left = 138
      Top = 24
      Width = 105
      Height = 24
      Date = 38624.000000000000000000
      Time = 38624.000000000000000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object cmbKeyerID: TComboBox
      Left = 138
      Top = 114
      Width = 257
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 5
      OnClick = cmbKeyerIDClick
    end
    object Button3: TButton
      Left = 319
      Top = 62
      Width = 75
      Height = 25
      Caption = 'VIEW LIST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = Button3Click
    end
    object txtTaskID: TEdit
      Left = 138
      Top = 140
      Width = 97
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 216
    Width = 415
    Height = 139
    Caption = 'IDLE DETAILS'
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label8: TLabel
      Left = 65
      Top = 53
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
    object Label9: TLabel
      Left = 54
      Top = 78
      Width = 69
      Height = 16
      Caption = 'Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 68
      Top = 26
      Width = 56
      Height = 16
      Caption = 'Idle Time:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 306
      Top = 27
      Width = 54
      Height = 16
      Caption = 'minute(s)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object cmbIdleCode: TComboBox
      Left = 138
      Top = 47
      Width = 161
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = cmbIdleCodeClick
    end
    object memIdle: TMemo
      Left = 138
      Top = 72
      Width = 241
      Height = 57
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'memIdle')
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtIdleTime: TEdit
      Left = 138
      Top = 21
      Width = 161
      Height = 24
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object cmdSubmit: TButton
    Left = 340
    Top = 359
    Width = 89
    Height = 25
    Caption = '&SAVE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = cmdSubmitClick
  end
  object cmdView: TButton
    Left = 184
    Top = 359
    Width = 155
    Height = 25
    Caption = '&VIEW KEYED IDLE TIME'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdViewClick
  end
  object ADODataSet: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 64
    Top = 400
  end
  object ADOQuery: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 104
    Top = 400
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 400
  end
end
