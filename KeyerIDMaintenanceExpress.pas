unit KeyerIDMaintenanceExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids;

type
  TfrmKeyerIDMaintenanceExpress = class(TForm)
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    txtPIN: TEdit;
    txtKeyerID: TEdit;
    Label1: TLabel;
    cmbName: TComboBox;
    cmbProject: TComboBox;
    Label2: TLabel;
    dsEmployees: TADODataSet;
    ADOConn: TADOConnection;
    cmdInsert: TButton;
    dsProjects: TADODataSet;
    dsTask: TADODataSet;
    dsTask1: TADODataSet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    gridKeyerID: TDBGrid;
    lblRecords: TLabel;
    dSourceKeyerID: TDataSource;
    dsKeyerList: TADODataSet;
    Label4: TLabel;
    Label5: TLabel;
    dsKeyerList1: TADODataSet;
    procedure FormShow(Sender: TObject);
    procedure cmbProjectClick(Sender: TObject);
    procedure cmdInsertClick(Sender: TObject);
    procedure cmbNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure loadEmployeeNames;
    procedure loadProjects;
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyerIDMaintenanceExpress: TfrmKeyerIDMaintenanceExpress;
  varSql : String;

implementation

uses CommonModule;

{$R *.dfm}

procedure TfrmKeyerIDMaintenanceExpress.FormCreate(Sender: TObject);
begin
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;
end;

procedure TfrmKeyerIDMaintenanceExpress.loadEmployeeNames;
begin
  //code here
  cmbName.Clear;

  varSql := 'SELECT Employee_Name ' +
    'FROM dtaEmployees ' +
    'WHERE Emp_Status IN (''ACTIVE'',''MATERNITY LEAVE'') ' +
    'ORDER BY Employee_Name';

  dsEmployees.Close;
  dsEmployees.CommandText := varSql;
  dsEmployees.Open;

  if dsEmployees.RecordCount > 0 then
  begin
    while not dsEmployees.eof do
    begin
      cmbName.Items.Add(dsEmployees.FieldByName('Employee_Name').AsString);
      dsEmployees.Next;
    end;
  end;

  dsEmployees.Close;

end;

procedure TfrmKeyerIDMaintenanceExpress.loadProjects;
begin

  cmbProject.Clear;

  varSql := 'SELECT DISTINCT Task_Description ' +
    'FROM dtaTaskRemarks (nolock) ' +
    'WHERE Project_Status = 1 ' +
    'ORDER BY Task_Description';

  dsProjects.Close;
  dsProjects.CommandText := varSql;
  dsProjects.Open;

  if dsProjects.RecordCount > 0 then
  begin
    while not dsProjects.eof do
    begin
      cmbProject.Items.Add(dsProjects.FieldByName('Task_Description').AsString);
      dsProjects.Next;
    end;
  end;

  dsProjects.Close;

end;
procedure TfrmKeyerIDMaintenanceExpress.cmbNameClick(Sender: TObject);
begin
  varSql := 'SELECT Employee_PIN ' +
    'FROM dtaEmployees ' +
    'WHERE Employee_Name = ''' + cmbName.Text +
    ''' AND emp_status in (''ACTIVE'', ''MATERNITY LEAVE'')';

  dsEmployees.Close;
  dsEmployees.CommandText := varSql;
  dsEmployees.Open;

  if dsEmployees.RecordCount > 0 then
    txtPIN.Text := dsEmployees.FieldByName('Employee_PIN').AsString;

  dsEmployees.Close;
end;

procedure TfrmKeyerIDMaintenanceExpress.cmdInsertClick(Sender: TObject);
var
  sPIN : String;
  sKeyerID : String;
  sProject : String;

  sTaskID : String;

begin
  if (txtPIN.Text <> '') and (txtKeyerID.Text <> '') then
  begin

    sProject := cmbProject.Text;
    sPIN := txtPIN.Text;
    sKeyerID := txtKeyerID.Text;

    varSql := 'SELECT * FROM dtaKeyerRemarks (nolock) ' +
      'WHERE Employee_Pin <> ' + sPIN +
      ' AND Keyer_ID = ''' + sKeyerID + '''';

    dsKeyerList1.Close;
    dsKeyerList1.CommandText := varSql;
    dsKeyerList1.Open;

    if dsKeyerList1.RecordCount = 0 then
    begin

        varSql := 'SELECT * FROM dtaTaskRemarks (nolock) ' +
          'WHERE Task_Description = ''' + sProject +
          ''' AND Project_Status = 1 ' +
          'ORDER BY Task_ID';

        dsTask.Close;
        dsTask.CommandText := varSql;
        dsTask.Open;

        if dsTask.RecordCount > 0 then
        begin
          while not dsTask.Eof do
          begin
            sTaskID := dsTask.FieldByName('Task_ID').AsString;

            varSql := 'SELECT * FROM dtaKeyerRemarks (nolock) ' +
              'WHERE Employee_PIN = ' + sPIN +
              ' AND Keyer_ID = ''' + sKeyerID +
              ''' AND Task_ID = ''' + sTaskID + '''';

            dsTask1.Close;
            dsTask1.CommandText := varSql;
            dsTask1.Open;

            if dsTask1.RecordCount = 0 then
            begin
              with dsTask1 do
              begin
                dsKeyerList1.Insert;

                dsKeyerList1.FieldByName('Employee_PIN').AsString := sPIN;
                dsKeyerList1.FieldByName('Keyer_ID').AsString := UpperCase(sKeyerID);
                dsKeyerList1.FieldByName('Task_ID').AsString := sTaskID;

                dsKeyerList1.Post;
              end;
            end;

            dsTask.Next;
          end;

          cmdInsert.Enabled := False;
          txtKeyerID.Clear;

          ShowMessage('Keyer ID has been added to all Task types of ' + cmbProject.Text + ' project');

          cmbProjectClick(cmbProject);
        end;

      end
      else
        ShowMessage('Keyer ID is already assigned to another employee, type another!');

  end
  else
    ShowMessage('Please make sure to fill out PIN and Keyer ID for this employee!');

end;

procedure TfrmKeyerIDMaintenanceExpress.cmbProjectClick(Sender: TObject);
var
  sPIN : String;
begin
  sPIN := txtPIN.Text;

  varSql := 'SELECT lTrim(Task_ID) as [Task_ID], lTrim(Keyer_ID) as [Keyer_ID] ' +
    'FROM vwKeyerRemarks (nolock) ' +
    'WHERE Employee_PIN = ''' + sPIN +
    ''' AND Task_Description = ''' + cmbProject.Text +
    ''' ORDER BY Task_ID';

  dsKeyerList.Close;
  dsKeyerList.CommandText := varSql;
  dsKeyerList.Open;

  dSourceKeyerID.DataSet := dsKeyerList;
  gridKeyerID.DataSource := dSourceKeyerID;
  gridKeyerID.Refresh;

  lblRecords.Caption := IntToStr(dsKeyerList.RecordCount) + ' record(s)';

  cmdInsert.Enabled := True;
end;

procedure TfrmKeyerIDMaintenanceExpress.FormShow(Sender: TObject);
begin
  loadEmployeeNames;
  loadProjects;
end;

end.
