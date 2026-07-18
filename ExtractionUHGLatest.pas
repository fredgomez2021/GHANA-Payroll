// Name:  ExtractionUHGLatest.pas
// Description:  This window is for UHG project use only.  It
//     extracts data (production report) from MS excel file to
//     an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionUHGLatest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, StrUtils, ExtCtrls, FileCtrl, CommonModule, DateUtils;

type
  TfrmExtractionUHGLatest = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOTable1: TADOTable;
    ADOCommand1: TADOCommand;
    ADODataSet1: TADODataSet;
    ADOQuery2: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Process_Log;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractionUHGLatest: TfrmExtractionUHGLatest;
  string1, string2 : AnsiString;
  gUser : String;
  gUser_ID : Integer;

implementation
   uses ComObj;
{$R *.dfm}

procedure TfrmExtractionUHGLatest.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmExtractionUHGLatest.Button1Click(Sender: TObject);
  var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   Tem : String;
   vkeyer_ID : String;
   vTask : String;
   vExtracted_Date : String;
   vFormatted : String;
   vFormatted1 : String;

   vClaims : String;
   vBatchName : String;


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

    Keyer :=  5;

    //  ADOConnection1.Execute('DELETE FROM dtaProduction'); //Note Not Valid Code
    // Get the starting keyer line
    Edit2.Text := 'open dtaProduction..';
    edit2.Refresh;
    ADOQuery1.SQL.Add('SELECT * FROM dtaProduction');
    ADOQuery1.Active := True;

    //Capture Keyer Data...
    vFormatted := (oSheet.Cells[Keyer,1]);
    vFormatted := MidStr(vFormatted,13,9);
    vFormatted := TrimRight(vFormatted);
    vFormatted := TrimLeft(vFormatted);

    repeat
        x:=0;
        repeat
            Keyer := Keyer + 1;
            //ShowMessage( oSheet.Cells[Keyer,1] );
            IF Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))>0 Then x:=1;
        until ( Pos('KEYERID:',UpperCase(oSheet.Cells[Keyer,1]))>0 ) OR (x=1);

        IF Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))=0 Then
          begin
            Tem := (oSheet.Cells[Keyer,1]);
            Tem := MidStr(Tem,10,50);
            vKeyer_ID := Trimright(Tem);
            vKeyer_ID := TrimLeft(Tem);


            Keyer := Keyer + 4;

             repeat

                vTask := (oSheet.Cells[Keyer,1]);
                if vTask > '' then
                begin
                  //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
                  ADODATASET1.Close;
                  ADODATASET1.Connection := ADOCONNECTION1;
                  ADODATASET1.CommandText := 'SELECT TimeDiff, Start_Time FROM dtaTaskRemarks WHERE Task_ID = ''' + vTask + ''' ';
                  ADODATASET1.Open;
                  TimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
                  Start_Time := ADODataSet1.FieldByName('Start_Time').AsString;
                end; // if vTask > ''

                            //CONVERT DATE
                if (vFormatted <> '')  then
                begin
                    //vFormatted := vFormatted +  ' ' + Start_Time;
                  vExtracted_Date := vFormatted;

                  myDate := StrToDateTime(vFormatted);

                  myDate := IncMinute(myDate, StrToInt(TimeDiff));
                  vFormatted1 := DateTimeToStr(myDate);
                end;


                vClaims := (oSheet.Cells[Keyer,7]);
                vBatchName := (oSheet.Cells[Keyer,3]);

                //Extrating Note
                Edit2.Text := 'Extracting Excel Report...' + vKeyer_ID + ' '+ vTask +' '+ vFormatted1;
                Edit2.Refresh;

                ADODataSet1.Close;
                ADODATASET1.CommandText := 'SELECT * FROM dtaProduction where KEYER_ID = '+ chr(39)+ vKeyer_id +chr(39)+ ' and Task_id = '+chr(39)+  vTask +chr(39)+ ' and Tran_Date = ' + chr(39) +  vformatted + chr(39) ;
//                ShowMessage(ADODATASET1.CommandText);

                ADODATASET1.Open;
                if (ADODATASET1.RecordCount=0) then
                  begin

                    ADOQuery1.Insert;
                    //Data Temp Record to SQL ;
                      ADOQuery1.FieldByName('Keyer_ID').AsString := vKeyer_ID;
                      ADOQuery1.FieldByName('Task_ID').AsString := vTask;
                      ADOQuery1.FieldByName('Tran_Date').AsString := vFormatted1;
                      ADOQuery1.FieldByName('Docs').AsString := vClaims;
                      ADOQuery1.FieldByName('Idle_Time').Value := 0;
                      ADOQuery1.FieldByName('Idle_Code').Value := '';
                      ADOQuery1.FieldByName('BatchName').AsString := vBatchName;
                      ADOQuery1.FieldByName('Extracted_Tran_Date').AsString := vExtracted_Date;

                    ADOQuery1.Post;

                  end
                else
                  begin // exist

                    if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                    begin
                      SQLUpdate := 'UPDATE dtaProduction ' +
                        'SET Batchname = '+vBatchName+', Docs='+vClaims+' WHERE KEYER_ID = '+
                          chr(39)+ vKeyer_id +chr(39)+ ' AND Task_id = '+chr(39)+  vTask +chr(39)+
                          ' AND Tran_Date = '+chr(39)+ vFormatted1 +chr(39) ;
                      ADOConnection1.Execute( SQLupdate );
                    end;
                  end;
                ADODATASET1.Close;
              Keyer := Keyer + 1;
            until ( Pos('KEN',MidStr(UpperCase(oSheet.Cells[Keyer,1]),1,3))>0 )

        end;
        if Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))=0 then Keyer := Keyer - 1;
    until Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))>0;
    oXL.Quit;
    ADOQuery1.Active := False;
    ADOQuery1.Close;
    Process_Log;
    Edit2.Text := 'Processing Complete!!!';

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionUHGLatest.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - UHG' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionUHGLatest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmExtractionUHGLatest.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionUHGLatest.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

end.
