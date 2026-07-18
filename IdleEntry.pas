unit IdleEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CommonModule, ViewIdleTimeEntry, ComCtrls, DB, ADODB, EmployeeList;

type
  TfrmIdleEntry = class(TForm)
    ADODataSet: TADODataSet;
    ADOQuery: TADOQuery;
    ADOConn: TADOConnection;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtEmployeePIN: TEdit;
    txtEmployeeName: TEdit;
    txtPieceRate: TEdit;
    txtTaskDesc: TEdit;
    dtDate: TDateTimePicker;
    cmbKeyerID: TComboBox;
    Button3: TButton;
    txtTaskID: TEdit;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cmbIdleCode: TComboBox;
    memIdle: TMemo;
    txtIdleTime: TEdit;
    cmdSubmit: TButton;
    cmdView: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure txtEmployeePINKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure cmdSubmitClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmbIdleCodeClick(Sender: TObject);
    procedure cmbKeyerIDClick(Sender: TObject);
    procedure cmdViewClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdleEntry: TfrmIdleEntry;

implementation

{$R *.dfm}


procedure TfrmIdleEntry.cmbKeyerIDClick(Sender: TObject);
begin

    //execute a query that will display the selected task id's details based on the selected keyer id
    //ADODataSet.CommandText := 'SELECT dtaTaskRemarks.Task_ID, Task_Description, Piece_Rate' +
    //    ' FROM dtaTaskRemarks, dtaKeyerRemarks ' +
    //    ' WHERE dtaKeyerRemarks.Keyer_ID = ' + Chr(39) + cmbKeyerID.Text + Chr(39) + ' AND dtaKeyerRemarks.Task_ID = dtaTaskRemarks.Task_ID ';
    //ADODataSet.Open;
    ADODataSet.CommandText := 'SELECT * FROM vwTaskRemarks WHERE Keyer_ID =' + Chr(39) + cmbKeyerID.Text + Chr(39);
    ADODataSet.Open;

    //ShowMessage(ADODataSet.CommandText);

    //assign selected fields to corresponding text boxes
    txtTaskID.Text := ADODataSet.FieldByName('Task_ID').AsString;
    txtTaskDesc.Text := ADODataSet.FieldByName('Task_Description').AsString;
    txtPieceRate.Text := ADODataSet.FieldByName('Piece_Rate').AsString;

    //close the dataset connection
    ADODataSet.Close;

    //enable the idle time text box and idle code combo box
    txtIdleTime.Enabled := TRUE;
    cmbIdleCode.Enabled := TRUE;

    //populate the idle code combo box
    ADODataSet.CommandText := 'SELECT Idle_Code FROM dtaIdleRemarks ORDER BY Idle_Code';
    ADODataSet.Open;

    cmbIdleCode.Clear;
    While not ADODataSet.Eof do
    begin
      cmbIdleCode.AddItem(ADODataSet.FieldByName('Idle_Code').AsString, cmbIdleCode);
      ADODataSet.Next;
    end;

    ADODataSet.Close;
end;

procedure TfrmIdleEntry.cmbIdleCodeClick(Sender: TObject);
begin
    ADODataSet.CommandText := 'SELECT * FROM dtaIdleRemarks WHERE Idle_Code = ' + cmbIdleCode.Text;
    ADODataSet.Open;

    memIdle.Text := ADODataSet.FieldByName('Idle_Description').AsString;

    ADODataSet.Close;

    cmdSubmit.Enabled := TRUE;
end;

procedure TfrmIdleEntry.cmdCloseClick(Sender: TObject);
begin

    frmIdleEntry.Close;
end;

procedure TfrmIdleEntry.cmdSubmitClick(Sender: TObject);
begin

    if (txtEmployeePIN.Text <> '') AND (cmbKeyerID.Text <> '') AND (txtTaskID.Text <> '') AND (txtIdleTime.Text <> '') AND (cmbIdleCode.Text <> '') then
    begin
      ADOQuery.SQL.Add('SELECT * FROM dtaIdleValues');
      ADOQuery.Active := TRUE;

      ADOQuery.Insert;
        ADOQuery.FieldByName('Tran_Date').AsString := DateToStr(dtDate.Date);
//        ADOQuery.FieldByName('Employee_PIN').Value := txtEmployeePIN.Text;
        ADOQuery.FieldByName('Keyer_ID').Value := cmbKeyerID.Text;
        ADOQuery.FieldByName('Task_ID').AsString := txtTaskID.Text;
        ADOQuery.FieldByName('Idle_Time').Value := txtIdleTime.Text;
        ADOQuery.FieldByName('Idle_Code').AsString := cmbIdleCode.Text;
      ADOQuery.Post;

      ADOQuery.Active := False;
//      ShowMessage('Record was successfully saved!');

      if MessageDlg('Record was successfully saved!  Save another?', mtConfirmation, mbYesNo, 0) = mrYes then
      begin
        txtEmployeePIN.Clear;
        txtEmployeeName.Clear;

      end
      else
      begin
        txtEmployeePIN.Clear;
        txtEmployeeName.Clear;
        cmbKeyerID.Clear;
        txtTaskID.Clear;
        txtTaskDesc.Clear;
        txtPieceRate.Clear;

        txtIdleTime.Clear;
        cmbIdlecode.Clear;
        memIdle.Clear;

      end;
      txtEmployeePIN.SetFocus;
    end
    else
      ShowMessage('Please fill in all required fields!');


    //cmdSubmit.Enabled := FALSE;
end;


procedure TfrmIdleEntry.FormCreate(Sender: TObject);
var
  sqlserver : String;
  sqldatabase : String;
  sqluser : String;
  sqlpwd : String;
  xIni : TextFile;
  xData : String;
  xDir : String;
begin
{  xDir :=  GetCurrentDir;
  AssignFile(xIni, xDir + '\PSYSTEM.INI');
  reset(xIni);

  repeat
    readln(xIni, xData);
    if(pos('Server=',xData)>0) then sqlserver := Copy(xData,8,100);
    if(pos('User=',xData)>0) then sqluser := Copy(xData,6,100);
    if(pos('Database=',xData)>0) then sqldatabase := Copy(xData,10,100);
    if(pos('Password=',xData)>0) then sqlpwd := Copy(xData,10,100);
  until (eof(xIni));

  CloseFile(xIni);
//Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=Payroll;Data Source=RM02RT01
//  ADOConn.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+SqlUser+';Initial Catalog=' + sqlDatabase + ';Data Source='+sqlServer;
  ADOConn.ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=' + sqluser + ';Initial Catalog='+sqldatabase + ';Data Source='+sqlserver;
  ADOConn.Connected := TRUE;//    ADOConn.Connected := TRUE;
}
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;

    memIdle.Clear;
end;


procedure TfrmIdleEntry.txtEmployeePINKeyPress(Sender: TObject; var Key: Char);
var
  varEmpPIN : String;
  varLen : Integer;
  varCounter : Integer;
begin
 if Key = #13 then
 begin
    //key in the employee PIN
    //varEmpPIN := InputBox('Employee PIN', 'Enter Employee PIN', ' ');
    varEmpPIN := txtEmployeePIN.Text;

    varLen := Strlen(PChar(varEmpPIN));
    if varLen > 1 then
    begin                       
        txtEmployeePIN.Text := varEmpPIN;

        //connect to the server
       ADOConn.Connected := TRUE;

        //execute a query base on the keyed employee PIN
        ADODataSet.Close;
        ADODataSet.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + txtEmployeePIN.Text;
        ADODataSet.Open;

     if ADODataSet.RecordCount > 0 then
     begin
        varCounter := 0;
        while not ADODataSet.Eof do
        begin
          varCounter := varCounter + 1;
          ADODataSet.Next;
        end;

        if varCounter > 0 then
        begin
            //display the employee name that corresponds to the keyed employee PIN
            txtEmployeeName.Text := ADODataSet.FieldByName('Employee_Name').AsString;
            //temporarily close the data set connection
            ADODataSet.Close;



            //ADOConn.Connected := TRUE;

            cmbKeyerID.Enabled := TRUE;

            //populate the keyer id combo box
            ADODataSet.CommandText := 'SELECT Keyer_ID FROM dtaKeyerRemarks WHERE Employee_PIN = ' + txtEmployeePIN.Text;
            ADODataSet.Open;

            cmbKeyerID.Clear;
            While not ADODataSet.Eof do
            begin
              cmbKeyerID.AddItem(ADODataSet.FieldByName('Keyer_ID').AsString, cmbKeyerID);
              ADODataSet.Next;
            end;

            ADODataSet.Close;
            //cmbKeyerID.SetFocus;
        end;
    end
    else
       ShowMessage('No record found in our database!');
    end;
  end;

end;

procedure TfrmIdleEntry.Button3Click(Sender: TObject);
begin
  frmEmployeeList.Show;
end;

procedure TfrmIdleEntry.cmdViewClick(Sender: TObject);
begin
    frmViewKeyedIdleTime.Show;
end;
procedure TfrmIdleEntry.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
