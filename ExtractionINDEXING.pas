// Name:  ExtractionINDEXING.pas
// Description:  This window is for INDEXING project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionINDEXING;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ADODB, DB, ExtCtrls, DateUtils, CommonModule;

type
    TfrmExtractionINDEXING = class(TForm)
    OpenDialog1: TOpenDialog;
    ADOTable1: TADOTable;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Process_Log;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractionINDEXING: TfrmExtractionINDEXING;
  string1, string2 : AnsiString;
  sqlserver: String;
  sqldatabase: String;
  sqluser: String;
  sqlpwd: String;
  gUser : String;
  gUser_ID : Integer;

implementation
  uses ComObj;
{$R *.dfm}

procedure TfrmExtractionINDEXING.Button1Click(Sender: TObject);
  var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   dStart: TDateTime;
   dEnd: TDateTime;
   dCreateDate: String;
   vDuration: Double;
   Tem : String;
   vkeyer_ID : String;
   vDocCount : String;
   vSQL : String;
   vCheckFirst : String;
   vCheckSecond : String;
   vTask_ID : String;
   dummy : string;

   TimeDiff : string;

   myTimeDiff : string;
   myvSQL : string;

   myDate : TDateTime;
begin
    if Edit1.Text <> '' then
    begin

    Edit2.Text := 'start..';
    edit2.Refresh;

    oXL := CreateOleObject('Excel.Application');

    oWB := oXL.Workbooks.Open(Edit1.text);
    oSheet := oWB.ActiveSheet;

    Keyer :=  3;

    Edit2.Text := 'open dtaIndexing..';
    Edit2.Refresh;

    {
    vTask_ID:=UpperCase(oSheet.Cells[2,2]);

    if vTask_ID<>'INDEXING' then
      begin
        showmessage('Not Valid format');
        exit;
      end;
      }

    vCheckFirst:=oSheet.Cells[Keyer,1];
    vCheckSecond :=oSheet.Cells[Keyer,3];

    while (vCheckFirst <> 'Report Totals') do
    begin
      //if (LeftStr(vCheckFirst,5) = 'Total') then
      //  begin
      //    oWB := '';
      //    oSheet := '';
      //    oXL.Quit;
      //    Edit2.Text := 'Processing Complete!!!';
      //    frmExtractionINDEXING.Cursor := crDefault;
      //    exit;
      //  end;

      If (vCheckFirst = '') AND (vCheckSecond = '') then
        begin
          Keyer := Keyer + 1;
          vCheckFirst:=oSheet.Cells[Keyer,1];
          vCheckSecond :=oSheet.Cells[Keyer,3];
        end
      else if (vCheckFirst = 'Created') AND (vCheckSecond <> '') then
        begin
          Keyer := Keyer + 1;
          vCheckFirst:=oSheet.Cells[Keyer,1];
          vCheckSecond :=oSheet.Cells[Keyer,3];
        end
      else if (vCheckFirst <> '') AND (vCheckSecond = '') then
        begin
          Keyer := Keyer + 1;
          vCheckFirst:=oSheet.Cells[Keyer,1];
          vCheckSecond :=oSheet.Cells[Keyer,3];
        end
      else
        begin
          //frmExtractionINDEXING.Cursor := crHourGlass;

          vTask_ID := '';

          if (AnsiMidStr(vCheckSecond,5,1) = 'H') then vTask_ID := 'INDEXING HCFA'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'U') then vTask_ID := 'INDEXING UB'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'O') then vTask_ID := 'INDEXING OTHER'

          // as of august 28, 2008
          else if (AnsiMidStr(vCheckSecond,6,1) = 'F') then vTask_ID := 'UHG CHECKS'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'F') then vTask_ID := 'UHG CHECKS'
          else if (AnsiMidStr(vCheckSecond,6,1) = 'N') then vTask_ID := 'UHG CHECKS'
          // as of April 3, 2006 -- start //
          else if (AnsiMidStr(vCheckSecond,6,1) = 'M') then vTask_ID := 'INDEXING CLAIM'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'M') then vTask_ID := 'INDEXING CLAIM'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'A') then vTask_ID := 'INDEXING CLAIM'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'B') then vTask_ID := 'INDEXING CLAIM'

          // corr is again included on production reports effective - march 1, 2008
          else if (AnsiMidStr(vCheckSecond,6,1) = 'I') then vTask_ID := 'INDEXING CORR'
          else if (AnsiMidStr(vCheckSecond,6,1) = 'R') then vTask_ID := 'INDEXING CORR'
          else if (AnsiMidStr(vCheckSecond,6,1) = 'E') then vTask_ID := 'INDEXING CORR'
          else if (AnsiMidStr(vCheckSecond,6,1) = 'C') then vTask_ID := 'INDEXING CORR'

          else if (AnsiMidStr(vCheckSecond,6,1) = 'X') then vTask_ID := 'INDEXING RX'
          else if (AnsiMidStr(vCheckSecond,5,1) = 'R') then vTask_ID := 'INDEXING CLAIM';
          // as of April 3, 2006 -- end //



          //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
          ADODATASET1.Close;
          ADODATASET1.Connection := ADOCONNECTION1;
          ADODATASET1.CommandText := 'Select TimeDiff, Start_Time From dtaTaskRemarks Where Task_ID = ''' + vTask_ID + ''' ';
          ADODATASET1.Open;
          myTimeDiff := '780';
          if not ADODataSet1.FieldByName('TimeDiff').IsNull then
            myTimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
          ADODataSet1.Close;

          dCreateDate:= FormatDateTime('mm"/"dd"/"yyyy', oSheet.Cells[Keyer,1]) + ' ' + TimeToStr(oSheet.Cells[Keyer,1]);

          myDate := StrToDateTime(dCreateDate);

//          myDate := IncMinute(myDate, StrToInt(myTimeDiff));

          dStart:=oSheet.Cells[Keyer,5];
          dEnd:=oSheet.Cells[Keyer,7];
          vDuration:=MinuteSpan(dStart,dEnd);
          Tem := (oSheet.Cells[Keyer,8]);
          vKeyer_ID := uppercase(Trimright(TrimLeft(Tem)));
          vDocCount := (oSheet.Cells[Keyer,10]);



          //Edit2.Text := IntToStr(Keyer) + ' Extracting Excel Report...' + vKeyer_ID + '-' + dCreateDate;
          Edit2.Text := 'Extracting [' + FloatToStr(Keyer) + ']..' + vKeyer_ID + '-' + dCreateDate;
          Edit2.Refresh;

          if vKeyer_ID > '' then
          begin
            ADOTable1.Connection:= ADOConnection1;
            ADOTable1.Open;
            ADODataSet1.Connection := ADOConnection1;
            ADODataSet1.CommandText:='SELECT * FROM dtaProduction WHERE Task_ID='+ chr(39) + vTask_ID + chr(39)+' AND Keyer_ID='+ chr(39) + vkeyer_ID
              + chr(39)+' AND Extracted_Tran_Date = '+chr(39)+  dCreateDate + chr(39) + ' AND BatchName = ''' + vCheckSecond + '''';
            ADODataSet1.Open;
            if ((ADODataSet1.RecordCount=0) and (StrToInt(vDocCount)>0)) then
              begin
              {
                ADOTable1.Insert;
                ADOTable1.FieldByName('Keyer_ID').AsString := vkeyer_ID;
                ADOTable1.FieldByName('Tran_Date').AsDateTime := myDate;
                ADOTable1.FieldByName('Task_ID').AsString := vTask_ID;
                ADOTable1.FieldByName('Time_Taken').Value := vDuration;
                ADOTable1.FieldByName('Docs').Value := vDocCount;
                ADOTable1.FieldByName('Idle_Time').Value := 0;
                ADOTable1.FieldByName('Idle_Code').Value := 0;
                ADOTable1.FieldByName('Batches').Value := 0;
                ADOTable1.FieldByName('Pulls').Value := 0;
                ADOTable1.FieldByName('Extracted_Tran_Date').AsString := dCreateDate;
              }
                vSQL:='INSERT INTO dtaProduction (Keyer_ID,Tran_Date,Task_ID,Time_Taken,Docs,Idle_Time,Idle_Code,Batches,Pulls,Extracted_Tran_Date,Batchname) VALUES (' +
                ''''+vKeyer_ID+''','+
                ''''+DateTimeToStr(myDate)+''','+
                ''''+vTask_ID+''','+
                FloatToStr(vDuration)+','+
                vDocCount+','+
                '0,0,0,0,'+
                ''''+dCreateDate+''',''' +
                vCheckSecond + ''')';
                //ShowMessage(vSQL);
                ADOConnection1.Execute(vSQL);
              end
            else
              begin
                if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                begin
                  vSQL := 'UPDATE dtaProduction SET Time_Taken='+ FloatToStr(vDuration)
                    +', Docs='+ chr(39) + vDocCount + chr(39) +' WHERE Task_ID='
                    + chr(39) + vTask_ID + chr(39)+' AND Keyer_ID='+ chr(39) + vkeyer_ID
                    + chr(39)+' AND Extracted_Tran_Date = '+chr(39)+  dCreateDate + chr(39);
                  ADOConnection1.Execute(vSQL);
                end;
              end;

            Keyer := Keyer + 1;
            vCheckFirst:=oSheet.Cells[Keyer,1];
            vCheckSecond :=oSheet.Cells[Keyer,3];

            ADODataSet1.Close;
          end; // if vKeyer_ID > ''
          //frmExtractionINDEXING.Cursor := crDefault;
        end;
        if Keyer > 65000 then vCheckFirst := 'Report Totals';
    end;
    ADOTable1.Close;
    ADOTable1.Active := FALSE;
    oWB := '';
    oSheet := '';
    oXL.Quit;
    Process_Log;
    Edit2.Text := 'Processing Complete!!!';
    //frmExtractionINDEXING.Cursor := crDefault;

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionINDEXING.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmExtractionINDEXING.Button3Click(Sender: TObject);
begin
  frmExtractionINDEXING.Close;
end;

procedure TfrmExtractionINDEXING.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionINDEXING.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - INDEXING' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionINDEXING.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionINDEXING.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
