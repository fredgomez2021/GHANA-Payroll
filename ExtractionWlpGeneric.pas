// Name:  ExtractionWlpGeneric.pas
// Description:  This type of extraction can be used by any project.
//     It extracts data (production report) from MS excel file with
//     standard format to an existing payroll database.  These data
//     will then be used for the computation of production pay for
//     each keyer during payroll processing if they are qualified to
//     receive the pay or not.

unit ExtractionWlpGeneric;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DateUtils, StrUtils, ADODB, DB, ExtCtrls, FileCtrl, CommonModule;

type
    TfrmExtractionWlpGeneric = class(TForm)
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOTable1: TADOTable;
    ADOCommand1: TADOCommand;
    ADODataSet1: TADODataSet;
    ADOQuery2: TADOQuery;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
  frmExtractionWlpGeneric: TfrmExtractionWlpGeneric;
  string1, string2 : AnsiString;
  connString: String;
  sqlserver: String;
  sqldatabase: String;
  sqluser: String;
  sqlpwd: String;
  gUser : String;
  gUser_ID : Integer;
implementation

uses ComObj;

{$R *.dfm}

procedure TfrmExtractionWlpGeneric.Button1Click(Sender: TObject);
  var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   Tem : String;
   vkeyer_ID : String;
   vProject : String;
   vTask : String;
   vExtracted_Date : String;
   vFormatted : String;
   vBatch : String;
   vClaims : String;
   vOthers : String;
   vPulls : String;
   vKeyTime : String;
   vKeyStroke : String;

   x : integer;
   //tempp : Integer;
   SQLupdate : string;

   TimeDiff : string;
   Start_Time : string;
   vSQL : string;
   myDate: TDateTime;
   I: INT64;

begin
    if Edit1.Text <> '' then
    begin

    Edit2.Text := 'start..';
    edit2.Refresh;

    oXL := CreateOleObject('Excel.Application');
    //oXL.Visible := True;

    oWB := oXL.Workbooks.Open(Edit1.text);
    oSheet := oWB.ActiveSheet;

    Keyer :=  1;

    // Get the starting keyer line
    Edit2.Text := 'open dtaProduction..';
    edit2.Refresh;

    // Look for project id //
    repeat
      Keyer := Keyer + 1;
      Edit2.Text := 'Looking for Project-ID:, Reading ['+FloatToStr(Keyer)+']..';
      Edit2.Refresh;
      if Keyer > 100 then
      begin
        oXL.Quit;
        ShowMessage('Project-ID not found...');
        exit;
      end;
    until Pos('PROJECT-ID:',UpperCase(oSheet.Cells[Keyer,1]))>0;
    vProject := oSheet.Cells[Keyer,2];
    //ShowMessage(vTask);

    // Look for Keyer id //
    repeat
      Keyer := Keyer + 1;
      Edit2.Text := 'Looking for Keyer-ID, Reading ['+FloatToStr(Keyer)+']..';
      Edit2.Refresh;
      if Keyer > 100 then
      begin
        oXL.Quit;
        ShowMessage('Keyer-ID not found...');
        exit;
      end;
    until Pos('KEYER-ID',UpperCase(oSheet.Cells[Keyer,1]))>0;
    //ShowMessage(oSheet.Cells[Keyer,1]);

    ADODATASET1.Connection := ADOCONNECTION1;

    // Process data //
    vKeyer_ID := '';
    if (UpperCase(oSheet.Cells[Keyer,7]) = 'KEYSTROKES') then
    begin

    repeat

      Keyer := Keyer + 1;
      Edit2.Text := 'Processing data, Reading ['+FloatToStr(Keyer)+']..';
      Edit2.Refresh;
      if Keyer > 60000 then
      begin
        oXL.Quit;
        ShowMessage('REPORT TOTALS not found...');
        exit;
      end;
      if (UpperCase(oSheet.Cells[Keyer,1])<>'SUB-TOTALS') and
         (Length(Trim(oSheet.Cells[Keyer,1]))>0) then
          vKeyer_ID := UpperCase(oSheet.Cells[Keyer,1]);
      if (Length(Trim(oSheet.Cells[Keyer,3]))>0) and
        //(Length(Trim(oSheet.Cells[Keyer,2]))>0) and
         (Length(Trim(oSheet.Cells[Keyer,4]))>0) and
        // (Length(Trim(oSheet.Cells[Keyer,5]))>0) and
         (Length(Trim(oSheet.Cells[Keyer,6]))>0) then
      begin
          //ShowMessage(oSheet.Cells[Keyer,2]);
          //ShowMessage(oSheet.Cells[Keyer,3]);
          vTask := Trim(oSheet.Cells[Keyer,2]);
          vExtracted_Date := Trim(oSheet.Cells[Keyer,3]);
          vClaims := Trim(oSheet.Cells[Keyer,4]);
          vOthers := Trim(oSheet.Cells[Keyer,5]);
          vKeyTime := Trim(oSheet.Cells[Keyer,6]);
          vKeyStroke := Trim(oSheet.Cells[Keyer,7]);

          vFormatted := vExtracted_Date;

          //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
          ADODATASET1.CommandText := 'SELECT TimeDiff, Start_Time ' +
            'FROM dtaTaskRemarks WHERE Task_ID = ''' + vTask + '''';
          ADODATASET1.Open;
          if ADODataSet1.RecordCount > 0 then
          begin
            TimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
            Start_Time := ADODataSet1.FieldByName('Start_Time').AsString;
            vFormatted := vFormatted +  ' ' + Start_Time;
            myDate := StrToDateTime(vFormatted);
            myDate := IncMinute(myDate, StrToInt(TimeDiff));
            vFormatted := DateTimeToStr(myDate);
          end;
          ADODATASET1.Close;

          ADODATASET1.CommandText := 'SELECT * FROM dtaProduction (nolock) ' +
            'WHERE Keyer_ID = '+ chr(39)+ vKeyer_id + chr(39)+
            ' AND Task_id = '+ chr(39)+  vTask + chr(39)+
            ' AND Tran_Date = ' + chr(39) +  vformatted + chr(39) +
            ' AND Batchname = ' + chr(39) + vOthers + chr(39);
          ADODATASET1.Open;
          I := ADODATASET1.RecordCount;

          if I = 0 then
            begin
              // insert //
              vSQL := 'INSERT INTO dtaProduction ' +
                      '( Task_ID, Keyer_ID, Tran_Date, Docs, Time_Taken, Extracted_Tran_Date, Batchname, KS ) ' +
                      'VALUES ' +
                      '( ''' + vTask + ''', ''' + vKeyer_ID + ''', ''' + vFormatted + ''', ' +vClaims + ',' + vKeyTime +
                      ', ''' + vExtracted_Date + ''', ''' + vOthers + ''',''' + vKeyStroke + ''') ';

//              vSQL := 'INSERT INTO dtaProduction ' +
//                      '( Task_ID, Keyer_ID, Tran_Date, Docs, Time_Taken, Extracted_Tran_Date, Batchname) ' +
//                      'VALUES ' +
//                      '( ''' + vTask + ''', ''' + vKeyer_ID + ''', ''' + vFormatted + ''', ' +vClaims + ',' + vKeyTime +
//                      ', ''' + vExtracted_Date + ''', ''' + vOthers + ''')';

              ADOConnection1.Execute(vSQL);
            end
          else
            begin
              if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
              begin
                // update //
                vSQL := 'UPDATE dtaProduction ' +
                      'SET Docs = ' + vClaims + ' ' +
                      ', Time_Taken =' + vKeyTime + ' ' +
                      ', Time_id = null ' +
                      ', KS = ' + vKeyStroke + ' ' +
                      'WHERE Keyer_ID = ' + chr(39) + vKeyer_id + chr(39) +
                        ' AND Task_ID = '+ chr(39) +  vTask + chr(39) +
                        ' AND Tran_Date = ' + chr(39) +  vFormatted + chr(39) +
                        ' AND batchname = ' +
                      chr(39) + vOthers + chr(39);
                ADOConnection1.Execute(vSQL);
              end;
            end;
          //ShowMessage(vSQL);
          ADODATASET1.Close;
      end;
    until Pos('REPORT TOTALS',UpperCase(oSheet.Cells[Keyer,1]))>0;
    end;

    oXL.Quit;
    Process_Log;
    Edit2.Text := 'Processing Complete!!!';
    Edit2.Refresh;

  end
  else
    ShowMessage('Please select a file to extract ...');
end;

procedure TfrmExtractionWlpGeneric.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;
procedure TfrmExtractionWlpGeneric.Button3Click(Sender: TObject);
begin
  frmExtractionWlpGeneric.Close;
end;

procedure TfrmExtractionWlpGeneric.FormCreate(Sender: TObject);
begin
  label2.Caption := TimeToStr(Time());
  label3.Caption := FormatDateTime('dddd d of mmmm yyyy', Date);

  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionWlpGeneric.Timer1Timer(Sender: TObject);
begin
  label2.Caption := TimeToStr(Time());
end;

procedure TfrmExtractionWlpGeneric.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - GENERIC' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionWlpGeneric.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionWlpGeneric.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
