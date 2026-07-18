object PaySlip: TPaySlip
  Left = 0
  Top = 0
  Width = 993
  Height = 678
  Caption = 'PaySlip'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label17: TLabel
    Left = 60
    Top = 175
    Width = 38
    Height = 13
    Caption = 'OT_Pay'
  end
  object Label18: TLabel
    Left = 60
    Top = 151
    Width = 38
    Height = 13
    Caption = 'OT_Pay'
  end
  object Label55: TLabel
    Left = 32
    Top = 17
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label56: TLabel
    Left = 304
    Top = 17
    Width = 37
    Height = 13
    Caption = 'Amount'
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 337
    Height = 636
    Caption = 'Panel1'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 8
      Top = 104
      Width = 321
      Height = 476
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object edtSearch: TEdit
      Left = 8
      Top = 74
      Width = 321
      Height = 21
      TabOrder = 1
      Text = 'edtRatePerMonthNonKeyers'
      OnChange = edtSearchChange
    end
    object Panel6: TPanel
      Left = 8
      Top = 8
      Width = 321
      Height = 57
      TabOrder = 2
      object Label28: TLabel
        Left = 8
        Top = 1
        Width = 51
        Height = 13
        Caption = 'Pay Period'
      end
      object cboDate: TComboBox
        Left = 8
        Top = 21
        Width = 201
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'cboDate'
        OnChange = cboDateChange
        Items.Strings = (
          '')
      end
      object cboYear: TComboBox
        Left = 223
        Top = 21
        Width = 90
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'ComboBox1'
        OnChange = cboYearChange
      end
    end
    object Panel11: TPanel
      Left = 8
      Top = 586
      Width = 321
      Height = 41
      TabOrder = 3
      object btnPrintAll: TBitBtn
        Left = 8
        Top = 8
        Width = 153
        Height = 25
        Caption = 'Print All'
        TabOrder = 0
        OnClick = btnPrintAllClick
      end
      object btnPrint: TBitBtn
        Left = 168
        Top = 8
        Width = 145
        Height = 25
        Caption = 'Print'
        TabOrder = 1
        OnClick = btnPrintClick
      end
    end
  end
  object Panel2: TPanel
    Left = 352
    Top = 8
    Width = 631
    Height = 636
    TabOrder = 1
    object Panel7: TPanel
      Left = 216
      Top = 8
      Width = 402
      Height = 619
      TabOrder = 3
      object Panel12: TPanel
        Left = 8
        Top = 216
        Width = 385
        Height = 153
        TabOrder = 1
        object Label25: TLabel
          Left = 8
          Top = 83
          Width = 133
          Height = 13
          Caption = 'Other Deductions After Tax'
        end
        object Label26: TLabel
          Left = 8
          Top = 1
          Width = 121
          Height = 13
          Caption = 'Other Earnings After Tax'
        end
        object Label48: TLabel
          Left = 32
          Top = 17
          Width = 53
          Height = 13
          Caption = 'Description'
        end
        object Label49: TLabel
          Left = 272
          Top = 17
          Width = 37
          Height = 13
          Caption = 'Amount'
        end
        object Label50: TLabel
          Left = 8
          Top = 65
          Width = 6
          Height = 13
          Caption = '2'
        end
        object Label51: TLabel
          Left = 8
          Top = 41
          Width = 6
          Height = 13
          Caption = '1'
        end
        object Label39: TLabel
          Left = 8
          Top = 103
          Width = 6
          Height = 13
          Caption = '1'
        end
        object Label40: TLabel
          Left = 8
          Top = 127
          Width = 6
          Height = 13
          Caption = '2'
        end
        object edtEarn4: TEdit
          Left = 270
          Top = 35
          Width = 107
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object edtEarn5: TEdit
          Left = 270
          Top = 60
          Width = 107
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
        end
        object edtEarnDesc5: TEdit
          Left = 32
          Top = 60
          Width = 225
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
        object edtEarnDesc4: TEdit
          Left = 32
          Top = 35
          Width = 225
          Height = 21
          TabOrder = 3
          Text = 'Edit1'
        end
        object edtOtherDed4: TEdit
          Left = 271
          Top = 98
          Width = 106
          Height = 21
          TabOrder = 4
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtOtherDedDesc4: TEdit
          Left = 32
          Top = 98
          Width = 225
          Height = 21
          TabOrder = 5
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtOtherDed5: TEdit
          Left = 271
          Top = 122
          Width = 106
          Height = 21
          TabOrder = 6
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtOtherDedDesc5: TEdit
          Left = 32
          Top = 122
          Width = 225
          Height = 21
          TabOrder = 7
          Text = 'edtRatePerMonthNonKeyers'
        end
      end
      object Panel9: TPanel
        Left = 8
        Top = 372
        Width = 385
        Height = 238
        TabOrder = 0
        object Label30: TLabel
          Left = 11
          Top = 17
          Width = 32
          Height = 13
          Caption = 'W/Tax'
        end
        object Label31: TLabel
          Left = 11
          Top = 41
          Width = 33
          Height = 13
          Caption = 'SSS EE'
        end
        object Label32: TLabel
          Left = 211
          Top = 41
          Width = 34
          Height = 13
          Caption = 'SSS ER'
        end
        object Label33: TLabel
          Left = 11
          Top = 65
          Width = 61
          Height = 13
          Caption = 'Philhealth EE'
        end
        object Label34: TLabel
          Left = 211
          Top = 65
          Width = 62
          Height = 13
          Caption = 'Philhealth ER'
        end
        object Label35: TLabel
          Left = 11
          Top = 89
          Width = 36
          Height = 13
          Caption = 'ECC ER'
        end
        object Label44: TLabel
          Left = 11
          Top = 113
          Width = 51
          Height = 13
          Caption = 'PagIbig EE'
        end
        object Label45: TLabel
          Left = 211
          Top = 113
          Width = 52
          Height = 13
          Caption = 'PagIbig ER'
        end
        object edtWTax: TEdit
          Left = 80
          Top = 10
          Width = 176
          Height = 21
          TabOrder = 0
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtSSSEE: TEdit
          Left = 80
          Top = 34
          Width = 97
          Height = 21
          TabOrder = 1
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtSSSER: TEdit
          Left = 280
          Top = 34
          Width = 97
          Height = 21
          TabOrder = 2
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtPhilHealthEE: TEdit
          Left = 80
          Top = 58
          Width = 97
          Height = 21
          TabOrder = 3
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtPhilHealthER: TEdit
          Left = 280
          Top = 58
          Width = 97
          Height = 21
          TabOrder = 4
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtECCER: TEdit
          Left = 80
          Top = 82
          Width = 176
          Height = 21
          TabOrder = 5
          Text = 'edtRatePerMonthNonKeyers'
        end
        object Panel10: TPanel
          Left = 8
          Top = 152
          Width = 369
          Height = 77
          TabOrder = 6
          object Label46: TLabel
            Left = 11
            Top = 20
            Width = 75
            Height = 13
            Caption = 'Total Deduction'
          end
          object Label47: TLabel
            Left = 11
            Top = 52
            Width = 38
            Height = 13
            Caption = 'Net Pay'
          end
          object edtTotalDed: TEdit
            Left = 93
            Top = 12
            Width = 260
            Height = 21
            TabOrder = 0
            Text = 'edtRatePerMonthNonKeyers'
          end
          object edtNetPay: TEdit
            Left = 93
            Top = 44
            Width = 260
            Height = 21
            TabOrder = 1
            Text = 'edtRatePerMonthNonKeyers'
          end
        end
        object edtPagIbigEE: TEdit
          Left = 80
          Top = 106
          Width = 97
          Height = 21
          TabOrder = 7
          Text = 'edtRatePerMonthNonKeyers'
        end
        object edtPagIbigER: TEdit
          Left = 280
          Top = 106
          Width = 97
          Height = 21
          TabOrder = 8
          Text = 'edtRatePerMonthNonKeyers'
        end
      end
    end
    object Panel3: TPanel
      Left = 8
      Top = 8
      Width = 201
      Height = 169
      TabOrder = 0
      object Label2: TLabel
        Left = 7
        Top = 25
        Width = 57
        Height = 13
        Caption = 'Rate/Month'
        WordWrap = True
      end
      object Label3: TLabel
        Left = 7
        Top = 55
        Width = 46
        Height = 13
        Caption = 'Rate/Day'
        WordWrap = True
      end
      object Label4: TLabel
        Left = 7
        Top = 77
        Width = 65
        Height = 26
        Caption = 'No. of Day(s) Absent'
        WordWrap = True
      end
      object Label5: TLabel
        Left = 7
        Top = 115
        Width = 45
        Height = 13
        Caption = 'Basic Pay'
        WordWrap = True
      end
      object Label6: TLabel
        Left = 7
        Top = 137
        Width = 56
        Height = 13
        Caption = 'Holiday Pay'
        WordWrap = True
      end
      object Label1: TLabel
        Left = 8
        Top = 1
        Width = 62
        Height = 13
        Caption = 'Non - Keyers'
      end
      object edtRatePerMonthNonKeyers: TEdit
        Left = 80
        Top = 18
        Width = 107
        Height = 21
        TabOrder = 0
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtRatePerDayNonKeyers: TEdit
        Left = 80
        Top = 48
        Width = 107
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
      object edtNoAbsentNonKeyers: TEdit
        Left = 80
        Top = 78
        Width = 107
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
      end
      object edtBasicPayNonKeyers: TEdit
        Left = 80
        Top = 108
        Width = 106
        Height = 21
        TabOrder = 3
        Text = 'Edit1'
      end
      object edtHolPayNonKeyers: TEdit
        Left = 80
        Top = 138
        Width = 107
        Height = 21
        TabOrder = 4
        Text = 'Edit1'
      end
    end
    object Panel4: TPanel
      Left = 8
      Top = 181
      Width = 201
      Height = 378
      TabOrder = 1
      object Label7: TLabel
        Left = 8
        Top = 1
        Width = 33
        Height = 13
        Caption = 'Keyers'
      end
      object Label8: TLabel
        Left = 6
        Top = 26
        Width = 42
        Height = 13
        Caption = 'Rate/Hr.'
        WordWrap = True
      end
      object Label9: TLabel
        Left = 6
        Top = 56
        Width = 56
        Height = 13
        Caption = 'Hr(s). Work'
        WordWrap = True
      end
      object Label10: TLabel
        Left = 6
        Top = 86
        Width = 45
        Height = 13
        Caption = 'Basic Pay'
        WordWrap = True
      end
      object Label11: TLabel
        Left = 6
        Top = 116
        Width = 45
        Height = 13
        Caption = 'OT Hr(s).'
        WordWrap = True
      end
      object Label12: TLabel
        Left = 6
        Top = 236
        Width = 69
        Height = 13
        Caption = 'Day Off Hr(s).'
        WordWrap = True
      end
      object Label13: TLabel
        Left = 6
        Top = 146
        Width = 35
        Height = 13
        Caption = 'OT Pay'
        WordWrap = True
      end
      object Label14: TLabel
        Left = 6
        Top = 176
        Width = 60
        Height = 13
        Caption = 'Day(s) Work'
        WordWrap = True
      end
      object Label15: TLabel
        Left = 6
        Top = 266
        Width = 59
        Height = 13
        Caption = 'Day Off Pay'
        WordWrap = True
      end
      object Label16: TLabel
        Left = 6
        Top = 206
        Width = 27
        Height = 13
        Caption = 'COLA'
        WordWrap = True
      end
      object Label19: TLabel
        Left = 6
        Top = 326
        Width = 50
        Height = 13
        Caption = 'Bonus Pay'
        WordWrap = True
      end
      object Label20: TLabel
        Left = 6
        Top = 296
        Width = 66
        Height = 13
        Caption = 'Night Diff Pay'
        WordWrap = True
      end
      object Label21: TLabel
        Left = 6
        Top = 356
        Width = 59
        Height = 13
        Caption = ' Holiday Pay'
        WordWrap = True
      end
      object edtRatePerHrsKeyers: TEdit
        Left = 80
        Top = 19
        Width = 105
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object edtHrsWorkKeyers: TEdit
        Left = 80
        Top = 49
        Width = 105
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
      object edtBasicPayKeyers: TEdit
        Left = 80
        Top = 79
        Width = 105
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
      end
      object edtOTHrsKeyers: TEdit
        Left = 80
        Top = 109
        Width = 105
        Height = 21
        TabOrder = 3
        Text = 'Edit1'
      end
      object edtOTPayKeyers: TEdit
        Left = 80
        Top = 139
        Width = 105
        Height = 21
        TabOrder = 4
        Text = 'Edit1'
      end
      object edtNDPayKeyers: TEdit
        Left = 80
        Top = 289
        Width = 105
        Height = 21
        TabOrder = 5
        Text = 'Edit1'
      end
      object edtDayOffPayKeyers: TEdit
        Left = 80
        Top = 259
        Width = 105
        Height = 21
        TabOrder = 6
        Text = 'Edit1'
      end
      object edtDayOffHrsKeyers: TEdit
        Left = 80
        Top = 229
        Width = 105
        Height = 21
        TabOrder = 7
        Text = 'Edit1'
      end
      object edtColaKeyers: TEdit
        Left = 80
        Top = 199
        Width = 105
        Height = 21
        TabOrder = 8
        Text = 'Edit1'
      end
      object edtDayWorkKeyers: TEdit
        Left = 80
        Top = 169
        Width = 105
        Height = 21
        TabOrder = 9
        Text = 'Edit1'
      end
      object EdtHolPayKeyers: TEdit
        Left = 80
        Top = 349
        Width = 105
        Height = 21
        TabOrder = 10
        Text = 'Edit1'
      end
      object edtBonusPayKeyers: TEdit
        Left = 80
        Top = 319
        Width = 105
        Height = 21
        TabOrder = 11
        Text = 'Edit1'
      end
    end
    object Panel5: TPanel
      Left = 224
      Top = 14
      Width = 385
      Height = 203
      TabOrder = 2
      object Label22: TLabel
        Left = 8
        Top = 41
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label23: TLabel
        Left = 8
        Top = 65
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label27: TLabel
        Left = 8
        Top = 1
        Width = 128
        Height = 13
        Caption = 'Other Earnings Before Tax'
      end
      object Label53: TLabel
        Left = 8
        Top = 106
        Width = 140
        Height = 13
        Caption = 'Other Deductions Before Tax'
      end
      object Label42: TLabel
        Left = 8
        Top = 129
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label43: TLabel
        Left = 8
        Top = 153
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label54: TLabel
        Left = 8
        Top = 177
        Width = 6
        Height = 13
        Caption = '3'
      end
      object Label24: TLabel
        Left = 8
        Top = 89
        Width = 6
        Height = 13
        Caption = '3'
      end
      object Label36: TLabel
        Left = 32
        Top = 17
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label41: TLabel
        Left = 272
        Top = 17
        Width = 37
        Height = 13
        Caption = 'Amount'
      end
      object edtEarn1: TEdit
        Left = 270
        Top = 34
        Width = 107
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object edtEarn2: TEdit
        Left = 270
        Top = 58
        Width = 107
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
      object edtEarn3: TEdit
        Left = 270
        Top = 82
        Width = 107
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
      end
      object edtEarnDesc1: TEdit
        Left = 35
        Top = 34
        Width = 222
        Height = 21
        TabOrder = 3
        Text = 'edtEarnDesc1'
      end
      object edtEarnDesc2: TEdit
        Left = 35
        Top = 58
        Width = 222
        Height = 21
        TabOrder = 4
        Text = 'Edit1'
      end
      object edtEarnDesc3: TEdit
        Left = 35
        Top = 82
        Width = 222
        Height = 21
        TabOrder = 5
        Text = 'Edit1'
      end
      object edtOtherDed1: TEdit
        Left = 272
        Top = 122
        Width = 105
        Height = 21
        TabOrder = 6
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtOtherDedDesc1: TEdit
        Left = 35
        Top = 122
        Width = 222
        Height = 21
        TabOrder = 7
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtOtherDed2: TEdit
        Left = 272
        Top = 146
        Width = 105
        Height = 21
        TabOrder = 8
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtOtherDedDesc2: TEdit
        Left = 35
        Top = 146
        Width = 222
        Height = 21
        TabOrder = 9
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtOtherDed3: TEdit
        Left = 272
        Top = 170
        Width = 105
        Height = 21
        TabOrder = 10
        Text = 'edtRatePerMonthNonKeyers'
      end
      object edtOtherDedDesc3: TEdit
        Left = 35
        Top = 170
        Width = 222
        Height = 21
        TabOrder = 11
        Text = 'edtRatePerMonthNonKeyers'
      end
    end
    object Panel8: TPanel
      Left = 8
      Top = 563
      Width = 201
      Height = 64
      TabOrder = 4
      object Label29: TLabel
        Left = 11
        Top = 9
        Width = 48
        Height = 13
        Caption = 'Gross Pay'
      end
      object edtGrossPay: TEdit
        Left = 9
        Top = 26
        Width = 176
        Height = 21
        TabOrder = 0
        Text = 'edtRatePerMonthNonKeyers'
      end
    end
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 32
    Top = 160
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 72
    Top = 160
  end
  object DataSource1: TDataSource
    OnDataChange = DataSource1DataChange
    Left = 112
    Top = 160
  end
  object ADODataSet2: TADODataSet
    Parameters = <>
    Left = 448
    Top = 24
  end
  object ADODataJobCode: TADODataSet
    Parameters = <>
    Left = 72
    Top = 200
  end
  object ADODataSet3: TADODataSet
    Parameters = <>
    Left = 72
    Top = 232
  end
  object ADODataSetEmpName: TADODataSet
    Parameters = <>
    Left = 72
    Top = 264
  end
end
