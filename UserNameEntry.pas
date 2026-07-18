unit UserNameEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CommonModule, DB, ADODB, StdCtrls, Grids, DBGrids;

type
  TfrmUserNameEntry = class(TForm)
    GroupBox1: TGroupBox;
    ADOUser: TADOConnection;
    DSUser: TADODataSet;
    cmbProjectName: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    label4: TLabel;
    txtSupervisor: TEdit;
    txtUsername: TEdit;
    txtPassword: TEdit;
    Button4: TButton;
    DSFillProject: TADODataSet;
    cmdSave: TButton;
    DSProject: TADODataSet;
    spEmployees: TADOStoredProc;
    ds1: TDataSource;
    Grid1: TDBGrid;
    ADOMds: TADOConnection;
    ADOLocal: TADOConnection;
    dsMds: TADODataSet;
    dsLocal: TADODataSet;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FillProjectNames();
    procedure SaveUser();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUserNameEntry: TfrmUserNameEntry;

implementation

{$R *.dfm}

procedure TfrmUserNameEntry.FormCreate(Sender: TObject);
begin
  ADOUser.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOUser.Connected := TRUE;
end;

procedure TfrmUserNameEntry.Button4Click(Sender: TObject);
begin
//  frmUserNameEntry.Close;

  spEmployees.Connection := ADOUser;
  spEmployees.ProcedureName := 'spTIME_EXTRACT';
  spEmployees.Parameters.Refresh;

  spEmployees.Parameters.ParamByName('@d1').Value := '11/1/2005 12:00:00 AM';
  spEmployees.Parameters.ParamByName('@d2').Value := '11/15/2005 12:00:00 PM';
  spEmployees.ExecProc;
  spEmployees.Active := TRUE;

  if spEmployees.RecordCount > 0 then
  begin

  end;
end;

procedure TfrmUserNameEntry.FormShow(Sender: TObject);
begin
  //FillProjectNames();
end;

procedure TfrmUserNameEntry.FillProjectNames();
var
  varBranch : String;
begin
  DSFillProject.Close;
  DSFillProject.CommandText := 'SELECT * FROM dtaProjects ORDER BY Project_Desc';
  DSFillProject.Connection := ADOUser;
  DSFillProject.Active := TRUE;

  cmbProjectName.Clear;
  if DSFillProject.RecordCount > 0 then
  begin
    DSFillProject.First;
    while not DSFillProject.Eof do
    begin
      varBranch := DSFillProject.FieldByName('Project_Desc').AsString;

      cmbProjectName.AddItem(varBranch, cmbProjectName);

      DSFillProject.Next;
    end;
  end;
end;

procedure TfrmUserNameEntry.SaveUser();
var
  varProject :  String;
begin
  DSUser.CommandText := 'SELECT * from dtaUsers WHERE UserName = ' + Chr(39) + txtUsername.Text + Chr(39) + ' AND Password = ' + Chr(39) + txtPassword.Text + Chr(39);
  DSUser.Connection := ADOUser;
  DSUser.Active := TRUE;

  if DSUser.RecordCount > 0 then
  begin
    ShowMessage('Username already exists!  Please choose another.');
  end
  else
  begin
    with DSUser do
    begin
      Insert;
        FieldByName('UserName').AsString := txtUserName.Text;
        FieldByName('Password').AsString := txtPassword.Text;
        FieldByName('Supervisor_Name').AsString := txtSupervisor.Text;

        DSProject.CommandText := 'SELECT * FROM dtaProjects WHERE Project_Desc = ' + chr(39) + cmbProjectName.Text + Chr(39);
        DSProject.Connection := ADOUser;
        DSProject.Active := TRUE;

        if DSProject.RecordCount > 0 then
        begin
          varProject := DSProject.FieldByName('Project_Code').AsString;
          FieldByName('Project_Code').AsString := varProject;
        end;

      Post;
    end;
  end;
end;

procedure TfrmUserNameEntry.cmdSaveClick(Sender: TObject);
begin
  if (cmbProjectName.Text <> '') and (txtSupervisor.Text <> '') and
    (txtUsername.Text <> '') and (txtPassword.Text <> '') then
      SaveUser()
  else
      ShowMessage('Please check input!');
end;

procedure TfrmUserNameEntry.Button1Click(Sender: TObject);
begin
  dsLocal.CommandText := 'SELECT * FROM dtaTime_Summary';
  dsLocal.Active := TRUE;

  dsMds.CommandText := 'SELECT * FROM dtaTime_Summary';
  dsMds.Open;

  if dsLocal.RecordCount > 0 then
  begin
    dsLocal.First;
    while not dsLocal.Eof do
    begin
    dsMds.Insert;
      dsMds.FieldByName('Work_Date').AsString := dsLocal.FieldByName('Work_Date').AsString;
      dsMds.FieldByName('Employee_PIN').AsString := dsLocal.FieldByName('Employee_PIN').AsString;
      dsMds.FieldByName('OT').AsString := dsLocal.FieldByName('OT').AsString;
      dsMds.FieldByName('AuthorizeOT').AsString := dsLocal.FieldByName('AuthorizeOT').AsString;
      dsMds.FieldByName('Regular_Hours').AsString := dsLocal.FieldByName('Regular_Hours').AsString;
      dsMds.FieldByName('Days_Work').AsString := dsLocal.FieldByName('Days_Work').AsString;
      dsMds.FieldByName('Actual_In').AsString := dsLocal.FieldByName('Actual_In').AsString;
      dsMds.FieldByName('Actual_Out').AsString := dsLocal.FieldByName('Actual_Out').AsString;
      dsMds.FieldByName('Employee_Name').AsString := dsLocal.FieldByName('Employee_Name').AsString;
      dsMds.FieldByName('Task_ID').AsString := dsLocal.FieldByName('Task_ID').AsString;
    dsMds.Post;

      dsLocal.Next;
    end;
  end;
end;

end.
