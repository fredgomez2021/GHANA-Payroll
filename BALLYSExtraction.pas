// Name:  BALLYSExtraction.pas
// Description:  This window is for BALLYS project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit BALLYSExtraction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, StrUtils, ExtCtrls, FileCtrl, CommonModule, DateUtils;

type
  TfrmBALLYSExtraction = class(TForm)
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
  frmBALLYSExtraction: TfrmBALLYSExtraction;
  string1, string2 : AnsiString;
  gUser : String;
  gUser_ID : Integer;

implementation
   uses ComObj;
{$R *.dfm}

procedure TfrmBALLYSExtraction.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmBALLYSExtraction.Button1Click(Sender: TObject);
  var
   oXL, oWB, oSheet: Variant;
   Keyer: Word;
   Tem : String;
   vkeyer_ID : String;
   vTask : String;
   vExtracted_Date : String;
   vFormatted : String;

   vClaims : String;
   vBatchName : String;

   x : integer;
   SQLupdate : string;

   TimeDiff : string;
   Start_Time : string;
   vSQL : string;
   myDate: TDateTime;

begin
    oXL := CreateOleObject('Excel.Application');
    //oXL.Visible := True;

    oWB := oXL.Workbooks.Open(Edit1.text);
    oSheet := oWB.ActiveSheet;

    if Pos('DOCCOUNT',UpperCase(oSheet.Cells[9,9]))>0 then
    begin
      Edit2.Text := 'start..';
      Edit2.Refresh;


      Keyer :=  2;

      //  ADOConnection1.Execute('DELETE FROM dtaProduction'); //Note Not Valid Code
      // Get the starting keyer line
      Edit2.Text := 'open dtaProduction..';
      Edit2.Refresh;

//      ADOQuery1.SQL.Add('SELECT * FROM dtaProduction');
//      ADOQuery1.Active := True;

      //Capture task ID...
      Tem := (oSheet.Cells[Keyer,1]);
      Tem := MidStr(Tem, 1, 6);
      vTask := TrimRight(Tem);
      vTask := UpperCase(TrimLeft(Tem));

      repeat
          x:=0;
          repeat
              Keyer := Keyer + 1;
              //ShowMessage( oSheet.Cells[Keyer,1] );
              if Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))>0 Then x:=1;
          until ( Pos('INDEXER',UpperCase(oSheet.Cells[Keyer,1]))>0 ) OR (x=1);

          if Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))=0 then
          begin
             Keyer := Keyer + 1;

             repeat

                vFormatted := (oSheet.Cells[Keyer,3]);

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
                  vFormatted := DateTimeToStr(myDate);
                end;

                vKeyer_ID := (oSheet.Cells[Keyer,1]);
                vBatchName := (oSheet.Cells[Keyer,5]);

                vClaims := (oSheet.Cells[Keyer,9]);

                //Extrating Note
                Edit2.Text := 'Extracting Excel Report...' + vKeyer_ID + ' '+ vTask +' '+ vFormatted;
                Edit2.Refresh;

                ADODataSet1.Close;
                ADODATASET1.CommandText := 'SELECT * FROM dtaProduction WHERE KEYER_ID = '+ chr(39)+ vKeyer_ID +chr(39)+ ' AND Task_ID = '+chr(39)+  vTask +chr(39) +
                  ' AND Tran_Date = ' + chr(39) +  vFormatted + chr(39) + ' AND BatchName = ' + Chr(39) + vBatchName + Chr(39) +
                  ' AND Docs = ' + vClaims;
//                ShowMessage(ADODATASET1.CommandText);

                ADODATASET1.Open;
                if (ADODATASET1.RecordCount=0) then
                  begin

                    ADODATASET1.Insert;
                    //Data Temp Record to SQL ;
                      ADODATASET1.FieldByName('Keyer_ID').AsString := vKeyer_ID;
                      ADODATASET1.FieldByName('Task_ID').AsString := vTask;
                      ADODATASET1.FieldByName('Tran_Date').AsString := vFormatted;
                      ADODATASET1.FieldByName('Docs').AsString := vClaims;
                      ADODATASET1.FieldByName('Idle_Time').Value := 0;
                      ADODATASET1.FieldByName('Idle_Code').Value := '';
                      ADODATASET1.FieldByName('BatchName').AsString := vBatchName;
                      ADODATASET1.FieldByName('Extracted_Tran_Date').AsString := vExtracted_Date;

                    ADODATASET1.Post;

                  end
                else
                  begin // exist

                    if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                    begin
                      SQLUpdate := 'UPDATE dtaProduction ' +
                        'SET Docs='+vClaims+' WHERE BatchName = '+chr(39)+vBatchName+chr(39)+' AND KEYER_ID = '+
                          chr(39)+ vKeyer_ID +chr(39)+ ' AND Task_id = '+chr(39)+  vTask +chr(39)+
                          ' AND Tran_Date = '+chr(39)+ vFormatted +chr(39) ;
                      ADOConnection1.Execute( SQLupdate );
                    end;
                  end;
                ADODATASET1.Close;
              Keyer := Keyer + 1;
            until ( Pos('TOTAL FOR',MidStr(UpperCase(oSheet.Cells[Keyer,1]),1,9))>0 )

        end;
        if Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))=0 then Keyer := Keyer - 1;
    until Pos('GRAND TOTAL:',UpperCase(oSheet.Cells[Keyer,1]))>0;

//    ADOQuery1.Active := False;
//    ADOQuery1.Close;

    Process_Log;
    Edit2.Text := 'Processing Complete!!!';

  end
  else
  begin
    ShowMessage('Invalid BALLYS production report format!');
  end;

  oXL.Quit;

end;

procedure TfrmBALLYSExtraction.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - BALLYS' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;


procedure TfrmBALLYSExtraction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBALLYSExtraction.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmBALLYSExtraction.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

end.
