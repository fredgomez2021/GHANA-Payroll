// Name:  ExtractionWELPOINT.pas
// Description:  This window is for WELPOINT project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionWELLPOINT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ADODB, DB, ExtCtrls, DateUtils, CommonModule;

type
  TfrmExtractionWELLPOINT = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    ADODataSet1: TADODataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Process_Log;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractionWELLPOINT: TfrmExtractionWELLPOINT;
  gUser : String;
  gUser_ID : Integer;

implementation
  uses ComObj;
{$R *.dfm}

procedure TfrmExtractionWELLPOINT.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmExtractionWELLPOINT.Button3Click(Sender: TObject);
begin
  frmExtractionWELLPOINT.Close;
end;

procedure TfrmExtractionWELLPOINT.Button1Click(Sender: TObject);
var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   dStart: TDateTime;
   dEnd: TDateTime;
   dCreateDate: String;
   vDuration: Double;
   Tem : String;
   vkeyer_ID : String;
   vSQL : String;
   vTask_ID : String;
   dummy : string;

   TimeDiff : string;

   myTimeDiff : string;
   myvSQL : string;

   myDate : TDateTime;

   vBatch, vFormatted, vTran_Date, vRecords, vKS, vMinutes : String;

begin
    if Edit1.Text <> '' then
    begin


    Edit2.Text := 'start..';
    edit2.Refresh;

    oXL := CreateOleObject('Excel.Application');

    oWB := oXL.Workbooks.Open(Edit1.text);
    oSheet := oWB.ActiveSheet;


    Edit2.Text := 'opening dtaProduction ..';
    Edit2.Refresh;

    {
    vTask_ID:=UpperCase(oSheet.Cells[2,2]);

    if vTask_ID<>'INDEXING' then
      begin
        showmessage('Not Valid format');
        exit;
      end;
      }

    Keyer :=  1;
    repeat
      Tem := UpperCase( AnsiMidStr( Trim(oSheet.Cells[Keyer,1]), 1, 7 ));
      if( Tem = 'USER ID' ) then
      begin
        vKeyer_ID := Trim( oSheet.Cells[Keyer+1,3] );
        //ShowMessage( vKeyer_ID );
        Keyer := Keyer + 3;
        repeat
          Tem := UpperCase( AnsiMidStr( Trim(oSheet.Cells[Keyer,1]), 1, 3 ));
          if( Tem = 'WLP' ) then
          begin
            //ShowMessage( oSheet.Cells[Keyer,4 ]) ;
            vBatch := Trim( oSheet.Cells[Keyer,4] );
            vFormatted := Trim( oSheet.Cells[Keyer,7] );
            vRecords := Trim( oSheet.Cells[Keyer,8] );
            vKS := Trim( oSheet.Cells[Keyer,10] );
            vMinutes := Trim( oSheet.Cells[Keyer,11] );

            vTask_ID := Trim( oSheet.Cells[Keyer,1] );

            //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
            ADODATASET1.Connection := ADOCONNECTION1;
            ADODATASET1.CommandText := 'SELECT TimeDiff, Start_Time FROM dtaTaskRemarks WHERE Task_ID = ''' + vTask_ID + ''' ';
            ADODATASET1.Open;
            myTimeDiff := '780';
            if not ADODataSet1.FieldByName('TimeDiff').IsNull then
              myTimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
            ADODataSet1.Close;

            Edit2.Text := 'Extracting Excel Report...' + IntToStr(Keyer)+'='+vKeyer_ID + '-' + vBatch;
            Edit2.Refresh;

            // recompute the date to US time
            myDate := StrToDateTime(vFormatted);
            myDate := IncMinute(myDate, StrToInt(myTimeDiff));

            // if data already exist
            // search key : TASK_ID + KEYER_ID + EXTRACTED_TRAN_DATE + BATCHNAME
            ADODataSet1.Connection := ADOConnection1;
            ADODataSet1.CommandText:='SELECT * FROM dtaProduction WHERE Task_ID='+ chr(39) + vTask_ID + chr(39)+' AND Keyer_ID='+ chr(39) + vkeyer_ID + chr(39)+' AND Extracted_Tran_Date = '+chr(39)+  vFormatted + chr(39) + ' AND Batchname = '''+vBatch+'''';
            ADODataSet1.Open;
            if ((ADODataSet1.RecordCount=0) and (StrToInt(vRecords)>0)) then
              begin
                // if not exist then insert
                  vSQL:='INSERT INTO dtaProduction (Keyer_ID,Tran_Date,Task_ID,Time_Taken,Docs,Extracted_Tran_Date,Batchname,KS) VALUES (' +
                    ''''+vKeyer_ID+''','+               // Keyer_ID
                    ''''+DateTimeToStr(myDate)+''','+   // Tran_Date
                    ''''+vTask_ID+''','+                // Task_ID
                    vMinutes+','+                       // Time_Taken
                    vRecords+','+                       // Docs
                    ''''+vFormatted+''','+              // Extracted_Tran_Date;
                    ''''+vBatch+''','+                  // Batchname
                    vKS + ')';                          // Keystroke
//                  ShowMessage(vSQL);
                  ADOConnection1.Execute(vSQL);
              end
            else
              begin
                  if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                  begin
                    // if exist then update
                    vSQL:='UPDATE dtaProduction SET Time_Taken='+ vMinutes +
                      ', Docs='+ vRecords +
                      ', KS='+ vKS +
                      ' WHERE Task_ID='+ chr(39) + vTask_ID + chr(39)+
                      ' AND Keyer_ID='+ chr(39) + vkeyer_ID + chr(39)+
                      ' AND Extracted_Tran_Date = '+chr(39)+  vFormatted + chr(39) +
                      ' AND BATCHNAME = '''+vBatch+'''';
//                  ShowMessage(vSQL);
                    ADOConnection1.Execute(vSQL);
                  end;
              end;
            ADODataSet1.Close;
          end; // if( Tem = 'WLP' ) then
          Keyer := Keyer + 1;
          Tem := UpperCase( AnsiMidStr( Trim(oSheet.Cells[Keyer,8]), 1, 9 ));
        until ( Tem = 'TOTAL FOR' );
      end;
      Keyer := Keyer + 1;
      Tem := UpperCase( AnsiMidStr( Trim(oSheet.Cells[Keyer,11]), 1, 4 ));
    until ( Tem = 'PAGE' );
    //frmExtractionWELLPOINT.Cursor := crDefault;
{
    ADOTable1.Close;
    ADOTable1.Active := FALSE;
}
    oWB := '';
    oSheet := '';
    oXL.Quit;
    Process_Log;
    Edit2.Text := 'Processing Complete!!!';
    //frmExtractionWELLPOINT.Cursor := crDefault;

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionWELLPOINT.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionWELLPOINT.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - WELLPOINT' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionWELLPOINT.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionWELLPOINT.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.


{
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
          frmExtractionWELLPOINT.Cursor := crHourGlass;

          vTask_ID := '';
          if (AnsiMidStr(vCheckSecond,5,1) = 'H') then vTask_ID := 'INDEXING HICFA';
          if (AnsiMidStr(vCheckSecond,5,1) = 'U') then vTask_ID := 'INDEXING UB';
          if (AnsiMidStr(vCheckSecond,5,1) = 'O') then vTask_ID := 'INDEXING OTHER';

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

          myDate := IncMinute(myDate, StrToInt(myTimeDiff));

          dStart:=oSheet.Cells[Keyer,5];
          dEnd:=oSheet.Cells[Keyer,7];
          vDuration:=MinuteSpan(dStart,dEnd);
          Tem := (oSheet.Cells[Keyer,8]);
          vKeyer_ID := uppercase(Trimright(TrimLeft(Tem)));
          vDocCount := (oSheet.Cells[Keyer,10]);

          Keyer := Keyer + 1;
          vCheckFirst:=oSheet.Cells[Keyer,1];
          vCheckSecond :=oSheet.Cells[Keyer,3];

          //Edit2.Text := IntToStr(Keyer) + ' Extracting Excel Report...' + vKeyer_ID + '-' + dCreateDate;
          Edit2.Text := 'Extracting Excel Report...' + vKeyer_ID + '-' + dCreateDate;
          Edit2.Refresh;

          if vKeyer_ID > '' then
          begin
            ADOTable1.Connection:= ADOConnection1;
            ADOTable1.Open;
            ADODataSet1.Connection := ADOConnection1;
            ADODataSet1.CommandText:='SELECT * FROM dtaProduction WHERE Task_ID='+ chr(39) + vTask_ID + chr(39)+' AND Keyer_ID='+ chr(39) + vkeyer_ID + chr(39)+' AND Extracted_Tran_Date = '+chr(39)+  dCreateDate + chr(39);
            ADODataSet1.Open;
            if ((ADODataSet1.RecordCount=0) and (StrToInt(vDocCount)>0)) then
              begin
                vSQL:='INSERT INTO dtaProduction (Keyer_ID,Tran_Date,Task_ID,Time_Taken,Docs,Idle_Time,Idle_Code,Batches,Pulls,Extracted_Tran_Date) VALUES (' +
                ''''+vKeyer_ID+''','+
                ''''+DateTimeToStr(myDate)+''','+
                ''''+vTask_ID+''','+
                FloatToStr(vDuration)+','+
                vDocCount+','+
                '0,0,0,0,'+
                ''''+dCreateDate+''')';
                //ShowMessage(vSQL);
                ADOConnection1.Execute(vSQL);
              end
            else
              begin
                vSQL:='UPDATE dtaProduction SET Time_Taken='+ FloatToStr(vDuration) +', Docs='+ chr(39) + vDocCount + chr(39) +' WHERE Task_ID='+ chr(39) + vTask_ID + chr(39)+' AND Keyer_ID='+ chr(39) + vkeyer_ID + chr(39)+' AND Extracted_Tran_Date = '+chr(39)+  dCreateDate + chr(39);
                ADOConnection1.Execute(vSQL);
              end;
            ADODataSet1.Close;
          end; // if vKeyer_ID > ''
}
