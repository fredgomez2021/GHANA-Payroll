// Name:  KeyerRemarks.pas
// Description:  This window allows you to view all keyer' IDs
//     under a selected project.

unit KeyerRemarks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, CommonModule;

type
  TfrmKeyerRemarks = class(TForm)
    GroupBox1: TGroupBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtUser: TEdit;
    txtUser_EmployeeName: TEdit;
    txtJobPosition: TEdit;
    cmbTaskID: TComboBox;
    Label5: TLabel;
    ADODataSet2: TADODataSet;
    procedure cmbTaskIDSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtKeyerIDChange(Sender: TObject);
    procedure cmdRefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyerRemarks: TfrmKeyerRemarks;
  gUser : String;
  gUser_ID : Integer;

implementation

{$R *.dfm}

procedure TfrmKeyerRemarks.Button1Click(Sender: TObject);
begin
  frmKeyerRemarks.Close;
end;

procedure TfrmKeyerRemarks.cmdRefreshClick(Sender: TObject);
begin
    ADOConnection1.Close;
    FormActivate(frmKeyerRemarks);
end;

procedure TfrmKeyerRemarks.txtKeyerIDChange(Sender: TObject);
begin

  //ShowMessage(ADODataSet1.CommandText);

  //ADODataSet1.Open;
    
  //DataSource1.DataSet := ADODataSet1;
  //DBGrid1.DataSource := DataSource1;
  //DBGrid1.Refresh;
end;

procedure TfrmKeyerRemarks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmKeyerRemarks.FormActivate(Sender: TObject);
var
  varTask : String;
begin

  // populate the current user
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  With ADODataSet2 do
  begin
    CommandText := 'SELECT * FROM vwUsers WHERE UserName=' + chr(39) + gUser + chr(39);
    Open;
    if RecordCount = 1 then begin
      txtUser.Text := gUser;
      txtUser_EmployeeName.Text := FieldByName('Employee_Name').AsString;
      txtJobPosition.Text := FieldByName('Job_Position_Code').AsString;
      end
    else begin
      ShowMessage('Multiple user found for this username [' + gUser + ']');
      //Halt(0);
      end;
    Close;
  end;
  // check the current user if supervisor or team leader
  if not ((txtJobPosition.Text='SUP') or (txtJobPosition.Text='TL')) then begin
    ShowMessage('Only Supervisor and Team-Leader is allowed..');
//    Close;
    Exit;
  end;

  //populate task id combo box with its corresponding
  cmbTaskID.Enabled := FALSE;
  With ADODataSet2 do
  begin
    CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID);
    Open;
    if RecordCount > 0 then
    begin
      First;
      While Not eof do
      begin
        cmbTaskID.AddItem(FieldByName('Task_ID').AsString, cmbTaskID);
        Next;
      end;
      cmbTaskID.Enabled := TRUE;
      cmbTaskID.ItemIndex := 0;
      cmbTaskID.Refresh;
      ADODataSet1.Close;
      ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_Name, Keyer_ID, Task_ID FROM vwKeyerRemarks WHERE Task_ID = ' + Chr(39) + cmbTaskID.Text + Chr(39) + ' ORDER BY Employee_Name';
      ADODataSet1.Open;
      DataSource1.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource1;
      DBGrid1.Refresh;
    end;
    Close;
  end;
{
      varTask := '';

      ADODataSet1.Close;
      ADODataSet1.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + Chr(39) + ActiveUserID + Chr(39);
      ADODataSet1.Active := TRUE;

      if ADODataSet1.RecordCount > 0 then
        varTask := ADODataSet1.FieldByName('Primary_Task_ID').AsString;

      ADODataSet1.Close;
      ADODataSet1.CommandText := 'SELECT Employee_PIN, Keyer_ID, Task_ID FROM dtaKeyerRemarks WHERE Task_ID = ' + Chr(39) + varTask + Chr(39) + ' ORDER BY Keyer_ID';
      ADODataSet1.Open;
      //ADODataSet1.Refresh;

      DataSource1.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource1;
      DBGrid1.Refresh;
 }
end;

procedure TfrmKeyerRemarks.FormCreate(Sender: TObject);
var
  varTask : String;
begin
      ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
      ADOConnection1.Connected := TRUE;

end;

procedure TfrmKeyerRemarks.cmbTaskIDSelect(Sender: TObject);
begin
  with ADODataSet1 do
  begin
    Close;
    CommandText := 'SELECT Employee_PIN, Employee_Name, Keyer_ID, Task_ID ' +
      'FROM vwKeyerRemarks ' +
      'WHERE task_description = ' + Chr(39) + cmbTaskID.Text + Chr(39) +
      ' ORDER BY Employee_Name';

    Open;
    DataSource1.DataSet := ADODataSet1;
    DBGrid1.DataSource := DataSource1;
    DBGrid1.Refresh;
  end;
end;

end.
