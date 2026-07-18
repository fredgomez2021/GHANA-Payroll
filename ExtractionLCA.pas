// Name:  ExtractionAFLAC.pas
// Description:  This window is for AFLAC project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionLCA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, StrUtils, ExtCtrls, CommonModule;

type
  TfrmExtractionLCA = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADODataSet1: TADODataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Process_Log;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractionLCA: TfrmExtractionLCA;
  sqlserver : string;
  sqldatabase : string;
  sqluser : string;
  sqlpwd : string;
  gUser : String;
  gUser_ID : Integer;

implementation
uses comobj;
{$R *.dfm}

procedure TfrmExtractionLCA.Button3Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel File(*.xls) | *.xls';
  opendialog1.Execute;
  edit1.Text := opendialog1.FileName;
end;

procedure TfrmExtractionLCA.Button2Click(Sender: TObject);
begin
  frmExtractionLCA.close;
end;

procedure TfrmExtractionLCA.Button1Click(Sender: TObject);
var
   oxl, owb, osheet : variant;
   keyer: word;
   Tem : String;
   vKeyer_ID: String;
   vExtracted_Date : String;
   vProcessed: string;
   vTask_ID : string;
   vBatches : Integer;
   vClaims : Integer;
   vPulls : Integer;
   vMins : double;
   x: Integer;
   SQLupdate: String;
   rec_count : Integer;

   TimeDiff : string;
   Start_Time : string;
   vSQL : string;

begin
    if Edit1.Text <> '' then
    begin

   edit2.Text := 'Starting...';
   edit2.Refresh;

   oxl := CreateOleObject('Excel.Application');

   owb := oxl.workbooks.open(Edit1.Text);
   osheet := owb.ActiveSheet;

   keyer := 0;

   edit2.Text := 'Opening dtaProduction Table...';
   edit2.Refresh;

//   ADOQuery1.Connection := ADOConnection1;
//   ADOQuery1.SQL.Add('Select * From dtaProduction');
//   ADOQuery1.Active:= True;

   // Initialize pointer for PROCESSED on the 9th row

   repeat
      keyer := keyer + 1;
   until
     ( Pos('PROCESSED',UpperCase(oSheet.Cells[Keyer,1]))>0 );
      vProcessed := (oSheet.Cells[Keyer,1]);
   //ShowMessage(vProcessed);
   keyer := keyer + 3;
   //ShowMessage(oSheet.Cells[Keyer,1]);

   //Capture Keyer Production Data
   repeat
      //PROCESS START HERE

      vTask_ID := trim((oSheet.Cells[Keyer,6]));
      //GET TIMEDIFF AND STARTTIME DEPEND ON TASK ID
      ADODataSet1.Close;
      ADODataSet1.Connection := ADOConnection1;
      ADODataSet1.CommandText := 'SELECT TimeDiff, Start_Time FROM dtaTaskRemarks WHERE Task_ID = ''' + vTask_ID + '''';
//      ADODataSet1.CommandText := 'SELECT TimeDiff, Start_Time FROM dtaTaskRemarks';
      ADODataSet1.Open;

      if (ADODataSet1.RecordCount > 0) then
      begin
        TimeDiff := ADODataSet1.FieldByName('TimeDiff').AsString;
        Start_Time := ADODataSet1.FieldByName('Start_Time').AsString;
        ADODataSet1.Close;

        //CONVERT DATE
        vProcessed := (oSheet.Cells[Keyer,1]);
        if ((vProcessed <> '') and (vProcessed <> 'Total Processed') and (vProcessed <> 'Processed')) then
        begin
          vProcessed := vProcessed +  ' ' + Start_Time;
          vExtracted_Date := vProcessed;

          ADODataSet1.Close;
          ADODataSet1.Connection := ADOConnection1;

          vSQL := 'SELECT RTRIM(CONVERT(CHAR(30), DATEADD(mi, ' + TimeDiff + ', ''' + vProcessed + '''), 100 )) AS xTIME';
          ADODataSet1.CommandText := vSQL;
          ADODataSet1.Open;
          vProcessed := ADODataSet1.FieldByName('xTIME').AsString;
          ADODataSet1.Close;

          vKeyer_ID := trim((oSheet.Cells[Keyer,3]));
          vBatches := (oSheet.Cells[Keyer,8]);
          vClaims := (oSheet.Cells[Keyer,10]);
          vPulls := (oSheet.Cells[Keyer,11]);
          vMins := (oSheet.Cells[Keyer,13]);
        //end;

        //if ((vProcessed > '') and (vProcessed <> 'Total Processed') and (vProcessed <> 'Processed')) then
        //begin
        //repeat
          edit2.Text := 'Extracting LCA Report...' + chr(39)+ vProcessed + chr(39)+ ' '+ chr(39) + (vKeyer_ID) + chr(39)+' '+ chr(39) + (vTask_ID) + chr(39)+' '+
          inttostr(vBatches) +' '+inttostr(vClaims)+' '+inttostr(vPulls)+' '+ floattostr(vMins);
          edit2.Refresh;

          ADODataSet1.Connection := ADOConnection1;
          ADODataSet1.CommandText := 'SELECT * FROM dtaProduction WHERE Tran_Date = ' +
            chr(39) + (vProcessed) + chr(39) + ' AND Keyer_ID = '+ chr(39) +
            vKeyer_ID + chr(39) + ' AND Task_ID = ' + chr(39) + vTask_ID + chr(39) +
            ' AND Docs = ' + IntToStr(vClaims);
          ADODataSet1.Open;
          rec_count := rec_count+1;

          if (ADODataSet1.RecordCount = 0) then
          begin
             // Insert Records to dtaALFAC Table(No Duplicate Records Found)
            SQLUpdate := 'INSERT INTO dtaProduction ' +
              '( Tran_Date, Keyer_ID, Task_ID, Batches, Docs, Pulls, Time_Taken, Idle_Time, Idle_Code, Extracted_Tran_Date)' +
              'VALUES'
              +
              '('+ chr(39) + (vProcessed) + chr(39) + ',' + chr(39) + (vKeyer_ID) + chr(39) + ',' + chr(39) + (vTask_ID)+ chr(39)+
              ',' + inttostr(vBatches) + ',' + inttostr(vClaims) + ',' + intToStr(vPulls) + ',' + FloatToStr(vMins) + ',0,'''','''+vExtracted_Date+''')';
            ADOConnection1.Execute(SQLUpdate);
          end
          else // If there are Duplicate Records found
          begin
            if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
            begin
              SQLUpdate := 'UPDATE dtaProduction ' +
                ' SET Batches = '+ inttostr(vBatches) +', Docs = '+ inttostr(VClaims) +' , Pulls = '+ intToStr(vPulls) +' , Time_Taken = '+ FloatToStr(VMins) +
                ' WHERE Tran_Date = '+ chr(39) + (vProcessed) + chr(39) +' AND Keyer_ID = '+ chr(39) + (vKeyer_ID) + chr(39) +' AND Task_ID = '+ chr(39) + (vTask_ID)+
                chr(39) + ' AND Batches = ' + IntToStr(vBatches);
              ADOConnection1.Execute(SQLupdate);
            end;
          end;

          ADODataSet1.Close;

        end;
      end;
      keyer := keyer+1;
   until Pos('REPORT TOTALS',UpperCase(oSheet.Cells[Keyer,1]))>0;
   oXL.Quit;
//   ADOQUERY1.Close;
//   ADOQUERY1.Active := False;

   Process_Log;

   edit2.Text := 'Extraction of '+intToStr(rec_count)+ ' ' + 'LCA production records is complete!';

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionLCA.FormCreate(Sender: TObject);
begin
   ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
   ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionLCA.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - LCA' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionLCA.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionLCA.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
