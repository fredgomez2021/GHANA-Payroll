// Name:  ExtractionARPI.pas
// Description:  This window is for ARPI project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionARPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DateUtils, StrUtils, ADODB, DB, ExtCtrls, FileCtrl, CommonModule;

type
    TfrmExtractionARPI = class(TForm)
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
  frmExtractionARPI: TfrmExtractionARPI;
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

procedure TfrmExtractionARPI.Button1Click(Sender: TObject);
  var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   Tem : String;
   vkeyer_ID : String;
   vTask : String;
   vExtracted_Date : String;
   vFormatted : String;
   vBatch : String;
   vClaims : String;
   vPulls : String;
   vKeyTime : String;
   x : integer;
   //tempp : Integer;
   SQLupdate : string;

   TimeDiff : string;
   Start_Time : string;
   vSQL : string;
   myDate: TDateTime;

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

//    Edit2.Text := 'delete dtaProduction..';
//    Edit2.Refresh;

    //  ADOConnection1.Execute('DELETE FROM dtaProduction'); //Note Not Valid Code
    // Get the starting keyer line
    Edit2.Text := 'Open dtaProduction..';
    Edit2.Refresh;

//    ADOQuery1.SQL.Add('SELECT * FROM dtaProduction');
//    ADOQuery1.Active := True;

    //Capture Keyer Data...
    repeat
        x:=0;
        repeat
            Keyer := Keyer + 1;
            //ShowMessage( oSheet.Cells[Keyer,1] );
            IF Pos('REPORT TOTALS:',UpperCase(oSheet.Cells[Keyer,5]))>0 Then x:=1;
        until ( Pos('KEYER ID:',UpperCase(oSheet.Cells[Keyer,1]))>0 ) OR (x=1);
        IF Pos('REPORT TOTALS:',UpperCase(oSheet.Cells[Keyer,5]))=0 Then
          begin
            Tem := (oSheet.Cells[Keyer,1]);
            Tem := MidStr(Tem,11,50);
            vKeyer_ID := Trimright(Tem);
            vKeyer_ID := TrimLeft(Tem);

            Keyer := Keyer + 3;
            repeat
              vTask := (oSheet.Cells[Keyer,3]);
              if vTask > '' then
              begin
                //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
                ADODATASET1.Close;
                ADODATASET1.Connection := ADOCONNECTION1;
                ADODATASET1.CommandText := 'SELECT TimeDiff, Start_Time FROM dtaTaskRemarks WHERE Task_ID = ''' + vTask + ''' ';
                ADODATASET1.Open;
                TimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
                Start_Time := ADODataSet1.FieldByName('Start_Time').AsString;

                vFormatted := (oSheet.Cells[Keyer,4]);
               //CONVERT DATE
               if (vFormatted <> '')  THEN
               BEGIN
                 vFormatted := vFormatted +  ' ' + Start_Time;
                 vExtracted_Date := vFormatted;

                 myDate := StrToDateTime(vFormatted);

                 myDate := IncMinute(myDate, StrToInt(TimeDiff));
                 vFormatted := DateTimeToStr(myDate);

               END;

                vBatch := (oSheet.Cells[Keyer,6]);
                vClaims := (oSheet.Cells[Keyer,7]);
                vPulls := (oSheet.Cells[Keyer,8]);
                vKeyTime := (oSheet.Cells[Keyer,10]);
                //Extrating Note
                Edit2.Text := 'Extracting Excel Report...' + vKeyer_ID + ' '+ vTask +' '+ vFormatted;
                Edit2.Refresh;

                ADODataSet1.Close;
                ADODATASET1.CommandText := 'SELECT * FROM dtaProduction WHERE Keyer_ID = '+ chr(39)+ vKeyer_id +chr(39) +
                  ' AND Task_ID = '+chr(39)+  vTask +chr(39)+ ' AND Tran_Date = ' + chr(39) +  vformatted + chr(39) ;
//                ShowMessage(ADODATASET1.CommandText);

                ADODATASET1.Open;
                if (ADODATASET1.RecordCount=0) then
                  begin

                    ADODATASET1.Insert;
                    //Data Temp Record to SQL ;
                      ADODATASET1.FieldByName('Keyer_ID').AsString := vkeyer_ID;
                      ADODATASET1.FieldByName('Task_ID').AsString := vTask;
                      ADODATASET1.FieldByName('Tran_Date').AsString := vFormatted;
                      ADODATASET1.FieldByName('Batches').AsString := vBatch;
                      ADODATASET1.FieldByName('Docs').AsString := vClaims;
                      ADODATASET1.FieldByName('Pulls').AsString := vPulls;
                      ADODATASET1.FieldByName('Time_Taken').AsString := vKeyTime;
                      ADODATASET1.FieldByName('Idle_Time').Value := 0;
                      ADODATASET1.FieldByName('Idle_Code').Value := '';
                      ADODATASET1.FieldByName('Extracted_Tran_Date').AsString := vExtracted_Date;

                    ADODATASET1.Post;

                  end
                else
                  begin // exist

                    if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                    begin
                      SQLUpdate := 'UPDATE dtaProduction ' +
                        'SET Batches = '+vBatch+', Docs='+vClaims+', ' +
                        '    Pulls='+vPulls+', Time_Taken='+vKeyTime + ' ' +
                        'WHERE KEYER_ID = '+ chr(39)+ vKeyer_id +chr(39)+ ' AND Task_id = '+chr(39)+  vTask +chr(39)+ ' AND Tran_Date = '+chr(39)+  vformatted+chr(39) ;
                      ADOConnection1.Execute( SQLupdate );
                    end;
                  end;
                ADODATASET1.Close;
              end; // if vTask > ''
              Keyer := Keyer + 1;
            until (trim(oSheet.Cells[Keyer,1])>'') or (Pos('REPORT TOTALS:',UpperCase(oSheet.Cells[Keyer,5]))>0);
          end;
          if Pos('REPORT TOTALS:',UpperCase(oSheet.Cells[Keyer,5]))=0 then Keyer := Keyer - 1;
    until Pos('REPORT TOTALS:',UpperCase(oSheet.Cells[Keyer,5]))>0;
    oXL.Quit;

//    ADOQuery1.Active := False;
//    ADOQuery1.Close;

    Process_Log;
    Edit2.Text := 'Processing Complete!!!';

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionARPI.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;
procedure TfrmExtractionARPI.Button3Click(Sender: TObject);
begin
  frmExtractionARPI.Close;
end;

procedure TfrmExtractionARPI.FormCreate(Sender: TObject);
begin
  label2.Caption := TimeToStr(Time());
  label3.Caption := FormatDateTime('dddd d of mmmm yyyy', Date);

  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionARPI.Timer1Timer(Sender: TObject);
begin
  label2.Caption := TimeToStr(Time());
end;

procedure TfrmExtractionARPI.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - ARPI' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionARPI.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionARPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.


