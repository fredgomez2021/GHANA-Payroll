unit untPaySlip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB, ADODB, StdCtrls, Buttons, ShellAPI;

type
  TPaySlip = class(TForm)
    ADOConn: TADOConnection;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    edtRatePerMonthNonKeyers: TEdit;
    edtRatePerDayNonKeyers: TEdit;
    edtNoAbsentNonKeyers: TEdit;
    edtBasicPayNonKeyers: TEdit;
    edtHolPayNonKeyers: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel4: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtRatePerHrsKeyers: TEdit;
    edtHrsWorkKeyers: TEdit;
    edtBasicPayKeyers: TEdit;
    edtOTHrsKeyers: TEdit;
    edtOTPayKeyers: TEdit;
    edtNDPayKeyers: TEdit;
    edtDayOffPayKeyers: TEdit;
    edtDayOffHrsKeyers: TEdit;
    edtColaKeyers: TEdit;
    edtDayWorkKeyers: TEdit;
    EdtHolPayKeyers: TEdit;
    edtBonusPayKeyers: TEdit;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Panel5: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Label27: TLabel;
    edtEarn1: TEdit;
    edtEarn2: TEdit;
    edtEarn3: TEdit;
    ADODataSet2: TADODataSet;
    edtSearch: TEdit;
    Panel6: TPanel;
    cboDate: TComboBox;
    cboYear: TComboBox;
    Label28: TLabel;
    ADODataJobCode: TADODataSet;
    Panel7: TPanel;
    Panel9: TPanel;
    Label30: TLabel;
    edtWTax: TEdit;
    edtSSSEE: TEdit;
    edtSSSER: TEdit;
    edtPhilHealthEE: TEdit;
    edtPhilHealthER: TEdit;
    edtECCER: TEdit;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Panel10: TPanel;
    Label46: TLabel;
    edtTotalDed: TEdit;
    edtNetPay: TEdit;
    Label47: TLabel;
    Panel11: TPanel;
    btnPrintAll: TBitBtn;
    btnPrint: TBitBtn;
    edtEarnDesc1: TEdit;
    edtEarnDesc2: TEdit;
    edtEarnDesc3: TEdit;
    ADODataSet3: TADODataSet;
    ADODataSetEmpName: TADODataSet;
    edtOtherDed1: TEdit;
    edtOtherDedDesc1: TEdit;
    edtOtherDed2: TEdit;
    edtOtherDedDesc2: TEdit;
    edtOtherDed3: TEdit;
    edtOtherDedDesc3: TEdit;
    Label53: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label54: TLabel;
    Label24: TLabel;
    Label36: TLabel;
    Label41: TLabel;
    Panel12: TPanel;
    edtEarn4: TEdit;
    edtEarn5: TEdit;
    edtEarnDesc5: TEdit;
    edtEarnDesc4: TEdit;
    edtOtherDed4: TEdit;
    edtOtherDedDesc4: TEdit;
    edtOtherDed5: TEdit;
    edtOtherDedDesc5: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label44: TLabel;
    edtPagIbigEE: TEdit;
    Label45: TLabel;
    edtPagIbigER: TEdit;
    Panel8: TPanel;
    Label29: TLabel;
    edtGrossPay: TEdit;
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintAllClick(Sender: TObject);
    procedure cboYearChange(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure cboDateChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowEmployee;
    procedure SearchEmployee(mySearch: string);
    procedure ClearKeyers;
    procedure ClearNonKeyers;
    procedure ClearOthers;
    procedure CreateYear;
    procedure ClearMisc;
    procedure CreateDate;
    procedure QueryPaySlip;
    procedure CopyQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PaySlip: TPaySlip;
  vSQL: string;
  vEmpID : string;
  vPeriod : string;
  vPeriodDate : string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  Closed: Boolean;

implementation

uses CommonModule;

{$R *.dfm}
procedure TPaySlip.ShowEmployee;
begin
  ADODataSet1.Active  := False;

  ADODataSet1.Connection := ADOConn;
  vSQL := 'SELECT Employee_PIN, Employee_Name FROM dtaEmployees ORDER BY Employee_Name ASC';
  ADODataSet1.CommandText := vSQL;

  ADODataSet1.Active := True;
  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
end;

procedure TPaySlip.SearchEmployee(mySearch: string);
begin
  ADODataSet1.Active  := False;

  ADODataSet1.Connection := ADOConn;
  vSQL := 'SELECT Employee_PIN, Employee_Name FROM dtaEmployees WHERE Employee_Name like ' + Chr(39) + mySearch + '%' + Chr(39);
  ADODataSet1.CommandText := vSQL;

  ADODataSet1.Active := True;
  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
end;

procedure TPaySlip.ClearKeyers;
begin
  edtRatePerHrsKeyers.Clear;
  edtHrsWorkKeyers.Clear;
  edtBasicPayKeyers.Clear;
  edtOTHrsKeyers.Clear;
  edtOTPayKeyers.Clear;
  edtDayWorkKeyers.Clear;
  edtColaKeyers.Clear;
  edtDayOffHrsKeyers.Clear;
  edtDayOffPayKeyers.Clear;
  edtNDPayKeyers.Clear;
  edtBonusPayKeyers.Clear;
  EdtHolPayKeyers.Clear;
end;

procedure TPaySlip.ClearNonKeyers;
begin
  edtHolPayNonKeyers.Clear;
  edtBasicPayNonKeyers.Clear;
  edtNoAbsentNonKeyers.Clear;
  edtRatePerDayNonKeyers.Clear;
  edtRatePerMonthNonKeyers.Clear;
end;

procedure TPaySlip.ClearOthers;
begin
  edtEarn1.Clear;
  edtEarn2.Clear;
  edtEarn3.Clear;
  edtEarn4.Clear;
  edtEarn5.Clear;
  edtEarnDesc1.Clear;
  edtEarnDesc2.Clear;
  edtEarnDesc3.Clear;
  edtEarnDesc4.Clear;
  edtEarnDesc5.Clear;
end;

procedure TPaySlip.ClearMisc;
begin
  edtGrossPay.Clear;
  edtWTax.Clear;
  edtSSSEE.Clear;
  edtSSSER.Clear;
  edtPhilHealthEE.Clear;
  edtPhilHealthER.Clear;
  edtECCER.Clear;
  edtPagIbigEE.Clear;
  edtPagIbigER.Clear;
  edtOtherDed1.Clear;
  edtOtherDed2.Clear;
  edtOtherDed3.Clear;
  edtOtherDed4.Clear;
  edtOtherDed5.Clear;
  edtOtherDedDesc1.Clear;
  edtOtherDedDesc2.Clear;
  edtOtherDedDesc3.Clear;
  edtOtherDedDesc4.Clear;
  edtOtherDedDesc5.Clear;
  edtTotalDed.Clear;
  edtNetPay.Clear;
end;

procedure TPaySlip.CreateYear;
var
  i: integer;
  vYear, vMonth, vDay : Word;
  myYear: integer;
begin
  for i := 0 to 9 do
      begin
          DecodeDate(Date,vYear,vMonth,vDay);
          myYear := vYear + i;
          cboYear.Items.Add(IntToStr(myYear-5));
      end;
  cboYear.Text := IntToStr(vYear);
end;

procedure TPaySlip.CreateDate;
begin
  cboDate.Items.Clear;
  cboDate.Items.Add('January 1');
  cboDate.Items.Add('January 16');
  cboDate.Items.Add('February 1');
  cboDate.Items.Add('February 16');
  cboDate.Items.Add('March 1');
  cboDate.Items.Add('March 16');
  cboDate.Items.Add('April 1');
  cboDate.Items.Add('April 16');
  cboDate.Items.Add('May 1');
  cboDate.Items.Add('May 16');
  cboDate.Items.Add('June 1');
  cboDate.Items.Add('June 16');
  cboDate.Items.Add('July 1');
  cboDate.Items.Add('July 16');
  cboDate.Items.Add('August 1');
  cboDate.Items.Add('August 16');
  cboDate.Items.Add('September 1');
  cboDate.Items.Add('September 16');
  cboDate.Items.Add('October 1');
  cboDate.Items.Add('October 16');
  cboDate.Items.Add('November 1');
  cboDate.Items.Add('November 16');
  cboDate.Items.Add('December 1');
  cboDate.Items.Add('December 16');
  cboDate.Text := 'January 1';
end;

procedure TPaySlip.FormCreate(Sender: TObject);
begin
  ClearNonKeyers;
  ClearKeyers;
  ClearOthers;

  edtSearch.Clear;

  CreateYear;
  CreateDate;
//  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
//  ADOConn.Connected := TRUE;
end;

procedure TPaySlip.edtSearchChange(Sender: TObject);
begin    
  if ADOConn.Connected = TRUE then
      ADOConn.Connected := FALSE;

  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;

  if edtSearch.Text <> '' then
      begin
          SearchEmployee(edtSearch.Text);
      end
  else
      begin
          ShowEmployee;
      end;
end;

procedure TPaySlip.CopyQuery;
var
  dSQL:string;
begin
  dSQL := 'if exists (select * from xPaySlipTmp) DROP TABLE xPaySlipTmp';
  ADOConn.Execute(dSQL);
  ADOConn.Execute(vSQL);
end;

procedure TPaySlip.QueryPaySlip;
var
  vYear,vMonth,vDay : Word;
begin
  ClearNonKeyers;
  ClearKeyers;
  ClearOthers;
  ClearMisc;

  if cboYear.Text = 'ComboBox1' then
      begin
          DecodeDate(Date,vYear,vMonth,vDay);
          cboYear.Text := IntToStr(vYear);
      end;
  if vPeriod = '' then
      vPeriodDate := '01/01/' + (cboYear.Text)
  else
      vPeriodDate := vPeriod + '/' + cboYear.Text;

  //vPeriodDate := FormatDateTime('mm"/"dd"/"yyyy', StrToDate(vPeriodDate));

  ADODataSet2.Active := False;
  vEmpID := ADODataSet1.FieldByName('Employee_PIN').AsString;

  ADODataSet2.Connection := ADOConn;
  vSQL := 'SELECT * FROM dtaPayrollProcess WHERE Employee_PIN = ' + Chr(39) + vEmpID + Chr(39) + ' AND Period1 = ' + Chr(39) + vPeriodDate + Chr(39);
  ADODataSet2.CommandText := vSQL;
  ADODataSet2.Active := True;
  if ADODataSet2.Recordset.RecordCount  <> 0 then
      begin
          ADODataJobCode.Active := False;
          vSQL := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + Chr(39) + vEmpID + Chr(39);
          ADODataJobCode.Connection := ADOConn;
          ADODataJobCode.CommandText := vSQL;
          ADODataJobCode.Active := True;
          if ADODataJobCode.FieldByName('Job_Position_Code').AsString <> 'KEYER' then
              begin
                  ClearKeyers;
                  edtRatePerMonthNonKeyers.Text := ADODataSet2.FieldByName('Rate_Month1').AsString;
                  edtRatePerDayNonKeyers.Text := CurrToStr(StrToCurr(ADODataSet2.FieldByName('Rate_Day1').AsString) / 11);
                  edtHolPayNonKeyers.Text := ADODataSet2.FieldByName('Holiday_Pay1').AsString;
                  edtBasicPayNonKeyers.Text := ADODataSet2.FieldByName('Basic_Pay1').AsString;
                  edtNoAbsentNonKeyers.Text := ADODataSet2.FieldByName('Days_Absent1').AsString;
              end
          else
              begin
                  ClearNonKeyers;
                  edtRatePerHrsKeyers.Text := ADODataSet2.FieldByName('Rate_Hr2').AsString;
                  edtHrsWorkKeyers.Text := ADODataSet2.FieldByName('Hrs_Work2').AsString;
                  edtBasicPayKeyers.Text := ADODataSet2.FieldByName('Basic_Pay2').AsString;
                  edtOTHrsKeyers.Text := ADODataSet2.FieldByName('OT_Hrs2').AsString;
                  edtOTPayKeyers.Text := ADODataSet2.FieldByName('OT_Pay2').AsString;
                  edtDayWorkKeyers.Text := ADODataSet2.FieldByName('Days_Work2').AsString;
                  edtColaKeyers.Text := ADODataSet2.FieldByName('COLA2').AsString;
                  edtDayOffHrsKeyers.Text := ADODataSet2.FieldByName('Day_Off_Hrs2').AsString;
                  edtDayOffPayKeyers.Text := ADODataSet2.FieldByName('Day_Off_Pay2').AsString;
                  edtNDPayKeyers.Text := ADODataSet2.FieldByName('Night_Diff_Pay2').AsString;
                  edtBonusPayKeyers.Text := ADODataSet2.FieldByName('Bonus_Pay2').AsString;
                  EdtHolPayKeyers.Text := ADODataSet2.FieldByName('Holiday_Pay2').AsString;
              end;

          edtEarn1.Text := ADODataSet2.FieldByName('Other_Earn1').AsString;
          edtEarn2.Text := ADODataSet2.FieldByName('Other_Earn2').AsString;
          edtEarn3.Text := ADODataSet2.FieldByName('Other_Earn3').AsString;
          edtEarn4.Text := ADODataSet2.FieldByName('Other_Earn4').AsString;
          edtEarn5.Text := ADODataSet2.FieldByName('Other_Earn5').AsString;
          edtEarnDesc1.Text := ADODataSet2.FieldByName('Other_Earn_Desc1').AsString;
          edtEarnDesc2.Text := ADODataSet2.FieldByName('Other_Earn_Desc2').AsString;
          edtEarnDesc3.Text := ADODataSet2.FieldByName('Other_Earn_Desc3').AsString;
          edtEarnDesc4.Text := ADODataSet2.FieldByName('Other_Earn_Desc4').AsString;
          edtEarnDesc5.Text := ADODataSet2.FieldByName('Other_Earn_Desc5').AsString;

          edtGrossPay.Text := ADODataSet2.FieldByName('Gross_Pay').AsString;
          edtWTax.Text := ADODataSet2.FieldByName('With_Tax').AsString;
          edtSSSEE.Text := ADODataSet2.FieldByName('SSS_EE').AsString;
          edtSSSER.Text := ADODataSet2.FieldByName('SSS_ER').AsString;
          edtPhilHealthEE.Text := ADODataSet2.FieldByName('Philhealth_EE').AsString;
          edtPhilHealthER.Text := ADODataSet2.FieldByName('Philhealth_ER').AsString;
          edtECCER.Text := ADODataSet2.FieldByName('ECC_ER').AsString;
          edtPagIbigEE.Text := ADODataSet2.FieldByName('PagIbig_EE').AsString;
          edtPagIbigER.Text := ADODataSet2.FieldByName('PagIbig_ER').AsString;
          edtOtherDed1.Text := ADODataSet2.FieldByName('Other_Ded1').AsString;
          edtOtherDed2.Text := ADODataSet2.FieldByName('Other_Ded2').AsString;
          edtOtherDed3.Text := ADODataSet2.FieldByName('Other_Ded3').AsString;
          edtOtherDed4.Text := ADODataSet2.FieldByName('Other_Ded4').AsString;
          edtOtherDed5.Text := ADODataSet2.FieldByName('Other_Ded5').AsString;
          edtOtherDedDesc1.Text := ADODataSet2.FieldByName('Other_Ded_Desc1').AsString;
          edtOtherDedDesc2.Text := ADODataSet2.FieldByName('Other_Ded_Desc2').AsString;
          edtOtherDedDesc3.Text := ADODataSet2.FieldByName('Other_Ded_Desc3').AsString;
          edtOtherDedDesc4.Text := ADODataSet2.FieldByName('Other_Ded_Desc4').AsString;
          edtOtherDedDesc5.Text := ADODataSet2.FieldByName('Other_Ded_Desc5').AsString;
          edtTotalDed.Text := ADODataSet2.FieldByName('Total_Ded').AsString;
          edtNetPay.Text := ADODataSet2.FieldByName('Net_Pay').AsString;
      end
  else
      begin
          ClearOthers;
          ClearKeyers;
          ClearNonKeyers;
          ClearMisc;
      end
end;

procedure TPaySlip.cboDateChange(Sender: TObject);
begin
  if cboDate.Text = 'January 1' then
      vPeriod := '1/1'
  else if cboDate.Text = 'January 16' then
      vPeriod := '1/16'
  else if cboDate.Text = 'February 1' then
      vPeriod := '2/1'
  else if cboDate.Text = 'February 16' then
      vPeriod := '2/16'
  else if cboDate.Text = 'March 1' then
      vPeriod := '3/1'
  else if cboDate.Text = 'March 16' then
      vPeriod := '3/16'
  else if cboDate.Text = 'April 1' then
      vPeriod := '4/1'
  else if cboDate.Text = 'April 16' then
      vPeriod := '4/16'
  else if cboDate.Text = 'May 1' then
      vPeriod := '5/1'
  else if cboDate.Text = 'May 16' then
      vPeriod := '5/16'
  else if cboDate.Text = 'June 1' then
      vPeriod := '6/1'
  else if cboDate.Text = 'June 16' then
      vPeriod := '6/16'
  else if cboDate.Text = 'July 1' then
      vPeriod := '7/1'
  else if cboDate.Text = 'July 16' then
      vPeriod := '7/16'
  else if cboDate.Text = 'August 1' then
      vPeriod := '8/1'
  else if cboDate.Text = 'August 16' then
      vPeriod := '8/16'
  else if cboDate.Text = 'September 1' then
      vPeriod := '9/1'
  else if cboDate.Text = 'September 16' then
      vPeriod := '9/16'
  else if cboDate.Text = 'October 1' then
      vPeriod := '10/1'
  else if cboDate.Text = 'October 16' then
      vPeriod := '10/16'
  else if cboDate.Text = 'November 1' then
      vPeriod := '11/1'
  else if cboDate.Text = 'November 16' then
      vPeriod := '11/16'
  else if cboDate.Text = 'December 1' then
      vPeriod := '12/1'
  else
      vPeriod := '12/16';
  QueryPaySlip;
end;

procedure TPaySlip.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  QueryPaySlip;
end;

procedure TPaySlip.cboYearChange(Sender: TObject);
begin
  QueryPaySlip;
end;

procedure TPaySlip.btnPrintAllClick(Sender: TObject);
begin
  ADODataSet2.Active := False;
  vEmpID := ADODataSet1.FieldByName('Employee_PIN').AsString;

  ADODataSet2.Connection := ADOConn;
  vSQL := 'SELECT * FROM dtaPayrollProcess WHERE Period1 = ' + Chr(39) + vPeriodDate + Chr(39);
  ADODataSet2.CommandText := vSQL;
  ADODataSet2.Active := True;
  if ADODataSet2.Recordset.RecordCount  <> 0 then
      begin
          vSQL := 'SELECT * INTO xPaySlipTmp FROM dtaPayrollProcess WHERE Period1 = ' + Chr(39) + vPeriodDate + Chr(39);
          CopyQuery;
          StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
          StartupInfo.wShowWindow := 10;
          if not CreateProcess(nil,'wprjPaySlip.EXE', nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
              showMessage('Bad or Missing Executable');
      end;

end;

procedure TPaySlip.btnPrintClick(Sender: TObject);
begin
  ADODataSet2.Active := False;
  vEmpID := ADODataSet1.FieldByName('Employee_PIN').AsString;

  ADODataSet2.Connection := ADOConn;
  vSQL := 'SELECT * FROM dtaPayrollProcess WHERE Employee_PIN = ' + Chr(39) + vEmpID + Chr(39) + ' AND Period1 = ' + Chr(39) + vPeriodDate + Chr(39);
  ADODataSet2.CommandText := vSQL;
  ADODataSet2.Active := True;
  if ADODataSet2.Recordset.RecordCount  <> 0 then
      begin
          vSQL := 'SELECT * INTO xPaySlipTmp FROM dtaPayrollProcess WHERE Employee_PIN = ' + Chr(39) + vEmpID + Chr(39) + ' AND Period1 = ' + Chr(39) + vPeriodDate + Chr(39);
          CopyQuery;
          StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
          StartupInfo.wShowWindow := 10;
          if not CreateProcess(nil,'wprjPaySlip.EXE', nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
              showMessage('Bad or Missing Executable');
      end;
  end;

end.
