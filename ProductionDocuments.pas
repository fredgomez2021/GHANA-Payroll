unit ProductionDocuments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, DB, ADODB, CommonModule, DateUtils,
  ShellAPI;

type
  TfrmProductionDocuments = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    lblTotalDocs: TLabel;
    Label3: TLabel;
    lblRecords: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtDate1: TDateTimePicker;
    dtDate2: TDateTimePicker;
    GroupBox4: TGroupBox;
    dGridProduction: TDBGrid;
    btnViewDocuments: TButton;
    dSourceProd: TDataSource;
    ADOProd: TADOConnection;
    dsProd: TADODataSet;
    dsProdGrid: TADODataSet;
    procedure btnViewDocumentsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDate1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetTotals();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProductionDocuments: TfrmProductionDocuments;

  varEditEmp_Name, varEditTaskID : String;
  gUser : String;
  gUser_ID : Integer;
  vEmpID : String;
  vID : String;

  varName : String;
  varPosition : String;

  varDateFrom : string;
  varDateTo : String;
  
implementation

{$R *.dfm}

procedure TfrmProductionDocuments.FormCreate(Sender: TObject);
begin
  ADOProd.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOProd.Connected := TRUE;
end;

procedure TfrmProductionDocuments.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  With dsProd do
  begin
    Close;
    CommandText := 'SELECT * FROM vwUsers WHERE UserName=' + chr(39) + gUser + chr(39);
    Open;
    if RecordCount = 1 then begin
      varName := FieldByName('Employee_Name').AsString;
      varPosition := FieldByName('Job_Position_Code').AsString;
      end
    else begin
      ShowMessage('Multiple user found for this username [' + gUser + ']');
      //Halt(0);
      end;
    Close;
  end;

  lblTotalDocs.Caption := '0';
  lblRecords.Caption := '0';

  dtDate1.Date := Date();
  dtDate2.Date := Date();
end;

procedure TfrmProductionDocuments.dtDate1Change(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
  DecodeDate(dtDate1.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(dtDate1.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
  dtDate2.Date := dt;
  dtDate2.Refresh;
end;

procedure TfrmProductionDocuments.GetTotals();
var
  vDocs, vRecords : Extended;
  sqlStr : string;
begin
//label totals
  vDocs := 0;
  vRecords := 0;

  sqlStr := 'SELECT ISNULL(SUM(docs),0) AS tDocs, COUNT(*) AS tRecords ' +
    'FROM dtaProduction ' +
    'WHERE tran_date BETWEEN ''' + varDateFrom + ''' AND ''' + varDateTo + '''';

  dsProd.Close;
  dsProd.CommandText := sqlStr;
  dsProd.Open;

  if (dsProd.RecordCount > 0) then
  begin
    vDocs := dsProd.FieldByName('tDocs').Value;
    vRecords := dsProdGrid.RecordCount;
  end;

  lblTotalDocs.Caption := FloatToStrF(vDocs, ffNumber, 12, 0);
  lblRecords.Caption := FloatToStrF(vRecords, ffNumber, 12, 0) + ' record(s)';

end;

procedure TfrmProductionDocuments.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmProductionDocuments.btnViewDocumentsClick(Sender: TObject);
var
  sqlStr : string;
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';
//  varDateTo := DateToStr(dtDate2.Date);
//  varDateTo := DateToStr(IncDay(StrtoDate(varDateTo), 1)) + ' 11:59:59 AM';

  sqlStr := 'SELECT b.task_description, a.task_id, SUM(a.docs) as tDocs ' +
    'FROM dtaProduction a LEFT OUTER JOIN dtaTaskRemarks b ' +
    'ON a.task_id = b.task_id ' +
    'WHERE a.tran_date BETWEEN ''' + varDateFrom + ''' AND ''' + varDateTo +
    ''' AND (LEN(a.task_id) > 1 AND a.task_id IS NOT NULL) ' +
    'GROUP BY b.task_description, a.task_id ' +
    'ORDER BY b.task_description';


  dsProdGrid.Close;
  dsProdGrid.CommandText := sqlStr;
  dsProdGrid.Open;

  dSourceProd.DataSet := dsProdGrid;
  dGridProduction.DataSource := dSourceProd;
  dGridProduction.Refresh;

  GetTotals();

end;

end.
