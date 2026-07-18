// Name:  TimeExtract.pas
// Description:  This window allows you to extract all employee
//     log details from EDS finger scan database for a specific
//     period to your existing payroll database.  During extraction,
//     the system will automatically compute an employee's regular
//     hours and overtimes (if any) separately and daily.
unit timeextract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, DateUtils, ExtCtrls, Modification,
  ComCtrls, CommonModule, StrUtils, LogtimeMaintenance;

type
  TfrmTimeExtraction = class(TForm)
    ADOConn: TADOConnection;
    DS1: TDataSource;
    ADODataSet: TADODataSet;
    ADOSQL: TADOConnection;
    DataSetSQL: TADODataSet;
    SourceSQL: TDataSource;
    Edit1: TEdit;
    Button3: TButton;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    Shape2: TShape;
    GroupBox3: TGroupBox;
    optDates: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    dtDate1: TDateTimePicker;
    dtDate2: TDateTimePicker;
    Label1: TLabel;
    lblRecordsFound: TLabel;
    lblExtractedRecords: TLabel;
    Label3: TLabel;
    dsSched: TADODataSet;
    myDSet: TADODataSet;
    Shape3: TShape;
    Label2: TLabel;
    Label4: TLabel;
    dsFillBranch: TADODataSet;
    Open1: TOpenDialog;
    Button6: TButton;
    txtPath: TEdit;
    dsEmployeeName: TADODataSet;
    dsLogFile: TADODataSet;
    dsCount: TADODataSet;
    dsPIN: TADODataSet;
    dsTime: TADODataSet;
    dsSummary: TADODataSet;
    spEmployees: TADOStoredProc;
    dsHoliday: TADODataSet;
    Button7: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    dsEmployees: TADODataSet;
    Button4: TButton;
    Button5: TButton;
    ADODataSet1: TADODataSet;
    ADODataSet2: TADODataSet;
    procedure FormActivate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtDate1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StoreExtractedPeriods();
    procedure FillBranchCombo();
    procedure InsertExtractToLogFile(vDate, vUser, vModule, vCommand, vTable, vFieldName : String);
    procedure DetailToSummary(vDate1, vDate2: String);

    function IsFileInUse(fName : string): boolean;

    procedure ExtractTimeFromEDS1();
    procedure StoreToTimeSummary();
    procedure optDatesClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    procedure Process_Log;

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTimeExtraction: TfrmTimeExtraction;
  d1, d2 : String;
  ExtractedRecords, RefinedRecords : Integer;
  curDIR, selectedDbase, newFileName, varBranch : String;
  varClicked : Boolean;
  varEmpCount : Integer;
  varCurCount : Integer;

  sUserID : string;
  sTranDate : string;

  //log file variables
  varDate1, varUser, varModule, varCommand, varTable, varFieldName : String;

  KeyerSched, KeyerSched1 : String;
  varWorkDate, varWorkDate1, varWorkDate2 : TDateTime;
  TimeIn, TimeOut, LastTime, TimeIn1, TimeIn2, bTime : String;
  DayOut, varEmpPIN1 : String;
  HrsWorked, TimeInterval, varOT, DayInterval, bInterval : Double;
  varTime, varTime1, varDate : TDateTime;
  varTime2, bOut, bIn : TDateTime;
  KeyerIn, KeyerOut, KeyerOutSched : TDateTime;
  varCurPIN, varEmpPIN, SearchForOut : Integer;
  varInvalid : Boolean;
  varTardiness : Double;
  empName : String;

  VHTime1, VHTime2, vHMid : TDateTime;

  WDate : String;
  vHType : String;
  vWDate, vWDate1, vWMid : String;
  vT1, vT2 : String;
  vHPIN : String;
  vHPay, vInterval, vIntervalNightDiff : Double;
  //vInterval is the holiday hours

  vHRate : String;
  vHEmpRate : String;
  vWNDiff : String;

  v1, v2 : String;
  isOk : String;

implementation

{$R *.dfm}

procedure TfrmTimeExtraction.Button6Click(Sender: TObject);
begin
  curDIR := GetCurrentDir;


 if varClicked = TRUE then
 begin
    IsFileInUse(newFileName);

    ADOConn.Close;

    selectedDbase := AnsiLeftStr(selectedDbase, Length(selectedDbase) - 3) + 'mdb';
    if FileExists(newFileName) then
    begin
      RenameFile(newFileName, selectedDbase);
      ChangeFileExt(newFileName, 'mdb');
    end;
 end;


  Open1.InitialDir := curDIR;
  Open1.Options := [ofFileMustExist];
  Open1.Filter := 'MS Access Database|*.mdb';
//  Open1.Filter := 'All Files|*.*';
  Open1.FilterIndex := 2;

  if Open1.Execute then
  begin
    selectedDbase := Open1.FileName;
    txtPath.Text := selectedDbase;
  end;

//  ShowMessage(AnsiLeftStr(txtPath.Text, Length(txtPath.Text) - 3) + 'tob');
end;

procedure TfrmTimeExtraction.Button1Click(Sender: TObject);
begin
  //SetCurrentDir('C:\');
  {if cmbBranch.Text <> '' then
  begin
  curDIR := GetCurrentDir;

    if cmbBranch.Text = 'MDEPI' then
    begin
      if FileExists('FingerID-Clark\FingerID.mdb') then
      begin
        RenameFile('FingerID-Clark\FingerID.mdb', 'FingerID-Clark\FingerID.tob');
        ChangeFileExt('FingerID-Clark\FingerID.mdb', 'tob');
      end
      else
      begin
        ADOConn.Close;
        ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + curDir + '\FingerID-Clark\FingerID.tob' + ';Mode=ReadWrite;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password=6eds97';
        ADOConn.Connected := TRUE;
      end;
    end
    else if cmbBranch.Text = 'MDEPI-Subic' then
    begin
      if FileExists('FingerID-Subic\FingerID.mdb') then
      begin
        RenameFile('FingerID-Subic\FingerID.mdb', 'FingerID-Subic\FingerID.tob');
        ChangeFileExt('FingerID-Subic\FingerID.mdb', 'tob');
      end
      else
      begin
        ADOConn.Close;
        ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + curDir + '\FingerID-Subic\FingerID.tob' + ';Mode=ReadWrite;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password=6eds97';
        ADOConn.Connected := TRUE;
      end;
    end;


      ADODataSet.Connection := ADOConn;

      d1 := '#' + DateToStr(dtDate1.Date) + '#';
      d2 := '#' + DateToStr(IncDay(dtDate2.Date, 1)) + '#';

      ADODataSet.CommandText := 'SELECT PIN, Timedata, InOut, CompanyCode FROM Timedata WHERE Timedata BETWEEN ' + d1 + ' AND ' + d2 + ' ORDER BY PIN, Timedata';
//      ADODataSet.CommandText := 'SELECT PIN, Timedata, InOut FROM Timedata WHERE Timedata BETWEEN ' + d1 + ' AND ' + d2 + ' ORDER BY Timedata';

//      ShowMessage(ADODataSet.CommandText);
      ADODataSet.Active := TRUE;

      lblRecordsFound.Caption := IntToStr(ADODataSet.RecordCount) + ' records';
      ExtractedRecords := ADODataSet.RecordCount;

      DS1.DataSet := ADODataSet;

      DBGrid1.DataSource := DS1;

  end
  else
    ShowMessage('Please choose a branch to extract EDS from!');
  }



   //code for using a search database button instead of hardcoding
    if txtPath.Text <> '' then
    begin
      newFileName := AnsiLeftStr(selectedDbase, Length(selectedDbase) - 3) + 'tob';
//      ShowMessage(newFileName);
      if FileExists(selectedDbase) then
      begin
        RenameFile(selectedDbase, newFileName);
        ChangeFileExt(selectedDbase, 'tob');

        ADOConn.Close;
        ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + newFileName + ';Mode=ReadWrite;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password=6eds97';
        ADOConn.Connected := TRUE;

      end
      else
      begin
        ADOConn.Close;
        ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + newFileName + ';Mode=ReadWrite;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password=6eds97';
        ADOConn.Connected := TRUE;
      end;

      ADODataSet.Connection := ADOConn;

      d1 := '#' + DateToStr(dtDate1.Date) + '#';
      d2 := '#' + DateToStr(IncDay(dtDate2.Date, 2)) + '#';

      ADODataSet.CommandText := 'SELECT PIN, Timedata, InOut, CompanyCode FROM Timedata WHERE Timedata BETWEEN ' + d1 +
        ' AND ' + d2 + ' ORDER BY PIN, Timedata';
      ADODataSet.Active := TRUE;

      lblRecordsFound.Caption := IntToStr(ADODataSet.RecordCount) + ' records';
      ExtractedRecords := ADODataSet.RecordCount;

      DS1.DataSet := ADODataSet;

      DBGrid1.DataSource := DS1;

      if ADODataSet.RecordCount > 0 then
        Button2.Enabled := TRUE;

//    RenameFile(newFileName, selectedDbase);
//    ChangeFileExt(newFileName, 'mdb');

      varClicked := TRUE;
    end;
end;


procedure TfrmTimeExtraction.StoreToTimeSummary();
begin

  ADODataSet.Close;
  ADODataSet.Connection := ADOConn;

  ADODataSet.CommandText := 'SELECT PIN, Timedata, InOut, CompanyCode FROM Timedata WHERE Timedata BETWEEN ' + d1 + ' AND ' + d2 + ' ORDER BY PIN, Timedata';
  ADODataSet.Active := TRUE;

  //open the table
  DataSetSQL.Close;
  DataSetSQL.Connection := ADOSQL;
  DataSetSQL.CommandText := 'SELECT * FROM TimeInterval';
  DataSetSQL.Active := TRUE;

    with ADODataSet do
    begin
      First;

     TimeInterval := 0.00;
     ExtractedRecords := 0;
     varTardiness := 0.00;
     HrsWorked := 0.00;

      while not Eof do
      begin
          SearchForOut := 0;

          varEmpPIN := FieldByName('PIN').Value;
          varEmpPIN1 := FieldByName('PIN').AsString;

          //get first log in time
          TimeIn := FieldByName('Timedata').AsString;

        //if varEmpPIN = FieldByName('PIN').Value then
        //begin
          if (FieldByName('InOut').AsString = 'IN') then
          begin
            //get first record from database
            varWorkDate := FieldByName('Timedata').AsDateTime;
            varBranch := FieldByName('CompanyCode').AsString;

            //get the date from the access database
            KeyerIn := FieldByName('Timedata').AsDateTime;
            KeyerSched := FormatDateTime('ddddd', KeyerIn);

            Next;

            if ((FieldByName('InOut').AsString = 'IN') and (varEmpPIN = FieldByName('PIN').Value)) then
            begin
              TimeIn1 := FieldByName('Timedata').AsString;
              varTime := StrToDateTime(TimeIn);
              varTime1 := StrToDateTime(TimeIn1);

              if (varTime < varTime1) then
                TimeIn := DateTimeToStr(varTime1);

            end;
            Previous;

            //Retrieve start time of an employee
            dsSched.Close;
            dsSched.Connection := ADOSQL;
            dsSched.CommandText := 'SELECT * FROM dtaKeyerSchedule WHERE Work_Date =' + Chr(39) + KeyerSched + Chr(39) + ' AND Employee_PIN = ' + IntToStr(varEmpPIN);
            //ShowMessage(dsSched.CommandText);

            dsSched.Active := TRUE;
            if dsSched.RecordCount > 0 then
            begin
              TimeIn1 := dsSched.FieldByName('Start_Time').AsString;

              TimeIn2 := dsSched.FieldByName('End_Time').AsString;

              varTime2 := StrToDateTime(TimeIn2);

              varTime := StrToDateTime(TimeIn);
              varTime1 := StrToDateTime(TimeIn1);

              if (varTime > varTime1) then
              begin
                TimeIn := DateTimeToStr(varTime);
                varTardiness := MinuteSpan(varTime1, varTime);
              end
              else
                TimeIn := DateTimeToStr(varTime1);
            end
            else
            begin
              TimeIn1 := '';
              TimeIn2 := '';
            end;
            HrsWorked := 0.00;
            TimeInterval := 0.00;
            DayInterval := 0.00;

            repeat
            //if (TimeInterval <= 480) then
            begin

              LastTime := FieldByName('Timedata').AsString;
              //check for log out time
              if ((FieldByName('InOut').AsString = 'OUT') and (varEmpPIN = FieldByName('PIN').Value)) then
              begin
                TimeOut := FieldByName('Timedata').AsString;

                varTime := StrToDateTime(TimeIn);
                varTime1 := StrToDateTime(TimeOut);

                //if an employee has committed an undertime
                if (varTime1 < varTime2) then
                begin
                  HrsWorked := MinuteSpan(varTime, varTime1);
                  TimeInterval := MinuteSpan(varTime, varTime1);
                end
                else
                begin
                    //compute for minute span
                    HrsWorked := MinuteSpan(varTime, varTime2);
                    TimeInterval := MinuteSpan(varTime, varTime1);
                    varOT := MinuteSpan(varTime2,varTime1);
                end;

                if (DayInterval < 60) then
                begin
                  break;
                end;
             end
             //else condition for the ----- > if ((FieldByName('InOut').AsString = 'OUT') and (varEmpPIN = FieldByName('PIN').Value)) then
            else
              break;

                Next;
              //if (DayInterval <= 480) then
              //begin
                 SearchForOut := SearchForOut + 1;

                 if (SearchForOut >= 3) then
                 begin
                    TimeOut := '';
                    break;
                //    SearchForOut := 0;
                 end;

                 DayOut := FieldByName('Timedata').AsString;

                 varTime := StrToDateTime(DayOut);
                 varTime1 := StrToDateTime(LastTime);

                 DayInterval := MinuteSpan(varTime, varTime1);

                 Previous;
            end;
            until ((TimeInterval >= 360) and (DayInterval >= 240));
            //until ((TimeInterval >= 320) and (DayInterval >= 240));

            //convert timeinterval (minutes) to hours
            TimeInterval := TimeInterval / 60;

            varOT := varOT / 60;
            HrsWorked := HrsWorked / 60;
            varTardiness := varTardiness / 60;

            //save to sql database
            with DataSetSQL do
            begin
              Insert;


                FieldByName('Work_Date').AsString := FormatDateTime('ddddd', varWorkDate);
                FieldByName('Employee_PIN').Value := varEmpPIN;
{
                FieldByName('Sched_In').AsString := TimeIn1;
                FieldByName('Sched_Out').AsString := TimeIn2;

                FieldByName('Time_Interval').AsFloat := TimeInterval;

                if (HrsWorked > 8.01) then
                begin
                  FieldByName('Regular_Hours').AsFloat := 0.00;
                  FieldByName('Remarks').AsString := 'CHECK SCHED'
                end
                else
                begin
                  FieldByName('Regular_Hours').AsFloat := HrsWorked;
                end;

                //FieldByName('Regular_Hours').AsFloat := HrsWorked;
                FieldByName('Tardiness').AsFloat := varTardiness;
}

                FieldByName('Actual_In').AsString := DateTimeToStr(KeyerIn);
                FieldByName('Actual_Out').AsString := TimeOut;
{                FieldByName('Branch_Code').AsString := varBranch;


                if ((varOT > 100) or (varOT < 0)) then
                  FieldByName('OT').AsFloat := 0
                else
                  FieldByName('OT').AsFloat := varOT;

                if (TimeInterval <= 3) then
                begin
                  FieldByName('Remarks').AsString := 'INVALID';
                end;

                FieldByName('AuthorizeOT').AsString := 'Yes';
 }
              Post;

              //add employee name to timeinterval.employee_name
              dsEmployeeName.Close;
              dsEmployeeName.Connection := ADOSQL;
              dsEmployeeName.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + chr(39) + varEmpPIN1 + chr(39);
              dsEmployeeName.Active := TRUE;

              if dsEmployeeName.RecordCount > 0 then
              begin
                  empName := dsEmployeeName.FieldByName('Employee_Name').AsString;

                  ADOSQL.Execute('UPDATE dtaTime_Detail SET Employee_Name = ' + chr(39) + empName + chr(39) +
                    ' WHERE Employee_PIN = ' + varEmpPIN1);

              end;

              ExtractedRecords := ExtractedRecords + 1;

              TimeInterval := 0.00;
              HrsWorked := 0.00;
              varTardiness := 0.00;
              TimeOut := '';
            end;
         end
         else
            Next;
   end;

  DataSetSQL.Close;
  DataSetSQL.Connection := ADOSQL;

  //View extracted records
  d1 := Chr(39) + DateToStr(dtDate1.Date) + Chr(39);
  d2 := Chr(39) + DateToStr(dtDate2.Date) + Chr(39);

//  DataSetSQL.CommandText := 'SELECT Work_Date, TimeInterval.Employee_PIN, dtaEmployees.Employee_Name, Time_In, Time_Out, Actual_In, Actual_Out, Time_Interval, OT, Regular_Hours, Tardiness, Remarks FROM TimeInterval, dtaEmployees WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2 + ' AND TimeInterval.Employee_PIN = dtaEmployees.Employee_PIN AND TimeInterval.Employee_PIN <> dtaEmployees.Employee_PIN AND TimeInterval.Branch_Code = ' + Chr(39) + cmbBranch.Text + Chr(39) + ' ORDER BY TimeInterval.Employee_PIN, Work_Date';
  DataSetSQL.CommandText := 'SELECT * FROM vwExtractedTimes WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2 + ' AND Branch_Code = ' + Chr(39) + varBranch + Chr(39) + ' ORDER BY Employee_PIN, Work_Date';
  DataSetSQL.Active := TRUE;


  lblExtractedRecords.Caption := IntToStr(DataSetSQL.RecordCount) + ' records';
  RefinedRecords := DataSetSQL.RecordCount;

  SourceSQL.DataSet := DataSetSQL;

  dbGrid2.DataSource := SourceSQL;
  dbGrid2.Refresh;
 end;

  //read employee pins
  dsPIN.Close;
  dsPIN.Connection := ADOSQL;
  dsPIN.CommandText := 'SELECT DISTINCT Work_Date, Employee_PIN FROM TimeInterval ORDER BY Work_Date';
  dsPIN.Active := TRUE;

  if dsPIN.RecordCount > 0 then
  begin

    dsPIN.First;
    While not dsPIN.Eof do
    begin
      varEmpPIN1 := dsPIN.FieldByName('Employee_PIN').AsString;

      dsCount.Close;
      dsCount.Connection := ADOSQL;
      dsCount.CommandText := 'SELECT * FROM TimeInterval WHERE Employee_PIN = ' + Chr(39) + varEmpPIN1 + Chr(39) + ' ORDER BY Work_Date';
      dsCount.Active := TRUE;

      if dsCount.RecordCount > 0 then
      begin
        dsCount.First;

        varTime := dsCount.FieldByName('Actual_In').AsDateTime;
        varTime1 := dsCount.FieldByName('Actual_Out').AsDateTime;

        d1 := FormatDateTime('ddddd', varTime);
        d2 := FormatDateTime('ddddd', varTime1);

//        varTime := IncDay(varTime, -1);
//        varTime1 := IncDay(varTime1, 1);

        dsTime.Close;
        dsTime.Connection := ADOSQL;
        dsTime.CommandText := 'SELECT * FROM TimeInterval WHERE Work_Date BETWEEN ' + Chr(39) + d1 + Chr(39) + ' AND ' + Chr(39) + d2 + Chr(39) + ' AND Employee_PIN = ' + Chr(39) + varEmpPIN1 + Chr(39) +
          ' ORDER BY Employee_PIN, Work_Date';
        dsTime.Active := TRUE;

        if dsTime.RecordCount > 0 then
        begin
          dsTime.First;
            dsSummary.Close;
            dsSummary.Connection := ADOSQL;
            dsSummary.CommandText := 'SELECT * FROM dtaTime_Summary';
            dsSummary.Active := TRUE;

            dsSummary.Insert;
            dsSummary.FieldByName('Actual_In').AsString := dsTime.FieldByName('Actual_In').AsString;

         dsTime.Last;

            dsSummary.FieldByName('Actual_Out').AsString := dsTime.FieldByName('Actual_Out').AsString;
            dsSummary.FieldByName('Employee_PIN').AsString := varEmpPIN1;

            dsSummary.FieldByName('Work_Date').AsString := d1;

            dsSummary.Post;
        end;
      end;

      dsPIN.Next;
    end;
  end;
end;









procedure TfrmTimeExtraction.Button3Click(Sender: TObject);
begin
  with ADODataSet do
  begin
    if (FieldByName('InOut').AsString = 'OUT') then
      Edit1.Text := FieldByName('Timedata').AsString;

    Next;
  end;
end;

procedure TfrmTimeExtraction.Button4Click(Sender: TObject);
var
  sID : string;
  d3 : String;
  d4 : String;

  sOut : string;
  sIn : string;

  sTime1 : string;
  sTime2 : string;

  sTime3 : string;

  vOut : TDateTime;
  vIn : TDateTime;

  sInterval : Double;
begin
//    IsFileInUse(newFileName);

//    ADOConn.Close;

//    selectedDbase := AnsiLeftStr(selectedDbase, Length(selectedDbase) - 3) + 'mdb';
//    if FileExists(newFileName) then
//    begin
//      RenameFile(newFileName, selectedDbase);
//      ChangeFileExt(newFileName, 'mdb');
//    end;

//  frmTimeExtraction.Close;
  d1 := '''' + DateToStr(dtDate1.Date) + '''';
  d2 := '''' + DateToStr(dtDate2.Date) + '''';

  d3 := '''' + DateToStr(IncDay(dtDate1.Date, -1)) + '''';
  d4 := '''' + DateToStr(IncDay(dtDate1.Date, -15)) + '''';

  dsEmployees.Close;
  dsEmployees.CommandText := 'SELECT Employee_PIN FROM dtaEmployees WHERE Emp_status = ''ACTIVE''' +
    ' AND (Job_Position_Code = ''KEYER'' OR Job_Position_Code = ''QA'') ORDER BY Employee_PIN';
//  dsEmployees.CommandText := 'SELECT Employee_PIN FROM dtaEmployees WHERE Emp_status = ''ACTIVE''' +
//    ' AND Employee_PIN = ''541''';

  dsEmployees.Open;


  if dsEmployees.RecordCount > 0 then
  begin
    dsEmployees.First;

    sTime3 :=  DateToStr(dtDate1.Date);

    while not dsEmployees.Eof do
    begin
      d1 := '''' + DateToStr(dtDate1.Date) + '''';

      dsTime.Close;
      dsTime.Connection := ADOSQL;
      dsTime.CommandText := 'SELECT * FROM dtaTime_Detail WHERE Work_date BETWEEN ' + d1 + ' AND ' +
        d2 + ' AND Employee_PIN = ''' + dsEmployees.FieldByName('Employee_PIN').AsString +
        ''' ORDER BY Work_Date, Actual_In';
      dsTime.Open;

      if dsTime.RecordCount > 0 then
      begin
        dsTime.First;

        sID := dsTime.FieldByName('Time_ID').AsString;

        if (dsTime.FieldByName('Actual_Out').AsString = '') then
        begin

        end
        else
        begin

          sTime1 := dsTime.FieldByName('Work_date').AsString;

          if sTime1 = sTime3 then
          begin
            sOut := dsTime.FieldByName('Actual_Out').AsString;

            dsTime.Next;
            sIn := dsTime.FieldByName('Actual_In').AsString;


            vIn := StrToDateTime(sIn);
            vOut := StrToDateTime(sOut);

            sInterval := MinuteSpan(vIn, vOut);

            sInterval := sInterval / 60;

            if sInterval > 4 then
            begin
              dsTime.Prior;

              sID := dsTime.FieldByName('Time_ID').AsString;
              sOut := dsTime.FieldByName('Actual_In').AsString;

              d1 := '''' + DateToStr(IncDay(dtDate1.Date, -1)) + '''';


              //get last day of previous payroll
              dsTime.Close;
              dsTime.Connection := ADOSQL;
              dsTime.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date BETWEEN ' + d4 +
                ' AND ' + d1 + ' AND Employee_PIN = ''' + dsEmployees.FieldByName('Employee_PIN').AsString +
                ''' ORDER BY Work_Date, Actual_In';
              dsTime.Open;

              if dsTime.RecordCount > 0 then
              begin

                dsTime.Last;

                d1 := '''' + dsTime.FieldByName('Work_date').AsString + '''';

              end;



              dsTime.Close;
              dsTime.Connection := ADOSQL;
              dsTime.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ' + d1 +
                ' AND ''' + sOut + ''' BETWEEN Actual_In AND Actual_Out AND Employee_PIN = ''' +
                dsEmployees.FieldByName('Employee_PIN').AsString + ''' ORDER BY Work_Date, Actual_In';
              dsTime.Open;

              if dsTime.RecordCount > 0 then
              begin

                ADOSQL.Execute('DELETE FROM dtaTime_Detail WHERE Time_ID = ''' + sID + '''');

              end;

            end;

          end;
        end;
      end;

      dsEmployees.Next;
    end;

    d1 := DateTimeToStr(dtDate1.DateTime) + ' 12:00:00 AM';
    dtDate2.Date := IncDay(dtDate2.Date,1);
    d2 := DateTimeToStr(dtDate2.DateTime);

    DetailToSummary(d1, d2);


    // delete excess work date in dtatime_summary table
    dsEmployees.Close;
    dsEmployees.CommandText := 'SELECT Employee_PIN FROM dtaEmployees WHERE Emp_status = ''ACTIVE''' +
      ' AND (Job_Position_Code = ''KEYER'' OR Job_Position_Code = ''QA'') ORDER BY Employee_PIN';
//      ' AND (Job_Position_Code = ''KEYER'' OR Job_Position_Code = ''QA'') AND primary_task_id = ''bcbs-al''' +
//      ' AND emp_loc = ''MDEPI'' ORDER BY Employee_PIN';

//  dsEmployees.CommandText := 'SELECT Employee_PIN FROM dtaEmployees WHERE Emp_status = ''ACTIVE''' +
//    ' AND Employee_PIN = ''541''';

    dsEmployees.Open;


    if dsEmployees.RecordCount > 0 then
    begin
      dsEmployees.First;

      d1 := '''' + DateToStr(dtDate1.Date) + '''';
      d2 := '''' + DateToStr(dtDate2.Date) + '''';

      //sTime3 := '''' + DateToStr(dtDate1.Date) + '''';

      while not dsEmployees.Eof do
      begin
        dsTime.Close;
        dsTime.Connection := ADOSQL;
        dsTime.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date BETWEEN ' + d1 + ' AND ' +
          d2 + ' AND Employee_PIN = ''' + dsEmployees.FieldByName('Employee_PIN').AsString +
          ''' ORDER BY Employee_PIN, Actual_in';


        dsTime.Open;

        if dsTime.RecordCount > 0 then
        begin

          dsTime.First;


          sID := dsTime.FieldByName('Time_ID').AsString;

          sTime1 := dsTime.FieldByName('Work_date').AsString;

          if sTime1 = sTime3 then
          begin

            dsTime.Next;
            sTime2 := dsTime.FieldByName('Work_date').AsString;

            if sTime1 = sTime2 then
              ADOSQL.Execute('DELETE FROM dtaTime_Summary WHERE Time_ID = ''' + sID + '''')
            else
            begin

              dsTime.Prior;
              sID := dsTime.FieldByName('Time_ID').AsString;
              sTime1 := dsTime.FieldByName('Actual_in').AsString;

              vIn := IncDay(StrToDate(dsTime.FieldByName('Work_Date').AsString), -1);
              sIn := DateTimeToStr(vIn);

              dsSummary.Close;
              dsSummary.CommandText := 'SELECT * FROM dtaTime_Summary WHERE Work_date = ''' +
                sIn + ''' AND ''' + sTime1 + ''' BETWEEN Actual_In AND Actual_Out AND Employee_PIN = ''' +
                dsEmployees.FieldByName('Employee_PIN').AsString + '''';
              dsSummary.Open;

              if dsSummary.RecordCount > 0 then
                ADOSQL.Execute('DELETE FROM dtaTime_Summary WHERE Time_ID = ''' + sID + '''')


            end;

          end;

        end;

        dsEmployees.Next;
      end;
    end;


    ShowMessage('Process was successfully completed ...');
  end;

end;

procedure TfrmTimeExtraction.Button5Click(Sender: TObject);
//var
//  vDate1, vDate2 : TDateTime;
//  vDate1str, vDate2str : string;
begin
//  frmOvertimeValidation.Show;
//  vDate1str := '4/1/2007 12:33:12 PM';
//  vDate2str := '4/1/2007 1:33:12 PM';

//  varTime := StrToDateTime(vDate1str);
//  varTime1 := StrToDateTime(vDate2str);
   //-------------- COMPUTE FOR THE HOLIDAY PAY -------------//

                //determine if work date is a holiday
          ADODataSet.Close;
          ADODataSet.Connection := ADOSQL;
          ADODataSet.CommandText := 'SELECT * FROM dtaTime_Detail WHERE Work_date BETWEEN ''10/16/2007'' AND ''10/31/2007''' +
            ' ORDER BY Employee_PIN, Actual_in';
          ADODataSet.Open;

          if ADODataSet.RecordCount > 0 then
          begin
            ADODataSet.First;
            while not ADODataSet.Eof do
            begin
                varEmpPIN := ADODataSet.FieldByName('Employee_PIN').Value;
                varWorkDate := ADODataSet.FieldByName('Work_Date').AsDateTime;

                KeyerIn := ADODataSet.FieldByName('Actual_in').AsDateTime;
                TimeOut := DateTimeToStr(ADODataSet.FieldByName('Actual_out').AsDateTime);


                WDate := FormatDateTime('ddddd', varWorkDate);
                //vHPIN := '341';

                //get Employee rate per hour
                dsEmployees.Close;
                dsEmployees.CommandText := 'SELECT Rate_Hour, Night_Diff FROM dtaEmployees WHERE Employee_PIN = ''' +
                  IntToStr(varEmpPIN) + '''';
                dsEmployees.Active := TRUE;

                if dsEmployees.RecordCount > 0 then
                begin
                  vHEmpRate := dsEmployees.FieldByName('Rate_Hour').AsString;
                  vWNDiff := dsEmployees.FieldByName('Night_Diff').AsString;
                end;

                //set initial value of Employee rate per hour to 0
                if vHEmpRate = '' then
                  vHEmpRate := '0';

                dsHoliday.Close;
                dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Details WHERE HDate = ''' + WDate + '''';
                dsHoliday.Active := TRUE;

                if dsHoliday.RecordCount > 0 then
                begin
                  vHType := dsHoliday.FieldByName('Holiday_Type').AsString;

                  vWDate := WDate + ' 12:00:00 AM';
                  vWDate1 := WDate + ' 11:59:59 PM';

                  vT1 := DateTimeToStr(KeyerIn);
                  vT2 := TimeOut;

                  if vT2 = '' then
                    vT2 := '0';




                  //VHTime1 := StrToDateTime(vWDate);
                  //VHTime2 := StrToDateTime(vWDate1);

                  varTime := StrToDateTime(vT1);
                  varTime2 := StrToDateTime(vT2);

                  //check if actual in is within the holiday
                  //if ((varTime > VHTime1) and (varTime < VHTime2)) then
                    //check if actual out is within the holiday
                    //if ((varTime2 > VHTime1) and (varTime2 < VHTime2)) then
                    //begin
                      //whole working hours is holiday hours
//                      ShowMessage('whole working hours is holiday hours');
                        //vInterval := MinuteSpan(varTime, varTime2);
                    //end
                    //else
                    //begin
                      //compute for the holiday hours
                      //ShowMessage('compute for the holiday hours');

                      //vInterval := MinuteSpan(varTime, VHTime2);

//                      ShowMessage(FloatToStr(vInterval / 60));

                    //end;

                    vInterval := MinuteSpan(varTime, varTime2);

                    //get holiday rate based on the holiday type
                    dsHoliday.Close;
                    dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Type WHERE Holiday_Type = ''' + vHType + '''';
                    dsHoliday.Active := TRUE;

                    if dsHoliday.RecordCount > 0 then
                    begin
                      vHRate := dsHoliday.FieldByName('Holiday_Rate').AsString;

                      //compute for the holiday pay
                      vHPay := StrToFloat(vHRate) * ( vInterval / 60 )* StrToFloat(vHEmpRate);

//                      ShowMessage(FloatToStr(vHPay));

                      //save holiday fields to dtaTime_Detail
                      ADODataSet.Edit;

                        ADODataSet.FieldByName('Holiday_Hours').AsFloat := vInterval / 60;
                        ADODataSet.FieldByName('Holiday_Rate').AsFloat := StrToFloat(vHRate);
                        ADODataSet.FieldByName('Holiday_Pay').AsFloat := vHPay;

                      ADODataSet.Post;
                    end;
                end;

                ADODataSet.Next;
          end;
      end;

end;

procedure TfrmTimeExtraction.optDatesClick(Sender: TObject);
begin
  if optDates.Checked = TRUE then
  begin
    dtDate1.Enabled := TRUE;
    dtDate2.Enabled := TRUE;

    dtDate1.SetFocus;
  end
end;

//Procedure to store extracted time periods
procedure TfrmTimeExtraction.StoreExtractedPeriods();
var
  varSelected : Integer;
begin
  d1 := Chr(39) + DateToStr(dtDate1.Date) + Chr(39);
  d2 := Chr(39) + DateToStr(dtDate2.Date) + Chr(39);

  myDSet.Close;
  myDSet.Connection := ADOSQL;
  myDSet.CommandText := 'SELECT * FROM dtaExtractedTimePeriods WHERE Extract_From = ' + d1 +
    ' AND Extract_To = ' + d2 + ' AND Branch_Code = ' + Chr(39) + varBranch + Chr(39);

  //ShowMessage(myDSet.CommandText);
  myDSet.Active := TRUE;

  if myDSet.RecordCount > 0 then
  begin
    varSelected := MessageDlg('This Payroll Period has already been extracted, pressing OK button would overwrite the existing records!',
        mtError, mbOkCancel, 0);

    if varSelected = mrOk then
    begin
      //Codes to place here-----
      //Delete records based on the range given above
      ADOSQL.Execute('DELETE FROM dtaTime_Detail WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2);

      ExtractTimeFromEDS1();
      //ShowMessage(ADOSQL.Execute);
      //

    //  ShowMessage('ok button clicked')
    end
    else if varSelected = mrCancel then
      //ShowMessage('cancel button clicked');

  end
  else
  begin
    ADOSQL.Execute('DELETE FROM dtaTime_Detail WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2);
    ExtractTimeFromEDS1();

    myDSet.Close;
    myDSet.Connection := ADOSQL;
    myDSet.CommandText := 'SELECT * FROM dtaExtractedTimePeriods';
    myDSet.Active := TRUE;

    with myDSet do
    begin
      Insert;
        d1 := DateToStr(dtDate1.Date);
        d2 := DateToStr(dtDate2.Date);

        FieldByName('Extract_From').AsString := d1;
        FieldByName('Extract_To').AsString := d2;
        FieldByName('Extracted_Records').Value := ExtractedRecords;
        FieldByName('Refined_Records').Value := RefinedRecords;

        FieldByName('Branch_Code').AsString := varBranch;
      Post;
    end;
  end;
end;

procedure TfrmTimeExtraction.DetailToSummary(vDate1, vDate2: String);
begin
  spEmployees.Connection := ADOSQL;
  spEmployees.ProcedureName := 'spTIME_EXTRACT';
  spEmployees.Parameters.Refresh;

  spEmployees.Parameters.ParamByName('@d1').Value := vDate1;
  spEmployees.Parameters.ParamByName('@d2').Value := vDate2;
  spEmployees.ExecProc;
//  spEmployees.Active := TRUE;
end;

procedure TfrmTimeExtraction.Button2Click(Sender: TObject);
var
  strSt : string;
  tDay : integer;
begin
  if selectedDbase <> '' then
  begin
    DataSetSQL.Close;
    DataSetSQL.Connection := ADOSQL;
    DataSetSQL.CommandText := 'SELECT * FROM dtaTimeSecurity';
    DataSetSQL.Active := TRUE;

    if DataSetSQL.RecordCount > 0 then
    begin
      tDay := DayOfTheMonth(dtDate1.Date);

      if ((tDay = 1) or (tDay = 16)) then
      begin
        //if dtDate1.Date > DataSetSQL.FieldByName('tFrom').AsDateTime then
        //begin
          strSt := 'UPDATE dtaTimeSecurity SET tStatus = 0, tFrom = ''' + DateToStr(dtDate1.Date) +
            ''', tTo = ''' + DateToStr(dtDate2.Date) + '''';

          ADOSQL.Execute(strSt);

          ExtractTimeFromEDS1();
          //    StoreExtractedPeriods();

          d1 := DateTimeToStr(dtDate1.DateTime) + ' 12:00:00 AM';
          dtDate2.Date := IncDay(dtDate2.Date,1);
          d2 := DateTimeToStr(dtDate2.DateTime);

          DetailToSummary(d1, d2);


          DataSetSQL.Close;
          DataSetSQL.Connection := ADOSQL;

          //View extracted records
          d1 := Chr(39) + DateToStr(dtDate1.Date) + Chr(39);
          d2 := Chr(39) + DateToStr(dtDate2.Date) + Chr(39);

          //DataSetSQL.CommandText := 'SELECT Employee_Name, Employee_PIN, Work_Date, Sched_In, Sched_Out, Actual_In, Actual_Out, Time_Interval, OT, Regular_Hours, Tardiness, Remarks FROM dtaTime_Detail WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2 + ' AND Branch_Code = ' + Chr(39) + varBranch + Chr(39) + ' ORDER BY Employee_PIN, Work_Date';
          DataSetSQL.CommandText := 'SELECT Employee_Name, Employee_PIN, Work_Date, Actual_In, Actual_Out, OT, Regular_Hours, Tardiness, Remarks FROM dtaTime_Summary WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2 + ' AND Branch_Code = ' +
            chr(39) + varBranch + chr(39) + ' ORDER BY Employee_PIN, Work_Date';

          DataSetSQL.Active := TRUE;

          if DataSetSQL.RecordCount > 0 then
          begin
            lblExtractedRecords.Caption := IntToStr(DataSetSQL.RecordCount) + ' records';
            RefinedRecords := DataSetSQL.RecordCount;

            SourceSQL.DataSet := DataSetSQL;

          end;

          dbGrid2.DataSource := SourceSQL;
          dbGrid2.Refresh;


          Process_Log;

          ShowMessage('Time extraction was successfully finished!');
        //end
        //else
        //  ShowMessage('Selected period is already extracted, select another!');
      end
      else
        ShowMessage('Please select only the 1st or the 16th day of the month!');
    end;
  end;




end;

function TfrmTimeExtraction.IsFileInUse(fName : string) : boolean;
var
    HFileRes : HFILE;
begin
    Result := false;
    if not FileExists(fName) then exit;
    HFileRes :=
      CreateFile(pchar(fName),
                 GENERIC_READ or GENERIC_WRITE,
                 0, nil, OPEN_EXISTING,
                 FILE_ATTRIBUTE_NORMAL,
                 0) ;
    Result := (HFileRes = INVALID_HANDLE_VALUE) ;
    if not Result then
    CloseHandle(HFileRes);
end;

procedure TfrmTimeExtraction.FormShow(Sender: TObject);
begin
  FillBranchCombo();

  varClicked := FALSE;
end;

procedure TfrmTimeExtraction.FillBranchCombo();
var
  varBranch : String;
begin
  dsFillBranch.Close;
  dsFillBranch.CommandText := 'SELECT * FROM dtaBranches ORDER BY Branch_Code';
  dsFillBranch.Connection := ADOSQL;
  dsFillBranch.Active := TRUE;

end;


procedure TfrmTimeExtraction.InsertExtractToLogFile(vDate, vUser, vModule, vCommand, vTable, vFieldName : String);
var
  valueRemarks : String;
begin

  valueRemarks := 'Extracted period: ' + DateToStr(dtDate1.Date) + ' - ' + DateToStr(dtDate2.Date);

  dsLogFile.Close;
  dsLogFile.Connection := ADOSQL;
  dsLogFile.CommandText := 'SELECT * FROM dtaLogFile';
  dsLogFile.Active := TRUE;

  with dsLogFile do
  begin
    Insert;
      FieldByName('Tran_Date').AsString := vDate;
      FieldByName('User_Id').AsString := vUser;
      FieldByName('Module_Desc').AsString := vModule;
      FieldByName('Command').AsString := vCommand;
      FieldByName('Table_Name').AsString := vTable;
      FieldByName('Field_Name').AsString := vFieldName;
      FieldByName('Remarks').AsString := valueRemarks;

    Post;

  end;
end;

procedure TfrmTimeExtraction.ExtractTimeFromEDS1();
var
  varTaskID : String;

  bVar : Integer;
begin

  bVar := 0;

  d1 := '''' + DateToStr(dtDate1.Date) + '''';
  d2 := '''' + DateToStr(IncDay(dtDate2.Date, 2)) + '''';
//  varBranch := '''' + ADODataSet.FieldByName('CompanyCode').AsString + '''';
  varBranch := ADODataSet.FieldByName('CompanyCode').AsString;

  ADOSQL.Execute('DELETE FROM dtaTime_Detail WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2 +
    ' AND Branch_Code = ' + chr(39) + varBranch + chr(39));

  //open the table
  DataSetSQL.Close;
  DataSetSQL.Connection := ADOSQL;
  DataSetSQL.CommandText := 'SELECT * FROM dtaTime_Detail WHERE Work_Date BETWEEN ' + d1 + ' AND ' + d2;
  DataSetSQL.Active := TRUE;

    with ADODataSet do
    begin
      First;

      TimeInterval := 0.00;
      ExtractedRecords := 0;
      varTardiness := 0.00;
      HrsWorked := 0.00;

      while not Eof do
      begin
          SearchForOut := 0;

          varEmpPIN := FieldByName('PIN').Value;
          varEmpPIN1 := FieldByName('PIN').AsString;

          //varWorkDate1 := FieldByName('Timedata').AsDateTime;

          //get first log in time
          if bVar = 0 then
            TimeIn := FieldByName('Timedata').AsString;

          varWorkDate := FieldByName('Timedata').AsDateTime;

//        if varCurPIN = varEmpPIN then
//        begin
          if (FieldByName('InOut').AsString = 'IN') then
          begin
            //get first record from database
            //varBranch := FieldByName('CompanyCode').AsString;

            //get the date from the access database
            KeyerIn := FieldByName('Timedata').AsDateTime;
            KeyerSched := FormatDateTime('ddddd', KeyerIn);

            Next;

            if ((FieldByName('InOut').AsString = 'IN') and (varEmpPIN = FieldByName('PIN').Value)) then
            begin
              TimeIn1 := FieldByName('Timedata').AsString;
              varTime := StrToDateTime(TimeIn);
              varTime1 := StrToDateTime(TimeIn1);

              if (varTime < varTime1) then
                TimeIn := DateTimeToStr(varTime1);

            end;
            Previous;

 //----------------  DETERMINING EMPLOYEE Schedule --------------------//
            //Retrieve start time of an employee
 {           dsSched.Close;
            dsSched.Connection := ADOSQL;
            dsSched.CommandText := 'SELECT * FROM dtaKeyerSchedule WHERE Work_Date =' + Chr(39) + KeyerSched + Chr(39) + ' AND Employee_PIN = ' + IntToStr(varEmpPIN);

            dsSched.Active := TRUE;
            if dsSched.RecordCount > 0 then
            begin
              TimeIn1 := dsSched.FieldByName('Start_Time').AsString;

              TimeIn2 := dsSched.FieldByName('End_Time').AsString;

              varTime2 := StrToDateTime(TimeIn2);

              varTime := StrToDateTime(TimeIn);
              varTime1 := StrToDateTime(TimeIn1);

              if (varTime > varTime1) then
              begin
                TimeIn := DateTimeToStr(varTime);
                varTardiness := MinuteSpan(varTime1, varTime);
              end
              else
                TimeIn := DateTimeToStr(varTime1);
            end
            else
            begin
              TimeIn1 := '';
              TimeIn2 := '';
            end;}

//----------------  END OF DETERMINING EMPLOYEE Schedule --------------------//


//            varTardiness := 0.00;
            HrsWorked := 0.00;
            TimeInterval := 0.00;
            DayInterval := 0.00;

            repeat
            //if (TimeInterval <= 480) then
            begin

              LastTime := FieldByName('Timedata').AsString;
              //-------
              //check for log out time
              if ((FieldByName('InOut').AsString = 'OUT') and (varEmpPIN = FieldByName('PIN').Value)) then
              begin
                TimeOut := FieldByName('Timedata').AsString;

                varTime := StrToDateTime(TimeIn);
                varTime1 := StrToDateTime(TimeOut);

                //------
                //if an employee has committed an undertime
                if (varTime1 < varTime2) then
                begin

                  HrsWorked := MinuteSpan(varTime, varTime1);
                  TimeInterval := MinuteSpan(varTime, varTime1);
                end
                else
                begin
                    //compute for minute span
                    HrsWorked := MinuteSpan(varTime, varTime2);
                    TimeInterval := MinuteSpan(varTime, varTime1);
                    varOT := MinuteSpan(varTime2,varTime1);
                end;
                //------

                if (DayInterval < 60) then
                begin
                   break;
                end;
             end
             //else condition for the ----- > if ((FieldByName('InOut').AsString = 'OUT') and (varEmpPIN = FieldByName('PIN').Value)) then
            else
              break;
            //-------

                Next;
                 SearchForOut := SearchForOut + 1;

                 if (SearchForOut >= 3) then
                 begin
                    TimeOut := '';
                    break;
                 end;

                 DayOut := FieldByName('Timedata').AsString;

                 varTime := StrToDateTime(DayOut);
                 varTime1 := StrToDateTime(LastTime);

                 DayInterval := MinuteSpan(varTime, varTime1);

                 Previous;
            end;
            until ((TimeInterval >= 60) and (DayInterval >= 240));

            //convert timeinterval (minutes) to hours
            TimeInterval := TimeInterval / 60;
            //varOT := varOT / 60;
            HrsWorked := HrsWorked / 60;
            varTardiness := varTardiness / 60;

            //----
            //save to sql database
            with DataSetSQL do
            begin
              Insert;
                FieldByName('Work_Date').AsString := FormatDateTime('ddddd', varWorkDate);
                FieldByName('Employee_PIN').Value := varEmpPIN;

                //FieldByName('Sched_In').AsString := TimeIn1;
                //FieldByName('Sched_Out').AsString := TimeIn2;

                FieldByName('Time_Interval').AsFloat := TimeInterval;

                //---
//                if (HrsWorked > 8.01) then
//                begin
//                  FieldByName('Regular_Hours').AsFloat := 0.00;
//                  FieldByName('Remarks').AsString := 'CHECK SCHED'
//                end
//                else
//                begin
//                  FieldByName('Regular_Hours').AsFloat := HrsWorked;
//                  FieldByName('Regular_Hours').AsFloat := TimeInterval;

                  if TimeInterval > 8 then
                  begin
                    FieldByName('Regular_Hours').AsFloat := 8;
                    varOT := TimeInterval - 8;
                    FieldByName('OT').AsFloat := varOT;
                  end
                  else
                  begin
                    FieldByName('Regular_Hours').AsFloat := TimeInterval;
                    FieldByName('OT').AsFloat := 0;
                  end;
                //end;
                //---

                //FieldByName('Regular_Hours').AsFloat := HrsWorked;
                FieldByName('Tardiness').AsFloat := varTardiness;
//                FieldByName('Actual_In').AsString := DateTimeToStr(KeyerIn);
                FieldByName('Actual_In').AsString := TimeIn;
                FieldByName('Actual_Out').AsString := TimeOut;
                FieldByName('Branch_Code').AsString := varBranch;

//                FieldByName('Emp_Count').Value := varCurCount;

                //--
               // if ((varOT > 100) or (varOT < 0)) then
               //   FieldByName('OT').AsFloat := 0
               // else
               //   FieldByName('OT').AsFloat := varOT;

                {
                if (TimeInterval <= 3) then
                begin
                  FieldByName('Remarks').AsString := 'INVALID';
                end;
                == removed as of April 7, 2006
                }

                //--

                FieldByName('AuthorizeOT').AsString := 'Yes';


                //save task id of an employee
                dsPIN.Close;
                dsPIN.Connection := ADOSQL;
                dsPIN.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + chr(39) + varEmpPIN1 + Chr(39);
                dsPIN.Active := TRUE;

                if dsPIN.RecordCount > 0 then
                begin
                  varTaskID := dsPIN.FieldByName('Primary_Task_ID').AsString;
                  FieldByName('Task_ID').AsString := varTaskID;
                end;



   //-------------- COMPUTE FOR THE HOLIDAY PAY -------------//

                //determine if work date is a holiday

                WDate := FormatDateTime('ddddd', varWorkDate);
                //vHPIN := '341';

                //get Employee rate per hour
                dsEmployees.Close;
                dsEmployees.CommandText := 'SELECT Rate_Hour, Night_Diff FROM dtaEmployees WHERE Employee_PIN = ''' +
                  IntToStr(varEmpPIN) + '''';
                dsEmployees.Active := TRUE;

                if dsEmployees.RecordCount > 0 then
                begin
                  vHEmpRate := dsEmployees.FieldByName('Rate_Hour').AsString;
                  vWNDiff := dsEmployees.FieldByName('Night_Diff').AsString;
                end;

                //set initial value of Employee rate per hour to 0
                if vHEmpRate = '' then
                  vHEmpRate := '0';

                dsHoliday.Close;
                dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Details WHERE HDate = ''' + WDate + '''';
                dsHoliday.Active := TRUE;

                if dsHoliday.RecordCount > 0 then
                begin
                  vHType := dsHoliday.FieldByName('Holiday_Type').AsString;

                  vWDate := WDate + ' 12:00:00 AM';
                  vWDate1 := WDate + ' 11:59:59 PM';

                  vT1 := DateTimeToStr(KeyerIn);
                  vT2 := TimeOut;

                  if vT2 = '' then
                    vT2 := '0';

//                  VHTime1 := StrToDateTime(vWDate);
//                  VHTime2 := StrToDateTime(vWDate1);

                  varTime := StrToDateTime(vT1);
                  varTime2 := StrToDateTime(vT2);

                  //check if actual in is within the holiday
//                  if ((varTime > VHTime1) and (varTime < VHTime2)) then
                    //check if actual out is within the holiday
//                    if ((varTime2 > VHTime1) and (varTime2 < VHTime2)) then
//                    begin
                      //whole working hours is holiday hours
//                      ShowMessage('whole working hours is holiday hours');
//                        vInterval := MinuteSpan(varTime, varTime2);
//                    end
//                    else
//                    begin
                      //compute for the holiday hours
                      //ShowMessage('compute for the holiday hours');

//                      vInterval := MinuteSpan(varTime, VHTime2);

//                      ShowMessage(FloatToStr(vInterval / 60));

//                    end;


                    vInterval := MinuteSpan(varTime, varTime2);


                    //get holiday rate based on the holiday type
                    dsHoliday.Close;
                    dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Type WHERE Holiday_Type = ''' + vHType + '''';
                    dsHoliday.Active := TRUE;

                    if dsHoliday.RecordCount > 0 then
                    begin
                      vHRate := dsHoliday.FieldByName('Holiday_Rate').AsString;

                      //compute for the holiday pay
                      vHPay := StrToFloat(vHRate) * ( vInterval / 60 )* StrToFloat(vHEmpRate);

//                      ShowMessage(FloatToStr(vHPay));

                      //save holiday fields to dtaTime_Detail
                      FieldByName('Holiday_Hours').AsFloat := vInterval / 60;
                      FieldByName('Holiday_Rate').AsFloat := StrToFloat(vHRate);
                      FieldByName('Holiday_Pay').AsFloat := vHPay;
                    end;
                end;


             bVar := 0;
   //-------------- DETERMINE NIGHT DIFF -------------//

                  //night differential time range
              isOk := 'False';
              if vWNDiff = 'True' then
              begin

                  vT1 := DateTimeToStr(KeyerIn);
                  vT2 := TimeOut;

                  if vT2 = '' then
                    vT2 := '0';

                  varTime := StrToDateTime(vT1);
                  varTime2 := StrToDateTime(vT2);

                  //vWDate := DateToStr(StrToDateTime(vT1));
                  vWDate := WDate + ' 10:00:00 PM';

                  VHTime1 := StrToDateTime(vWDate);

                  vWDate := DateToStr(IncDay(StrToDateTime(vWDate), 1));

                  vWDate1 :=  vWDate + ' 6:00:00 AM';


                  VHTime2 := StrToDateTime(vWDate1);

                  //get workdate of actual_in and end of night diff hours
                  v1 := DateToStr(varTime);
                  v2 := DateToStr(VHTime2);


                  //check if actual in is within the night diff time range
                  if ((VHTime1 > varTime) and (VHTime1 < varTime2)) then
                  begin
                    //check if actual out is within the night diff time range
                    if ((VHTime2 > varTime) and (VHTime2 < varTime2)) then
                    begin
                      //whole working hours is holiday hours
                      //ShowMessage('your night diff is 8 hours');
                      vIntervalNightDiff := 480;
                    end
                    else
                    begin
                      //compute for the night differential base on the
                      //total number of working hours
                      //ShowMessage('compute for night diff');
                      vIntervalNightDiff := MinuteSpan(VHTime1, varTime2);
                      isOk := 'True';
                    end;
                 end
                 else  // if actual in is beyond 10:00:00 pm...
                 begin
                    if ((VHTime2 > varTime) and (VHTime2 < varTime2)) then
                    begin
                      //ShowMessage('compute for night diff');

                      vIntervalNightDiff := MinuteSpan(varTime, VHTime2);
                    end
                else
                begin
                    vInterval := 0;
                    isOk := 'True';
                 end;

                 end;

                  vT1 := DateToStr(varTime);
                  vT2 := DateToStr(varTime2);

                  if ((vT1 = vT2) and (isOk = 'False')) then
                  begin
                    vWMid := WDate + ' 12:00:00 AM';
                    vHMid := StrToDateTime(vWMid);

                    if (varTime > vHMid) then
                    begin
                      v1 := DateToStr(varTime);
                      v2 := DateToStr(varTime);
                    end;

                    if (v1 = v2) then
                    begin
                      vWMid := v1 + ' 6:00:00 AM';
                      VHTime2 := StrToDateTime(vWMid);
                      vIntervalNightDiff := MinuteSpan(varTime, VHTime2);
                    end;
                 end;

                 vWMid := WDate + ' 6:00:00 AM';
                 vHMid := StrToDateTime(vWMid);

                 if (varTime < vHMid) then
                 begin
                    vIntervalNightDiff := MinuteSpan(varTime, vHMid);
                 end;



                 vIntervalNightDiff := vIntervalNightDiff / 60;
                //save night differential fields
                if vIntervalNightDiff <= 8 then
                  if vIntervalNightDiff < TimeInterval then
                    //FieldByName('Night_Diff_Hours').AsFloat := vIntervalNightDiff
                  else
                    //FieldByName('Night_Diff_Hours').AsFloat := 0;

              end;

              //save changes
              Post;


              //frmTimeExtraction.Refresh;

              //add employee name to timeinterval.employee_name
              dsEmployeeName.Close;
              dsEmployeeName.Connection := ADOSQL;
              dsEmployeeName.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + chr(39) + varEmpPIN1 + chr(39);
              dsEmployeeName.Active := TRUE;

              //-
              if dsEmployeeName.RecordCount > 0 then
              begin
                  empName := dsEmployeeName.FieldByName('Employee_Name').AsString;

                  ADOSQL.Execute('UPDATE dtaTime_Detail SET Employee_Name = ' + chr(39) + empName + chr(39) +
                    ' WHERE Employee_PIN = ' + varEmpPIN1);
              end;
              //-

              ExtractedRecords := ExtractedRecords + 1;

              vInterval := 0.00;
              vIntervalNightDiff := 0.00;


              TimeInterval := 0.00;
              HrsWorked := 0.00;
              varTardiness := 0.00;
              TimeOut := '';
              TimeIn := '';
            end;
            //----

         end
         else
         begin
            Next;

            bOut := StrToDateTime(TimeIn);

            //bTime := FieldByName('TimeData').AsString;
            bIn := StrToDateTime(FieldByName('TimeData').AsString);

            bInterval := MinuteSpan(bIn, bOut);


            //check if employee is an ADMIN
            //if employee is an ADMIN then disable or do not make break/lunch
              //taken in less than one hour to a whole hour - 06/21/09
            dsEmployeeName.Close;
            dsEmployeeName.Connection := ADOSQL;
            dsEmployeeName.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + chr(39) + varEmpPIN1 + chr(39);
            dsEmployeeName.Active := TRUE;

            if (dsEmployeeName.FieldByName('Primary_task_id').AsString <> 'ADMIN') then
            begin

              if bInterval < 60 then
              begin
                bIn := bOut + 0.041666;

                TimeIn := DateTimeToStr(bIn);

                bVar := 1;
              end
              else
                bVar := 0;

            end;
        end;
         //-----
//     end
//     else
//     begin
//        varCurPIN := varEmpPIN;
//        varCurCount := varCurCount + 1;
//     end;
   end;

  //ShowMessage(DataSetSQL.CommandText);

//  if FileExists('FingerID.tob') then
//  begin
//    RenameFile('FingerID.tob', 'FingerID.mdb');
//    ChangeFileExt('FingerID.tob', 'mdb');
//  end;
 //ADODataSet.Close;
 //DataSetSQL.Close;
 end;
 //ADODataSet.Close;
 //DataSetSQL.Close;
end;

procedure TfrmTimeExtraction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTimeExtraction.dtDate1Change(Sender: TObject);
var
  dt : TDateTime;
  myYear, myMonth, myDay : Word;
begin

  DecodeDate(dtDate1.Date, myYear, myMonth, myDay);

  if(DayOfTheMonth(dtDate1.Date))= 1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
    dtDate2.Date := dt;
    dtDate2.Refresh;

end;

procedure TfrmTimeExtraction.FormCreate(Sender: TObject);
begin
  ADOSQL.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOSQL.Connected := TRUE;
end;

procedure TfrmTimeExtraction.Button7Click(Sender: TObject);
begin
   //-------------- COMPUTE FOR THE HOLIDAY PAY -------------//


                WDate := '12/24/2005'; //FormatDateTime('ddddd', varWorkDate);
                vHPIN := '346';

                //get Employee rate per hour
                dsEmployees.Close;
                dsEmployees.CommandText := 'SELECT Rate_Hour, Night_Diff FROM dtaEmployees WHERE Employee_PIN = ''' + vHPIN + '''';
                dsEmployees.Active := TRUE;

                if dsEmployees.RecordCount > 0 then
                begin
                  vHEmpRate := dsEmployees.FieldByName('Rate_Hour').AsString;
                  vWNDiff := dsEmployees.FieldByName('Night_Diff').AsString;
                end;
 {
                //set initial value of Employee rate per hour to 0
                if vHEmpRate = '' then
                  vHEmpRate := '0';

                dsHoliday.Close;
                dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Details WHERE HDate = ''' + WDate + '''';
                dsHoliday.Active := TRUE;

                if dsHoliday.RecordCount > 0 then
                begin
                  vHType := dsHoliday.FieldByName('Holiday_Type').AsString;

                  vWDate := WDate + ' 12:00:00 AM';
                  vWDate1 := WDate + ' 11:59:59 PM';

                  vT1 := '11/30/2005 6:00:00 PM';
                  vT2 := '12/1/2005 6:00:00 AM';

                  VHTime1 := StrToDateTime(vWDate);
                  VHTime2 := StrToDateTime(vWDate1);

                  varTime := StrToDateTime(vT1);
                  varTime2 := StrToDateTime(vT2);

                  //check if actual in is within the holiday
                  if ((varTime > VHTime1) and (varTime < VHTime2)) then
                    //check if actual out is within the holiday
                    if ((varTime2 > VHTime1) and (varTime2 < VHTime2)) then
                    begin
                      //whole working hours is holiday hours
//                      ShowMessage('whole working hours is holiday hours');

                    end
                    else
                    begin
                      //compute for the holiday hours
                      //ShowMessage('compute for the holiday hours');

                      vInterval := MinuteSpan(varTime, VHTime2);

//                      ShowMessage(FloatToStr(vInterval / 60));

                    end;

                    //get holiday rate based on the holiday type
                    dsHoliday.Close;
                    dsHoliday.CommandText := 'SELECT * FROM dtaHoliday_Type WHERE Holiday_Type = ''' + vHType + '''';
                    dsHoliday.Active := TRUE;

                    if dsHoliday.RecordCount > 0 then
                    begin
                      vHRate := dsHoliday.FieldByName('Holiday_Rate').AsString;

                      //compute for the holiday pay
                      vHPay := StrToFloat(vHRate) * ( vInterval / 60 )* StrToFloat(vHEmpRate);

//                      ShowMessage(FloatToStr(vHPay));
                    end;
                end;                   }



   //-------------- DETERMINE NIGHT DIFF -------------//

               isOk := 'False';
               if vWNDiff = 'True' then
               begin

                  vT1 := '12/25/2005 1:07:38 AM';
                  vT2 := '12/25/2005 7:10:33 AM';

                  //night differential time range
                  vWDate := WDate + ' 10:00:00 PM';

                  VHTime1 := StrToDateTime(vWDate);

                  vWDate := DateToStr(IncDay(StrToDateTime(vWDate), 1));

                  vWDate1 :=  vWDate + ' 6:00:00 AM';

                  VHTime2 := StrToDateTime(vWDate1);

                  varTime := StrToDateTime(vT1);
                  varTime2 := StrToDateTime(vT2);


                  vT1 := DateToStr(varTime);
                  vT2 := DateToStr(varTime2);


                  //check if actual in is within the night diff time range
                  if ((VHTime1 > varTime) and (VHTime1 < varTime2)) then
                  begin
                    //check if actual out is within the night diff time range
                    if ((VHTime2 > varTime) and (VHTime2 < varTime2)) then
                    begin
                      //whole working hours is holiday hours
                      ShowMessage('your night diff is 8 hours');
                      vInterval := 480;
                    end
                    else
                    begin
                      //compute for the night differential base on the
                      //total number of working hours
                      //ShowMessage('compute for night diff');

                      vInterval := MinuteSpan(VHTime1, varTime2);
                      isOk := 'True';
                    end;
                 end
                 //else  // if actual in is beyond 10:00:00 pm...
                 //begin
                 else if ((VHTime2 > varTime) and (VHTime2 < varTime2)) then
                    begin
                      //ShowMessage('compute for night diff');

                      vInterval := MinuteSpan(varTime, VHTime2);
                    end
                else
                begin
                    vInterval := 0;
                    isOk := 'True';
                 end;
                 //end;
               end;

                  if ((vT1 = vT2) and (isOk = 'False')) then
                  begin
                    vWMid := WDate + ' 12:00:00 AM';
                    vHMid := StrToDateTime(vWMid);

                    if (varTime > vHMid) then
                    begin
                      v1 := DateToStr(varTime);
                      v2 := DateToStr(varTime);
                    end;

                    if (v1 = v2) then
                    begin
                      vWMid := v1 + ' 6:00:00 AM';
                      VHTime2 := StrToDateTime(vWMid);
                      vInterval := MinuteSpan(varTime, VHTime2);
                    end;
                 end;

                 vWMid := WDate + ' 6:00:00 AM';
                 vHMid := StrToDateTime(vWMid);

                 if (varTime < vHMid) then
                 begin
                    vInterval := MinuteSpan(varTime, vHMid);
                 end;

                    ShowMessage(FloatToStr(vInterval / 60));
                    Edit2.Text := FloatToStr(vInterval / 60);

end;

procedure TfrmTimeExtraction.Process_Log;
var
  ID: String;
  SQL: String;
begin
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'EDS Time Extraction' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaTime_Detail' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtPath.Text + '|' + DateToStr(dtDate1.Date) + '|' + DateToStr(dtDate2.Date) + chr(39);
  SQL := SQL + ')';
  ADOSQL.Execute(SQL);
end;

procedure TfrmTimeExtraction.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary


  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);


  dtDate1.Date := Date();
  dtDate2.Date := Date();


  InsertToLogFile(sTranDate, sUserID, 'Time Extraction', '', 'dtaTime_detail', '');
end;

procedure TfrmTimeExtraction.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
begin

  dsLogFile.Close;
  dsLogFile.CommandText := 'SELECT * FROM dtaLogFile';
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

End.



