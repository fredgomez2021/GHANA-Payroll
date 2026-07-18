unit ExtractedDayOffList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, DB, ADODB, CommonModule, ExtCtrls;

type
  TfrmExtractedDayOff = class(TForm)
    GroupBox1: TGroupBox;
    btnProcess: TButton;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    lblRecords: TLabel;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    dtDate: TDateTimePicker;
    dtDate1: TDateTimePicker;
    DataSource: TDataSource;
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ADODataSet1: TADODataSet;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractedDayOff: TfrmExtractedDayOff;

implementation

{$R *.dfm}

procedure TfrmExtractedDayOff.btnProcessClick(Sender: TObject);
var
    varTranDate, varTranDate1 : String;
    varRecords :  Integer;

begin
    varTranDate := DateToStr(dtDate.Date);
    varTranDate1 := DateToStr(dtDate1.Date);

    //Close the connection first
    ADODataSet1.Close;

    ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_name, Day_off, Processed ' +
          'FROM vwDayOff ' +
          'WHERE Day_off BETWEEN ' + Chr(39) + varTranDate + Chr(39) +
          ' AND ' + Chr(39) + varTranDate1 + Chr(39) +
          ' ORDER BY Day_off, employee_name';


    //Reopen the connection
    ADODataSet1.Open;

    varRecords := 0;

    if ADODataSet1.RecordCount > 0 then
    begin
      ADODataSet1.First;
      while not ADODataSet1.Eof do
      begin
          varRecords := varRecords + 1;

          ADODataSet1.Next;
      end;

      DataSource.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource;

      lblRecords.Caption := IntToStr(varRecords);
    end
    else
      lblRecords.Caption := '0';
end;

procedure TfrmExtractedDayOff.FormCreate(Sender: TObject);
begin
  ADOConnection.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection.Connected := TRUE;
end;

procedure TfrmExtractedDayOff.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmExtractedDayOff.FormShow(Sender: TObject);
begin
  dtDate.Date := Date();
  dtDate1.Date := Date();
end;

end.
