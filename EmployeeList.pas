// Name:  EmployeeList.pas
// Description:  This is a simple form that provides you with
//     a list of employees which can be sorted by PIN or name.
//     You can also search employees by PIN or by their name which
//     can be viewed on the grid below while typing.

unit EmployeeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, CommonModule, ExtCtrls;

type
  TfrmEmployeeList = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    cmdRefresh: TButton;
    GroupBox2: TGroupBox;
    txtEmployeeName: TEdit;
    optPIN: TRadioButton;
    optName: TRadioButton;
    Shape1: TShape;
    txtEmpPIN: TEdit;
    GroupBox3: TGroupBox;
    optEmpPIN: TRadioButton;
    optEmpName: TRadioButton;
    btnSort: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSortClick(Sender: TObject);
    procedure txtEmpPINChange(Sender: TObject);
    procedure optNameClick(Sender: TObject);
    procedure optPINClick(Sender: TObject);
    procedure txtEmployeeNameChange(Sender: TObject);
    procedure cmdRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmployeeList: TfrmEmployeeList;

implementation

{$R *.dfm}

procedure TfrmEmployeeList.Button1Click(Sender: TObject);
begin
    frmEmployeeList.Close;
end;

procedure TfrmEmployeeList.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;

    ADODataSet1.Close;
    ADODataSet1.CommandText := 'SELECT employee_pin, employee_name, primary_task_id, job_position_code ' +
      'FROM dtaEmployees WHERE emp_status = ''ACTIVE'' ORDER BY Employee_Name';
    ADODataSet1.Open;

    DataSource1.DataSet := ADODataSet1;
    DBGrid1.DataSource := DataSource1;
    DBGrid1.Refresh;
end;

procedure TfrmEmployeeList.cmdRefreshClick(Sender: TObject);
begin
    ADOConnection1.Close;
    FormCreate(frmEmployeeList);
end;

procedure TfrmEmployeeList.txtEmployeeNameChange(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText := 'SELECT employee_pin, employee_name, primary_task_id, ' +
    'job_position_code FROM dtaEmployees WHERE Employee_Name LIKE ' + Chr(39) + '%' +
    txtEmployeeName.Text + '%' + Chr(39) + ' AND emp_status = ''ACTIVE''' +
    ' ORDER BY Employee_Name';

  //ShowMessage(ADODataSet1.CommandText);

  ADODataSet1.Open;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Refresh;
end;

procedure TfrmEmployeeList.optPINClick(Sender: TObject);
begin
  if optPIN.Checked = TRUE then
  begin
    txtEmpPIN.Enabled := TRUE;
    txtEmployeeName.Enabled := FALSE;
    txtEmpPIN.SetFocus;
  end;
end;

procedure TfrmEmployeeList.optNameClick(Sender: TObject);
begin
  if optName.Checked = TRUE then
  begin
    txtEmpPIN.Enabled := FALSE;
    txtEmployeeName.Enabled := TRUE;
    txtEmployeeName.SetFocus;
  end;
end;

procedure TfrmEmployeeList.txtEmpPINChange(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText := 'SELECT employee_pin, employee_name, primary_task_id, ' +
    'job_position_code FROM dtaEmployees WHERE Employee_PIN LIKE ' + Chr(39) +
    '%' + txtEmpPIN.Text + '%' + Chr(39) + ' AND emp_status = ''ACTIVE''' +
    ' ORDER BY Employee_Name';

  //ShowMessage(ADODataSet1.CommandText);

  ADODataSet1.Open;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Refresh;
end;

procedure TfrmEmployeeList.btnSortClick(Sender: TObject);
begin
  ADODataSet1.Close;

  if optEmpPIN.Checked = TRUE then
    ADODataSet1.CommandText := 'SELECT employee_pin, employee_name, primary_task_id, job_position_code FROM dtaEmployees WHERE primary_task_id <> ' + Chr(39) + 'ADMIN' + Chr(39) + ' ORDER BY Employee_PIN'
  else if optEmpName.Checked = TRUE then
    ADODataSet1.CommandText := 'SELECT employee_pin, employee_name, primary_task_id, job_position_code FROM dtaEmployees WHERE primary_task_id <> ' + Chr(39) + 'ADMIN' + Chr(39) + ' ORDER BY Employee_Name';

  ADODataSet1.Active := TRUE;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Refresh;
end;

procedure TfrmEmployeeList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
