// Name:  PayrollProcess.pas
// Description:  This is where the processing of payroll is made.
//     All entries made prior to the processing of payroll will all
//     be fetched and computed during processing.  Processing of payroll
//     is done periodically, usually every after 15 days.

unit PayrollProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, ComCtrls, DateUtils, ShellAPI, CommonModule, ProcessViewer,
  ProductionDocuments;

type
  TfrmPayrollProcess = class(TForm)
    ADOConnection1: TADOConnection;
    ADOCommand1: TADOCommand;
    ADODataSet1: TADODataSet;
    ADOTable1: TADOTable;
    ADOQuery1: TADOQuery;
    ADOStoredProc1: TADOStoredProc;
    ProgressBar1: TProgressBar;
    ADODataSet2: TADODataSet;
    ADODataSet3: TADODataSet;
    txtStatus: TEdit;
    dsHolidayDayOff: TADODataSet;
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    Button1: TButton;
    ADODataSet4: TADODataSet;
    ADODataSet5: TADODataSet;
    grpProductionDates: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    dtCurrentFrom: TDateTimePicker;
    dtCurrentTo: TDateTimePicker;
    btnIncludeFromPayroll: TButton;
    btnExcludeFromPayroll: TButton;
    Label5: TLabel;
    Label6: TLabel;
    dtPreviousFrom: TDateTimePicker;
    dtPreviousTo: TDateTimePicker;
    Label7: TLabel;
    chkTimedOut: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    btnPayrollProcess: TButton;
    btnPayrollDocuments: TButton;
    dsProjectCode: TADODataSet;
    dsCOLA: TADODataSet;
    dsKeyerID: TADODataSet;
    dsLogFile: TADODataSet;
    ds13Month: TADODataSet;

    //dsBonusesTable: TADODataSet;
    //dsBonusesDetails: TADODataSet;
    dsBonusesTable: TADODataSet;
    dsBonusesDetails: TADODataSet;
    dsPayrollTemp: TADODataSet;
    connSnacks: TADOConnection;
    dsPurchases: TADODataSet;
    chkDeductSnacks: TCheckBox;
    procedure FormDestroy(Sender: TObject);

    procedure btnPayrollDocumentsClick(Sender: TObject);
    procedure btnPayrollProcessClick(Sender: TObject);
    procedure btnIncludeFromPayrollClick(Sender: TObject);
    procedure btnExcludeFromPayrollClick(Sender: TObject);
    procedure dtPreviousFromChange(Sender: TObject);
    procedure chkTimedOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateTimePicker1_Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    function DTR_Validation:Boolean;
    function getProjectCode(const sPrimaryTask : string) : string;
    function getEmployeePIN(const sKeyerID : string) : string;
    function getCOLArate() : currency;

    procedure Process_Stage1;
    procedure Process_Stage2;
    procedure Process_Stage3;
    procedure Process_Log;

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayrollProcess: TfrmPayrollProcess;

  dt : TDateTime;
  day: Integer;
  sPeriod1, sPeriod2, tPeriod1, tPeriod2: String;

  // for the new process
  sDoc_Rate, sRev_Rate : String;
  vDoc_Rate, vRev_Rate : Double;
  vDoc_Amt, vRev_Amt : Currency;
  vTime_ID : String;

  vBatches, vDocs, vPulls, vTime_taken, vIdle_time : Currency;
  vOver_time : Integer;
  v99_Time, vOT_Pay, vBonus_Pay, vPiece_Rate,
  vRevenue_Rate, vTotal, vEarned_Pay, vUnearned_Pay,
  vComp_Pay, vTotal_Pay, vTotal_Hours, vTotal_OT,
  vAverage_Hourly, vTotal_Revenue, vRevenue : Currency;
  sRevenue_Rate : String;
  SQL,SQL2 : String;
  vUpdateTracking : String;

  vBonusUPH, vBonusQuality, vBonusAttendance, vBonusRetention, vBonusPAttendance : Currency;
  vSBCashAdvance, vBonusAttendanceRate : Currency;
  vBonusOthers : Currency;

  sRemarks : String;

  wIdle_Code, wIdle_Time, wBonus_Pay, wRevenue, wX99_TIME, wID: String;

  // variables for new payroll computation //
  vNo_Holidays : Integer;
  vJob_Position_Code : String;
  // for non keyers
  vRate_Month1, vRate_Day1, vBasic_Pay1, vHoliday_Pay1 : Currency;
  vDays_Absent1, vDays : Currency;
  // for keyers
  vRate_Hr2, vBasic_Pay2, vOT_Pay2, vCOLA2, vDay_Off_Pay2, vNight_Diff_Hrs2, vNight_Diff_Pay2, vBonus_Pay2, vRev_Amt2, vHoliday_Pay2 : Currency;
  vReg_Hrs2, vHrs_Work2, vOT_Hrs2, vDays_Work2, vDay_Off_Hrs2, vDay_Off_OT, vDay_Off_ND, vNight_Diff_Hours, vNight_Diff_Hours_Per_Day, vNight_Diff_Hours_Hol2, vNight_Diff_Hours_Hol_Pay2, vNight_Diff_Hours_Hol2_Day, vNight_Diff_Hours_Hol2_Day1, vHol_Hrs2, vHolidayOT, vHolidayOTHrs : Currency;

  vNDDayOffPay, vOTDayOffPay : Currency;
  vHolidayHrs : Currency;

  vHolidayOT_Pay : Currency;
  vNight_Diff : Boolean;
  vPresent_on_Holiday : Boolean;
  // for all
  vOther_Earn1, vOther_Earn2, vOther_Earn3, vOther_Earn4, vOther_Earn5 : Currency;
  vOther_Earn_Desc1, vOther_Earn_Desc2, vOther_Earn_Desc3, vOther_Earn_Desc4, vOther_Earn_Desc5 : String;
  vGross_Pay, vWith_Tax, vSSS_EE, vSSS_ER, vPhilhealth_EE, vPhilhealth_ER, vECC_ER : Currency;
  vOther_Ded1, vOther_Ded2, vOther_Ded3, vOther_Ded4, vOther_Ded5 : Currency;
  vOther_Ded_Desc1, vOther_Ded_Desc2, vOther_Ded_Desc3, vOther_Ded_Desc4, vOther_Ded_Desc5 : String;
  vTotal_Ded, vNet_Pay : Currency;
  // for withtax
  vTax_Code, vCol : String;
  vExcess, vExcess_Per, vExcess_Amt, vTax : Currency;
  // for previous sss and philhealth
  vPrev_Period : String;
  vPrev_Gross_Pay, vPrev_Other_Earn1, vPrev_SSS_EE, vPrev_SSS_ER, vPrev_Philhealth_EE, vPrev_Philhealth_ER, vPrev_ECC_ER : Currency;
  vBasic_Pay_Current, vBasic_Pay_Previous : Currency;

  // for pagibig
  vMC, vPagibig_EE, vPagibig_ER,
  vPrev_MC, vPrev_Basic_Pay1, vPrev_Basic_Pay2, vPrev_COLA2, vPrev_Pagibig_EE, vPrev_Pagibig_ER : Currency;
  I : Int64;
  vSUP : Boolean;
  // for night diff hours computation
  myDate : TDateTime;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
  myDate2 : TDateTime;
  myYear2, myMonth2, myDay2 : Word;
  myHour2, myMin2, mySec2, myMilli2 : Word;

  myHolDate : TDateTime;
  myHolYear, myHolMonth, myHolDay : Word;
  myHolHour, myHolMin, myHolSec, myHolMilli : Word;

  wDate : TDateTime;
  fromDate : TDateTime;
  fromYear, fromMonth, fromDay : Word;
  fromHour, fromMin, fromSec, fromMilli : Word;
  toDate : TDateTime;
  toYear, toMonth, toDay : Word;
  toHour, toMin, toSec, toMilli : Word;
  isNightDiff : Boolean;

  // for SLA 5% and 10%
  vSLA5, vSLA10 : Boolean;
  vSLA_5, vSLA_10 : Currency;

  vCOLArate : Currency;

  // 13th month
  vM13thmo : Currency;  // 3/20/2006

  gUser : String;
  gUser_ID : Integer;

  sUserID : string;
  sTranDate : string;

  vRetBonusRate, vMonthRetBonusAmount : Currency;

  // Pag-ibig MP2
  vMP2EmployeeShare, vMP2EmployerShare : Currency;

  vTotalGrossPay : Currency;
  
const
  Base_Pay = 30;

function Check_Empty(sInput: String):String;

implementation

{$R *.dfm}

procedure TfrmPayrollProcess.Button1Click(Sender: TObject);
var
  strSt : string;
begin
  dt := DateTimePicker1.Date;
  day := DayOfTheMonth(dt);

  if((day<>1) and (day<>16)) then
  begin
    ShowMessage('The Period From should either be 1st or 16th of the month.');
    DateTimePicker1.SetFocus;
    exit;
  end;

  ADOConnection1.Connected := True;
  sPeriod1 := chr(39)+DateToStr(DateTimePicker1.Date)+chr(39);
  sPeriod2 := chr(39)+DateToStr(DateTimePicker2.Date)+chr(39);
  tPeriod1 := chr(39)+DateToStr(DateTimePicker1.Date)+' 12:00:00 AM' + chr(39);
  tPeriod2 := DateToStr(IncDay(DateTimePicker2.Date));
  tPeriod2 := chr(39) + tPeriod2 + ' 12:00:00 PM' + chr(39);
  //tPeriod2 := chr(39)+DateToStr(DateTimePicker2.Date)+' 23:59:59 PM' + chr(39);

  strSt := 'UPDATE dtaTimeSecurity SET tStatus = 1';

  ADOConnection1.Execute(strSt);

  // check if the payroll period has been locked for processing //
  ADODataSet1.CommandText := 'SELECT * FROM dtaLockPayPeriod WHERE Period1='+sPeriod1;
  ADODataSet1.Open;
  ADODataSet1.First;
  I := ADODataSet1.RecordCount;
  ADODataSet1.Close;

  if I>0 then
  begin
    ShowMessage('The selected pay period has been locked, can not proceed with processing ...');
    ADOConnection1.Connected := False;
    exit;
  end;

  // if the payperiod is not empty //
  ADODataSet1.CommandText := 'SELECT * FROM dtaPayrollProcess WHERE Period1='+sPeriod1;
  ADODataSet1.Open;
  ADODataSet1.First;
  I := ADODataSet1.RecordCount;
  ADODataSet1.Close;
  
  if I>0 then
    if MessageDlg('The selected pay period has been processed, do you want to re-process?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    begin
      ADOConnection1.Connected := False;
      exit;
    end;

  Button1.Enabled := False;
  //Button2.Enabled := False;

  ADOConnection1.Execute('DELETE FROM dtaPayrollProcess WHERE Period1=' + sPeriod1);
//  ADOConnection1.Execute('DELETE FROM dtaMissingPIN');
  // reset processed tag on dtaDayOff table //
  ADOConnection1.Execute('UPDATE dtaDayOff SET Processed = NULL WHERE Day_Off Between ' + sPeriod1 + ' AND ' + sPeriod2);


//  ADOConnection1.Execute('UPDATE dtaProduction SET Time_ID = 0 WHERE Tran_Date BETWEEN ''1/20/2007 12:00:00 PM'' AND ''2/1/2007 11:59:59 AM''' +
//      ' AND Time_ID IS NULL');
//  ADOConnection1.Execute('UPDATE dtaProduction SET Time_ID = NULL WHERE Tran_Date BETWEEN ''1/16/2007 12:00:00 AM'' AND ''2/1/2007 11:59:59 AM''' +
//      ' AND Time_ID = 0');


  //if DTR_Validation then
  //begin
    //Process_Stage1;
    //Process_Stage2;
    Process_Stage3;
  //end
  //else
  //  ShowMessage('DTR Validation failed, please see the error log file..');

  Button1.Enabled := True;
  //Button2.Enabled := True;

end;

procedure TfrmPayrollProcess.Button2Click(Sender: TObject);
begin
  ADOConnection1.Connected := False;
  frmPayrollProcess.Close;
  //Halt(0);
end;

procedure TfrmPayrollProcess.DateTimePicker1_Change(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
  DecodeDate(DateTimePicker1.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(DateTimePicker1.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
  DateTimePicker2.Date := dt;
  DateTimePicker2.Refresh;
end;

function Check_Empty(sInput:String):String;
begin
  sInput := TrimRight(sInput);
  sInput := TrimLeft(sInput);
  if( Length(sInput)=0 ) then sInput := '0';
  Check_Empty := sInput;
end;

procedure TfrmPayrollProcess.FormCreate(Sender: TObject);
begin
{  xDir :=  GetCurrentDir;
  AssignFile(xIni, xDir + '\PSYSTEM.INI');
  reset(xIni);

  repeat
    readln(xIni, xData);
    if(pos('Server=',xData)>0) then sqlserver := Copy(xData,8,100);
    if(pos('User=',xData)>0) then sqluser := Copy(xData,6,100);
    if(pos('Database=',xData)>0) then sqldatabase := Copy(xData,10,100);
    if(pos('Password=',xData)>0) then sqlpwd := Copy(xData,10,100);
  until (eof(xIni));

  CloseFile(xIni);
  ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+SqlUser+';Initial Catalog=' + sqlDatabase + ';Data Source='+sqlServer;
  ADOConnection1.Connected := TRUE;
 }
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;

  // connect to SNACKS database
  connSnacks.ConnectionString := CommonModule.ReadInitConn_Snacks(CommonModule.ToConnect('Null'));
  connSnacks.Connected := TRUE;

  DateTimePicker1.Date := Date();
  DateTimePicker2.Date := Date();

  dtPreviousFrom.Date := Date();
  dtPreviousTo.Date := Date();

  dtCurrentFrom.Date := Date();
  dtCurrentTo.Date := Date();
end;

function TfrmPayrollProcess.DTR_Validation:boolean;
var
  bResult : boolean;
  errFile : Textfile;
begin
  bResult := FALSE;

  assignFile( errFile, 'ERRORLOG.TXT' );
  rewrite( errFile );

  // validate missing actual_out or actual_in in dtatime_detail

  ADODataSet1.CommandText := 'SELECT t.*,e.rate_hour FROM dtaTime_Detail t LEFT OUTER JOIN dtaEmployees e ON t.employee_pin = e.employee_pin' +
      ' WHERE e.rate_hour > 0 AND t.work_date BETWEEN '+sPeriod1+' AND '+sPeriod2 +
      ' AND t.actual_out IS NULL OR t.actual_in IS NULL ORDER BY t.work_date';
  ADODataSet1.Open;
  ADODataSet1.First;
  if ADODataSet1.RecordCount>0 then
  begin
    writeln(errFile,'DTR entries with missing LOG-IN or LOG-OUT');
    //writeln(
    ProgressBar1.Max := ADODataSet1.RecordCount;
    ProgressBar1.Step := 1;
    repeat
      ProgressBar1.StepIt;
      txtStatus.Text := 'DTR Validation >> Name:'+Trim(ADODataSet1.FieldByName('Employee_Name').AsString);
      txtStatus.Refresh;
      frmPayrollProcess.Refresh;

      // process next record
      ADODataSet1.Next;
    until ADODataSet1.Eof;
  end;
  ADODataSet1.Close;

  closeFile( errFile );

  DTR_Validation := bResult;
end;

procedure TfrmPayrollProcess.Process_Stage1;
var
  sPIN : string;

  sSecondRate : String;
  vSecondRate : Double;

  vMinValue : Integer;
  vSecondMinValue : Integer;
  vCurAmount : Currency;

  vCount : Integer;

begin

  ADODataSet1.CommandText := 'SELECT * ' +
    'FROM dtaProduction (nolock)' +
    'WHERE Tran_date BETWEEN ' + tperiod1 + ' AND ' + tperiod2 +
      ' AND Time_ID IS NULL ' +
      'AND task_id <> '''' ORDER BY Keyer_ID, Task_ID';

  ADODataSet1.Open;
  ADODataSet1.First;
  if ADODataSet1.RecordCount>0 then
  begin
    ProgressBar1.Max := ADODataSet1.RecordCount;
    ProgressBar1.Step := 1;
    repeat
      ProgressBar1.StepIt;
      txtStatus.Text := 'Pass 1 >> Keyer ID:'+Trim(ADODataSet1.FieldByName('Keyer_ID').AsString) +
        ' Task ID:' + Trim(ADODataSet1.FieldByName('Task_ID').AsString) + ' '
        + Trim(ADODataSet1.FieldByName('Tran_Date').AsString);

      txtStatus.Refresh;


      vSecondMinValue := 0;
      vMinValue := 0;
      vSecondRate := 0;
      
      // extract the piece rate and revenue rate per task
      ADODataSet2.CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID='+chr(39)+
        ADODataSet1.FieldByName('Task_ID').AsString + chr(39);
      ADODataSet2.Open;
      vDoc_Rate := 0; vRev_Rate := 0;
      if( ADODataSet2.RecordCount > 0 ) then
      begin
        sDoc_Rate := ADODataSet2.FieldByName('Piece_Rate').Value;
        vDoc_Rate := StrToFloat(sDoc_Rate);
        sRev_Rate := ADODataSet2.FieldByName('Revenue_Rate').Value;
        vRev_Rate := StrToFloat(sRev_Rate);

        sSecondRate := ADODataSet2.FieldByName('secondRate').Value;
        vSecondRate := StrToFloat(sSecondRate);

        vMinValue := ADODataSet2.FieldByName('minValue').Value;
        vSecondMinValue := ADODataSet2.FieldByName('secondMinValue').Value;

      end;
      ADODataSet2.Close;

      vDoc_Amt := 0;

      vCount := ADODataSet1.FieldByName('Docs').Value;

      if (vCount > vSecondMinValue) then
      begin
        vCurAmount := ((vCount - vSecondMinValue) + 1) * vSecondRate;
        vDoc_Amt := vDoc_Amt + vCurAmount;
      end;

      if ((vCount > vMinValue) and (vCount > vSecondMinValue)) then
      begin
        vCurAmount := (vSecondMinValue - vMinValue) * vDoc_Rate;
        vDoc_Amt := vDoc_Amt + vCurAmount;
      end
      else if (vCount >= vMinValue) then
      begin
        vCurAmount := ((vCount - vMinValue) + 1) * vDoc_Rate;
        vDoc_Amt := vDoc_Amt + vCurAmount;
      end
      else if (vMinValue = 1) then
      begin
        vCurAmount := vCount * vDoc_Rate;
        vDoc_Amt := vDoc_Amt + vCurAmount;
      end;


      // assign the time_id based on the tran_date within eds actual_in actual_out (dtatime_summary)
      vTime_ID := '0';

      sPIN := getEmployeePIN(ADODataSet1.FieldByName('keyer_id').AsString);

      //if not ADODataSet1.FieldByName('Employee_PIN').IsNull then
      if sPIN <> '' then
      begin
        //edited code to include all production records
        ADODataSet2.CommandText := 'SELECT top 1 * ' +
          'FROM dtaTime_Summary (nolock) WHERE employee_pin=' + sPIN + ' AND ' +
          'work_date = ''' + ADODataSet1.FieldByName('Tran_Date').AsString +
          ''' AND Work_Date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2 +
          ' ORDER BY work_date';

        ADODataSet2.Open;
        if( ADODataSet2.RecordCount > 0 ) then
          vTime_ID := ADODataSet2.FieldByName('Time_ID').AsString
        else
        begin
          ADODataSet2.Close;
          ADODataSet2.CommandText := 'SELECT TOP 1 * ' +
            'FROM dtaTime_Summary ' +
            'WHERE Employee_PIN =' + sPIN + ' AND ' +
            'Work_Date BETWEEN ' + sPeriod1 +
            ' AND ' + sPeriod2;
          ADODataSet2.Open;

          if (ADODataSet2.RecordCount > 0) then
            vTime_ID := ADODataSet2.FieldByName('Time_ID').AsString;
        end;
        ADODataSet2.Close;
      end;

      wID := ADODataSet1.FieldByName('ID').AsString;
      SQL := 'UPDATE dtaProduction SET ' +
                'Doc_Rate = '+ FloatToStr(vDoc_Rate) + ',' +
                'Doc_Amt = '+ CurrToStr(vDoc_Amt) + ',' +
                'Time_Id = '+ vTime_ID +
             'WHERE ID = '+ wID;
      ADOConnection1.Execute(SQL);


      vUpdateTracking := 'UPDATE dtaTracking SET Process_Num = ''Process 1'', Keyer_ID = ''' +
        ADODataSet1.FieldByName('Keyer_ID').AsString + '''';
      ADOConnection1.Execute(vUpdateTracking);


      // process next record
      ADODataSet1.Next;
    until ADODataSet1.Eof;
  end;
  ADODataSet1.Close;

end; // process_stage1

procedure TfrmPayrollProcess.Process_Stage2;
//var


  //ADDED FOR INTEGRATION OF BASIC PAY AND COLA
//  varPIN : string;
begin

  ADODataSet1.CommandText := 'SELECT * ' +
    'FROM dtaTime_Summary (nolock)' +
    'WHERE Work_date BETWEEN ' + speriod1 + ' AND ' + speriod2 +
    ' ORDER BY employee_name, Work_date';

  ADODataSet1.Open;
  ADODataSet1.First;
  if ADODataSet1.RecordCount > 0 then
  begin
    ProgressBar1.Max := ADODataSet1.RecordCount;
    ProgressBar1.Step := 1;

    repeat


      ProgressBar1.StepIt;
      txtStatus.Text := 'Pass 2 >> Name :'+Trim(ADODataSet1.FieldByName('Employee_Name').AsString)+' Date:'+Trim(ADODataSet1.FieldByName('Work_Date').AsString);
      txtStatus.Refresh;

      // compute total doc_amt and rev_amt per day per employee_pin from production
      ADODataSet2.CommandText := 'SELECT ISNULL(SUM(docs),0) AS tDocs, ISNULL(SUM(doc_amt),0) AS tDoc_Amt,ISNULL(SUM(rev_amt),0) AS tRev_Amt FROM dtaProduction (nolock) WHERE Time_ID='+ADODataSet1.FieldByName('Time_ID').AsString;
      ADODataSet2.Open;
      vDocs := 0; vDoc_Amt := 0; vRev_Amt := 0;
      if( ADODataSet2.RecordCount > 0 ) then
        if not ADODataSet2.FieldByName('tDoc_Amt').IsNull then
        begin
          vDocs := ADODataSet2.FieldByName('tDocs').Value;
          vDoc_Amt := ADODataSet2.FieldByName('tDoc_Amt').Value;
          vRev_Amt := ADODataSet2.FieldByName('tRev_Amt').Value;
        end;
      ADODataSet2.Close;

      // extract total idle time per day
      ADODataSet2.CommandText := 'SELECT ISNULL(SUM(idle_time),0) AS tIdle_Time FROM (SELECT DISTINCT * FROM vwIdleValues WHERE employee_pin=' + ADODataSet1.FieldByName('Employee_PIN').AsString +
        ' AND tran_date = ''' + ADODataSet1.FieldByName('Work_Date').AsString + ''') AS tbl';
      ADODataSet2.Open;
      vIdle_Time := 0;
      if( ADODataSet2.RecordCount > 0 ) then
        if not ADODataSet2.FieldByName('tIdle_Time').IsNull then
          vIdle_Time := (ADODataSet2.FieldByName('tIdle_Time').Value / 60);
      ADODataSet2.Close;

      // get the rate_hr from dtaEmployees
      ADODataSet2.CommandText := 'SELECT rate_hour FROM dtaEmployees WHERE employee_pin=' + ADODataSet1.FieldByName('Employee_PIN').AsString ;
      ADODataSet2.Open;
      vRate_Hr2 := 0;
      if( ADODataSet2.RecordCount > 0 ) then
        if not ADODataSet2.FieldByName('rate_hour').IsNull then
          if ADODataSet2.FieldByName('rate_hour').Value > 0 then
            vRate_Hr2 := ADODataSet2.FieldByName('rate_hour').Value;
      ADODataSet2.Close;

      // bonus pay
      vBonus_Pay := 0;
      vReg_Hrs2 := 0;
      if not ADODataSet1.FieldByName('Regular_Hours').IsNull then vReg_Hrs2 := ADODataSet1.FieldByName('Regular_Hours').Value;

      vOT_Hrs2 := 0;
      if not ADODataSet1.FieldByName('OT').IsNull and (Trim(ADODataSet1.FieldByName('AuthorizeOT').AsString)='Yes') then
        vOT_Hrs2 := ADODataSet1.FieldByName('OT').Value;

      vBonus_Pay := vDoc_Amt -
          ( ( vReg_Hrs2 + vOT_Hrs2 ) * vRate_Hr2 ) +
          ( vIdle_Time * vRate_Hr2 );

      wID := ADODataSet1.FieldByName('Time_ID').AsString;
      SQL := 'UPDATE dtaTime_Summary SET ' +
                'Docs_Day = '+ CurrToStr(vDocs) + ',' +
                'Doc_Amt_Day = '+ CurrToStr(vDoc_Amt) + ',' +
                'Rev_Amt_Day = '+ CurrToStr(vRev_Amt) + ',' +
                'Idle_Hours_Day = '+ CurrToStr(vIdle_Time) + ',' +
                'Bonus_Pay_Day = '+ CurrToStr(vBonus_Pay) +
             'WHERE Time_ID = '+ wID;
      ADOConnection1.Execute(SQL);


      vUpdateTracking := 'UPDATE dtaTracking SET Process_Num = ''Process 2'', Keyer_ID = ''' +
        ADODataSet1.FieldByName('Employee_Name').AsString + '''';
      ADOConnection1.Execute(vUpdateTracking);

      // process next record
      ADODataSet1.Next;
    until ADODataSet1.Eof;
  end;
  ADODataSet1.Close;

end; // process_stage2

function WorkingDaysBetween(const FirstDate, SecondDate: TDateTime): Integer;
var
  CurrDate : TDateTime;
  StartDate, EndDate: TDateTime;
begin
  if SecondDate > FirstDate then
  begin
    StartDate := FirstDate;
    EndDate := SecondDate;
  end
  else
  begin
    StartDate := SecondDate;
    EndDate := FirstDate;
  end;

  CurrDate := StartDate;
  Result := 0;

  while (CurrDate <= EndDate) do
  begin
    if DayOfTheWeek(CurrDate) < 6 then
      Inc(Result);
    CurrDate := CurrDate + 1;
  end;
end;

procedure TfrmPayrollProcess.Process_Stage3;
var
  strOutND : string;
  sProj : string;

  //added on 07/30/2008
  sEmployeeName : string;
  sPositionCode : string;
  sEmpStatus : string;
  sEmpLoc : string;
  sAtmNumber : string;
  sTaxCode : string;

  sNightDiff : string;
  sBonusAllowed : string;
  sNoHoliday : string;
  sNoTax : string;
  sNoPagibig : string;
  sNoPhilhealth : string;
  sNoSSS : string;
  //sNoOT : string; // added on July 20, 2010 to allow overtime pay for monthly-rate employees

  sSSSNo : string;
  sPhicNo : string;
  sPagibigNo : string;
  sTIN : string;

  holCOLA : integer;

  strInND : String;
  strInND2 : String;

  s01 : String;
  s02 : String;
  s001 : String;

  // Pag-ibig MP2
  sMP2Qualified : string;


  {vEmpWorkingDaysLastMonth : Currency;

  sWithAttBonus : String;
  WorkingDaysCount : Integer;
  AbsentCount : Integer;

  // datetime variables to get last month start and end dates
  dtAttBonusStart : TDateTime;
  dtAttBonusEnd : TDateTime;
  dtTemp : TDateTime;
  myYear, myMonth, myDay : Word;

  AttBonusYear, AttBonusMonth : Integer; }

begin

  {vEmpWorkingDaysLastMonth := 0;
  AbsentCount := 0;
  AttBonusYear := 0;
  AttBonusMonth := 0;

  dtAttBonusStart := Now();
  dtAttBonusEnd := Now();}
  
  // get COLA rate
  vCOLArate := getCOLArate();

  {
  // get number of working days from previous month
  DecodeDate(DateTimePicker1.Date, myYear, myMonth, myDay);
  if(myDay = 1) then
  begin

    if (myMonth = 1) then // this means January, so need to get last Year, December start and end dates
    begin
      dtAttBonusStart := EncodeDate(myYear - 1, 12, 1);
      dtAttBonusEnd := EncodeDate(myYear - 1, 12, 31);

      AttBonusYear := myYear - 1;
      AttBonusMonth := 12;
    end
    else
    begin
      dtAttBonusStart := EncodeDate(myYear, myMonth - 1, 1);

      // get previous month end of the month day
      dtTemp := EndOfAMonth(myYear, myMonth - 1);
      DecodeDate(dtTemp, myYear, myMonth, myDay);

      dtAttBonusEnd := EncodeDate(myYear, myMonth, myDay);

      AttBonusYear := myYear;
      AttBonusMonth := myMonth;
    end;

  end;

  WorkingDaysCount := WorkingDaysBetween(dtAttBonusStart, dtAttBonusEnd);
        }

  ADODataSet1.CommandText := 'SELECT * FROM dtaEmployees (nolock) WHERE Emp_status = ''ACTIVE'' '+
//  'AND (EMPLOYEE_PIN=875 OR EMPLOYEE_PIN=877 OR EMPLOYEE_PIN=879 OR EMPLOYEE_PIN=876 OR EMPLOYEE_PIN=874 OR EMPLOYEE_PIN=872)'+
//  'AND (Employee_PIN = 714 OR employee_pIN = 414) '+
//    'AND employee_pin = 136 ' +
//    'AND employee_pin = 765 ' +
//    'AND primary_task_id = ''healthserve'' ' +
    'AND ProcessIncluded = 1 ' +
    'ORDER BY EMPLOYEE_NAME';
  ADODataSet1.Open;
  //ShowMessage(IntToStr(ADODataSet1.RecordCount));
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ADODataSet1.RecordCount;
  if ADODataSet1.RecordCount>0 then
  begin
    ProgressBar1.Step := 1;
    ADODataSet1.First;
    repeat
      ProgressBar1.StepIt;
      txtStatus.Text := 'Pass 3 >> Employee PIN:'+ADODataSet1.FieldByName('Employee_PIN').AsString + ' Name: '+ADODataSet1.FieldByName('Employee_Name').AsString;
      txtStatus.Refresh;
      //frmPayrollProcess.Refresh;

      //Process Payroll Here

      // Initialize Computation Variables
      vBatches := 0;      vDocs := 0;           vPulls := 0;
      vTime_taken := 0;   vIdle_time:=0;        vOver_Time := 0;
      v99_Time := 0;      vOT_Pay := 0;         vBonus_Pay := 0;
      vTotal := 0;        vEarned_Pay := 0;     vUnearned_Pay := 0;
      vComp_Pay := 0;     vTotal_Pay := 0;      vTotal_Hours := 0;
      vTotal_OT := 0;     vAverage_Hourly := 0; vTotal_Revenue := 0;
      vRevenue := 0;

      vJob_Position_Code := '';
      vRate_Month1 := 0;
      vRate_Day1 := 0;
      vNo_Holidays := 0;
      vRate_Hr2 := 0;
      vDays_Absent1 := 0;
      vDay_Off_Hrs2 := 0;
      vHrs_Work2 := 0;
      vReg_Hrs2 := 0;
      vDays_Work2 := 0;
      vNight_Diff := FALSE;
      vNight_Diff_Hours := 0;
      vNight_Diff_Pay2 := 0;

      vNight_Diff_Hours_Hol2 := 0;
      vNight_Diff_Hours_Hol_Pay2 := 0;
      vNight_Diff_Hours_Hol2_Day := 0;

      vHoliday_Pay1 := 0;
      vHoliday_Pay2 := 0;

      vHolidayOT := 0;
      vHolidayOT_Pay := 0;
      vHolidayOTHrs := 0;

      vHolidayHrs := 0;
      vOTDayOffPay := 0;
      vNDDayOffPay := 0;


      vOther_Earn1 := 0;
      vOther_Earn2 := 0;
      vOther_Earn3 := 0;
      vOther_Earn4 := 0;
      vOther_Earn5 := 0;
      vOther_Earn_Desc1 := '';
      vOther_Earn_Desc2 := '';
      vOther_Earn_Desc3 := '';
      vOther_Earn_Desc4 := '';
      vOther_Earn_Desc5 := '';
      vOther_Ded1 := 0;
      vOther_Ded2 := 0;
      vOther_Ded3 := 0;
      vOther_Ded4 := 0;
      vOther_Ded5 := 0;
      vOther_Ded_Desc1 := '';
      vOther_Ded_Desc2 := '';
      vOther_Ded_Desc3 := '';
      vOther_Ded_Desc4 := '';
      vOther_Ded_Desc5 := '';

      vSLA5 := false;
      vSLA10 := false;
      vSLA_5 := 0;
      vSLA_10 := 0;

      vOT_Hrs2 := 0;

      vM13thmo := 0;
      holCOLA := 0;

      vBasic_Pay1 := 0;
      vBasic_Pay2 := 0;

      vTax_Code := 'Z';  // default value // zero exemption

      // initialize
      vRetBonusRate := 0;
      vMonthRetBonusAmount := 0;

      vBonusUPH := 0;
      vBonusQuality := 0;
      vBonusAttendance := 0;
      vBonusRetention := 0;
      vSBCashAdvance := 0;
      vBonusPAttendance := 0;
      vBonusOthers := 0;

      sRemarks := '';

      vMP2EmployeeShare := 0;
      vMP2EmployerShare := 0;


      if Not ADODataSet1.FieldByName('Employee_PIN').IsNull then
      begin

        // Extraction information from dtaHoliday_Details //
        ADODataSet2.CommandText := 'SELECT COUNT(*) AS tHolidays FROM dtaHoliday_Details WHERE (Period1 = '+sPeriod1+')';
        ADODataSet2.Open;
        if( ADODataSet2.RecordCount > 0 ) then
        begin
          // process the extracted production of the particular employee
          ADODataSet2.First;
          vNo_Holidays := ADODataSet2.FieldByName('tHolidays').Value;
        end;
        ADODataSet2.Close;

        // Extraction information from dtaEmployees //
          if Not ADODataSet1.FieldByName('Job_Position_Code').IsNull  then
              vJob_Position_Code := ADODataSet1.FieldByName('Job_Position_Code').Value;
          if Not ADODataSet1.FieldByName('Monthly_Rate').IsNull  then
              vRate_Month1 := ADODataSet1.FieldByName('Monthly_Rate').Value;
          if Not ADODataSet1.FieldByName('Rate_Hour').IsNull  then
              vRate_Hr2 := ADODataSet1.FieldByName('Rate_Hour').Value;
          if Not ADODataSet1.FieldByName('Night_Diff').IsNull  then
              vNight_Diff := ADODataSet1.FieldByName('Night_Diff').Value;
          if Not ADODataSet1.FieldByName('Tax_Code').IsNull  then
              vTax_Code := ADODataSet1.FieldByName('Tax_Code').Value;

          //if Not ADODataSet1.FieldByName('RetentionBonus_Rate').IsNull  then
          //    vRetBonusRate := ADODataSet1.FieldByName('RetentionBonus_Rate').Value;

        // Extraction information from dtaOther_Earn_Ded //
        ADODataSet2.CommandText := 'SELECT * FROM dtaOther_Earn_Ded (nolock) WHERE Employee_PIN = ' + ADODataSet1.FieldByName('Employee_PIN').AsString +
          ' AND Payroll_Period =' + sPeriod1;
        ADODataSet2.Open;
        if( ADODataSet2.RecordCount > 0 ) then
        begin
          // process the extracted production of the particular employee
          ADODataSet2.First;

          if Not ADODataSet2.FieldByName('DaysAbsent').IsNull  then
              vDays_Absent1 := ADODataSet2.FieldByName('DaysAbsent').Value;

          //if Not ADODataSet2.FieldByName('DayOffHrsWork').IsNull  then
          //    vDay_Off_Hrs2 := ADODataSet2.FieldByName('DayOffHrsWork').Value;

          if Not ADODataSet2.FieldByName('Other_Earn_Amount1').IsNull  then
              vOther_Earn1 := ADODataSet2.FieldByName('Other_Earn_Amount1').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Amount2').IsNull  then
              vOther_Earn2 := ADODataSet2.FieldByName('Other_Earn_Amount2').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Amount3').IsNull  then
              vOther_Earn3 := ADODataSet2.FieldByName('Other_Earn_Amount3').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Amount4').IsNull  then
              vOther_Earn4 := ADODataSet2.FieldByName('Other_Earn_Amount4').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Amount5').IsNull  then
              vOther_Earn5 := ADODataSet2.FieldByName('Other_Earn_Amount5').Value;

          if Not ADODataSet2.FieldByName('Other_Ded_Amount1').IsNull  then
              vOther_Ded1 := ADODataSet2.FieldByName('Other_Ded_Amount1').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Amount2').IsNull  then
              vOther_Ded2 := ADODataSet2.FieldByName('Other_Ded_Amount2').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Amount3').IsNull  then
              vOther_Ded3 := ADODataSet2.FieldByName('Other_Ded_Amount3').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Amount4').IsNull  then
              vOther_Ded4 := ADODataSet2.FieldByName('Other_Ded_Amount4').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Amount5').IsNull  then
              vOther_Ded5 := ADODataSet2.FieldByName('Other_Ded_Amount5').Value;

          if Not ADODataSet2.FieldByName('Other_Earn_Description1').IsNull  then
              vOther_Earn_Desc1 := ADODataSet2.FieldByName('Other_Earn_Description1').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Description2').IsNull  then
              vOther_Earn_Desc2 := ADODataSet2.FieldByName('Other_Earn_Description2').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Description3').IsNull  then
              vOther_Earn_Desc3 := ADODataSet2.FieldByName('Other_Earn_Description3').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Description4').IsNull  then
              vOther_Earn_Desc4 := ADODataSet2.FieldByName('Other_Earn_Description4').Value;
          if Not ADODataSet2.FieldByName('Other_Earn_Description5').IsNull  then
              vOther_Earn_Desc5 := ADODataSet2.FieldByName('Other_Earn_Description5').Value;

          if Not ADODataSet2.FieldByName('Other_Ded_Description1').IsNull  then
              vOther_Ded_Desc1 := ADODataSet2.FieldByName('Other_Ded_Description1').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Description2').IsNull  then
              vOther_Ded_Desc2 := ADODataSet2.FieldByName('Other_Ded_Description2').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Description3').IsNull  then
              vOther_Ded_Desc3 := ADODataSet2.FieldByName('Other_Ded_Description3').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Description4').IsNull  then
              vOther_Ded_Desc4 := ADODataSet2.FieldByName('Other_Ded_Description4').Value;
          if Not ADODataSet2.FieldByName('Other_Ded_Description5').IsNull  then
              vOther_Ded_Desc5 := ADODataSet2.FieldByName('Other_Ded_Description5').Value;

          if Not ADODataSet2.FieldByName('SLA5').IsNull then
              if ADODataSet2.FieldByName('SLA5').AsString = 'True' then
                  vSLA5 := true;

          if Not ADODataSet2.FieldByName('SLA10').IsNull then
              if ADODataSet2.FieldByName('SLA10').AsString = 'True' then
                  vSLA10 := true;

        end;
        ADODataSet2.Close;

        // Check if monthly_rate > 0 for non-keyers //
        if (ADODataSet1.FieldByName('Monthly_rate').Value > 0)
          and (ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN') then
        begin

          vHoliday_Pay1 := 0;

          if ADODataSet1.FieldByName('No_holiday').Value = FALSE then
          begin
            vSUP := FALSE;
            // check job position code if SUP or TL
            if not ADODataSet1.FieldByName('Job_position_code').IsNull then
              if (ADODataSet1.FieldByName('Job_position_code').AsString = 'SUP') or
                 (ADODataSet1.FieldByName('Job_position_code').AsString = 'GA') or
                 (ADODataSet1.FieldByName('Job_position_code').AsString = 'TL') or
                 (ADODataSet1.FieldByName('Job_position_code').AsString = 'PROJMGR') or
                 (ADODataSet1.FieldByName('Job_position_code').AsString = 'PRODMGR') then
                    vSUP := TRUE;
            // extract data from dtaholiday_holiday //
            ADODataSet2.CommandText := 'SELECT * FROM vwHoliday_Details WHERE Period1 = ' + sPeriod1;
            ADODataSet2.Open;
            if( ADODataSet2.RecordCount > 0 ) then
            begin
              ADODataSet2.First;
              while not ADODataSet2.Eof do
              begin
                vDays := 1;
                // check if the date_hired is less than the date of holiday
                if not ADODataSet1.FieldByName('Date_Hired').IsNull then

                  if ADODataSet1.FieldByName('Date_Hired').Value < ADODataSet2.FieldByName('HDate').Value then
                  begin
                    // compute for the holiday pay //
                    //updated - april 30, 2007 //
                    // check if monthly rate employees go to work during the holiday //
                    if ADODataSet2.FieldByName('Holiday_type').AsString = 'Legal Holiday' then
                    begin
{                      wDate := IncDay(ADODataSet2.FieldByName('HDate').Value, -1);

                      ADODataSet3.Close;
                      ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ''' +
                        DateTimeToStr(wDate) + ''' AND Employee_PIN = ' + ADODataSet1.FieldByName('Employee_PIN').AsString;
                      ADODataSet3.Open;

                      if ADODataSet3.RecordCount = 0 then
                      begin }
                        ADODataSet3.Close;
                        ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Employee_PIN = ' +
                          ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Work_date = ''' +
                          ADODataSet2.FieldByName('HDate').AsString + '''';
                        ADODataSet3.Open;

                        if (ADODataSet3.RecordCount > 0) then
                        begin
                          //if not vSUP then
                          //begin
                            // change number of working days from 21.667 to 21.74
                            vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 21.74) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                            vRate_Day1 := vRate_Month1 / 21.74;
                          //end
                          //else
                          //begin
                          //  vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 26) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                          //  vRate_Day1 := vRate_Month1 / 26;
                          //end;
                        end
                        else

                          vNo_Holidays := vNo_Holidays - 1;

{                      end
                      else
                      begin

                          if not vSUP then
                          begin
                            vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 21.667) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                            vRate_Day1 := vRate_Month1 / 21.667;
                          end
                          else
                          begin
                            vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 26) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                            vRate_Day1 := vRate_Month1 / 26;
                          end;
                      end; }
                    end
                    else
                    begin

                        ADODataSet3.Close;
                        ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Employee_PIN = ' +
                          ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Work_date = ''' +
                          ADODataSet2.FieldByName('HDate').AsString + '''';
                        ADODataSet3.Open;

                        if (ADODataSet3.RecordCount > 0) then
                        begin
                          //if not vSUP then
                          //begin
                            // change number of working days from 21.667 to 21.74
                            vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 21.74) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                            vRate_Day1 := vRate_Month1 / 21.74;
                          //end
                          //else
                          //begin
                          //  vHoliday_Pay1 := vHoliday_Pay1 + ((ADODataSet1.FieldByName('Monthly_rate').Value / 26) * (vDays * ADODataSet2.FieldByName('Holiday_Rate').Value));
                          //  vRate_Day1 := vRate_Month1 / 26;
                          //end;
                        end
                        else

                          vNo_Holidays := vNo_Holidays - 1;

                      end;

                  end;
                ADODataSet2.Next;
              end;
            end;
            ADODataSet2.Close;

            //determine daily rate of fixed employees
            // change number of working days from 21.667 to 21.74
            //if not vSUP then
              vRate_Day1 := vRate_Month1 / 21.74;
            //else
            //  vRate_Day1 := vRate_Month1 / 26;


          end   // with_holiday
          else
            vNo_Holidays := 0;
        end;

        vNight_Diff_Hours := 0;
        vNight_Diff_Hours_Hol2 := 0;
        vBonus_Pay2 := 0;
        vRev_Amt2 := 0;



        // Check if rate_hour > 0 //
        //if (ADODataSet1.FieldByName('Rate_hour').Value > 0) or
        //  (ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN') then

        if (ADODataSet1.FieldByName('Rate_hour').Value > 0) or
          (ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN') then
        begin

          // added to allow overtime pay for monthly rate employees that are not Admin as primary task  - July 20, 2010

          if ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN' then
          begin
            vRate_Hr2 := ADODataSet1.FieldByName('Rate_hour').Value
          end
          else if ADODataSet1.FieldByName('Monthly_rate').Value > 0 then
          begin
            // change number of working days from 21.667 to 21.74
            vRate_Day1 := vRate_Month1 / 21.74;
            vRate_Hr2 := vRate_Day1 / 8;
          end;


          {if ADODataSet1.FieldByName('Monthly_rate').Value > 0 then
          begin
            // change number of working days from 21.667 to 21.74
            vRate_Day1 := vRate_Month1 / 21.74;
            vRate_Hr2 := vRate_Day1 / 8;
          end
          else if ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN' then
          begin
            vRate_Hr2 := ADODataSet1.FieldByName('Rate_hour').Value
          end;   }


          // extract the summarized data from dtaTime_Summary
          ADODataSet2.CommandText := 'SELECT ISNULL(SUM(Days_Work),0) AS tDays_Work,' +
            'ISNULL(SUM(Regular_Hours),0) AS tReg_Hrs,' +
//            'ISNULL(sum(Night_Diff_Hours),0) as tNight_Diff_Hours, ' +
            'ISNULL(SUM(Bonus_Pay_Day),0) AS tBonus_Pay, ' +
            'ISNULL(SUM(Rev_Amt_Day),0) AS tRev_Amt ' +
            'FROM dtaTime_Summary WHERE employee_pin = ' + ADODataSet1.FieldByName('Employee_PIN').AsString +
            ' AND work_date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2 +
            ' AND regular_hours IS NOT NULL';
          //showmessage(adodataset2.commandtext);
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
          begin
            vDays_Work2       := ADODataSet2.FieldByName('tDays_Work').Value;
            vReg_Hrs2         := ADODataSet2.FieldByName('tReg_Hrs').Value;
//            vNight_Diff_Hours := ADODataSet2.FieldByName('tNight_Diff_Hours').Value;
            if not ADODataSet1.FieldByName('Bonus_Allowed').IsNull then
              if ADODataSet1.FieldByName('Bonus_Allowed').Value<>0 then
                vBonus_Pay2       := ADODataSet2.FieldByName('tBonus_Pay').Value;
            vRev_Amt2         := ADODataSet2.FieldByName('tRev_Amt').Value;

            ADODataSet2.Close;
            ADODataSet2.CommandText := 'SELECT DISTINCT Work_date' +
              ' FROM dtaTime_Summary WHERE Employee_PIN = ' + ADODataSet1.FieldByName('Employee_PIN').AsString +
              ' AND Work_date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2 +
              ' AND Regular_hours IS NOT NULL';

            ADODataSet2.Open;
            if (ADODataSet2.RecordCount > 0) then
              vDays_Work2 := ADODataSet2.RecordCount;

          end;
          ADODataSet2.Close;

          //ADODataSet2.CommandText := 'select ISNULL(sum(Night_Diff_Hours),0) as tNight_Diff_Hours from dtaTime_Detail where employee_pin='+ADODataSet1.FieldByName('Employee_PIN').AsString+' and work_date between '+sPeriod1+' AND '+sPeriod2;
          //ADODataSet2.Open;
          //if( ADODataSet2.RecordCount > 0 ) then
          //  vNight_Diff_Hours := ADODataSet2.FieldByName('tNight_Diff_Hours').Value;
          //ADODataSet2.Close;

          // do a manual computation of night_diff hours from dtatime_detail
          // due to failed computation of night_diff hours from EDS time extraction
          ADODataSet2.CommandText := 'SELECT * FROM dtaTime_Detail WHERE employee_pin=' +
            ADODataSet1.FieldByName('Employee_PIN').AsString +
            ' AND actual_in BETWEEN ' + tPeriod1 + ' AND ' + tPeriod2 +
            ' AND DateIn IN (SELECT Time_id FROM dtaTime_Detail WHERE employee_pin = ' +
                ADODataSet1.FieldByName('Employee_PIN').AsString +
                ' AND work_date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2 + ')' +
            ' ORDER BY actual_in';
          ADODataSet2.Open;

        if( ADODataSet2.RecordCount > 0 ) then
          while not ADODataSet2.Eof do
          begin
            // compute night diff hours //
            // night is from 10pm to 6am //
            if ((ADODataSet2.FieldByName('Actual_In').AsString>'') and (ADODataSet2.FieldByName('Actual_Out').AsString>'')) then
            begin
              myDate := StrToDateTime(ADODataSet2.FieldByName('Actual_In').AsString);
              DecodeDateTime(myDate, myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);
              myDate2 := StrToDateTime(ADODataSet2.FieldByName('Actual_Out').AsString);
              DecodeDateTime(myDate2, myYear2, myMonth2, myDay2, myHour2, myMin2, mySec2, myMilli2);

              fromDate := EncodeDateTime(myYear, myMonth, myDay, 22, 00, 00, 00);
              toDate := EncodeDateTime(myYear2, myMonth2, myDay2, 6, 00, 00, 00);

              // check if actual-in start at 0-6 hours, then decrement the date
              if( myHour < 10 ) then
              begin
                fromDate := IncDay(fromDate,-1);
                //myDay := myDay - 1;

                //fromDate := EncodeDateTime(myYear, myMonth, myDay, 22, 00, 00, 00);
              end;

              isNightDiff := false;
              if( (fromDate >= myDate) and (fromDate <= myDate2) ) then isNightDiff := true;
                //showmessage(ADODataSet2.FieldByName('Actual_In').AsString+'  '+ADODataSet2.FieldByName('Actual_Out').AsString+chr(13)+DateTimeToStr(fromdate)+'  '+DateTimeToStr(todate)+chr(13)+'10pm is nightdiff');
              if( (toDate >= myDate) and (toDate <= myDate2) ) then isNightDiff := true;
                //showmessage(ADODataSet2.FieldByName('Actual_In').AsString+'  '+ADODataSet2.FieldByName('Actual_Out').AsString+chr(13)+DateTimeToStr(fromdate)+'  '+DateTimeToStr(todate)+chr(13)+'6am is nightdiff');
              if( (myDate >= fromDate) and (myDate2 <= toDate) ) then isNightDiff := true;

              if (IsNightDiff) then
              begin
                //showmessage(ADODataSet2.FieldByName('Actual_In').AsString+'  '+ADODataSet2.FieldByName('Actual_Out').AsString+chr(13)+DateTimeToStr(fromdate)+'  '+DateTimeToStr(todate)+chr(13)+'its nightdiff');
                // compute nightdiff

                // check if actual in is less than 10pm but not less than 6am
                // then, set the time 10pm
                if ( (((myHour*60)+myMin) < (22*60)) and (((myHour*60)+myMin) > (6*60)) ) then
                  myDate := EncodeDateTime(myYear, myMonth, myDay, 22, 0, 0, 0);

                // check if actual out greater than than 6am but not greater than 10pm
                // then, set the time 6am
                if ( (((myHour2*60)+myMin2) > (6*60)) and (((myHour2*60)+myMin2) < (22*60)) ) then
                  myDate2 := EncodeDateTime(myYear2, myMonth2, myDay2, 6, 0, 0, 0);
                //showmessage(ADODataSet2.FieldByName('Actual_In').AsString+'  '+ADODataSet2.FieldByName('Actual_Out').AsString+chr(13)+DateTimeToStr(mydate)+'  '+DateTimeToStr(mydate2)+chr(13)+'new nightdiff');

                // compute nightdiff
                toDate := myDate2 - myDate;
                DecodeDateTime(toDate, toYear, toMonth, toDay, toHour, toMin, toSec, toMilli);
                vNight_Diff_Hours_Per_Day := 0;
                vNight_Diff_Hours_Per_Day := toHour + (toMin/60);
                vNight_Diff_Hours := vNight_Diff_Hours + StrToFloat(FloatToStrF(vNight_Diff_Hours_Per_Day,ffFixed,6,2));
                //ShowMessage(FloatToStr(vNight_Diff_Hours_Per_Day));
                //ShowMessage(FloatToStr(vNight_Diff_Hours));


                //save to dtatime_detail (night_diff_hours_hol) if work date is holiday
                //coded on Nov. 2, 2006
                ADODataSet3.Close;
                ADODataSet3.CommandText := 'SELECT * FROM dtaHoliday_Details WHERE HDate = ''' +
                  ADODataSet2.FieldByName('Work_Date').AsString + '''';
                ADODataSet3.Open;

                // update the dtaTime_Detail
                wID := ADODataSet2.FieldByName('Time_ID').AsString;

                vNight_Diff_Hours_Hol2_Day := 0;
                vNight_Diff_Hours_Hol2_Day1 := 0;

                //start of checking date
                if ADODataSet3.RecordCount > 0 then
                begin

                    vNight_Diff_Hours_Hol2_Day := vNight_Diff_Hours_Per_Day;


                    ADODataSet4.Close;
                    ADODataSet4.CommandText := 'SELECT * FROM dtaPayRates WHERE day_type = ''' +
                      ADODataSet3.FieldByName('Holiday_Type').AsString + '''';
                    ADODataSet4.Open;

                    if ADODataSet4.RecordCount > 0 then
                    begin

                      //vNight_Diff_Hours_Hol_Pay2 := vNight_Diff_Hours_Hol_Pay2 +
                        //(vNight_Diff_Hours_Hol2_Day * (vRate_Hr2 * ADODataSet4.FieldByName('nightdiff_reg').Value));

                    end;

                    vNight_Diff_Hours_Hol2_Day1 := vNight_Diff_Hours_Hol2_Day;

                  //end;

                end;



           //no holiday for keyers
           if ADODataSet1.FieldByName('No_holiday').Value = FALSE then
           begin
               if (ADODataSet3.RecordCount > 0) then //or (ADODataSet5.RecordCount > 0)) then
               begin
                  //vNight_Diff_Hours_Hol2_Day := vNight_Diff_Hours_Per_Day;
                  //vNight_Diff_Hours_Hol2 := vNight_Diff_Hours_Hol2 + vNight_Diff_Hours_Hol2_Day;
                  //vNight_Diff_Hours_Hol2 := vNight_Diff_Hours_Hol2 + vNight_Diff_Hours_Hol2_Day1;

                    SQL := 'UPDATE dtaTime_Detail SET ' +
                      'Night_Diff_Hours = '+ FloatToStr(vNight_Diff_Hours_Per_Day) +
                      //', Night_Diff_Hours_Hol = '+ FloatToStr(vNight_Diff_Hours_Hol2_Day1) +
                      ' WHERE Time_ID = '+ wID;
                    ADOConnection1.Execute(SQL);

                    SQL := 'UPDATE dtaTime_Detail SET Night_Diff_Hours_Hol = Night_Diff_Hours ' +
                      'WHERE DateIn = ' + wID;
                    ADOConnection1.Execute(SQL);

                    SQL := 'SELECT isnull(sum(Night_Diff_Hours_Hol),0) as NDHol FROM dtaTime_Detail ' +
                      'WHERE DateIn = ' + wID;

                    ADODataSet4.Close;
                    ADODataSet4.CommandText := SQL;
                    ADODataSet4.Open;

                    if (ADODataSet4.RecordCount > 0) then
                      vNight_Diff_Hours_Hol2_Day1 := ADODataSet4.FieldByName('NDHol').Value
                    else
                      vNight_Diff_Hours_Hol2_Day1 := 0;


                    // compute for night diff regular holiday
                      ADODataSet4.Close;
                      ADODataSet4.CommandText := 'SELECT * FROM dtaPayRates WHERE day_type = ''' +
                        ADODataSet3.FieldByName('Holiday_Type').AsString + '''';
                      ADODataSet4.Open;

                      if ADODataSet4.RecordCount > 0 then
                      begin

                        vNight_Diff_Hours_Hol_Pay2 :=  vNight_Diff_Hours_Hol_Pay2 +
                          (vNight_Diff_Hours_Hol2_Day1 * (vRate_Hr2 * ADODataSet4.FieldByName('nightdiff_reg').Value));

                      end;

                      vNight_Diff_Hours_Hol2 := vNight_Diff_Hours_Hol2 + vNight_Diff_Hours_Hol2_Day1;

                end
                else
                begin
                  SQL := 'UPDATE dtaTime_Detail SET ' +
                    'Night_Diff_Hours = '+ FloatToStr(vNight_Diff_Hours_Per_Day) +
                    'WHERE Time_ID = '+ wID;
                  ADOConnection1.Execute(SQL);
                end;

           end;
           // end of statement for no holiday keyers


              //end of statement of checking if it is night diff
              end;

            // end of statement of checking if actual in and out are not equal to ''
            end;
            ADODataSet2.Next;
          end;
          ADODataSet2.Close;

          ADODataSet2.CommandText := 'SELECT ISNULL(SUM(OT),0) AS tOT FROM dtaTime_Summary WHERE AuthorizeOT = ''Yes'' AND employee_pin=' +
            ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Work_Date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2;
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
            vOT_Hrs2 := ADODataSet2.FieldByName('tOT').Value;

          ADODataSet2.Close;

          vHrs_Work2 := vReg_Hrs2 + vOT_Hrs2;

          // holiday pay for keyers
          vHoliday_Pay2 := 0;
          vHolidayOT := 0;
          vHolidayOTHrs := 0;

          // extract data from dtaholiday_holiday //
          ADODataSet2.CommandText := 'SELECT * FROM vwHoliday_Details WHERE Period1 = '+sPeriod1;
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
          begin
            ADODataSet2.First;
            while not ADODataSet2.Eof do
            begin
              vDays := 1;
              // check if the date_hired is less than the date of holiday
              if not ADODataSet1.FieldByName('Date_Hired').IsNull then
                if ADODataSet1.FieldByName('Date_Hired').Value < ADODataSet2.FieldByName('HDate').Value then
                begin
                  // compute for the holiday pay //
                  if ADODataSet2.FieldByName('Holiday_Type').AsString = 'Legal Holiday' then
                  begin

                    //removed as of 04/17/08 - to remove the policy
                    //that if an employee did not go to work on the day before
                    //the holiday and on that holiday, will not be paid.
                    //****
                    wDate := IncDay(ADODataSet2.FieldByName('HDate').Value, -1);

                    ADODataSet3.Close;
                    ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ''' +
                      DateTimeToStr(wDate) + ''' AND Employee_PIN = ' + ADODataSet1.FieldByName('Employee_PIN').AsString;
                    ADODataSet3.Open;

                    if ADODataSet3.RecordCount > 0 then
                    begin

                      vHol_Hrs2 := 8;


                      //ADODataSet3.Close;
                      //ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ''' +
                      //  ADODataSet2.FieldByName('HDate').AsString + ''' AND Employee_PIN = ' +
                      //  ADODataSet1.FieldByName('Employee_PIN').AsString;
                      //ADODataSet3.Open;

                      holCOLA := holCOLA + 1;

                    end

                    else
                    begin

                      ADODataSet3.Close;
                      ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ''' +
                        ADODataSet2.FieldByName('HDate').AsString + ''' AND Employee_PIN = ' +
                        ADODataSet1.FieldByName('Employee_PIN').AsString;
                      ADODataSet3.Open;

                      if ADODataSet3.RecordCount > 0 then
                      begin
                        vHol_Hrs2 := 8;
                        holCOLA := holCOLA + 1;
                      end
                      else
                        vNo_Holidays := vNo_Holidays - 1;

                    end;

                  end
                  else
                  begin
                    ADODataSet3.Close;
                    ADODataSet3.CommandText := 'SELECT SUM(ISNULL(Regular_hours, 0)) AS tHolHours FROM dtaTime_Summary WHERE Employee_PIN = ' +
                      ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Work_Date = ''' + ADODataSet2.FieldByName('HDATE').AsString + '''';
                    ADODataSet3.Open;

                    if ADODataSet3.RecordCount > 0 then
                      if ADODataSet3.FieldByName('tHolHours').IsNull = true then
                      begin
                        vHol_Hrs2 := 0;
                        vNo_Holidays := vNo_Holidays - 1;
                      end
                      else
                        vHol_Hrs2 := ADODataSet3.FieldByName('tHolHours').Value;
                   end;

                  // forgot to check if the keyer reported for work on that day //
                  //vPresent_on_Holiday := FALSE;

                  //ADODataSet3.Close;
                  //ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Summary WHERE employee_pin = '+ADODataSet1.FieldByName('Employee_PIN').AsString +
                    //' AND work_date = ''' +ADODataSet2.FieldByName('HDATE').AsString+ '''';
                  //ADODataSet3.Open;

                  //if ( ADODataSet3.RecordCount > 0 ) then vPresent_on_Holiday := TRUE;
                  //ADODataSet3.Close;

                  //if vPresent_on_Holiday then
                  //begin
                    // add holiday only if keyer reported to
                    ADODataSet3.Close;
                    ADODataSet3.CommandText := 'SELECT ISNULL(OT,0) AS tOT FROM dtaTime_Summary WHERE AuthorizeOT=''Yes'' AND employee_pin=' +
                      ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND work_date =''' + ADODataSet2.FieldByName('HDate').AsString + '''';
                    ADODataSet3.Open;

                    // add the ot hours
//                    if( ADODataSet3.RecordCount > 0 ) then
//                      vHol_Hrs2 := vHol_Hrs2 + ADODataSet3.FieldByName('tOT').Value;
//                    ADODataSet3.Close;
                    //vHoliday_Pay2 := vHoliday_Pay2 + ( vHol_Hrs2 * vRate_Hr2 * ADODataSet2.FieldByName('Holiday_Rate').Value );


                    //edited - oct 25, 2006 due to different ot and night diff rates on holidays
                    if ( ADODataSet3.RecordCount > 0 ) then
                    begin
                      vHolidayOT := ADODataSet3.FieldByName('tOT').Value;
                      vHol_Hrs2 := vHol_Hrs2 + vHolidayOT;

                    end;
                    ADODataSet3.Close;

                    ADODataSet3.CommandText := 'SELECT * FROM dtaPayRates WHERE day_type = ''' + ADODataSet2.FieldByName('Holiday_Type').AsString + '''';
                    ADODataSet3.Open;

                    vHoliday_Pay2 := vHoliday_Pay2 + ((vHol_Hrs2-vHolidayOT) * vRate_Hr2 * ADODataSet2.FieldByName('Holiday_Rate').Value );
                      //                      (vHolidayOT * (ADODataSet3.FieldByName('overtime_rate').Value * vRate_Hr2));

                    vHolidayOT_Pay := vHolidayOT_Pay + (vHolidayOT * (ADODataSet3.FieldByName('overtime_rate').Value * vRate_Hr2));


                    vHolidayOTHrs := vHolidayOTHrs + vHolidayOT;
                    vHolidayHrs := vHolidayHrs + (vHol_Hrs2-vHolidayOT);

                    vHol_Hrs2 := 0;
                    vHolidayOT := 0;

                    ADODataSet3.Close;
                  //end;
                end;
              ADODataSet2.Next;
            end;
          end;
          ADODataSet2.Close;

        end;

        //vRate_Day1 := vRate_Month1 / 21.667;
        if (ADODataSet1.FieldByName('Primary_task_id').AsString = 'ADMIN')
          and (ADODataSet1.FieldByName('Rate_hour').Value = 0) then
        begin
          //if not vSUP then
            vRate_Day1 := vRate_Month1 / 21.74;
          //else
          //  vRate_Day1 := vRate_Month1 / 26;

          vBasic_Pay1 := (vRate_Month1 / 2) - (vRate_Day1 * vDays_Absent1);

        end
        else if (ADODataSet1.FieldByName('Primary_task_id').AsString <> 'ADMIN')
          and (ADODataSet1.FieldByName('Monthly_rate').Value > 0) then

          vBasic_Pay2 := (vRate_Month1 / 2) - (vRate_Day1 * vDays_Absent1)

        else
          vBasic_Pay2 := vRate_Hr2 * vReg_Hrs2;         // vHrs_Work2 now is Regulars Hours only as of 3/20/2006



        if ADODataSet1.FieldByName('No_13thMonth').Value = FALSE then
          // 13th month computation
          vM13thmo := ( vBasic_Pay1 + vBasic_Pay2 ) / 12;


        vCOLA2 := 0;

        // modified on 08-19-2011
        if ADODataSet1.FieldByName('Rate_Hour').Value > 0 then
        begin
          //vCOLA2 := vDays_Work2 * 9;
          if ADODataSet1.FieldByName('No_COLA').Value = FALSE then
          begin
            vCOLA2 := holCOLA * vCOLArate;
            vCOLA2 := vCOLA2 + (vDays_Work2 * vCOLArate);
          end;
        end;

        // recompute Day Off Hours using the dtaDayOff table //
        vDay_Off_Hrs2 := 0;
        vDay_Off_OT := 0;
        vDay_Off_ND := 0;

        ADODataSet2.CommandText := 'SELECT * FROM dtaDayOff WHERE Employee_PIN = '+
          ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Day_Off BETWEEN ' +
          sPeriod1 + ' AND ' + sPeriod2;
        ADODataSet2.Open;
        if( ADODataSet2.RecordCount > 0 ) then
        begin
          ADODataSet2.First;
          while not ADODataSet2.Eof do
          begin
            //check if the day_off it is found in dtaTime_Summary //
            ADODataSet3.Close;
            ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Regular_Hours),0) AS tHrs, ISNULL(SUM(OT),0) AS tOT FROM dtaTime_Summary WHERE Employee_PIN = '+
              ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Work_Date = ''' + ADODataSet2.FieldByName('Day_Off').AsString + '''';
            ADODataSet3.Open;
            // add the tHrs to vDay_Off_Hrs2
            if( ADODataSet3.RecordCount > 0 ) then
              vDay_Off_Hrs2 := vDay_Off_Hrs2 + ADODataSet3.FieldByName('tHrs').Value;
              vDay_Off_OT := vDay_Off_OT + ADODataSet3.FieldByName('tOT').Value;
            ADODataSet3.Close;

            //get dayoff ND
//            strOutND := DateToStr(IncDay(StrToDate(ADODataSet2.FieldByName('Day_Off').AsString), 1)) + ' 6:00:00 AM';
//            ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
//              ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' + ADODataSet2.FieldByName('Day_Off').AsString +
//              ' 12:00:00 AM'' AND ''' + strOutND + '''';


            ADODataSet3.CommandText := 'SELECT * FROM dtaTime_Detail ' +
              'WHERE Work_Date = ''' + ADODataSet2.FieldByName('Day_Off').AsString +
              ''' AND employee_pin = ' + ADODataSet1.FieldByName('Employee_PIN').AsString +
              ' ORDER BY Actual_in DESC';
            ADODataSet3.Open;


            if (ADODataSet3.RecordCount > 0) then
            begin

              if (ADODataSet3.RecordCount >= 2) then
              begin
                strInND := ADODataSet3.FieldByName('Actual_In').AsString;
                ADODataSet3.Next;
                strInND2 := ADODataSet3.FieldByName('Actual_In').AsString;

                ADODataSet3.Close;

                s01 := ADODataSet2.FieldByName('Day_Off').AsString + ' 12:00:00 AM';
                s001 := ADODataSet2.FieldByName('Day_Off').AsString + ' 6:00:00 AM';
                s02 := DateToStr(IncDay(StrToDate(ADODataSet2.FieldByName('Day_Off').AsString), 1)) + ' 6:00:00 AM';

                if (((StrToDateTime(strInND) >= StrToDateTime(s01)) and (StrToDateTime(strInND) <= StrToDateTime(s001))) and
                  ((StrToDateTime(strInND2) >= StrToDateTime(s01)) and (StrToDateTime(strInND) <= StrToDateTime(s001)))) then
                begin
                  strOutND := ADODataSet2.FieldByName('Day_Off').AsString + ' 6:00:00 AM';
                  ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
                    ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' +
                    strInND2 + ''' AND ''' + strOutND + '''';
                end

  //              strInND := chr(39) + strInND + chr(39);
                else if ((StrToDateTime(strInND) >= StrToDateTime(s01)) and (StrToDateTime(strInND) <= StrToDateTime(s02))) then
                begin

                  //edited due to miscomputation of regular night differential - 04/20/2010
                  strOutND := DateToStr(IncDay(StrToDate(ADODataSet2.FieldByName('Day_Off').AsString), 1)) + ' 6:00:00 AM';
                  ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
                    ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' +
                    strInND + ''' AND ''' + strOutND + '''';
                end
                else
                begin
                  strOutND := ADODataSet2.FieldByName('Day_Off').AsString + ' 6:00:00 AM';
                  ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
                    ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' +
                    strInND + ''' AND ''' + strOutND + '''';
                end;

              end
              // if employee logged in between 12am-6am on his/her dayoff and logged out once
              else if (ADODataSet3.RecordCount = 1) then
              begin
                strInND := ADODataSet3.FieldByName('Actual_In').AsString;
                ADODataSet3.Close;

                s01 := ADODataSet2.FieldByName('Day_Off').AsString + ' 12:00:00 AM';
                s02 := ADODataSet2.FieldByName('Day_Off').AsString + ' 6:00:00 AM';

  //              strInND := chr(39) + strInND + chr(39);
                if ((StrToDateTime(strInND) >= StrToDateTime(s01)) and (StrToDateTime(strInND) <= StrToDateTime(s02))) then
                begin

                  //edited due to miscomputation of regular night differential - 04/20/2010
                  strOutND := ADODataSet2.FieldByName('Day_Off').AsString + ' 6:00:00 AM';
                  ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
                    ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' +
                    strInND + ''' AND ''' + strOutND + '''';

                end
                else
                begin
                  s02 := DateToStr(IncDay(StrToDate(ADODataSet2.FieldByName('Day_Off').AsString), 1)) + ' 6:00:00 AM';
                  ADODataSet3.CommandText := 'SELECT ISNULL(SUM(Night_Diff_Hours),0) AS tND FROM dtaTime_Detail WHERE Employee_PIN = '+
                    ADODataSet1.FieldByName('Employee_PIN').AsString + ' AND Actual_In BETWEEN ''' +
                    strInND + ''' AND ''' + s02 + '''';
                end;

              end;


              ADODataSet3.Open;

              // add the tHrs to vDay_Off_Hrs2
              if( ADODataSet3.RecordCount > 0 ) then
                vDay_Off_ND := vDay_Off_ND + ADODataSet3.FieldByName('tND').Value;
              ADODataSet3.Close;

            end;

            // update DayOff Processed field
            ADOConnection1.Execute('UPDATE dtaDayOff SET Processed=''Y'' WHERE ID=' + ADODataSet2.FieldByName('ID').AsString);
            ADODataSet2.Next;
          end;
        end;
        ADODataSet2.Close;


        //no holiday for keyers - added on December 17, 2009 to compute no holiday for selected keyers
        if ADODataSet1.FieldByName('No_holiday').Value = TRUE then
        begin

          vHoliday_Pay2 := 0;
          vHolidayOT_Pay := 0;

          vHolidayOTHrs := 0;
          vHolidayHrs := 0;

          vNight_Diff_Hours_Hol2 := 0;

          vNo_Holidays := 0;


          //vNight_Diff_Hours := 0;
          vNight_Diff_Hours_Hol2_Day := 0;
          vNight_Diff_Hours_Hol2_Day1 := 0;

          vNight_Diff_Hours_Hol_Pay2 := 0;

        end;


        vDay_Off_Pay2 := (vDay_Off_Hrs2 * (vRate_Hr2 * 0.30));
        vOTDayOffPay := (vDay_Off_OT * (vRate_Hr2 * 1.69));
        vNDDayOffPay := (vDay_Off_ND * (vRate_Hr2 * 0.13));

        //vDay_Off_Hrs2 := vDay_Off_Hrs2 + vDay_Off_OT;


        if (ADODataSet1.FieldByName('Primary_task_id').AsString <> 'ADMIN') and
          (ADODataSet1.FieldByName('Monthly_rate').Value > 0) then
        begin
          vOT_Pay2 := 0;
          vOT_Hrs2 := 0;

          vHolidayOT_Pay := 0;
          vHolidayOTHrs := 0;
        end
        else
        begin
          //vOT_Pay2 := (vRate_Hr2 * 0.25) * vOT_Hrs2;  // as of 3/20/06
          vOT_Pay2 := (vRate_Hr2 * 1.25) * (vOT_Hrs2 - vHolidayOTHrs - vDay_Off_OT);    // as of 3/20/06
          vOT_Hrs2 := vOT_Hrs2 - vHolidayOTHrs - vDay_Off_OT;
        end;

        // automatic deduct one hour on night diff
        //vNight_Diff_Hours := vNight_Diff_Hours - vDays_Work2;

        if( vNight_Diff = TRUE ) then
        begin
//          vNight_Diff_Pay2 := ((vRate_Hr2 * 0.10) * (vNight_Diff_Hours - vNight_Diff_Hours_Hol2)) + vNight_Diff_Hours_Hol_Pay2;
          vNight_Diff_Pay2 := ((vRate_Hr2 * 0.10) * (vNight_Diff_Hours - vNight_Diff_Hours_Hol2 - vDay_Off_ND));
          vNight_Diff_Hours := vNight_Diff_Hours - vNight_Diff_Hours_Hol2 - vDay_Off_ND;
        end
        else
        begin
          vNight_Diff_Hours := 0;
          vNight_Diff_Hours_Hol2 := 0;
          vNight_Diff_Pay2 := 0;
          vNight_Diff_Hours_Hol_Pay2 := 0;
        end;

        if (vNight_Diff_Hours < 0) then
        begin
          vNight_Diff_Pay2 := 0;
          vNight_Diff_Hours := 0;
        end;

          //vNight_Diff_Hours := vNight_Diff_Hours - vNight_Diff_Hours_Hol2;



//        ADODataSet2.CommandText := 'SELECT SUM(night_diff_hours) AS ND_COLA ' +
//          'FROM dtaTime_Detail WHERE work_date BETWEEN ' + sPeriod1 + ' AND ' + sPeriod2 + ' AND employee_pin = ' +
//          ADODataSet1.FieldByName('employee_pin').AsString + ' AND work_date < ''8/3/2007''';
//        ADODataSet2.Open;

//        if ADODataSet2.RecordCount > 0 then
//        begin

//          if vNight_Diff_Pay2 > 0 then
//            if not ADODataSet2.FieldByName('ND_COLA').IsNull then
//              vNight_Diff_Pay2 := vNight_Diff_Pay2 - ((5 * 0.10) * ADODataSet2.FieldByName('ND_COLA').Value);

//        end;

        ADODataSet2.Close;


        vUnearned_Pay := vBonus_Pay2;
        if vBonus_Pay2 < 0 then
          vBonus_Pay2 := 0;

        // compute for SLA5 and SLA10
        if vSLA5 then
        begin
            vSLA_5 := vBasic_Pay2 * 0.05;
        end;

        if vSLA10 then
        begin
            vSLA_10 := vBasic_Pay2 * 0.10;
            if vSLA_10 > vBonus_Pay2 then
                vSLA_10 := vBonus_Pay2;
        end;

        // determine if employee is allowed OT pay
        // modified on 08-19-2011
        if ADODataSet1.FieldByName('OT_Allowed').Value = False then
        begin
          vOT_Pay2 := 0;
          vHolidayOT_Pay := 0;
          vOTDayOffPay := 0;
        end;

        vGross_Pay := vBasic_Pay1 + vHoliday_Pay1 +
                      vBasic_Pay2 + vHoliday_Pay2 + vOt_Pay2 + vCOLA2 + vDay_Off_Pay2 + vNight_Diff_Pay2 + vBonus_Pay2 +
                      vSLA_5 +
                      vOther_Earn1 + vOther_Earn2 + vOther_Earn3 +
                      vHolidayOT_Pay + vNight_Diff_Hours_Hol_Pay2 + vOTDayOffPay + vNDDayOffPay;
        vGross_Pay := vGross_Pay - ( vSLA_10 + vOther_Ded1 + vOther_Ded2 + vOther_Ded3 ) ;


        // additional bonuses
        {// check if attendance bonus is computed
        if Not ADODataSet1.FieldByName('WithAttendanceBonus').IsNull then
        begin
          if ADODataSet1.FieldByName('WithAttendanceBonus').Value = 'true' then
            sWithAttBonus := '1'
          else
            sWithAttBonus := '0';
        end;

        if (sWithAttBonus = '1') then
        begin

          AbsentCount := 0;
          vEmpWorkingDaysLastMonth := 0;
          
          // get employee working hours last month

          SQL := 'SELECT ISNULL(SUM(Days_Work2),0) AS Days_Work2 ';
          SQL := SQL + 'FROM dtaPayrollProcess ';
          SQL := SQL + 'WHERE YEAR(Period1) = ' + IntToStr(AttBonusYear) + ' ' +
            'AND MONTH(Period1) = ' + IntToStr(AttBonusMonth) + ' ' +
            'AND Employee_PIN = ''' + ADODataSet1.FieldByName('Employee_PIN').AsString + '''';

          dsPayrollTemp.CommandText := SQL;
          dsPayrollTemp.Open;

          if (dsPayrollTemp.RecordCount > 0) then
          begin
            vEmpWorkingDaysLastMonth := dsPayrolltemp.FieldByName('Days_Work2').Value;
          end;

          dsPayrollTemp.Close;

          if (vEmpWorkingDaysLastMonth > 0) then
          begin
            // need to determine number of days absent
            if (WorkingDaysCount >= Round(vEmpWorkingDaysLastMonth)) then
            begin
              AbsentCount := WorkingDaysCount - Round(vEmpWorkingDaysLastMonth);
            end;
          
            // open dtaBonusesDetails to get bonus records
            SQL := 'SELECT TOP 1 ISNULL(BonusAmount,0) AS BonusAmount ';
            SQL := SQL + 'FROM dtaBonusesTable ';
            SQL := SQL + 'WHERE BonusType = ''ATTENDANCE'' ';
            SQL := SQL + 'AND Deleted = 0 ';
            SQL := SQL + 'AND DaysAbsent >= ' + IntToStr(AbsentCount) + ' ';
            SQL := SQL + 'ORDER BY DaysAbsent';

            dsBonusesTable.CommandText :=  SQL;
            dsBonusesTable.Open;

            if (dsBonusesTable.RecordCount > 0) then
            begin
              vBonusAttendanceRate := dsBonusesTable.FieldByName('BonusAmount').Value;

              if (vBonusAttendanceRate > 0) then
                vBonusAttendance := vBonusAttendanceRate * vEmpWorkingDaysLastMonth
              else
                vBonusAttendance := 0;
            end;

            dsBonusesTable.Close;
          end;
        end;   }

        // open tblBonusesDetails table by period
        SQL := 'SELECT ISNULL(Bonus_UPH,0) AS Bonus_UPH, ISNULL(Bonus_Quality,0) AS Bonus_Quality, ' +
          'ISNULL(Bonus_Retention,0) AS Bonus_Retention, ISNULL(Bonus_Attendance,0) AS Bonus_Attendance, ' +
          'ISNULL(Bonus_PerfectAttendance,0) AS Bonus_PerfectAttendance, ISNULL(Remarks,'''') AS Remarks, ' +
          'ISNULL(Bonus_Others,0) AS Bonus_Others ';
        SQL := SQL + 'FROM dtaBonusesDetails ';
        SQL := SQL + 'WHERE Period1 = ' + sPeriod1 + ' ';
        SQL := SQL + 'AND Deleted = 0 ';
        SQL := SQL + 'AND Employee_PIN = ''' + ADODataSet1.FieldByName('Employee_PIN').AsString + '''';

        dsBonusesDetails.CommandText := SQL;
        dsBonusesDetails.Open;

        if (dsBonusesDetails.RecordCount > 0) then
        begin

          vBonusUPH := dsBonusesDetails.FieldByName('Bonus_UPH').Value;
          vBonusQuality := dsBonusesDetails.FieldByName('Bonus_Quality').Value;
          vBonusRetention := dsBonusesDetails.FieldByName('Bonus_Retention').Value;

          vBonusAttendance := dsBonusesDetails.FieldByName('Bonus_Attendance').Value;
          vBonusPAttendance := dsBonusesDetails.FieldByName('Bonus_PerfectAttendance').Value;

          vBonusOthers := dsBonusesDetails.FieldByName('Bonus_Others').Value;

          sRemarks := dsBonusesDetails.FieldByName('Remarks').AsString;
        end;

        dsBonusesDetails.Close;


        vSBCashAdvance := 0;

        // add a checkbox for user if need to deduct from previous payroll debt or not
        if (chkDeductSnacks.Checked) then
        begin
          // get purchases from ES_SNACKS database
          SQL := 'SELECT ISNULL(SUM((PurchasedQuantity * ItemSellingPrice)),0) AS PurchaseAmount ';
          SQL := SQL + 'FROM ES_Purchases ';
          SQL := SQL + 'WHERE PayPeriod = ' + sPeriod1 + ' ';
          SQL := SQL + 'AND Deleted = 0 ';
          SQL := SQL + 'AND PurchasedBy = ''' + ADODataSet1.FieldByName('Employee_PIN').AsString + '''';

          dsPurchases.CommandText := SQL;
          dsPurchases.Open;

          if (dsPurchases.RecordCount > 0) then
          begin

            vSBCashAdvance := dsPurchases.FieldByName('PurchaseAmount').Value;
          end;

          dsPurchases.Close;
        end;


        // Pag-ibig MP2
        // only deduct every 16th payroll period
        if(day = 16) then
        begin
          if (not ADODataSet1.FieldByName('MP2Qualified').IsNull)
            AND (not ADODataSet1.FieldByName('MP2Share').IsNull) then
          begin
            if ADODataSet1.FieldByName('MP2Qualified').Value = TRUE then
            begin
              vMP2EmployeeShare := ADODataSet1.FieldByName('MP2Share').Value;

              // get employer share
              ADODataSet2.Close;
              ADODataSet2.CommandText := 'SELECT ISNULL(EmployerShare,0) AS EmployerShare ' +
                ' FROM dtaPagIbig_MP2 ';
              ADODataSet2.Open;
              if (ADODataSet2.RecordCount > 0) then
                vMP2EmployerShare := ADODataSet2.FieldByName('EmployerShare').Value;

              ADODataSet2.Close;
            end;
          end;
        end;

      // proceed the process if only the vgross_pay > 0 //
      if vGross_Pay > 0 then
      begin

        vBasic_Pay_Current := 0;
        vBasic_Pay_Previous := 0;

        vPrev_Period := '';
        vPrev_Gross_Pay := 0;
        vPrev_Other_Earn1 := 0;
        vPrev_SSS_EE := 0;
        vPrev_SSS_ER := 0;
        vPrev_Philhealth_EE := 0;
        vPrev_Philhealth_ER := 0;
        vPrev_ECC_ER := 0;
        vPrev_Basic_Pay1 := 0;
        vPrev_Basic_Pay2 := 0;
        vPrev_COLA2 := 0;
        vPrev_Pagibig_ER := 0;
        vPrev_Pagibig_EE := 0;
        // check previous sss and philhealth
        if(day=16) then
        begin
          vPrev_Period := StringReplace(sPeriod1,'/16/','/1/',[rfReplaceAll]);
          ADODataSet2.CommandText := 'SELECT * FROM dtaPayrollProcess WHERE (Employee_PIN = ' + ADODataSet1.FieldByName('Employee_PIN').AsString + ') AND (Period1 = ' + vPrev_Period + ')';
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
          begin
            ADODataSet2.First;
            if Not ADODataSet2.FieldByName('gross_pay').IsNull then
              vPrev_Gross_Pay := ADODataSet2.FieldByName('gross_pay').Value;
            if Not ADODataSet2.FieldByName('other_earn1').IsNull then
              vPrev_Other_Earn1 := ADODataSet2.FieldByName('other_earn1').Value;
            if Not ADODataSet2.FieldByName('sss_ee').IsNull then
              vPrev_SSS_EE := ADODataSet2.FieldByName('sss_ee').Value;
            if Not ADODataSet2.FieldByName('sss_er').IsNull then
              vPrev_SSS_ER := ADODataSet2.FieldByName('sss_er').Value;
            if Not ADODataSet2.FieldByName('philhealth_ee').IsNull then
              vPrev_Philhealth_EE := ADODataSet2.FieldByName('philhealth_ee').Value;
            if Not ADODataSet2.FieldByName('philhealth_er').IsNull then
              vPrev_Philhealth_ER := ADODataSet2.FieldByName('philhealth_er').Value;
            if Not ADODataSet2.FieldByName('ecc_er').IsNull then
              vPrev_ECC_ER := ADODataSet2.FieldByName('ecc_er').Value;
            if Not ADODataSet2.FieldByName('Basic_Pay1').IsNull then
              vPrev_Basic_Pay1 := ADODataSet2.FieldByName('Basic_Pay1').Value;
            if Not ADODataSet2.FieldByName('Basic_Pay2').IsNull then
              vPrev_Basic_Pay2 := ADODataSet2.FieldByName('Basic_Pay2').Value;
            if Not ADODataSet2.FieldByName('COLA2').IsNull then
              vPrev_COLA2 := ADODataSet2.FieldByName('COLA2').Value;
            if Not ADODataSet2.FieldByName('Pagibig_ee').IsNull then
              vPrev_Pagibig_EE := ADODataSet2.FieldByName('Pagibig_ee').Value;
            if Not ADODataSet2.FieldByName('Pagibig_er').IsNull then
              vPrev_Pagibig_ER := ADODataSet2.FieldByName('Pagibig_er').Value;
          end;
          ADODataSet2.Close;
        end;

        // computation for sss //
        vSSS_EE := 0;
        vSSS_ER := 0;
        vECC_ER := 0;
        // if day = 16 then get the previous gross and sss //

        // deduct bonus (Code 101) on gross pay before checking sss and philhealth table - added on 2012-10-05
        //vGross_Pay := vGross_Pay - vOther_Earn1;
        //vPrev_Gross_Pay := vPrev_Gross_Pay - vPrev_Other_Earn1;

        if ADODataSet1.FieldByName('NO_SSS').Value = FALSE then
        begin
          ADODataSet2.CommandText := 'SELECT * FROM dtaSSSTable WHERE range1<='+CurrToStr(vGross_Pay+vPrev_Gross_Pay)+' AND range2>='+CurrToStr(vGross_Pay+vPrev_Gross_Pay);
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
          begin
            // process the extracted production of the particular employee
            ADODataSet2.First;
            vSSS_EE := ADODataSet2.FieldByName('sss_ee').Value - vPrev_SSS_EE;
            vSSS_ER := ADODataSet2.FieldByName('sss_er').Value - vPrev_SSS_ER;
            vECC_ER := ADODataSet2.FieldByName('ec_er').Value - vPrev_ECC_ER;
          end;
          ADODataSet2.Close;
        end;

        // used basic pay to get philhealth contribution
        // change gross pay to basic pay
        vBasic_Pay_Current := vBasic_Pay1 + vBasic_Pay2;
        vBasic_Pay_Previous := vPrev_Basic_Pay1 + vPrev_Basic_Pay2;

        // computation of philhealth
        vPhilhealth_EE := 0;
        vPhilhealth_ER := 0;
        if ADODataSet1.FieldByName('NO_PHILHEALTH').Value = FALSE then
        begin
          ADODataSet2.CommandText := 'SELECT * FROM dtaPhilhealthTable WHERE range1<='+
            CurrToStr(vBasic_Pay_Current+vBasic_Pay_Previous)+
            ' AND range2>='+CurrToStr(vBasic_Pay_Current+vBasic_Pay_Previous);
          ADODataSet2.Open;
          if( ADODataSet2.RecordCount > 0 ) then
          begin
            // process the extracted production of the particular employee
            ADODataSet2.First;
            vPhilhealth_EE := ADODataSet2.FieldByName('ee').Value - vPrev_Philhealth_EE;
            vPhilhealth_ER := ADODataSet2.FieldByName('er').Value - vPrev_Philhealth_ER;
          end
          else if ((vBasic_Pay_Current+vBasic_Pay_Previous) > 99999) then
          begin
            //get highest premium in PhilHealth - 05/06/2010
            ADODataSet2.Close;
            ADODataSet2.Commandtext := 'SELECT * FROM dtaPhilHealthTable ORDER BY range2 DESC';
            ADODataSet2.Open;

            ADODataSet2.First;
            vPhilhealth_EE := ADODataSet2.FieldByName('ee').Value - vPrev_Philhealth_EE;
            vPhilhealth_ER := ADODataSet2.FieldByName('er').Value - vPrev_Philhealth_ER;
          end;

          ADODataSet2.Close;
        end;


        // add back bonus on gross pay after checking sss and philhealth table
        //vGross_Pay := vGross_Pay + vOther_Earn1;
        //vPrev_Gross_Pay := vPrev_Gross_Pay + vPrev_Other_Earn1;
        
        vPagibig_EE := 0;
        vPagibig_ER := 0;
        if ADODataSet1.FieldByName('NO_PAGIBIG').Value = FALSE then
        begin
          // computation of pagibig
          vPrev_MC := vPrev_Basic_Pay1 + vPrev_Basic_Pay2 + vPrev_COLA2;
          vMC := vBasic_Pay1 + vBasic_Pay2 + vCOLA2 + vPrev_MC;
          if( vMC <= 1500 ) then
            begin
              vPagibig_EE := vMC * 0.01;
              vPagibig_ER := vMC * 0.02;
            end
          else if( vMC <= 5000 ) then
            begin
              vPagibig_EE := vMC * 0.02;
              vPagibig_ER := vMC * 0.02;
            end
          else
            begin
              //vPagibig_EE := vMC * 0.02;   adjusted as of March 2, 2006
              vPagibig_EE := 5000 * 0.02;
              vPagibig_ER := 5000 * 0.02;
            end;
          vPagibig_EE := vPagibig_EE - vPrev_Pagibig_EE;
          vPagibig_ER := vPagibig_ER - vPrev_Pagibig_ER;
          if vPagibig_EE < 0 then vPagibig_EE := 0;
          if vPagibig_ER < 0 then vPagibig_ER := 0;
        end;


        // compute for total gross pay
        vTotalGrossPay := 0;
        vTotalGrossPay := (vGross_Pay + vPrev_Gross_Pay);

        //vTotalGrossPay := (vGross_Pay + vPrev_Gross_Pay) -
        //  ((vSSS_EE + vPhilhealth_EE + vPagibig_EE) +
        //  (vPrev_SSS_EE + vPrev_Philhealth_EE + vPrev_Pagibig_EE));

        // deduct contributions from gross pay before tax computation
        // modified on 03-29-2011
        vGross_Pay := vGross_Pay - (vSSS_EE + vPhilhealth_EE + vPagibig_EE);

        // withholding tax computation //
        vWith_Tax := 0;

        // compute tax only on the 16th payroll period (once a month starting Feb 2019)
        if(day = 16) then
        begin

          if ADODataSet1.FieldByName('NO_TAX').Value = FALSE then
          begin
            // Extraction information from dtaTaxTable //
            ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''MONTHLY'' AND Code=''' + vTax_Code + '''';
            ADODataSet2.Open;
            vCol := 'Col0';
            if( ADODataSet2.RecordCount > 0 ) then
            begin
              // process the extracted production of the particular employee
              ADODataSet2.First;
              if vTotalGrossPay >= ADODataSet2.FieldByName('Col7').Value then vCol:='Col7'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col6').Value then vCol:='Col6'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col5').Value then vCol:='Col5'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col4').Value then vCol:='Col4'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col3').Value then vCol:='Col3'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col2').Value then vCol:='Col2'
              else if vTotalGrossPay >= ADODataSet2.FieldByName('Col1').Value then vCol:='Col1';
            end;
            if vCol <> 'Col0' then
            begin
              vExcess := vTotalGrossPay - ADODataSet2.FieldByName(vCol).Value;
              vExcess_Per := 0;
              ADODataSet2.Close;
              ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''MONTHLY'' AND Code=''EXCESS_PER''';
              ADODataSet2.Open;
              if( ADODataSet2.RecordCount > 0 ) then
              begin
                // process the extracted production of the particular employee
                ADODataSet2.First;
                vExcess_Per := ADODataSet2.FieldByName(vCol).Value;
              end;
              vExcess_Amt := vExcess * vExcess_Per;
              vTax := 0;
              ADODataSet2.Close;
              ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''MONTHLY'' AND Code=''TAX''';
              ADODataSet2.Open;
              if( ADODataSet2.RecordCount > 0 ) then
              begin
                // process the extracted production of the particular employee
                ADODataSet2.First;
                vTax := ADODataSet2.FieldByName(vCol).Value;
              end;
              vWith_Tax := vTax + vExcess_Amt;
            end;
            ADODataSet2.Close;
          end; // no_tax

        end;
        // compute only on the 16th payroll period


        // original tax calculation (semi-monthly) as of 01/03/2019
        {if ADODataSet1.FieldByName('NO_TAX').Value = FALSE then
          begin
            // Extraction information from dtaTaxTable //
            ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''SEMI-MONTHLY'' AND Code=''' + vTax_Code + '''';
            ADODataSet2.Open;
            vCol := 'Col0';
            if( ADODataSet2.RecordCount > 0 ) then
            begin
              // process the extracted production of the particular employee
              ADODataSet2.First;
              if vGross_Pay >= ADODataSet2.FieldByName('Col7').Value then vCol:='Col7'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col6').Value then vCol:='Col6'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col5').Value then vCol:='Col5'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col4').Value then vCol:='Col4'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col3').Value then vCol:='Col3'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col2').Value then vCol:='Col2'
              else if vGross_Pay >= ADODataSet2.FieldByName('Col1').Value then vCol:='Col1';
            end;
            if vCol <> 'Col0' then
            begin
              vExcess := vGross_Pay - ADODataSet2.FieldByName(vCol).Value;
              vExcess_Per := 0;
              ADODataSet2.Close;
              ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''SEMI-MONTHLY'' AND Code=''EXCESS_PER''';
              ADODataSet2.Open;
              if( ADODataSet2.RecordCount > 0 ) then
              begin
                // process the extracted production of the particular employee
                ADODataSet2.First;
                vExcess_Per := ADODataSet2.FieldByName(vCol).Value;
              end;
              vExcess_Amt := vExcess * vExcess_Per;
              vTax := 0;
              ADODataSet2.Close;
              ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable WHERE Period=''SEMI-MONTHLY'' AND Code=''TAX''';
              ADODataSet2.Open;
              if( ADODataSet2.RecordCount > 0 ) then
              begin
                // process the extracted production of the particular employee
                ADODataSet2.First;
                vTax := ADODataSet2.FieldByName(vCol).Value;
              end;
              vWith_Tax := vTax + vExcess_Amt;
            end;
            ADODataSet2.Close;
          end; // no_tax
        }

        // add back the contributions because it was deducted from gross before tax calculation
        // but contributions are not considered income
        // they just need to be removed/deducted before calculating withholding tax
        vGross_Pay := vGross_Pay + (vSSS_EE + vPhilhealth_EE + vPagibig_EE);

        // add bonuses (bonuses after tax)
        vGross_Pay := vGross_Pay + (vBonusUPH + vBonusQuality + vBonusRetention +
          vBonusAttendance + vBonusPAttendance + vBonusOthers);

        vTotal_Ded := vWith_Tax + vSSS_EE + vPhilhealth_EE + vPagibig_EE +
          vOther_Ded4 + vOther_Ded5;

        // deduct snack bar cash advance
        vTotal_Ded := vTotal_Ded + vSBCashAdvance;

        // deduct MP2 employee share
        vTotal_Ded := vTotal_Ded + vMP2EmployeeShare;

        // get net pay
        vNet_Pay := (vGross_Pay + vOther_Earn4 + vOther_Earn5) - vTotal_Ded ;

        // need to add these bonuses after tax
        //vNet_Pay := vNet_Pay + (vBonusUPH + vBonusQuality + vBonusRetention +
        //  vBonusAttendance + vBonusPAttendance);

        //get project code - 05/28/08
        sProj := getProjectCode(ADODataSet1.FieldByName('primary_task_id').AsString);

        //added on 07/30/2008
        sEmployeeName := ADODataSet1.FieldByName('employee_name').AsString;
        sPositionCode := ADODataSet1.FieldByName('job_position_code').AsString;
        sEmpStatus := ADODataSet1.FieldByName('emp_status').AsString;
        sEmpLoc := ADODataSet1.FieldByName('emp_loc').AsString;
        sAtmNumber := ADODataSet1.FieldByName('atm_number').AsString;
        sTaxCode := ADODataSet1.FieldByName('tax_code').AsString;

        if Not ADODataSet1.FieldByName('night_diff').IsNull then
        begin
          if ADODataSet1.FieldByName('night_diff').Value = 'true' then
            sNightDiff := '1'
          else
            sNightdiff := '0';
        end;

        if Not ADODataSet1.FieldByName('bonus_allowed').IsNull then
        begin
          if ADODataSet1.FieldByName('bonus_allowed').Value = 'true' then
            sBonusAllowed := '1'
          else
            sBonusAllowed := '0';
        end;

        if Not ADODataSet1.FieldByName('no_holiday').IsNull then
        begin
          if ADODataSet1.FieldByName('no_holiday').Value = 'true' then
            sNoHoliday := '1'
          else
            sNoHoliday := '0';
        end;

        if Not ADODataSet1.FieldByName('no_tax').IsNull then
        begin
          if ADODataSet1.FieldByName('no_tax').Value = 'true' then
            sNoTax := '1'
          else
            sNoTax := '0';
        end;

        if Not ADODataSet1.FieldByName('no_pagibig').IsNull then
        begin
          if ADODataSet1.FieldByName('no_pagibig').Value = 'true' then
            sNoPagibig := '1'
          else
            sNoPagibig := '0';
        end;

        if Not ADODataSet1.FieldByName('no_philhealth').IsNull then
        begin
          if ADODataSet1.FieldByName('no_philhealth').Value = 'true' then
            sNoPhilhealth := '1'
          else
            sNoPhilhealth := '0';
        end;

        if Not ADODataSet1.FieldByName('no_sss').IsNull then
        begin
          if ADODataSet1.FieldByName('no_sss').Value = 'true' then
            sNoSSS := '1'
          else
            sNoSSS := '0';
        end;

        sSSSNo := ADODataSet1.FieldByName('sssno').AsString;
        sPhicNo := ADODataSet1.FieldByName('phicno').AsString;
        sPagibigNo := ADODataSet1.FieldByName('pagibighdmfno').AsString;
        sTIN := ADODataSet1.FieldByName('tin').AsString;

        // compute for retention bonus
        //vMonthRetBonusAmount :=  vDays_work2 * vRetBonusRate;

        // Insert the data to SQL
        SQL := 'INSERT INTO dtaPayrollProcess ' +
            '(Period1, Period2, Employee_PIN, ' +
            ' Total_Docs, Time_Taken, Idle_Time, Over_Time, ' +
            ' x99_Time, OT_Pay, Bonus_Pay, ' +
            ' Total, Earned_Pay, Unearned_Pay, Comp_Pay, Total_Pay, ' +
            ' Total_Hours, Total_OT, Average_Hourly, Total_Revenue, ' +
            ' No_Holidays, Rate_Month1, Rate_Day1, Days_Absent1, ' +
            ' Basic_Pay1, Holiday_Pay1, Rate_Hr2, Hrs_work2, Reg_hrs2, Basic_Pay2, ' +
            ' Ot_hrs2, OT_Pay2, Days_work2, COLA2, Day_off_hrs2, Day_off_pay2, ' +
            ' Night_Diff_hrs2, Night_Diff_pay2, ' +
            ' Bonus_pay2, Holiday_pay2, Other_Earn1, Other_Earn2, ' +
            ' Other_Earn3, Other_Earn4, Other_Earn5, Other_Earn_Desc1, ' +
            ' Other_Earn_Desc2, Other_Earn_Desc3, Other_Earn_Desc4, ' +
            ' Other_Earn_Desc5, Gross_Pay, With_Tax, SSS_EE, SSS_ER, ' +
            ' Philhealth_EE, Philhealth_ER, ECC_ER, Other_Ded1, ' +
            ' Other_Ded2, Other_Ded3, Other_Ded4, Other_Ded5, ' +
            ' Other_Ded_Desc1, Other_Ded_Desc2, Other_Ded_Desc3, ' +
            ' Other_Ded_Desc4, Other_Ded_Desc5, Total_Ded, Net_Pay, ' +
            ' Pagibig_EE, Pagibig_ER, SLA_5, SLA_10, M13thmo, ND_Holiday, OT_Holiday, ' +
            ' ot_holiday_hrs, nd_holiday_hrs, ot_dayoff_hrs, nd_dayoff_hrs, ot_dayoff, ' +
            ' nd_dayoff, holiday_hrs, project, projectCode, employeeName, positionCode, ' +
            ' empStatus, empLoc, atmNumber, taxCode, nightDiff, bonusAllowed, noHoliday, ' +
            ' noTax, noPagibig, noPhilhealth, noSSS, sssNo, phicNo, pagibigNo, tin,' +
            ' Bonus_UPH, Bonus_Quality, Bonus_Attendance, Bonus_PerfectAttendance, Bonus_Retention, SB_CashAdvance, ' +
            ' Bonus_Others, Remarks, MP2_EE, MP2_ER) ' +

            //LastMonthDayCount, LastMonthDayAbsentCount) ' +
            //' RetentionBonus_Rate, MRetentionBonus) ' +
          'VALUES ' +
            '('+sPeriod1+', '+sPeriod2+', '+ADODataSet1.FieldByName('Employee_PIN').AsString+', '+
              CurrToStr(vDocs)+', '+CurrToStr(vTime_Taken)+', '+CurrToStr(vIdle_Time)+', '+CurrToStr(vOver_Time)+', ' +
              CurrToStr(v99_Time)+', '+CurrToStr(vOT_Pay)+', '+CurrToStr(vBonus_Pay)+', '+
              CurrToStr(vTotal)+', '+CurrToStr(vEarned_Pay)+', '+CurrToStr(vUnearned_Pay)+', '+
              CurrToStr(vComp_Pay)+', '+CurrToStr(vTotal_Pay)+', '+CurrToStr(vTotal_Hours)+', '+
              CurrToStr(vTotal_OT)+', '+CurrToStr(vAverage_Hourly)+', '+CurrToStr(vRev_Amt2)+', '+
              CurrToStr(vNo_Holidays)+', '+CurrToStr(vRate_Month1)+', '+CurrToStr(vRate_Day1)+', '+CurrToStr(vDays_Absent1)+', '+
              CurrToStr(vBasic_Pay1)+', '+CurrToStr(vHoliday_Pay1)+', '+CurrToStr(vRate_Hr2)+', '+CurrToStr(vHrs_work2)+', '+CurrToStr(vReg_hrs2)+', '+CurrToStr(vBasic_Pay2)+', '+
              CurrToStr(vOt_hrs2)+', '+CurrToStr(vOT_Pay2)+', '+CurrToStr(vDays_work2)+', '+CurrToStr(vCOLA2)+', '+CurrToStr(vDay_off_hrs2)+', '+CurrToStr(vDay_off_pay2)+', '+
              CurrToStr(vNight_Diff_Hours)+', '+CurrToStr(vNight_Diff_pay2)+', '+
              CurrToStr(vBonus_pay2)+', '+CurrToStr(vHoliday_pay2)+', '+CurrToStr(vOther_Earn1)+', '+CurrToStr(vOther_Earn2)+', ' +
              CurrToStr(vOther_Earn3)+', '+CurrToStr(vOther_Earn4)+', '+CurrToStr(vOther_Earn5)+', '+chr(39)+vOther_Earn_Desc1+chr(39)+', '+
              chr(39)+vOther_Earn_Desc2+chr(39)+', '+chr(39)+vOther_Earn_Desc3+chr(39)+', '+chr(39)+vOther_Earn_Desc4+chr(39)+', ' +
              chr(39)+vOther_Earn_Desc5+chr(39)+', '+CurrToStr(vGross_Pay)+', '+CurrToStr(vWith_Tax)+', '+CurrToStr(vSSS_EE)+', '+CurrToStr(vSSS_ER)+', ' +
              CurrToStr(vPhilhealth_EE)+', '+CurrToStr(vPhilhealth_ER)+', '+CurrToStr(vECC_ER)+', '+CurrToStr(vOther_Ded1)+', ' +
              CurrToStr(vOther_Ded2)+', '+CurrToStr(vOther_Ded3)+', '+CurrToStr(vOther_Ded4)+', '+CurrToStr(vOther_Ded5)+', ' +
              chr(39)+vOther_Ded_Desc1+chr(39)+', '+chr(39)+vOther_Ded_Desc2+chr(39)+', '+chr(39)+vOther_Ded_Desc3+chr(39)+', ' +
              chr(39)+vOther_Ded_Desc4+chr(39)+', '+chr(39)+vOther_Ded_Desc5+chr(39)+', '+CurrToStr(vTotal_Ded)+', '+CurrToStr(vNet_Pay)+ ', ' +
              CurrToStr(vPagibig_EE)+', '+CurrToStr(vPagibig_ER)+ ', ' +
              CurrToStr(vSLA_5)+', '+CurrToStr(vSLA_10)+', '+CurrToStr(vM13thmo)+ ', ' + CurrToStr(vNight_Diff_Hours_Hol_Pay2) + ', ' + CurrToStr(vHolidayOT_Pay) + ', ' +
              CurrToStr(vHolidayOTHrs)+', '+CurrToStr(vNight_Diff_Hours_Hol2)+', '+CurrToStr(vDay_Off_OT)+', '+CurrToStr(vDay_Off_ND)+ ', ' +
              CurrToStr(vOTDayOffPay) + ', ' + CurrToStr(vNDDayOffPay) + ', ' + CurrToStr(vHolidayHrs) + ', ''' + ADODataSet1.FieldByName('primary_task_id').AsString +
              ''',''' + sProj + ''',''' + sEmployeeName + ''',''' + sPositionCode +
              ''',''' + sEmpStatus + ''',''' + sEmpLoc + ''',''' + sAtmNumber +
              ''',''' + sTaxCode + ''',''' + sNightDiff + ''',''' + sBonusAllowed + ''',''' + sNoHoliday +
              ''',''' + sNotax + ''',''' + sNoPagibig + ''',''' + sNoPhilHealth + ''',''' + sNoSSS +
              ''',''' + sSSSNo + ''',''' + sPhicNo + ''',''' + sPagibigNo + ''',''' + sTIN +
              ''', ' + CurrToStr(vBonusUPH) + ',' + CurrToStr(vBonusQuality) + ',' + CurrToStr(vBonusAttendance) + ',' + CurrToStr(vBonusPAttendance) +
              ',' + CurrToStr(vBonusRetention) + ',' + CurrToStr(vSBCashAdvance) + ',' +
              CurrToStr(vBonusOthers) + ',''' + sRemarks +
              ''',' + CurrToStr(vMP2EmployeeShare) + ',' + CurrToStr(vMP2EmployerShare) + ')';

              //''',' + CurrToStr(vEmpWorkingDaysLastMonth) + ',' + IntToStr(AbsentCount) + ')';

              // retention bonus
              //''',' + CurrToStr(vRetBonusRate) + ',' + CurrToStr(vMonthRetBonusAmount) + ')';


          //if ADODataSet1.FieldByName('Employee_PIN').AsString = '397' then ShowMessage(SQL);
          //showmessage(SQL);
          ADOConnection1.Execute(SQL);

          // if record has been inserted to Payroll, mark records in SNACKS database as paid
          // update ES_Purchases table, make IsPaid = 1
          SQL := 'UPDATE ES_Purchases SET IsPaid = 1 ';
          SQL := SQL + 'WHERE PayPeriod = ' + sPeriod1 + ' ';
          SQL := SQL + 'AND Deleted = 0 ';
          SQL := SQL + 'AND PurchasedBy = ''' + ADODataSet1.FieldByName('Employee_PIN').AsString + '''';

          connSnacks.Execute(SQL);
          
      end; // if vGross_Pay > 0
      end; // Not ADODataSet1.FieldByName('Employee_PIN').IsNull
    //else
    //  begin
    //    ADOConnection1.Execute('INSERT INTO dtaMissingPIN (Keyer_ID) VALUES ('+chr(39)+ADODataSet1.FieldByName('Keyer_ID').AsString+chr(39));
    //  end;


      vUpdateTracking := 'UPDATE dtaTracking SET Process_Num = ''Process 3'', Keyer_ID = ''' +
        ADODataSet1.FieldByName('Employee_Name').AsString + '''';
      ADOConnection1.Execute(vUpdateTracking);


    ADODataSet1.Next;
  until ADODataSet1.Eof;
end; // if ADODataSet1.RecordCount > 0
  ADODataSet1.Close;
  ADOConnection1.Connected := False;
  if( ProgressBar1.Max > 0 ) then
  begin
    Process_Log;
    ShowMessage('Process Completed ...')
  end
  else
    ShowMessage('No record to process ...');
end; // process_stage3

procedure TfrmPayrollProcess.Process_Log;
var
  SQL: String;
begin
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Payroll Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaPayrollProcess' + chr(39) + ', ';
  SQL := SQL + chr(39) + DateToStr(DateTimePicker1.Date) + '|' + DateToStr(DateTimePicker2.Date) + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmPayrollProcess.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);

//  InsertToLogFile(sTranDate, sUserID, 'Payroll Process window', 'Load', 'dtaPayrollProcess', '');
end;

procedure TfrmPayrollProcess.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
begin

  dsLogFile.Close;
  dsLogFile.CommandText := 'SELECT top 1 * FROM dtaLogFile';
  dsLogFile.Active := TRUE;

  with dsLogFile do
  begin
    Insert;
      FieldByName('Tran_Date').AsString := vDate;
      FieldByName('User_Id').AsString := vUser;
      FieldByName('Module_Desc').AsString := vModule;
      FieldByName('Command').AsString := vCommand;
      FieldByName('Table_Name').AsString := vTable;
      FieldByName('Employee_PIN').AsString := vPIN;
      FieldByName('Remarks').AsString := 'Module log';

    Post;

  end;
end;


procedure TfrmPayrollProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPayrollProcess.chkTimedOutClick(Sender: TObject);
begin
  if chkTimedOut.Checked = true then
    grpProductionDates.Enabled := true
  else if chkTimedOut.Checked = false then
    grpProductionDates.Enabled := false;  
end;

procedure TfrmPayrollProcess.dtPreviousFromChange(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
  DecodeDate(dtPreviousFrom.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(dtPreviousFrom.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;

  dtPreviousTo.Date := dt;
  dtPreviousTo.Refresh;

end;

procedure TfrmPayrollProcess.btnExcludeFromPayrollClick(Sender: TObject);
var
  sPreviousFrom, sPreviousTo : string;
  sCurrentFrom, sCurrentTo : string;

  sqlStr : string;
begin

  sPreviousFrom := char(39) + DateToStr(dtPreviousFrom.Date) + char(39);
  sPreviousTo := char(39) + DateToStr(dtPreviousTo.Date) + char(39);

  sCurrentFrom := char(39) + DateToStr(dtCurrentFrom.Date) + ' 12:00:00 AM' + char(39);
  sCurrentTo := char(39) + DateToStr(IncDay(dtCurrentTo.Date)) + ' 11:59:59 AM' + char(39);

  sqlStr := 'UPDATE dtaProduction SET time_id = 1 ' +
    'WHERE tran_date BETWEEN ' + sCurrentFrom + ' AND ' + sCurrentTo +
    ' AND time_id IS NULL';

  ADOConnection1.Execute(sqlStr);

  ShowMessage('production dates from ' + sCurrentFrom + ' to ' +
    sCurrentTo + ' has been EXCLUDED from payroll ...');

end;

procedure TfrmPayrollProcess.btnIncludeFromPayrollClick(Sender: TObject);
var
  sPreviousFrom, sPreviousTo : string;
  sCurrentFrom, sCurrentTo : string;

  sqlStr : string;
begin

  sPreviousFrom := char(39) + DateToStr(dtPreviousFrom.Date) + char(39);
  sPreviousTo := char(39) + DateToStr(dtPreviousTo.Date) + char(39);

  sCurrentFrom := char(39) + DateToStr(dtCurrentFrom.Date) + ' 12:00:00 AM' + char(39);
  sCurrentTo := char(39) + DateToStr(IncDay(dtCurrentTo.Date)) + ' 11:59:59 AM' + char(39);

  sqlStr := 'UPDATE dtaProduction SET time_id = NULL WHERE tran_date ' +
    'BETWEEN ' + sCurrentFrom + ' AND ' + sCurrentTo + ' AND time_id = 1';

  ADOConnection1.Execute(sqlStr);


  ShowMessage('production dates from ' + sCurrentFrom + ' to ' +
    sCurrentTo + ' has been INCLUDED from payroll ...');

end;


procedure TfrmPayrollProcess.btnPayrollProcessClick(Sender: TObject);
begin
    with TfrmProcessViewer.Create(Application) do show;
end;

procedure TfrmPayrollProcess.btnPayrollDocumentsClick(Sender: TObject);
begin
    with TfrmProductionDocuments.Create(Application) do show;
end;

function TfrmPayrollProcess.getProjectCode(const sPrimaryTask : string) : string;
var
  vProjCode : string;
  vSql : string;
begin
  vProjCode := '';

  vSql := 'SELECT description ' +
    'FROM dtaCodeTables ' +
    'WHERE code = ''' + sPrimaryTask + '''';

  dsProjectCode.Close;
  dsProjectCode.CommandText := vSql;
  dsProjectCode.Open;

  if dsProjectCode.RecordCount > 0 then
    vProjCode := dsProjectCode.FieldByName('description').AsString;

  getProjectCode := vProjCode;
end;

function TfrmPayrollProcess.getEmployeePIN(const sKeyerID : string) : string;
var
  vKeyerID : string;
  vSql : string;
begin
  vKeyerID := '';

  vSql := 'SELECT employee_pin ' +
    'FROM dtaKeyerRemarks ' +
    'WHERE keyer_id = ''' + sKeyerID + '''';

  dsKeyerID.Close;
  dsKeyerID.CommandText := vSql;
  dsKeyerID.Open;

  if dsKeyerID.RecordCount > 0 then
    vKeyerID := dsKeyerID.FieldByName('employee_pin').AsString;


  getEmployeePIN := vKeyerID;
end;


function TfrmPayrollProcess.getCOLArate() : currency;
var
  vCOLA : currency;
  vSql : string;
begin
  vCOLA := 0;

  vSql := 'SELECT colaAmount ' +
    'FROM dtaCOLA ' +
    'WHERE status = 1';

  dsCOLA.Close;
  dsCOLA.CommandText := vSql;
  dsCOLA.Open;

  if dsCOLA.RecordCount > 0 then
    vCOLA := dsCOLA.FieldByName('colaAmount').Value;

  getCOLArate := vCOLA;
end;

procedure TfrmPayrollProcess.FormDestroy(Sender: TObject);
begin
  ADOConnection1.Close;
  connSnacks.Close;
end;

end.




