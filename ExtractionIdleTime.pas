unit ExtractionIdleTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ADODB, DB, ExtCtrls, DateUtils, CommonModule,
  ComCtrls;

type
    TfrmIdleTimeExtraction = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnExtract: TButton;
    txtFile: TEdit;
    btnOpen: TButton;
    txtProgress: TEdit;
    OpenDialog1: TOpenDialog;
    ADOConn: TADOConnection;
    dsIdleTime: TADODataSet;
    Label2: TLabel;
    dtPeriod: TDateTimePicker;
    Label8: TLabel;
    dtTo: TDateTimePicker;
    dsPeriod: TADODataSet;
    procedure dtPeriodChange(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure Process_Log;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdleTimeExtraction: TfrmIdleTimeExtraction;
  string1, string2 : AnsiString;

  gUser : String;
  gUser_ID : Integer;


implementation
  uses ComObj;
{$R *.dfm}

procedure TfrmIdleTimeExtraction.btnExtractClick(Sender: TObject);
var
   oXL, oWB, oSheet: Variant;
   vSQL : String;
   line : Integer;

   tValue : string;
   tPeriod: string;

   tran_date : string;
   PIN : string;
   idle_code : string;
   remarks : string;
   idle_time : string;

   selPeriod : string;
   selPeriod2 : string;

begin
    if txtFile.text <> '' Then
    begin
      txtProgress.Text := 'start..';
      txtProgress.Refresh;

      selPeriod := DateToStr(dtPeriod.Date);
      selPeriod2 := DateToStr(dtTo.Date);


      vSQL := 'SELECT * ' +
        'FROM dtaLockPayPeriod ' +
        'WHERE period1 = ''' + selPeriod + '''';

      dsPeriod.Close;
      dsPeriod.Connection := ADOConn;
      dsPeriod.CommandText := vSQL;
      dsPeriod.Open;

      if dsPeriod.RecordCount = 0 then
      begin

        //oXL.Visible := True;
        oXL := CreateOleObject('Excel.Application');

        //Workbook
        oWB := oXL.Workbooks.Open(txtFile.text);
        oSheet := oWB.ActiveSheet;

        line := 1;

        tValue := oSheet.Cells[line,1];

        if tValue = 'LIST OF IDLE TIME' then
        begin

          line := line + 1;
          tPeriod := oSheet.Cells[line, 2];

          if selPeriod = tPeriod then
          begin
            //proceed to the first row
            line := 7;

            vSQL := 'DELETE FROM dtaIdleValues ' +
              'WHERE tran_date BETWEEN ''' + selPeriod +
              ''' AND ''' + selPeriod2 + '''';
            ADOConn.Execute(vSQL);

            repeat

              tran_date := oSheet.Cells[line, 1];
              PIN := oSheet.Cells[line, 2];
              idle_code := oSheet.Cells[line, 3];
              remarks := oSheet.Cells[line, 4];
              idle_time := oSheet.Cells[line, 5];

              dsIdleTime.Close;
              dsIdleTime.Connection := ADOConn;
              dsIdleTime.CommandText := 'SELECT * FROM dtaIdleValues WHERE tran_date = ''' +
                tran_date + ''' AND Employee_PIN = ''' + PIN + ''' AND idle_time = ''' + idle_time +
                ''' AND idle_code = ''' + idle_code + '''';
              dsIdleTime.Open;

              if dsIdleTime.RecordCount = 0 then
              begin
                vSQL := 'INSERT INTO dtaIdleValues (Employee_PIN, Tran_date, Idle_time, Idle_code, Remarks) ' +
                  'VALUES (''' + PIN + ''',''' + tran_date + ''',''' + idle_time + ''',''' + idle_code + ''',''' +
                  remarks + ''')';
                ADOConn.Execute(vSQL);
              end;

              line := line + 1;
              tValue := oSheet.Cells[line, 1];

              txtProgress.Text := PIN + ' - ' + tran_date;
              txtProgress.Refresh;

            until (tValue = '');

            Process_Log;
            txtProgress.Text := 'Extraction of idle time values is complete!';

          end
          else
          begin

            ShowMessage('Selected idle time report file does not correspond to the selected starting payroll period ...');

            dtPeriod.SetFocus;

          end

        end
        else
        begin

          ShowMessage('Invalid list of idle time file, choose another ...');

          txtProgress.Text := 'Invalid file ...';
        end;

        oXL.Quit;

      //end if of checking if period exists in dtaLockPayPeriod.
      end
      else

        ShowMessage('Selected idle time report period has been processed, select another!');

    end;
end;

procedure TfrmIdleTimeExtraction.btnOpenClick(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  txtFile.Text := OpenDialog1.Filename;
end;

procedure TfrmIdleTimeExtraction.Button3Click(Sender: TObject);
begin
  frmIdleTimeExtraction.Close;
end;

procedure TfrmIdleTimeExtraction.FormCreate(Sender: TObject);
begin
  AdoConn.Close;
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := True;
end;

procedure TfrmIdleTimeExtraction.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - Idle time' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtFile.Text + chr(39);
  SQL := SQL + ')';
  ADOConn.Execute(SQL);
end;

procedure TfrmIdleTimeExtraction.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  dtPeriod.Date := Date();
end;

procedure TfrmIdleTimeExtraction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIdleTimeExtraction.dtPeriodChange(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
  DecodeDate(dtPeriod.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(dtPeriod.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
  dtTo.Date := dt;
  dtTo.Refresh;
end;

end.
