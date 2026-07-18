// Name:  ExtractionUHRC.pas
// Description:  This window is for UHRC project use only.  It
//     extracts data (production report) from MS excel file to
//     an existing payroll database.  These data will then be used
//     for the computation of production pay for each keyer during
//     payroll processing if they are qualified to receive the pay
//     or not.  This was revised to ExtractionUHGLatest.pas.

unit ExtractionUHRC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ADODB, DB, ExtCtrls, DateUtils, CommonModule;

type
    TfrmExtractionUHRC = class(TForm)
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    ADOConn: TADOConnection;
    ADODataSet1: TADODataSet;
    ADOTable1: TADOTable;
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
  frmExtractionUHRC: TfrmExtractionUHRC;
  string1, string2 : AnsiString;
  gUser : String;
  gUser_ID : Integer;


implementation
  uses ComObj;
{$R *.dfm}

procedure TfrmExtractionUHRC.Button1Click(Sender: TObject);
var
   oXL, oWB, oSheet: Variant;
   vSQL : String;
   line : Integer;

   LoopMe : Integer;

   Received : string;
   Allocated : string;
   Due_Client : string;
   Keyer_Due : string;
   KeyerID : string;
   Batch : string;
   EstRecords : string;

begin
    if Edit1.text <> '' then
    begin
      Edit2.Text := 'start..';
      edit2.Refresh;

      //oXL.Visible := True;
      oXL := CreateOleObject('Excel.Application');

      //Workbook
      oWB := oXL.Workbooks.Open(Edit1.text);
      oSheet := oWB.ActiveSheet;
      LoopMe := 0;

      line := 10;

      While LoopMe <= 10 do
        Begin
        Allocated := osheet.Cells[line,3];

        if (Allocated = '') then
          begin
            LoopMe := LoopMe + 1;
            line := line + 1;
          end
        else
          Begin
            LoopMe := 0;
            Received := osheet.Cells[line,1];
            Allocated := osheet.Cells[line,3];
            Due_Client := osheet.Cells[line,4];
            Keyer_Due := osheet.Cells[line,5];
            KeyerID := osheet.Cells[line,6];
            Batch := osheet.Cells[line,8];
            EstRecords := osheet.Cells[line,11];

            ADODataSet1.Connection := ADOConn;
            vSQL := 'SELECT * FROM dtaProduction WHERE Extracted_Tran_Date ='+ chr(39) + Keyer_Due + chr(39)+' AND Keyer_ID='+ chr(39) + KeyerID + chr(39)+' AND BatchName='+ chr(39) + batch + chr(39)+' AND Task_ID=''UHRC'' ';
            //vSQL := 'SELECT * FROM dtauhrctable ';
            ADODataSet1.CommandText := vSQL;
            ADODataSet1.Active := True;
            Edit2.Text := KeyerID + ' : ' + Due_Client;
            edit2.Refresh;
            if ADODataSet1.RecordCount=0 then
              //Insert new data if not exist
              begin
                AdoTable1.Connection := ADOConn;
                AdoTable1.TableName := 'dtaProduction';
                AdoTable1.Active := True;
                ADOTable1.Insert;
                ADOTable1.FieldByName('Keyer_ID').Value := KeyerID;
                ADOTable1.FieldByName('Task_ID').Value := 'UHRC';
                ADOTable1.FieldByName('Extracted_Tran_Date').Value := Keyer_Due;
                ADOTable1.FieldByName('BatchName').Value := Batch;
                ADOTable1.FieldByName('Tran_Date').Value := Keyer_Due;
                ADOTable1.FieldByName('Docs').Value := EstRecords;
                ADOTable1.Post;
                ADOTable1.Close;
              end
            else
              //Update/Edit data if exist
              begin
                if (ADODataSet1.FieldByName('Time_ID').IsNull = true) then
                begin
                  vSQL := 'UPDATE dtaProduction SET Docs = '+ chr(39) + EstRecords + chr(39)+', Tran_Date= '+chr(39) + Keyer_Due + chr(39)+' WHERE Extracted_Tran_Date ='+ chr(39) + Keyer_Due + chr(39)+' AND Keyer_ID='+ chr(39) + KeyerID + chr(39)+' AND BatchName='+ chr(39) + batch + chr(39)+' AND Task_ID=''UHRC'' ';
                  ADOConn.Execute(vSQL);
                end;
              end;
            line := line + 1;
            ADODataSet1.Close
          end;
        End;
    end;
    oXL.Quit;
    Process_Log;
    Edit2.Text := 'Process Completed!!!';
end;

procedure TfrmExtractionUHRC.Button2Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  Edit1.Text := OpenDialog1.Filename;
end;

procedure TfrmExtractionUHRC.Button3Click(Sender: TObject);
begin
  frmExtractionUHRC.Close;
end;

procedure TfrmExtractionUHRC.FormCreate(Sender: TObject);
begin
  AdoConn.Close;
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := True;

  //ADODataSet1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  //ADODataSet1.CommandText := 'SELECT * FROM dtaProduction';
  //ADODataSet1.Active := True;

end;

procedure TfrmExtractionUHRC.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - UHRC' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaProduction' + chr(39) + ', ';
  SQL := SQL + chr(39) + Edit1.Text + chr(39);
  SQL := SQL + ')';
  ADOConn.Execute(SQL);
end;

procedure TfrmExtractionUHRC.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmExtractionUHRC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
