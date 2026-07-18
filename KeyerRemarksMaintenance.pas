// Name:  KeyerRemarksMaintenance.pas
// Description:  This entry form is used for adding keyer IDs.
//     Editing and deleting existing keyer IDs can also be done
//     here.  Keyer IDs are used as the key in determining keyer
//     production which are saved during extraction of production
//     reports.

unit KeyerRemarksMaintenance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, EmployeeList, DB, ADODB, KeyerRemarks, CommonModule,
  KeyerIDMaintenanceExpress;

type
  TfrmKeyerRemarksMaintenance = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    txtEmployeePIN: TEdit;
    Button3: TButton;
    Label3: TLabel;
    txtEmployeeName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    cmbTaskID: TComboBox;
    Label7: TLabel;
    txtPieceRate: TEdit;
    txtTaskDesc: TEdit;
    txtKeyerID: TEdit;
    Label6: TLabel;
    Shape1: TShape;
    cmdDelete: TButton;
    cmdEdit: TButton;
    cmdAdd: TButton;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    cmdKeyerList: TButton;
    ADODataSet2: TADODataSet;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtUser: TEdit;
    txtUser_EmployeeName: TEdit;
    txtJobPosition: TEdit;
    Label11: TLabel;
    txtPrimary_Task_ID: TEdit;
    dsModule: TADODataSet;
    dsAccess: TADODataSet;
    dsLogFile: TADODataSet;
    cmdLoadExpress: TButton;
    procedure cmdLoadExpressClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmbTaskIDClick(Sender: TObject);

    procedure cmdAddClick(Sender: TObject);
    procedure cmdKeyerListClick(Sender: TObject);
    procedure txtEmployeePINKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure Delete_Log;
    procedure Add_Log;
    procedure Edit_Log;

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

    function StringToCaseSelect (Selector : string; CaseList: array of string): Integer;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyerRemarksMaintenance: TfrmKeyerRemarksMaintenance;
  varKeyer : String;
  varLen : Integer;
  varEditKeyerID, varEditTaskID : String;

  gUser : String;
  gUser_ID : Integer;
  vEmpID : String;

  sUserID : string;
  sTranDate : string;

implementation

{$R *.dfm}

procedure TfrmKeyerRemarksMaintenance.cmdCloseClick(Sender: TObject);
begin
  frmKeyerRemarksMaintenance.Close;
end;

procedure TfrmKeyerRemarksMaintenance.Button3Click(Sender: TObject);
begin
//  frmEmployeeList.Show;
  with TfrmEmployeeList.Create(Application) do show;
end;

procedure TfrmKeyerRemarksMaintenance.txtEmployeePINKeyPress(Sender: TObject;
  var Key: Char);
var
  varLen : Integer;
begin
    if Key = #13 then
    begin

      varLen := StrLen(PChar(txtEmployeePIN.Text));

      if varLen > 1 then
      begin
        With ADODataSet1 do
        begin
          Close;
          CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + txtEmployeePIN.Text;
          Open;

          if RecordCount > 0 then
          begin
            txtEmployeePIN.Text := FieldByName('Employee_PIN').AsString;
            txtEmployeeName.Text := FieldByName('Employee_Name').AsString;
            txtPrimary_Task_ID.Text := FieldByName('Primary_Task_ID').AsString;

            if length(txtPrimary_Task_ID.Text)=0 then
              begin
                ShowMessage('Primary Task ID is blank, please set it at Employee File Maintenance.');
                txtEmployeePIN.Clear;
                txtEmployeeName.Clear;
                txtPrimary_Task_ID.Clear;
                Exit;
              end;

            // check if the task_id is under that supervisor or team leader
            with ADODataSet2 do
            begin
              Close;
              //CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID = ' + chr(39) + txtPrimary_Task_ID.Text + chr(39);
              CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID) + ' AND Task_ID = ''' + txtPrimary_Task_ID.Text + '''';
              Open;
              if RecordCount = 0 then
              begin
                //ShowMessage('Primary Task ID ['+ txtPrimary_Task_ID.Text + '] does not exist in table!!!');

                { *** Temporarily disabled by Omar 1/23/06 11:21pm to allowed Vanessa to encode remaining keyer id's ***
                ShowMessage('Task-ID ['+txtPrimary_Task_ID.Text+'] is not handled by the Supervisor/Team Leader.');
                txtEmployeePIN.Clear;
                txtEmployeeName.Clear;
                txtPrimary_Task_ID.Clear;
                Exit;}
              end;
              {
              if RecordCount > 0 then
              begin
                // check the position first
                if txtJobPosition.Text = 'SUP' then
                  if IntToStr(gUser_ID) <> FieldByName('Supervisor').AsString then
                    begin
                      ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                      txtEmployeePIN.Clear;
                      txtEmployeeName.Clear;
                      txtPrimary_Task_ID.Clear;
                      Exit;
                    end;
                if txtJobPosition.Text = 'TL' then
                  if IntToStr(gUser_ID) <> FieldByName('Team_Leader').AsString then
                    begin
                      ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                      txtEmployeePIN.Clear;
                      txtEmployeeName.Clear;
                      txtPrimary_Task_ID.Clear;
                      Exit;
                    end;
              end;
              }
            end;

            //populate task id combo box with its corresponding
           With ADODataSet1 do
            begin
              Close;
              CommandText := 'SELECT Task_ID FROM dtaTaskRemarks ORDER BY Task_ID';
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
              end;
            end;


            txtKeyerID.SetFocus;
          end
          else
          begin;
            ShowMessage('No such Employee PIN found in our database!');
            txtEmployeePIN.Clear;
            txtEmployeeName.Clear;
          end;
        end;
      end
      else
        ShowMessage('Please key in a valid Employee PIN!');
      //end;
    end;
end;

procedure TfrmKeyerRemarksMaintenance.cmdKeyerListClick(Sender: TObject);
begin
//  frmKeyerRemarks.Show;
  with TfrmKeyerRemarks.Create(Application) do show;
end;

procedure TfrmKeyerRemarksMaintenance.cmdAddClick(Sender: TObject);
begin
    if (txtEmployeePIN.Text <> '') AND (txtKeyerID.Text <> '') AND (cmbTaskID.Text <> '') AND (txtTaskDesc.Text <> '') then
    begin

        InsertToLogFile(sTranDate, sUserID, 'Keyer ID Maintenance', 'Add', 'dtaKeyerRemarks', varKeyer);

        with ADODataSet1 do
        begin
            Close;
            CommandText := 'SELECT * FROM dtaKeyerRemarks WHERE Employee_PIN = ' + txtEmployeePIN.Text +
                'AND Keyer_ID = ' + Chr(39) + txtKeyerID.Text + Chr(39) + ' AND Task_ID = ' +
                Chr(39) + cmbTaskID.Text + Chr(39) ;
            Open;

            If RecordCount > 0 then
                ShowMessage('Keyer ID and Task ID for this Employee already exists!  Please try another.')
            else
            begin
              Close;
              CommandText := 'SELECT * FROM dtaKeyerRemarks WHERE Keyer_ID = ' + Chr(39) + txtKeyerID.Text + Chr(39);

              Open;

              if RecordCount > 0 then
              begin
                if (FieldByName('Employee_PIN').AsString <> txtEmployeePIN.Text) then
                  ShowMessage('This keyer ID is already assigned to another keyer, try another!')
                else
                begin
                  Insert;
                    FieldByName('Employee_PIN').AsString := txtEmployeePIN.Text;
                    FieldByName('Keyer_ID').AsString := txtKeyerID.Text;
                    FieldByName('Task_ID').AsString := cmbTaskID.Text;
                  Post;

                  Close;

                  Add_Log;

                  if MessageDlg('New Keyer ID was successfully saved!  Assign another?', mtConfirmation, mbYesNo, 0) = mrYes then
                  begin
                    txtKeyerID.Clear;
                    cmbTaskID.Text := '';
                    txtTaskDesc.Clear;
                    txtPieceRate.Clear;
                    //txtPrimary_Task_ID.Clear;
                  end
                  else
                  begin
                    txtEmployeePIN.Clear;
                    txtEmployeeName.Clear;

                    txtKeyerID.Clear;
                    cmbTaskID.Text := '';
                    txtTaskDesc.Clear;
                    txtPieceRate.Clear;
                    txtPrimary_Task_ID.Clear;
                  end;
                  txtEmployeePIN.SetFocus;

                end;
              end
              else
              begin

                  Insert;
                    FieldByName('Employee_PIN').AsString := txtEmployeePIN.Text;
                    FieldByName('Keyer_ID').AsString := txtKeyerID.Text;
                    FieldByName('Task_ID').AsString := cmbTaskID.Text;
                  Post;

                  Close;

                  Add_Log;

                  if MessageDlg('New Keyer ID was successfully saved!  Assign another?', mtConfirmation, mbYesNo, 0) = mrYes then
                  begin
                    txtKeyerID.Clear;
                    cmbTaskID.Text := '';
                    txtTaskDesc.Clear;
                    txtPieceRate.Clear;
                    txtPrimary_Task_ID.Clear;
                  end
                  else
                  begin
                    txtEmployeePIN.Clear;
                    txtEmployeeName.Clear;

                    txtKeyerID.Clear;
                    cmbTaskID.Text := '';
                    txtTaskDesc.Clear;
                    txtPieceRate.Clear;
                    txtPrimary_Task_ID.Clear;
                  end;
                  txtEmployeePIN.SetFocus;


              end
            end;
        end;
    end
    else
          ShowMessage('Please verify your inputs!');
end;

procedure TfrmKeyerRemarksMaintenance.cmbTaskIDClick(Sender: TObject);
begin
    With ADODataSet1 do
    begin
      Close;
      CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID = ' + Chr(39) + cmbTaskID.Text + Chr(39);
      Open;

      if RecordCount > 0 then
      begin
        txtTaskDesc.Text := FieldByName('Task_Description').AsString;
        txtPieceRate.Text := FieldByName('Piece_Rate').AsString;

      end;
    end;
end;

procedure TfrmKeyerRemarksMaintenance.cmdEditClick(Sender: TObject);
begin
  if cmdEdit.Caption = '&EDIT' then
  begin

      varKeyer := InputBox('Keyer ID', 'Enter Keyer ID',' ');

      varLen := StrLen(PChar(varKeyer));

      if varLen > 1 then
      begin

      with ADODataSet1 do
      begin
          Close;
//          CommandText := 'SELECT Employee_Name, dtaEmployees.Employee_PIN as "Emp_PIN", Keyer_ID, dtaKeyerRemarks.Task_ID as "KeyerTask_ID", Task_Description, Piece_Rate ' +
//            'FROM dtaKeyerRemarks, dtaEmployees, dtaTaskRemarks ' +
//            'WHERE dtaKeyerRemarks.Employee_PIN = dtaEmployees.Employee_PIN ' +
//            'AND dtaKeyerRemarks.Task_ID = dtaTaskRemarks.Task_ID ' +
//            'AND Keyer_ID = ' + Chr(39) + varKeyer + Chr(39);
//          CommandText := 'SELECT Employee_Name, Employee_PIN, Keyer_ID, Task_ID, Task_Description, Piece_Rate ' +
          CommandText := 'SELECT * ' +
            'FROM vwKeyerRemarks ' +
            'WHERE Keyer_ID = ' + Chr(39) + varKeyer + Chr(39);
          //ShowMessage(CommandText);
          Open;

          //ShowMessage(IntToStr(RecordCount));
          if RecordCount > 0 then
          begin
            //check primary task id
            if length( FieldByName('Primary_Task_ID').AsString ) = 0 then
            begin
              ShowMessage('Primary Task ID is blank, please set it at Employee File Maintenance.');
              Exit;
            end;
            // check if the task_id is under that supervisor or team leader
            with ADODataSet2 do
            begin
              Close;
              //CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID = ' + chr(39) + ADODataSet1.FieldByName('Primary_Task_ID').AsString + chr(39);
              CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID) + ' AND Task_ID = ''' + ADODataSet1.FieldByName('Primary_Task_ID').AsString + '''';
              Open;
              if RecordCount = 0 then
              begin
                //ShowMessage('Primary Task ID ['+ ADODataSet1.FieldByName('Primary_Task_ID').AsString + '] does not exist in table!!!');
                //ShowMessage('Task-ID ['+ADODataSet1.FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                //Exit;
              end;
              {
              if RecordCount > 0 then
              begin
                if txtJobPosition.Text = 'SUP' then
                  if IntToStr(gUser_ID) <> FieldByName('Supervisor').AsString then
                  begin
                    ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                    Exit;
                  end;
                if txtJobPosition.Text = 'TL' then
                  if IntToStr(gUser_ID) <> FieldByName('Team_Leader').AsString then
                  begin
                    ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                    Exit;
                  end;
              end;
              }
            end;

            cmdEdit.Caption := '&SAVE';
            cmdAdd.Enabled := FALSE;
            cmdDelete.Enabled := FALSE;
            txtEmployeePIN.ReadOnly := TRUE;
            cmbTaskID.Enabled := TRUE;

           //populate combo box
           With ADODataSet2 do
            begin
              Close;
              CommandText := 'SELECT Task_ID FROM dtaTaskRemarks ORDER BY Task_ID';
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
              end;
            end;

            //get keyer-id and task-id to update
            varEditKeyerID := FieldByName('Keyer_ID').AsString;
            varEditTaskID := FieldByName('Task_ID').AsString;
            txtPrimary_Task_ID.Text := FieldByName('Primary_Task_ID').AsString;

            //fill all fields with the keyed keyer-id
            txtEmployeePIN.Text := FieldByName('Employee_PIN').AsString;
            txtEmployeeName.Text := FieldByName('Employee_Name').AsString;
            txtKeyerID.Text := FieldByName('Keyer_ID').AsString;
            cmbTaskID.Text := FieldByName('Task_ID').AsString;
            txtPieceRate.Text := FieldByName('Piece_Rate').AsString;
            txtTaskDesc.Text := FieldByName('Task_Description').AsString;

            txtKeyerID.SetFocus;
          end
          else
            ShowMessage('Please verify Keyer ID!');
//          Close;
      end;
      end
      else
        ShowMessage('Please key in a valid keyer id!');
  end
  else
  begin

      with ADODataSet2 do
      begin
          Close;
          CommandText := 'SELECT * FROM dtaKeyerRemarks WHERE Keyer_ID = ' + Chr(39) + txtKeyerID.Text + Chr(39) + 'AND Task_ID = ' + Chr(39) + cmbTaskID.Text + Chr(39);
          Open;

          if (varEditKeyerID = txtKeyerID.Text) AND (varEditTaskID = cmbTaskID.Text) then
          begin
            txtEmployeePIN.Clear;
            txtEmployeeName.Clear;

            txtKeyerID.Clear;
            cmbTaskID.Text := '';
            txtTaskDesc.Clear;
            txtPieceRate.Clear;
            txtPrimary_Task_ID.Clear;

            txtEmployeePIN.SetFocus;

            cmdEdit.Caption := '&EDIT';
            cmdAdd.Enabled := TRUE;
            cmdDelete.Enabled := TRUE;
            txtEmployeePIN.ReadOnly := FALSE;
            cmbTaskID.Enabled := FALSE;
          end
          else if RecordCount > 0 Then
            ShowMessage('Keyer-ID already exists with this specific task-ID, choose another!')
          else
          begin
            With ADODataSet1 do
            begin
              Close;
              CommandText := 'SELECT * FROM dtaKeyerRemarks WHERE Keyer_ID = ' + Chr(39) + varEditKeyerID + Chr(39);
              Open;

              Edit_Log;

              Edit;
          //    FieldByName('Employee_PIN').AsString := txtEmployeePIN.Text;
                  FieldByName('Keyer_ID').AsString := txtKeyerID.Text;
                  FieldByName('Task_ID').AsString := cmbTaskID.Text;
              Post;

              cmdEdit.Caption := '&EDIT';
              cmdAdd.Enabled := TRUE;
              cmdDelete.Enabled := TRUE;
              txtEmployeePIN.ReadOnly := FALSE;
              cmbTaskID.Enabled := FALSE;

             end;
          ShowMessage('Record was successfully updated!');

          txtEmployeePIN.Clear;
          txtEmployeeName.Clear;

          txtKeyerID.Clear;
          cmbTaskID.Text := '';
          txtTaskDesc.Clear;
          txtPieceRate.Clear;
          txtPrimary_Task_ID.Clear;

          txtEmployeePIN.SetFocus;
          end;
      Close;
      end;
  end;

end;

procedure TfrmKeyerRemarksMaintenance.cmdDeleteClick(Sender: TObject);
begin
      varKeyer := InputBox('Keyer ID', 'Enter Keyer ID',' ');

      varLen := StrLen(PChar(varKeyer));

      if varLen > 1 then
      begin

      InsertToLogFile(sTranDate, sUserID, 'Keyer ID Maintenance', 'Delete', 'dtaKeyerRemarks', varKeyer);

      with ADODataSet1 do
      begin
          Close;
//          CommandText := 'SELECT Employee_Name, dtaEmployees.Employee_PIN as "Emp_PIN", Keyer_ID, dtaKeyerRemarks.Task_ID as "KeyerTask_ID", Task_Description, Piece_Rate ' +
//            'FROM dtaKeyerRemarks, dtaEmployees, dtaTaskRemarks ' +
//            'WHERE dtaKeyerRemarks.Employee_PIN = dtaEmployees.Employee_PIN ' +
//            'AND dtaKeyerRemarks.Task_ID = dtaTaskRemarks.Task_ID ' +
//            'AND Keyer_ID = ' + Chr(39) + varKeyer + Chr(39);
//          CommandText := 'SELECT Employee_Name, Employee_PIN, Keyer_ID, Task_ID, Task_Description, Piece_Rate ' +
          CommandText := 'SELECT * ' +
            'FROM vwKeyerRemarks ' +
            'WHERE Keyer_ID = ' + Chr(39) + varKeyer + Chr(39);
//          ShowMessage(CommandText);
          Open;

          if RecordCount = 0 then
            ShowMessage('No record found...');

          //ShowMessage(IntToStr(RecordCount));
          if RecordCount > 0 then
          begin
            //check primary task id
            if length( FieldByName('Primary_Task_ID').AsString ) = 0 then
            begin
              ShowMessage('Primary Task ID is blank, please set it at Employee File Maintenance.');
              Exit;
            end;
            // check if the task_id is under that supervisor or team leader
            with ADODataSet2 do
            begin
              Close;
              //CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID = ' + chr(39) + ADODataSet1.FieldByName('Primary_Task_ID').AsString + chr(39);
              CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID) + ' AND Task_ID = ''' + ADODataSet1.FieldByName('Primary_Task_ID').AsString + '''';
              Open;
              if RecordCount = 0 then
              begin
                //ShowMessage('Primary Task ID ['+ ADODataSet1.FieldByName('Primary_Task_ID').AsString + '] does not exist in table!!!');
                //ShowMessage('Task-ID ['+ADODataSet1.FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                //Exit;
              end;
              {
              if RecordCount > 0 then
              begin
                if txtJobPosition.Text = 'SUP' then
                  if IntToStr(gUser_ID) <> FieldByName('Supervisor').AsString then
                  begin
                    ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                    Exit;
                  end;
                if txtJobPosition.Text = 'TL' then
                  if IntToStr(gUser_ID) <> FieldByName('Team_Leader').AsString then
                  begin
                    ShowMessage('Task-ID ['+FieldByName('Task_ID').AsString+'] is not handled by the Supervisor/Team Leader.');
                    Exit;
                  end;
              end;
              }
            end;

            cmdAdd.Enabled := FALSE;

            //fill all fields with the keyed keyer-id
            txtEmployeePIN.Text := FieldByName('Employee_PIN').AsString;
            txtEmployeeName.Text := FieldByName('Employee_Name').AsString;
            txtKeyerID.Text := FieldByName('Keyer_ID').AsString;
            cmbTaskID.Text := FieldByName('Task_ID').AsString;
            txtPieceRate.Text := FieldByName('Piece_Rate').AsString;
            txtTaskDesc.Text := FieldByName('Task_Description').AsString;
            txtPrimary_Task_ID.Text := FieldByName('Primary_Task_ID').AsString;

            txtEmployeePIN.ReadOnly := TRUE;
            txtKeyerID.ReadOnly := TRUE;

            if MessageDlg('Delete Keyer ID?', mtConfirmation, mbYesNo, 0) = mrYes then
            with ADOConnection1 do
              begin
                Delete_Log;
                Execute('DELETE FROM dtaKeyerRemarks WHERE Keyer_ID = ' + Chr(39) + txtKeyerID.Text + Chr(39));
                ShowMessage('Record was successfully deleted!');
              end;
            end;
            txtEmployeePIN.Clear;
            txtEmployeeName.Clear;

            txtKeyerID.Clear;
            cmbTaskID.Text := '';
            txtTaskDesc.Clear;
            txtPieceRate.Clear;
            txtPrimary_Task_ID.Clear;
            txtEmployeePIN.SetFocus;
            cmdAdd.Enabled := TRUE;
          end;
      end;
end;

procedure TfrmKeyerRemarksMaintenance.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmKeyerRemarksMaintenance.FormActivate(Sender: TObject);
begin
  // initialize everything
  txtEmployeePIN.Text := '';
  txtEmployeeNAME.Text := '';
  txtPrimary_Task_ID.Text := '';
  txtKeyerID.Text := '';
  cmbTaskID.Clear;
  txtTaskDesc.Text := '';
  txtPieceRate.Text := '';
  cmdAdd.Caption := '&ADD';
  cmdEdit.Caption := '&EDIT';
  cmdDelete.Caption := '&DELETE';
  //cmdClose.Caption := '&CLOSE';
  cmdAdd.Enabled := true;
  cmdEdit.Enabled := false;
  cmdDelete.Enabled := true;
  //cmdClose.Enabled := true;

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
  end;
  // check the current user if supervisor or team leader
  if not ((txtJobPosition.Text='SUP') or (txtJobPosition.Text='TL') or (txtJobPosition.Text = 'PRODMGR') or
    (txtJobPosition.Text = 'PROJMGR') or (txtJobPosition.Text = 'Admin')) then begin
    ShowMessage('Only Supervisor and Team-Leader is allowed..');
    //Close;

    cmdAdd.Enabled := FALSE;
    //cmdEdit.Enabled := FALSE;
    cmdDelete.Enabled := FALSE;
  end;


  InsertToLogFile(sTranDate, sUserID, 'Keyer ID Maintenance', 'Load', 'dtaKeyerRemarks', '');

end;

procedure TfrmKeyerRemarksMaintenance.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
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

procedure TfrmKeyerRemarksMaintenance.Delete_Log;
var
  SQL: String;
begin
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, ID, Employee_PIN, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Keyer-ID Maintanance' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Delete' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaKeyerRemarks' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Keyer_ID' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtKeyerID.Text + chr(39) + ', ';
  SQL := SQL + ADODataSet1.FieldByName('KeyerPointerID').AsString + ', ';
  SQL := SQL + ADODataSet1.FieldByName('Employee_PIN').AsString + ', ';
  SQL := SQL + chr(39) + txtKeyerID.Text + '|' + cmbTaskID.Text + chr(39) ;
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmKeyerRemarksMaintenance.Add_Log;
var
  ID: String;
  SQL: String;
begin
  with ADODataSet1 do begin
    CommandText := 'SELECT * FROM dtaKeyerRemarks WHERE Keyer_ID = ''' + txtKeyerID.Text + ''' AND Task_ID = ''' + cmbTaskID.Text + '''';
    Open;
    ID:='0';
    if RecordCount > 0 then ID:=FieldByName('KeyerPointerID').AsString;
    Close;
  end;
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, New_Value, Employee_PIN, ID, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Keyer-ID Maintanance' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Add' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaKeyerRemarks' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Keyer_ID' + chr(39) + ', ';
  SQL := SQL + chr(39) + txtKeyerID.Text + chr(39) + ', ';
  SQL := SQL + chr(39) + txtEmployeePIN.Text + chr(39) + ', ';
  SQL := SQL + ID + ', ';
  SQL := SQL + chr(39) + txtKeyerID.Text + '|' + cmbTaskID.Text + chr(39) ;
  SQL := SQL + ')';
//  ShowMessage(SQL);
  ADOConnection1.Execute(SQL);
end;

procedure TfrmKeyerRemarksMaintenance.Edit_Log;
var
  SQL: String;
begin

  with ADODataSet1 do begin

//            FieldByName('Task_ID').AsString := txtTaskID.Text;

    if( FieldByName('Keyer_ID').AsString <> txtKeyerID.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Keyer-ID Maintenance' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaKeyerRemarks' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Keyer_ID' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Keyer_ID').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + txtKeyerID.Text + chr(39) + ', ';
      SQL := SQL + FieldByName('KeyerPointerID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

    if( FieldByName('Task_ID').AsString <> cmbTaskID.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Keyer-ID Maintenance' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaKeyerRemarks' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Task_ID' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Task_ID').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + cmbTaskID.Text + chr(39) + ', ';
      SQL := SQL + FieldByName('KeyerPointerID').AsString + ', ';
      SQL := SQL + FieldByName('Employee_PIN').AsString;
      SQL := SQL + ')';
      ADOConnection1.Execute(SQL);
    end;

  end;

end;

procedure TfrmKeyerRemarksMaintenance.FormShow(Sender: TObject);
var
  varAccessId : String;
  varModuleDesc : String;
begin

  vEmpId := CommonModule.ActiveUserId;
  //vEmpId := '313';

  cmdAdd.Enabled := FALSE;
  cmdEdit.Enabled := FALSE;
  cmdDelete.Enabled := FALSE;

  dsAccess.Close;
  dsAccess.Connection := ADOConnection1;
  dsAccess.CommandText := 'SELECT * FROM dtaUser_Access_Rights WHERE User_ID = ' + Chr(39) + vEmpId + Chr(39);
  dsAccess.Active := TRUE;

  //ShowMessage(IntToStr(dsAccess.RecordCount));
  if dsAccess.RecordCount > 0 then
  begin
    dsAccess.First;
    while not dsAccess.Eof do
    begin
      varAccessId := dsAccess.FieldByName('Access_Id').AsString;

      dsModule.Close;
      dsModule.Connection := ADOConnection1;
      dsModule.CommandText := 'SELECT * FROM dtaAccess_Rights_Codes WHERE Access_Id = ' + varAccessId;
      dsModule.Active := TRUE;

      if dsModule.RecordCount > 0 then
      begin
        varModuleDesc := dsModule.FieldByName('Program_Module').AsString;

        case StringToCaseSelect(varModuleDesc,['Keyer-ID Maintenance [Add]','Keyer-ID Maintenance [Update]','Keyer-ID Maintenance [Delete]']) of
          0:cmdAdd.Enabled := TRUE;
          1:cmdEdit.Enabled := TRUE;
          2:cmdDelete.Enabled := TRUE;

        end;
      end;

      dsAccess.Next;

    end;
   end;
end;

function TfrmKeyerRemarksMaintenance.StringToCaseSelect
   (Selector : string;
CaseList: array of string): Integer;
var cnt: integer;
begin
   Result:=-1;
   for cnt:=0 to Length(CaseList)-1 do
begin
     if CompareText(Selector, CaseList[cnt]) = 0 then
     begin
       Result:=cnt;
       Break;
     end;
   end;
end;

procedure TfrmKeyerRemarksMaintenance.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmKeyerRemarksMaintenance.cmdLoadExpressClick(Sender: TObject);
begin
  with TfrmKeyerIDMaintenanceExpress.Create(Application) do show;
end;

end.
