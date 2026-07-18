// Name:  ExtractionBCBS.pas
// Description:  This window is for BCBS project use only.
//     It extracts data (production report) from MS excel file
//     to an existing payroll database.  These data will then be
//     used for the computation of production pay for each keyer
//     during payroll processing if they are qualified to receive
//     the pay or not.

unit ExtractionBCBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, StrUtils, ExtCtrls, CommonModule, DateUtils;

type
  TfrmExtractionBCBS = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button3: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOTable1: TADOTable;
    ADOCommand1: TADOCommand;
    ADODataSet1: TADODataSet;
    ADOQuery2: TADOQuery;
    OpenDialog1: TOpenDialog;
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
  frmExtractionBCBS: TfrmExtractionBCBS;
  sqlserver: String;
  sqldatabase: String;
  sqluser: String;
  sqlpwd: String;
  gUser : String;
  gUser_ID : Integer;

implementation
    uses ComObj;
{$R *.dfm}

procedure TfrmExtractionBCBS.Button3Click(Sender: TObject);
begin
  opendialog1.Filter:= 'Excel File(*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmExtractionBCBS.Button2Click(Sender: TObject);
begin
  frmExtractionBCBS.Close;
end;

procedure TfrmExtractionBCBS.Button1Click(Sender: TObject);
var
 oXL, oWB, oSheet: Variant;
 keyer: word;
 Tem : String;
 vKeyer_ID: String;
 vExtracted_Date : String;
 vDate: string;
 vRegular: Integer;
 vIts_HCFA: Integer;
 vFEP: Integer;
 vFEPUB:  Integer;
 vOCR:  Integer;

 vRegUB: Integer;
 vOverlayRegUB : Integer;

 vITSUB : Integer;

 VDrugs: Integer;
 vTotal: Integer;
 vTask_ID : Integer;
 vOverlay : Integer;
 vOverlayDrugs : Integer;
 vTotal_Reg : Integer;
 vTotal_UB : Integer;

 x: Integer;
 SQLupdate: String;
begin
    if Edit1.Text <> '' then
    begin

   Edit2.Text:= 'Start...';
   Edit2.refresh;

    oXL := CreateOleObject('Excel.Application');
    //oXL.Visible := True;

    //ShowMessage(Edit1.text);

    oWB := oXL.Workbooks.Open(Edit1.text);



    oSheet := oWB.ActiveSheet;

    Keyer :=  0;

  // Edit2.Text:= 'Delet Bensample...';
   //Edit2.Refresh;
   //  ADOConnection1.Execute('DELETE FROM dtaProduction'); //Note Not Valid Code
   // Get the starting keyer line

   Edit2.Text:= 'Open dtaProduction...';
   Edit2.Refresh;

//   ADOQuery1.Connection := ADOConnection1;
//   ADOQuery1.SQL.Add('Select * FROM dtaProduction');
//   ADOQuery1.Active:= True;

   // get the Date first on the second row

   repeat
      keyer := keyer + 1;
   until ( Pos('DATE',UpperCase(oSheet.Cells[Keyer,1]))>0 );
   vDate := (oSheet.Cells[Keyer,2]);
   vDate := DateToStr(IncDay(StrToDate(vDate)));
   //ShowMessage(vDate);
   keyer := keyer + 2;
    //ShowMessage(oSheet.Cells[Keyer,1]);

   if (Trim(UpperCase(oSheet.Cells[2,10])) = 'TOTAL') then
   begin
   //Capture Keyer Data...
    repeat
      vKeyer_ID:= (oSheet.Cells[Keyer,1]);
      vRegular:= (oSheet.Cells[Keyer,2]);
      vIts_HCFA:= (oSheet.Cells[Keyer,3]);
      vFEP:= (oSheet.Cells[Keyer,4]);
      VDrugs:= (oSheet.Cells[Keyer,5]);
      vITSUB := (oSheet.Cells[Keyer,6]);
      vRegUB := (oSheet.Cells[Keyer,7]);

      //added two columns FEPUB and OCR starting Sept 1 - 15, 2006
      vFEPUB := (oSheet.Cells[Keyer,8]);
      vOCR := (oSheet.Cells[Keyer,9]);

      VOverlay:= (oSheet.Cells[Keyer,11]);
      VOverlayDrugs:= (oSheet.Cells[Keyer,12]);
      vOverlayRegUB := (oSheet.Cells[Keyer,13]);

//      vTotal_Reg := vRegular + vIts_HCFA + VFEP + vITSUB + vRegUB + VOverlay + vOverlayRegUB + vFEPUB + vOCR;
      vTotal_Reg := vRegular + vIts_HCFA + VFEP + VOverlay + vOCR;
      vDrugs := VDrugs + VOverlayDrugs;
      vTotal_UB := vITSUB + vRegUB + vFEPUB + vOverlayRegUB;

      vTotal := vTotal_Reg + vDrugs + vTotal_UB;

      Edit2.Text := 'Extracting Excel Report...' + chr(39)+ vKeyer_ID + chr(39) + ' '+ inttostr(vRegular) +' '+ inttostr(vIts_HCFA) +' '+ inttostr(vFEP) +' '+inttostr(vDrugs)+' '+inttostr(vOverlay);
      Edit2.Refresh;

//     ADODATASET1.Close;
     ADODATASET1.Connection := ADOConnection1;
     ADODATASET1.CommandText := 'SELECT * FROM dtaProduction WHERE Tran_Date = '+
      chr(39)+ vDate +chr(39)+ ' and Keyer_ID = '+ chr(39) + vKeyer_id + chr(39);
     ADODATASET1.open;

//    ADODATASET1.Open;
      if (ADODATASET1.RecordCount=0) then
        begin
          if vTotal_Reg > 0 then
          begin
            ADODATASET1.Insert;
            //Insert Record to SQL for REGULAR
            ADODATASET1.FieldByName('Tran_Date').AsString := vDate;
            ADODATASET1.FieldByName('Keyer_ID').AsString := vKeyer_ID;
            ADODATASET1.FieldByName('Task_ID').AsString := 'REGULAR';
            ADODATASET1.FieldByName('Docs').Asinteger := vTotal_Reg;
            ADODATASET1.FieldByName('Time_Taken').Asinteger := 0;
            ADODATASET1.FieldByName('Pulls').Asinteger := 0;
            ADODATASET1.FieldByName('Batches').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Time').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Code').AsString := '';
            ADODATASET1.FieldByName('Extracted_Tran_Date').AsString := vDate;
            ADODATASET1.Post;
          end;

          if vDrugs > 0 then
          begin
            ADODATASET1.Insert;
            //Insert Record to SQL for DRUGS
            ADODATASET1.FieldByName('Tran_Date').AsString := vDate;
            ADODATASET1.FieldByName('Keyer_ID').AsString := vKeyer_ID;
            ADODATASET1.FieldByName('Task_ID').AsString := 'DRUGS';
            ADODATASET1.FieldByName('Docs').Asinteger := vDrugs;
            ADODATASET1.FieldByName('Time_Taken').Asinteger := 0;
            ADODATASET1.FieldByName('Pulls').Asinteger := 0;
            ADODATASET1.FieldByName('Batches').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Time').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Code').AsString := '';
            ADODATASET1.FieldByName('Extracted_Tran_Date').AsString := vDate;
            ADODATASET1.Post;
          end;

          if vTotal_UB > 0 then
          begin
            ADODATASET1.Insert;
            //Insert Record to SQL for UB
            ADODATASET1.FieldByName('Tran_Date').AsString := vDate;
            ADODATASET1.FieldByName('Keyer_ID').AsString := vKeyer_ID;
            ADODATASET1.FieldByName('Task_ID').AsString := 'UB';
            ADODATASET1.FieldByName('Docs').Asinteger := vTotal_UB;
            ADODATASET1.FieldByName('Time_Taken').Asinteger := 0;
            ADODATASET1.FieldByName('Pulls').Asinteger := 0;
            ADODATASET1.FieldByName('Batches').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Time').Asinteger := 0;
            ADODATASET1.FieldByName('Idle_Code').AsString := '';
            ADODATASET1.FieldByName('Extracted_Tran_Date').AsString := vDate;
            ADODATASET1.Post;
          end;
        end
      else
        begin // exist

          if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
          begin
            SQLUpdate := 'UPDATE dtaProduction ' +
                      ' SET Docs = '+inttostr(vTotal_Reg) +
                      ' WHERE KEYER_ID = '+ chr(39)+ vKeyer_id +chr(39)+ ' and Tran_Date = '+ chr(39)+ (vDate) +chr(39)+ ' and Task_ID = '+ chr(39) + 'REGULAR' + chr(39);

            SQLUpdate := SQLUPdate + ';UPDATE dtaProduction ' +
                      ' SET Docs = '+inttostr(vDrugs) +
                      ' WHERE KEYER_ID = '+ chr(39)+ vKeyer_id +chr(39)+ ' and Tran_Date = '+ chr(39)+ (vDate) +chr(39)+ ' and Task_ID = '+ chr(39) + 'DRUGS' + chr(39);

            SQLUpdate := SQLUPdate + ';UPDATE dtaProduction ' +
                      ' SET Docs = '+inttostr(vTotal_UB) +
                      ' WHERE KEYER_ID = '+ chr(39)+ vKeyer_id +chr(39)+ ' and Tran_Date = '+ chr(39)+ (vDate) +chr(39)+ ' and Task_ID = '+ chr(39) + 'UB' + chr(39);

            ADOConnection1.Execute( SQLupdate );
          end;
          // exit;
        end;
      ADODATASET1.Close;
      keyer:= keyer + 1;
    until Pos('TOTAL',UpperCase(oSheet.Cells[Keyer,1]))>0;

    oXL.Quit;
//    ADOQuery1.Active := False;
//    ADOQuery1.Close;
    Process_Log;
    Edit2.Text := 'Processing Complete!!!';

    end
    else
    begin
      ShowMessage('Incorrect production report format, please verify format');
    end;

  end
  else
    ShowMessage('Please select a file to extract ...');

end;

procedure TfrmExtractionBCBS.FormCreate(Sender: TObject);
begin
   ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
   ADOConnection1.Connected := TRUE;
end;

procedure TfrmExtractionBCBS.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - BCBS' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmExtractionBCBS.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionBCBS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
