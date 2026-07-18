// Name:  ViewIdleTimeEntry.pas
// Description:  This form allows you to view all idle time entries
//     during a specified date range of the current user's project.

unit ViewIdleTimeEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, DB, ADODB, CommonModule, ExtCtrls;

type
  TfrmViewKeyedIdleTime = class(TForm)
    ADOQuery: TADOQuery;
    ADODataSet1: TADODataSet;
    GroupBox1: TGroupBox;
    Button3: TButton;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection: TADOConnection;
    DataSource: TDataSource;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    lblTotalIdleTime: TLabel;
    lblNumberOfRecords: TLabel;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    dtDate: TDateTimePicker;
    dtDate1: TDateTimePicker;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewKeyedIdleTime: TfrmViewKeyedIdleTime;

implementation

{$R *.dfm}

procedure TfrmViewKeyedIdleTime.Button3Click(Sender: TObject);
var
    varTranDate, varTranDate1 : String;
    varRecords, varMinutes :  Integer;

begin
    varTranDate := DateToStr(dtDate.Date);
    varTranDate1 := DateToStr(dtDate1.Date);

    //Close the connection first
    ADODataSet1.Close;

    ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_name, Tran_date, Idle_Time, Idle_Code, Remarks ' +
          'FROM vwIdleValues ' +
          'WHERE Tran_Date BETWEEN ' + Chr(39) + varTranDate + Chr(39) +
          ' AND ' + Chr(39) + varTranDate1 + Chr(39) +
          ' ORDER BY tran_date, employee_name';


    //Reopen the connection
    ADODataSet1.Open;

    varRecords := 0;
    varMinutes := 0;

    if ADODataSet1.RecordCount > 0 then
    begin
      ADODataSet1.First;
      while not ADODataSet1.Eof do
      begin
          varRecords := varRecords + 1;
          varMinutes := varMinutes + ADODataSet1.FieldByName('Idle_Time').Value;

          ADODataSet1.Next;
      end;

      DataSource.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource;

      lblNumberOfRecords.Caption := IntToStr(varRecords);
      lblTotalIdleTime.Caption := IntToStr(varMinutes);
    end
    else
    begin
      lblNumberOfRecords.Caption := '0';
      lblTotalIdleTime.Caption := '0';
    end;
end;

procedure TfrmViewKeyedIdleTime.Button1Click(Sender: TObject);
begin
       frmViewKeyedIdleTime.Close;
end;

procedure TfrmViewKeyedIdleTime.FormCreate(Sender: TObject);
begin
  ADOConnection.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection.Connected := TRUE;
end;

procedure TfrmViewKeyedIdleTime.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewKeyedIdleTime.FormShow(Sender: TObject);
begin
  dtDate.Date := Date();
  dtDate1.Date := Date();
end;

end.
