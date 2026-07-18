unit ExtractionDayOff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ADODB, DB, ExtCtrls, DateUtils, CommonModule;

type
  TfrmDayOffExtraction = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnExtract: TButton;
    txtFile: TEdit;
    btnOpen: TButton;
    txtProgress: TEdit;
    OpenDialog1: TOpenDialog;
    ADOConn: TADOConnection;
    dsDayOff: TADODataSet;

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
  frmDayOffExtraction: TfrmDayOffExtraction;
  string1, string2 : AnsiString;

  gUser : String;
  gUser_ID : Integer;

implementation
  uses ComObj;
{$R *.dfm}


procedure TfrmDayOffExtraction.btnExtractClick(Sender: TObject);
var
   oXL, oWB, oSheet: Variant;
   vSQL : String;
   line : Integer;

   tValue, tPeriod : string;
   dayoff_date : string;
   PIN : string;

begin
    if txtFile.Text <> '' Then
    begin
      txtProgress.Text := 'start..';
      txtProgress.Refresh;

      //oXL.Visible := True;
      oXL := CreateOleObject('Excel.Application');

      //Workbook
      oWB := oXL.Workbooks.Open(txtFile.text);
      oSheet := oWB.ActiveSheet;

      line := 1;

      tValue := oSheet.Cells[line,1];

      if tValue = 'LIST OF DAY-OFF' then
      begin
        //proceed to the first row
        line := line + 1;
        tPeriod := oSheet.Cells[line,2];

        line := 7;

        vSQL := 'DELETE FROM dtaDayOff WHERE day_off >= ''' + tPeriod + ''' AND Processed <> ''Y''';
        ADOConn.Execute(vSQL);

        repeat

          dayoff_date := oSheet.Cells[line, 3];
          PIN := oSheet.Cells[line, 1];

          dsDayOff.Close;
          dsDayOff.Connection := ADOConn;
          dsDayOff.CommandText := 'SELECT * FROM dtaDayOff WHERE Day_off = ''' + dayoff_date +
            ''' AND Employee_PIN = ''' + PIN + '''';
          dsDayOff.Open;

          if dsDayOff.RecordCount = 0 then
          begin
            vSQL := 'INSERT INTO dtaDayOff (Employee_PIN, Day_off) ' +
              'VALUES (''' + PIN + ''',''' + dayoff_date + ''')';
            ADOConn.Execute(vSQL);
          end;

          line := line + 1;
          tValue := oSheet.Cells[line, 1];

          txtProgress.Text := PIN + ' - ' + dayoff_date;
          txtProgress.Refresh;

        until (tValue = '');

        Process_Log;
        txtProgress.Text := 'Extraction of day-off values is complete!';

      end
      else
      begin

        ShowMessage('Invalid list of day-off file, choose another ...');

        txtProgress.Text := 'Invalid file ...';
      end;


      oXL.Quit;
    end;
end;

procedure TfrmDayOffExtraction.btnOpenClick(Sender: TObject);
begin
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  txtFile.Text := OpenDialog1.Filename;
end;

procedure TfrmDayOffExtraction.Button3Click(Sender: TObject);
begin
  frmDayOffExtraction.Close;
end;

procedure TfrmDayOffExtraction.FormCreate(Sender: TObject);
begin
  AdoConn.Close;
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := True;
end;

procedure TfrmDayOffExtraction.Process_Log;
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
  SQL := SQL + chr(39) + 'Extraction - Day-off' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Process' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaDayOff' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtFile.Text + chr(39);
  SQL := SQL + ')';
  ADOConn.Execute(SQL);
end;

procedure TfrmDayOffExtraction.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary
end;

procedure TfrmDayOffExtraction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

