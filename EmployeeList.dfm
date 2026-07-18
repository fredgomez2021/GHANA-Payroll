object frmEmployeeList: TfrmEmployeeList
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Search Employee'
  ClientHeight = 520
  ClientWidth = 427
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
    Left = 18
    Top = 10
    Width = 393
    Height = 474
    Color = clCream
    ParentColor = False
    TabOrder = 0
    object Shape1: TShape
      Left = 17
      Top = 164
      Width = 366
      Height = 290
      Brush.Color = clMenuHighlight
    end
    object DBGrid1: TDBGrid
      Left = 22
      Top = 169
      Width = 353
      Height = 279
      DataSource = DataSource1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 16
      Width = 361
      Height = 89
      Caption = 'SEARCH BY'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        361
        89)
      object txtEmployeeName: TEdit
        Left = 128
        Top = 46
        Width = 218
        Height = 22
        Anchors = [akLeft, akTop, akRight, akBottom]
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = txtEmployeeNameChange
      end
      object optPIN: TRadioButton
        Left = 15
        Top = 26
        Width = 98
        Height = 17
        Caption = 'Employee PIN'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = optPINClick
      end
      object optName: TRadioButton
        Left = 15
        Top = 50
        Width = 109
        Height = 17
        Caption = 'Employee Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = optNameClick
      end
      object txtEmpPIN: TEdit
        Left = 128
        Top = 22
        Width = 217
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = txtEmpPINChange
      end
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 109
      Width = 361
      Height = 51
      Caption = 'SORTY BY'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object optEmpPIN: TRadioButton
        Left = 20
        Top = 22
        Width = 97
        Height = 17
        Caption = 'Employee PIN'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object optEmpName: TRadioButton
        Left = 130
        Top = 22
        Width = 114
        Height = 17
        Caption = 'Employee Name'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object btnSort: TButton
        Left = 249
        Top = 18
        Width = 103
        Height = 21
        Caption = 'SORT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnSortClick
      end
    end
  end
  object cmdRefresh: TButton
    Left = 319
    Top = 486
    Width = 91
    Height = 25
    Caption = '&REFRESH'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdRefreshClick
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 496
  end
  object DataSource1: TDataSource
    Left = 56
    Top = 496
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 88
    Top = 496
  end
end
