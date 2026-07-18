// Name:  IdleEntry2.pas
// Description:  This form is used for keyer idle time entry.
//     If a keyer has been idle for a period of time, this will
//     be noted later on saved on this form.  Idle time entries
//     are included in the computation of their production pay.

unit IdleEntry2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, DB, ADODB, CommonModule,
  DateUtils, ShellAPI, ExtractionIdleTime;

type
  TfrmIdleEntry2 = class(TForm)
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtUser: TEdit;
    txtUser_EmployeeName: TEdit;
    txtJobPosition: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    cmbPrimaryTaskID: TComboBox;
    Label2: TLabel;
    dtDate: TDateTimePicker;
    DBGrid1: TDBGrid;
    cmdAdd: TButton;
    cmdEdit: TButton;
    cmdDelete: TButton;
    cmdSave: TButton;
    cmdCancel: TButton;
    GroupBox3: TGroupBox;
    cmbEmp_Name: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    txtIdleTime: TEdit;
    Label11: TLabel;
    Label5: TLabel;
    cmbIdleCode: TComboBox;
    txtRemarks: TEdit;
    Label12: TLabel;
    ADODataSet6: TADODataSet;
    ADODataSet5: TADODataSet;
    ADODataSet4: TADODataSet;
    ADODataSet3: TADODataSet;
    ADOTable1: TADOTable;
    ADODataSet1: TADODataSet;
    ADODataSet2: TADODataSet;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    lblMode: TLabel;
    txtEmp_PIN: TEdit;
    Label7: TLabel;
    btnLoadExtraction: TButton;
    dsLogFile: TADODataSet;
    procedure btnLoadExtractionClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbEmp_NameClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure dtDateChange(Sender: TObject);
    procedure cmbPrimaryTaskIDChange(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Load_Grid;
    procedure Load_IdleCode;
    procedure Load_Emp_Name;
    procedure Enable_Buttons(bEnable: Boolean; sMode: String);
    function GetNumbersOnly( InputString:String ) : String;
    procedure Add_Log;
    procedure Edit_Log;
    procedure Delete_Log;

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdleEntry2: TfrmIdleEntry2;
  varKeyer : String;
  varLen : Integer;
  varEditEmp_Name, varEditTaskID : String;

  gUser : String;
  gUser_ID : Integer;
  vEmpID : String;
  vID : String;

  sUserID : string;
  sTranDate : string;

implementation

{$R *.dfm}

procedure TfrmIdleEntry2.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmIdleEntry2.cmdExitClick(Sender: TObject);
begin
  frmIdleEntry2.Close;
end;

procedure TfrmIdleEntry2.FormActivate(Sender: TObject);
begin
  dtDate.Date := Date();

  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);

  With ADODataSet2 do
  begin
    Close;
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
  cmdSave.Enabled := FALSE;
  cmdCancel.Enabled := FALSE;
  // check the current user if supervisor or team leader
  //if not ((txtJobPosition.Text='SUP') or (txtJobPosition.Text='TL') OR (txtJobPosition.Text = 'PRODMGR')) then begin
  if not (txtJobPosition.Text = 'ADMIN ASST') then
  begin
    ShowMessage('Only Supervisor and Team-Leader is allowed..');
    //Close;
    cmdAdd.Enabled := FALSE;
    cmdEdit.Enabled := FALSE;
    cmdDelete.Enabled := FALSE;
  end;

  //populate task id combo box with its corresponding
  cmbPrimaryTaskID.Clear;
  With ADODataSet2 do
  begin
    Close;
    CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID) + ' ORDER by Task_ID';
    Open;
    if RecordCount > 0 then
    begin
      First;
      While Not eof do
      begin
        cmbPrimaryTaskID.AddItem(FieldByName('Task_ID').AsString, cmbPrimaryTaskID);
        Next;
      end;
      cmbPrimaryTaskID.ItemIndex := 0;
      cmbPrimaryTaskID.Refresh;
    end;
    Close;
  end;

  Load_Grid;

  // initialize everything
  //txtEmployeePIN.Text := '';
  //txtEmployeeNAME.Text := '';
  //txtPrimary_Task_ID.Text := '';
  //txtKeyerID.Text := '';
  //cmbTaskID.Clear;
  //txtTaskDesc.Text := '';
  //txtPieceRate.Text := '';
  //cmdAdd.Caption := '&ADD';
  //cmdEdit.Caption := '&EDIT';
  //cmdDelete.Caption := '&DELETE';
  //cmdClose.Caption := '&CLOSE';
  //cmdAdd.Enabled := true;
  //cmdEdit.Enabled := true;
  //cmdDelete.Enabled := true;
  //cmdClose.Enabled := true;

  InsertToLogFile(sTranDate, sUserID, 'Idle Time Entry', 'Load', 'dtaIdleValues', '');

end;

procedure TfrmIdleEntry2.cmdAddClick(Sender: TObject);
begin
  // Initialize
  Load_Emp_Name;
  Load_IdleCode;
  txtIdleTime.Text := '';
  txtRemarks.Text := '';
  Enable_Buttons(TRUE,'ADD');
end;

procedure TfrmIdleEntry2.Load_Grid;
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_Name, Idle_Time, Idle_Code, Remarks, ID FROM vwIdleValues WHERE Primary_Task_ID = ''' +
    cmbPrimaryTaskID.Text + ''' AND Tran_Date='''+DateToStr(dtDate.Date)+''' ORDER BY Employee_Name';
  ADODataSet1.Open;
  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Refresh;
  //frmIdleEntry2.Refresh;
end;

procedure TfrmIdleEntry2.Load_IdleCode;
begin
  //populate idle code
  cmbIdleCode.Clear;
  With ADODataSet2 do
  begin
    Close;
    CommandText := 'SELECT Code FROM dtaCodeTables WHERE Code_Category= ''Idle_Code'' ORDER BY Code';
    Open;
    if RecordCount > 0 then
    begin
      First;
      While Not eof do
      begin
        cmbIdleCode.AddItem(FieldByName('Code').AsString, cmbIdleCode);
        Next;
      end;
      cmbIdleCode.ItemIndex := 0;
      cmbIdleCode.Refresh;
    end;
    Close;
  end;
end;

procedure TfrmIdleEntry2.Load_Emp_Name;
begin
  //populate keyer_id with its corresponding task id
  cmbEmp_Name.Clear;
  With ADODataSet2 do
  begin
    Close;
    //CommandText := 'SELECT Keyer_ID FROM dtaKeyerRemarks WHERE Task_ID = '''+ cmbPrimaryTaskID.Text + ''' ORDER BY KEYER_ID';
    CommandText := 'SELECT Employee_Name, Employee_PIN FROM dtaEmployees WHERE Primary_Task_ID = ''' +
      cmbPrimaryTaskID.Text + ''' ORDER BY Employee_Name';
    Open;
    if RecordCount > 0 then
    begin
      First;
      txtemp_pin.Text := FieldByName('Employee_PIN').AsString;
      While Not eof do
      begin
        cmbEmp_Name.AddItem(FieldByName('Employee_Name').AsString, cmbEmp_Name);
        Next;
      end;
      cmbEmp_Name.ItemIndex := 0;
      cmbEmp_Name.Refresh;
    end;
    Close;
  end;
end;

procedure TfrmIdleEntry2.Enable_Buttons( bEnable: Boolean; sMode: String);
begin
  lblMode.Caption := 'Mode: ' + sMode;
  cmdAdd.Enabled := not bEnable;
  cmdEdit.Enabled := not bEnable;
  cmdDelete.Enabled := not bEnable;
  cmdSave.Enabled := bEnable;
  cmdCancel.Enabled := bEnable;

  cmbEmp_Name.Enabled := bEnable;
  txtIdleTime.Enabled := bEnable;
  cmbIdleCode.Enabled := benable;
  txtRemarks.Enabled := bEnable;

  dtDate.Enabled := not bEnable;
  cmbPrimaryTaskID.Enabled := not bEnable;
  //cmdExit.Enabled := not bEnable;

  DBGrid1.Enabled := not bEnable;
end;

procedure TfrmIdleEntry2.cmdCancelClick(Sender: TObject);
begin
  Enable_Buttons(FALSE,'');
end;

procedure TfrmIdleEntry2.cmdSaveClick(Sender: TObject);
var
  vSQL: String;
begin
  // initial field checking
  if trim(cmbEmp_Name.Text) = '' then
  begin
    ShowMessage('Specify Employee Name!');
    cmbEmp_Name.SetFocus;
    exit;
  end;
  if trim(cmbIdleCode.Text) = '' then
  begin
    ShowMessage('Specify Idle Code!');
    cmbIdleCode.SetFocus;
    exit;
  end;
  if trim(txtIdleTime.Text) = '' then
  begin
    ShowMessage('Specify Idle Time!');
    txtIdleTime.SetFocus;
    exit;
  end;
  if trim(txtRemarks.Text) = '' then
  begin
    ShowMessage('Specify Remarks!');
    txtRemarks.SetFocus;
    exit;
  end;

  // extract only numbers from Idle Time //

  txtIdleTime.Text := GetNumbersOnly(txtIdleTime.Text);
  cmbIdleCode.Text := UpperCase(cmbIdleCode.Text);

  // check mode
  if lblMode.Caption = 'Mode: ADD' then
  begin

    // check for duplicate //
    With ADODataSet2 do
    begin
      Close;
      CommandText := 'SELECT * FROM dtaIdleValues WHERE Employee_PIN = ' + txtEmp_PIN.Text + ' AND Tran_Date= ''' +
        DateToStr(dtDate.Date)+'''';
      Open;
      if RecordCount > 0 then
      begin
        ShowMessage('Record already exist, cannot save..');
        Close;
        Exit;
      end;
      Close;
    end;
    // save record
    if (Messagedlg('Save this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
    begin
      vSQL := '';
      vSQL := vSQL + 'INSERT INTO dtaIdleValues (Employee_PIN, Tran_Date, Idle_Time, Idle_Code, Remarks) VALUES ';
      vSQL := vSQL + '('+ txtEmp_PIN.Text + ', '''+ DateToStr(dtDate.Date) + ''', ' + txtIdleTime.Text + ', ''' + cmbIdleCode.Text  + ''', ''' + txtRemarks.Text + ''')' ;
      //ShowMessage(vSQL);
      ADOConnection1.Execute(vSQL);

      Add_Log;

    end

  end;

  if lblMode.Caption = 'Mode: EDIT' then
  begin
    // check for duplicate //
    With ADODataSet2 do
    begin
      Close;
      CommandText := 'SELECT * FROM dtaIdleValues WHERE Employee_PIN='+txtEmp_PIN.Text+' AND Tran_Date='''+DateToStr(dtDate.Date)+'''';
      Open;
      if RecordCount > 0 then
        if vID<>FieldByName('ID').AsString then
        begin
          ShowMessage('(EDIT) Record already exist, can not save..');
          Close;
          Exit;
        end;
      Close;
    end;
    if (Messagedlg('Save this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
    begin

      Edit_Log;

      vSQL := '';
      vSQL := vSQL + 'UPDATE dtaIdleValues SET ';
      vSQL := vSQL + 'Employee_PIN  = '''+ txtEmp_PIN.Text + ''', ';
      vSQL := vSQL + 'Tran_Date = '''+ DateToStr(dtDate.Date) + ''', ';
      vSQL := vSQL + 'Idle_Time = '  + txtIdleTime.Text + ', ';
      vSQL := vSQL + 'Idle_Code = '''+ cmbIdleCode.Text + ''', ';
      vSQL := vSQL + 'Remarks = '''+ txtRemarks.Text + '''';
      vSQL := vSQL + 'WHERE ID=' + vID;
      //ShowMessage(vSQL);
      ADOConnection1.Execute(vSQL);
    end
  end;

  // save new idle code //
  With ADODataSet2 do
  begin
    Close;
    CommandText := 'SELECT Code FROM dtaCodeTables WHERE Code_Category= ''Idle_Code'' AND Code= '''+ cmbIdleCode.Text + ''' ORDER BY Code';
    Open;
    if RecordCount = 0 then
    begin
      Close;
      // append the new idle code //
      vSQL := '';
      vSQL := vSQL + 'INSERT INTO dtaCodeTables (Code_Category, Code, Description) VALUES ';
      vSQL := vSQL + '(''Idle_Code'', '''+ cmbIdleCode.Text + ''', '''+ cmbIdleCode.Text + ''')' ;
      vSQL := vSQL + 'WHERE ID=' + vID;
      //ShowMessage(vSQL);
      ADOConnection1.Execute(vSQL);
    end;
    Close;
  end;

  ShowMessage('Record saved successfully..');
  Load_Grid;
  Enable_Buttons(FALSE,'');
end;

function TfrmIdleEntry2.GetNumbersOnly( InputString:String ) : String;
var
  cnt : Integer;
  sTemp : String;
begin
  sTemp := '';
  for cnt:=1 to length(InputString) do
  begin
    if Pos( Copy(InputString,cnt,1) , '0123456789' ) > 0 then
      sTemp := sTemp + Copy(InputString,cnt,1);
  end;
  GetNumbersOnly := sTemp;
end;

procedure TfrmIdleEntry2.cmbPrimaryTaskIDChange(Sender: TObject);
begin
  Load_Grid;
end;

procedure TfrmIdleEntry2.dtDateChange(Sender: TObject);
begin
  Load_Grid;
end;

procedure TfrmIdleEntry2.DBGrid1CellClick(Column: TColumn);
begin
  // load edit fields
  vID := ADODataSet1.FieldByName('ID').AsString;
  cmbEmp_Name.Clear;
  cmbEmp_Name.AddItem(ADODataSet1.FieldbyName('Employee_Name').AsString,cmbEmp_Name);
  cmbEmp_Name.ItemIndex := 0;
  cmbEmp_Name.Refresh;
  txtEmp_PIN.Text := ADODataSet1.FieldbyName('Employee_PIN').AsString;
  txtIdleTime.Text := ADODataSet1.FieldbyName('IDLE_TIME').AsString;
  cmbIdleCode.Clear;
  cmbIdleCode.AddItem(ADODataSet1.FieldbyName('IDLE_CODE').AsString,cmbIdleCode);
  cmbIdleCode.ItemIndex := 0;
  cmbIdleCode.Refresh;
  txtRemarks.Text := ADODataSet1.FieldbyName('REMARKS').AsString;
end;

procedure TfrmIdleEntry2.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  vID := ADODataSet1.FieldByName('ID').AsString;
  cmbEmp_Name.Clear;
  cmbEmp_Name.AddItem(ADODataSet1.FieldbyName('Employee_Name').AsString,cmbEmp_Name);
  cmbEmp_Name.ItemIndex := 0;
  cmbEmp_Name.Refresh;
  txtIdleTime.Text := ADODataSet1.FieldbyName('IDLE_TIME').AsString;
  cmbIdleCode.Clear;
  cmbIdleCode.AddItem(ADODataSet1.FieldbyName('IDLE_CODE').AsString,cmbIdleCode);
  cmbIdleCode.ItemIndex := 0;
  cmbIdleCode.Refresh;
  txtRemarks.Text := ADODataSet1.FieldbyName('REMARKS').AsString;
end;

procedure TfrmIdleEntry2.cmdEditClick(Sender: TObject);
var
  vKeyer, vIdleCode : String;
  i : integer;
begin
  if trim(txtEmp_PIN.Text) = '' then Exit;
  vKeyer := trim(cmbEmp_Name.Text);
  vIdleCode := trim(cmbIdleCode.Text);
  Load_Emp_Name;
  // for vkeyer in cmbkeyerid
  for i:=0 to cmbEmp_Name.Items.Count-1 do
  begin
    cmbEmp_Name.ItemIndex := i;
    cmbEmp_Name.Refresh;
    if trim(cmbEmp_Name.Text)=trim(vKeyer) then break;
  end;
  Load_IdleCode;
  cmbIdleCode.Text := vIdleCode;
  Enable_Buttons(TRUE,'EDIT');
end;

procedure TfrmIdleEntry2.cmdDeleteClick(Sender: TObject);
var
  vKeyer, vIdleCode, vSQL : String;
  i : integer;
begin
  if trim(txtEmp_PIN.Text) = '' then Exit;
  if (Messagedlg('Delete this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
  begin
      Delete_Log;

      vSQL := '';
      vSQL := vSQL + 'DELETE FROM dtaIdleValues ';
      vSQL := vSQL + 'WHERE ID=' + vID;
      txtEmp_PIN.Text := '';
      //ShowMessage(vSQL);
      ADOConnection1.Execute(vSQL);
      Load_Grid;
      ShowMessage('Record successfully deleted...');
  end;
end;

procedure TfrmIdleEntry2.Add_Log;
var
  ID: String;
  SQL: String;
begin
  with ADODataSet2 do begin
    Close;
    CommandText := 'SELECT * FROM dtaIdleValues WHERE Employee_PIN= ' + txtEmp_PIN.Text + ' AND Tran_Date= ''' +
      DateToStr(dtDate.Date) + '''';
    Open;
    ID:='0';
    if RecordCount > 0 then ID:=FieldByName('ID').AsString;
    Close;
  end;
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, New_Value, Employee_PIN, ID, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Add' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
//  SQL := SQL + chr(39) + 'Employee_Name' + chr(39) + ', ';
//  SQL := SQL + chr(39) + cmbEmp_Name.Text + chr(39);
  SQL := SQL + chr(39) + 'Employee_PIN' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtEmp_PIN.Text + chr(39) + ', ';
  SQL := SQL + chr(39) + txtEmp_PIN.Text + chr(39) + ', ';
  SQL := SQL + ID + ', ';
  SQL := SQL + chr(39) + txtEMP_PIN.Text + '|' + DateToStr(dtDate.Date) + '|' + cmbIdleCode.Text+ '|' + txtIdleTime.Text + chr(39) ;
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmIdleEntry2.Edit_Log;
var
  SQL: String;
begin

  with ADODataSet1 do begin

    if( FieldByName('Employee_Name').AsString <> cmbEmp_Name.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Employee_PIN' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Employee_PIN').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + cmbEmp_Name.Text + chr(39) + ', ';
      SQL := SQL + FieldByName('ID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

    if( FieldByName('Idle_Time').AsString <> txtIdleTime.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Idle_Time' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Idle_Time').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + txtIdleTime.Text + chr(39)+ ', ';
      SQL := SQL + FieldByName('ID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

    if( FieldByName('Idle_Code').AsString <> cmbIdleCode.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Idle_Code' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Idle_Code').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + cmbIdleCode.Text + chr(39)+ ', ';
      SQL := SQL + FieldByName('ID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

    if( FieldByName('Remarks').AsString <> txtRemarks.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Remarks' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Remarks').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + txtRemarks.Text + chr(39)+ ', ';
      SQL := SQL + FieldByName('ID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

  end;

end;

procedure TfrmIdleEntry2.Delete_Log;
var
  SQL: String;
begin
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, ID, Employee_PIN, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Idle Time Entry' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Delete' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaIdleValues' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Employee_Name' + chr(39) + ', ';
  SQL := SQL + chr(39) + cmbEmp_Name.Text + chr(39) + ', ';
  SQL := SQL + vID + ', ';
  SQL := SQL + chr(39) + txtEmp_PIN.Text + chr(39) + ', ';
  SQL := SQL + chr(39) + txtEMP_PIN.Text + '|' + DateToStr(dtDate.Date) + '|' + cmbIdleCode.Text+ '|' + txtIdleTime.Text + chr(39) ;
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmIdleEntry2.cmbEmp_NameClick(Sender: TObject);
begin
  // retrieve employee_pin //
    ADODataSet2.Close;
    ADODataSet2.CommandText := 'SELECT Employee_PIN FROM dtaEmployees WHERE Employee_Name= ''' + cmbEmp_Name.Text + '''';
    ADODataSet2.Open;
    if ADODataSet2.RecordCount > 0 then
    begin
      txtemp_pin.Text := ADODataSet2.FieldByName('Employee_PIN').AsString;
    end;
    ADODataSet2.Close;
end;

procedure TfrmIdleEntry2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIdleEntry2.btnLoadExtractionClick(Sender: TObject);
begin
    with TfrmIdleTimeExtraction.Create(Application) do show;

end;

procedure TfrmIdleEntry2.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
begin

  dsLogFile.Close;
  dsLogFile.CommandText := 'SELECT * FROM dtaLogFile';
  dsLogFile.Active := TRUE;

  with dsLogFile do
  begin
    Insert;
      FieldByName('Tran_Date').AsString := vDate;
      FieldByName('User_Id').AsString := vUser;
      FieldByName('Module_Desc').AsString := vModule;
      FieldByName('Command').AsString := vCommand;
      FieldByName('Table_Name').AsString := vTable;
      FieldByName('Employee_PIN').AsString := vPIN;
      FieldByName('Remarks').AsString := 'Module log';

    Post;

  end;
end;


end.
