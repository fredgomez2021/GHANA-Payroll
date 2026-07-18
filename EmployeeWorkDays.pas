unit EmployeeWorkDays;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, ADODB, CommonModule, DateUtils, Grids,
  DBGrids;

type
  TfrmEmployeeWorkDays = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    dtPickerFrom: TDateTimePicker;
    dtPickerTo: TDateTimePicker;
    ADODays: TADOConnection;
    dsDays: TADODataSet;
    dsEmployees: TADODataSet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    cboEmployeeName: TComboBox;
    Label2: TLabel;
    txtNumDays: TEdit;
    btnSaveEntry: TButton;
    GroupBox3: TGroupBox;
    lblRecords: TLabel;
    dbGridDetails: TDBGrid;
    btnRefresh: TButton;
    btnDelete: TButton;
    sourceDays: TDataSource;
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dbGridDetailsCellClick(Column: TColumn);
    procedure txtNumDaysChange(Sender: TObject);
    procedure btnSaveEntryClick(Sender: TObject);
    procedure cboEmployeeNameChange(Sender: TObject);
    procedure dtPickerFromChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure LoadEmployees();
    procedure LoadEmployeeDetails();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmployeeWorkDays: TfrmEmployeeWorkDays;

  varDaysID : Integer;
implementation

{$R *.dfm}

procedure TfrmEmployeeWorkDays.FormShow(Sender: TObject);
begin
  dtPickerFrom.Date := Date();
  dtPickerTo.Date := Date();

  LoadEmployees();
end;

procedure TfrmEmployeeWorkDays.FormCreate(Sender: TObject);
begin
   ADODays.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
   ADODays.Connected := TRUE;
end;

procedure TfrmEmployeeWorkDays.LoadEmployees();
begin
  dsEmployees.Close;
  dsEmployees.CommandText := 'SELECT Employee_Name FROM dtaEmployees WHERE Emp_Status = ''ACTIVE''' +
    ' AND Job_Position_Code <> ''KEYER'' AND Job_Position_Code <> ''QA'' AND Job_Position_Code <> ''PRES''' +
    ' AND Job_Position_Code <> ''VP'' AND Job_Position_Code <> ''ISM'' AND Job_Position_Code <> ''CHF ACT'' ORDER BY Employee_Name';
  dsEmployees.Open;

  cboEmployeeName.Clear;
  if dsEmployees.RecordCount > 0 then
  begin
    dsEmployees.First;
    while not dsEmployees.eof do
    begin
      cboEmployeeName.AddItem(dsEmployees.FieldByName('Employee_Name').AsString, cboEmployeeName);

      dsEmployees.  Next;
    end;
  end;
end;

procedure TfrmEmployeeWorkDays.dtPickerFromChange(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
  DecodeDate(dtPickerFrom.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(dtPickerFrom.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
  dtPickerTo.Date := dt;
  dtPickerTo.Refresh;

  LoadEmployeeDetails();

  cboEmployeeName.Enabled := true;

end;

procedure TfrmEmployeeWorkDays.LoadEmployeeDetails();
var
  payFrom : String;
begin
  //get employee pin
//  dsEmployees.Close;
//  dsEmployees.CommandText := 'SELECT employee_pin FROM dtaEmployees WHERE employee_name = ''' +
//    cboEmployeeName.Text + '''';
//  dsEmployees.Open;

//  if dsEmployees.RecordCount > 0 then
//  begin

    payFrom := DateToStr(dtPickerFrom.Date);

    dsDays.Close;
    dsDays.CommandText := 'SELECT a.id, a.employee_pin, b.employee_name, a.num_days' +
      ' FROM dtaNumWorkingDays a LEFT OUTER JOIN dtaEmployees b ON a.employee_pin = b.employee_pin' +
      ' WHERE a.period1 = ''' + payFrom + ''' ORDER BY b.employee_name';
    dsDays.Open;


    lblRecords.Caption := IntToStr(dsDays.RecordCount) + ' record(s)';

    sourceDays.DataSet := dsDays;
    dbGridDetails.DataSource := sourceDays;
    dbGridDetails.Refresh;

    dbGridDetails.Columns[0].Visible := false;
    dbGridDetails.Columns[1].Width := 80;
    dbGridDetails.Columns[2].Width := 150;
    dbGridDetails.Columns[3].Width := 60;
//  end;
end;


procedure TfrmEmployeeWorkDays.cboEmployeeNameChange(Sender: TObject);
begin
  txtNumDays.Enabled := true;
  txtNumDays.SetFocus;
end;

procedure TfrmEmployeeWorkDays.btnSaveEntryClick(Sender: TObject);
var
  varStr : String;
  payFrom : String;
begin
  if ((cboEmployeeName.Text <> '') AND (txtNumDays.Text <> '')) then
  begin
  //get employee pin
    dsEmployees.Close;
    dsEmployees.CommandText := 'SELECT employee_pin FROM dtaEmployees WHERE employee_name = ''' +
      cboEmployeeName.Text + '''';
    dsEmployees.Open;

    if dsEmployees.RecordCount > 0 then
    begin

      payFrom := DateToStr(dtPickerFrom.Date);

      dsDays.Close;
      dsDays.CommandText := 'SELECT * FROM dtaNumWorkingDays WHERE period1 = ''' + payFrom +
        ''' AND employee_pin = ''' + dsEmployees.FieldByName('employee_pin').AsString + '''';
      dsDays.Open;

      if dsDays.RecordCount > 0 then
      begin
        ShowMessage('Days of work entry already exists for this employee on the selected period, try another!');

        cboEmployeeName.SetFocus;

      end
      else
      begin
        varStr := 'INSERT INTO dtaNumWorkingDays (period1, employee_pin, num_days) VALUES (''' + payFrom +
          ''',''' + dsEmployees.FieldByName('employee_pin').AsString + ''',''' + txtNumDays.Text + ''')';

        ADODays.Execute(varStr);

        txtNumDays.Text := '0';

        LoadEmployeeDetails();

        ShowMessage('Employee days of work was successfully saved!');


      end;
    end;
  end;
end;

procedure TfrmEmployeeWorkDays.txtNumDaysChange(Sender: TObject);
begin
  if txtNumDays.Text <> '' then
    btnSaveEntry.Enabled := true
  else
    btnSaveEntry.Enabled := false;
end;

procedure TfrmEmployeeWorkDays.dbGridDetailsCellClick(Column: TColumn);
begin
  if dsDays.FieldByName('ID').IsNull = false then
  begin
    varDaysID := dsDays.FieldByName('ID').Value;

    btnDelete.Enabled := true;
  end;
end;

procedure TfrmEmployeeWorkDays.btnDeleteClick(Sender: TObject);
var
  varStr : String;
begin
  varStr := 'DELETE FROM dtaNumWorkingDays WHERE ID = ' + IntToStr(varDaysID);

  ADODays.Execute(varStr);

  LoadEmployeeDetails();

  ShowMessage('Days of work entry was successfully deleted!');

  btnDelete.Enabled := false;
end;

procedure TfrmEmployeeWorkDays.btnRefreshClick(Sender: TObject);
begin
  LoadEmployeeDetails();
end;

end.
