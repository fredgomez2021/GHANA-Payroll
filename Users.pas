// Name:  Users.pas
// Description:  This is the window where you can add a new
//     account for the payroll system.  Editing and deleting
//     of existing user accounts can also be done here.

unit Users;

interface

uses
//  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//  Dialogs, Borland.Vcl.StdCtrls, System.ComponentModel, Borland.Vcl.Grids,
//  Borland.Vcl.DBGrids, Borland.Vcl.Db, Borland.Vcl.ADODB, CommonModule, ADODB,
//  DB, StdCtrls, Grids, DBGrids;

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CommonModule, ADODB, DB, StdCtrls, Grids, DBGrids, dblookup, DBCtrls;

type
  TfrmUsers = class(TForm)
    cmdCancel: TButton;
    cmdDelete: TButton;
    cmdSave: TButton;
    cmdEdit: TButton;
    cmdAdd: TButton;
    ADOTable1: TADOTable;
    ADODataSet1: TADODataSet;
    ADOConn: TADOConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADODataSet2: TADODataSet;
    DataSource2: TDataSource;
    ADODataSet3: TADODataSet;
    ADODataSet4: TADODataSet;
    ADODataSet5: TADODataSet;
    ADODataSet6: TADODataSet;
    btnDecrypt: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    txtPassword: TEdit;
    txtUserName: TEdit;
    txtEmpNo: TEdit;
    cmdOk: TButton;
    lblMode: TLabel;
    dbEmployeeList: TDBLookupComboBox;
    txtEmpName: TEdit;
    dsLogFile: TADODataSet;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDecryptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtEmpNoChange(Sender: TObject);
    procedure dbEmployeeListClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

  private
    { Private declarations }
  public
    procedure CmdButton(ans : boolean);
    procedure ClearTxt;
    procedure ShowGrid;
    procedure EditLogUser;
    procedure EditLogPass;
    function Encripta(const S: String): String;
    function Desencripta(const S: String): String;
    { Public declarations }
  end;

var
  frmUsers: TfrmUsers;
  vUserOldValue : string;
  vUserNewValue : string;
  vPassOldValue : string;
  vPassNewValue : string;


  gUser : String;
  gUser_ID : Integer;

  sUserID : string;
  sTranDate : string;
  
implementation

{$R *.dfm}

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;


end;

procedure TfrmUsers.DBGrid1CellClick(Column: TColumn);
var
  Epass : string;
begin
  if ADODataSet1.Recordset.RecordCount > 0 then
  begin
    txtEmpNo.Text := DBGrid1.Columns.Grid.Fields[0].CurValue;
    txtEmpName.Text := DBGrid1.Columns.Grid.Fields[1].CurValue;
    txtUserName.Text := DBGrid1.Columns.Grid.Fields[2].CurValue;
    Epass := DBGrid1.Columns.Grid.Fields[3].CurValue;
    txtPassword.Text := Epass;
  end
end;

procedure TfrmUsers.CmdButton(ans : boolean);
begin
  cmdAdd.Enabled := ans;
  cmdEdit.Enabled := ans;
  cmdDelete.Enabled := ans;
  //cmdExit.Enabled := ans;

  cmdAdd.Visible := ans;
  cmdEdit.Visible := ans;
  cmdDelete.Visible := ans;
  //cmdExit.Visible := ans;

  cmdOk.Visible := not ans;
  cmdSave.Visible := not ans;
  cmdCancel.Visible := not ans;
//  lblMode.Visible := not ans;

  DBGrid1.Enabled := ans;

  txtEmpNo.ReadOnly := ans;
  txtUserName.ReadOnly := ans;
  txtPassword.ReadOnly := ans;
end;

procedure TfrmUsers.ClearTxt;
begin
  txtEmpNo.Text := '';
  txtEmpName.Text := '';
  txtUserName.Text := '';
  txtPassword.Text := '';
end;

function TfrmUsers.Desencripta(const S: String): String;
var
  I: byte;
  Key: Word;
  ls : string;
const
  {C1 y C2 aon usadas para encriptar la cadena de la clave}
  C1 = 52845;
  C2 = 11719;
begin
  Key := 1674;
  SetLength(ls,Length(S) div 2);
  SetLength(Result,Length(ls));
  for I := 1 to Length(ls) do begin
    ls[I] := char(StrToInt('$'+ Copy(S, (I*2)-1 , 2)));
  end;

  for I := 1 to Length(ls) do begin
    Result[I] := char(byte(ls[I]) xor (Key shr 8));
    Key := (byte(ls[I]) + Key) * C1 + C2;
  end;
end;

function TfrmUsers.Encripta(const S: String): String;
var
  I: byte;
  Key: Word;
  ls : string;
const
  {C1 y C2 aon usadas para encriptar la cadena de la clave}
  C1 = 52845;
  C2 = 11719;
begin
  Key := 1674;
  SetLength(ls,Length(S));
  Result := '';
  for I := 1 to Length(S) do begin
    ls[I] := char(byte(S[I]) xor (Key shr 8));
    Result := Result + IntToHex(byte(ls[I]),2);
    Key := (byte(ls[I]) + Key) * C1 + C2;
  end;

end;

procedure TfrmUsers.ShowGrid;
var
  vSQL : string;
begin
  ADODataSet1.Close;

  ADODataSet1.Connection := ADOConn;
  vSQL := 'SELECT     dU.Employee_PIN as [Emp No], dE.Employee_Name as [Emp Name], dU.UserName as [User Name], dU.Password  as [Password]';
  vSQL := vSQL + 'FROM         dtaUsers dU INNER JOIN ';
  vSQL := vSQL + 'dtaEmployees dE ON dU.Employee_PIN = dE.Employee_PIN ';

  ADODataSet1.CommandText := vSQL;
  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;

  ADODataSet1.Active := True;
  DBGrid1.Refresh;

  ADODataSet3.Connection := ADOConn;
  vSQL := 'SELECT Employee_PIN, Employee_Name FROM dtaEmployees ORDER BY Employee_Name';
  ADODataSet3.CommandText := vSQL;
  ADODataSet3.Active := True;

  DataSource2.DataSet := ADODataSet3;
  dbEmployeeList.ListSource := DataSource2;
  dbEmployeeList.ListField := 'Employee_Name';
  dbEmployeeList.KeyField := 'Employee_PIN';

end;


procedure TfrmUsers.cmdAddClick(Sender: TObject);
begin
  ClearTxt;
  CmdButton(False);
  lblMode.Caption := ' Mode : ADD ';
  txtEmpNo.SetFocus;
end;

procedure TfrmUsers.cmdEditClick(Sender: TObject);
begin
  if txtEmpNo.Text = '' Then
    begin
      if (Messagedlg('Please choose record to edit!!!', mtWarning,[mbOk],0) = mrOk) then
      begin
        exit;
      end;
    end
  else
    begin
      CmdButton(False);
      lblMode.Caption := ' Mode : EDIT ';
      txtUserName.SetFocus;
    end;
end;

procedure TfrmUsers.cmdSaveClick(Sender: TObject);
var
  vSQL : string;
  Epass : String;
  EPass1 : Byte;
begin
  if txtEmpNo.Text = '' then
  begin
    if (Messagedlg('Employee Number Is Empty!!!', mtWarning,[mbOk],0) = mrOk) then
    begin
      txtEmpNo.SetFocus;
      exit;
    end;
  end;

  if lblMode.Caption = ' Mode : ADD ' then
  begin
    cmdOkClick(frmUsers);
  end;
  if txtEmpName.Text = '' then
  begin
    txtEmpNo.SetFocus;
    exit;
  end;

  if txtUserName.Text = '' then
    begin
      if (Messagedlg('User Name Is Empty!!!', mtWarning,[mbOk],0) = mrOk) then
      begin
        txtUserName.SetFocus;
        exit;
      end;
    end;

  if txtPassword.Text = '' then
  begin
    if (Messagedlg('Password Is Empty!!!', mtWarning,[mbOk],0) = mrOk) then
    begin
      txtPassword.SetFocus;
      exit;
    end;
  end;

  if (lblMode.Caption = ' Mode : ADD ') then
    begin
      ADODataSet2.Connection := ADOConn;
      vSQL := 'SELECT UserName, Password FROM dtaUsers  WHERE UserName = '+ chr(39) + txtUserName.Text + chr(39)+ '';
      ADODataSet2.CommandText := vSQL;
      ADODataSet2.Active := True;
      if ADODataSet2.RecordCount > 0 then
        begin
          if (Messagedlg('User Name already exist!!!', mtWarning,[mbOk],0) = mrOk) then
            begin
              ADODataSet2.Close;
              exit;
            end;
        end
      else
        begin
          if (Messagedlg('Save this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
            begin
              Epass := Encripta(txtPassword.Text);
              vSQL := '';
              vSQL := vSQL + 'Insert Into dtaUsers (UserName, Password, Employee_PIN) Values ';
              vSQL := vSQL + '('+ chr(39) + txtUserName.Text + chr(39)+ ', '+ chr(39) + Epass + chr(39)+ ', '+ chr(39) + txtEmpNo.Text + chr(39)+ ')' ;
              ADOConn.Execute(vSQL);

            end
          else
            begin
              ADODataSet2.Close;
              exit;
            end;
        end;
    end;

  if (lblMode.Caption = ' Mode : EDIT ') then
    begin
      ADODataSet2.Connection := ADOConn;
      vSQL := 'SELECT Employee_PIN, UserName, Password FROM dtaUsers  WHERE UserName = '+ chr(39) + txtUserName.Text + chr(39)+ '';
      ADODataSet2.CommandText := vSQL;
      ADODataSet2.Active := True;
      if ADODataSet2.RecordCount > 0 then
        begin
          if (txtEmpNo.Text = ADODataSet2.FieldByName('Employee_PIN').AsString) then
          begin
            if (Messagedlg('Save this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
              begin

                vPassNewValue := Encripta(txtPassword.Text);
                EditLogPass;

                Epass := Encripta(txtPassword.Text);
                vSQL := '';
                vSQL := vSQL + 'Update dtaUsers Set Password = '+ chr(39) + Epass + chr(39)+ ' Where Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';

                ADOConn.Execute(vSQL);
              end
            else
              begin
                ADODataSet2.Close;
                exit;
              end;
          end
        else
          begin
            if (Messagedlg('User Name already exist!!!', mtWarning,[mbOk],0) = mrOk) then
              begin
                ADODataSet2.Close;
                exit;
              end;
            end;
        end
      else
        begin
          if (Messagedlg('Save this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
            begin

              vUserNewValue := txtUserName.Text;
              EditLogUser;

              vPassNewValue := Encripta(txtPassword.Text);
              EditLogPass;

              Epass := Encripta(txtPassword.Text);
              vSQL := '';
              vSQL := vSQL + 'Update dtaUsers Set UserName = '+ chr(39) + txtUserName.Text + chr(39)+ ', Password = '+ chr(39) + Epass + chr(39)+ ' Where Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';

              ADOConn.Execute(vSQL);
            end
          else
            begin
              ADODataSet2.Close;
              exit;
            end;
        end;
    end;

    ADODataSet2.Close;
    ADODataSet2.Connection := ADOConn;

    ShowGrid;
    ClearTxt;
    CmdButton(True);
    DBGRID1.Refresh;
    cmdAdd.SetFocus;
end;

procedure TfrmUsers.cmdCancelClick(Sender: TObject);
begin
  ClearTxt;
  CmdButton(True);
  ShowGrid;
end;

procedure TfrmUsers.cmdExitClick(Sender: TObject);
//var
//  buttonSelected : Integer;
begin
//  buttonSelected := Messagedlg('Are you sure, you want to exit?', mtConfirmation,[mbYes,mbNo],0);
//  if (buttonSelected = mrYes) then
//  begin
//    Close;
//  end;
end;

procedure TfrmUsers.cmdOkClick(Sender: TObject);
var
  vSQL : string;
begin
  if txtEmpNo.Text = '' then
    begin
      if (Messagedlg('Employee Number Is Empty!!!', mtWarning,[mbOk],0) = mrOk) then
      begin
        txtEmpNo.SetFocus;
        exit;
      end;
    end
  else
    begin
      ADODataSet2.Connection := ADOConn;
      vSQL := 'SELECT Employee_Name FROM dtaEmployees WHERE Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';
      ADODataSet2.CommandText := vSQL;
      ADODataSet2.Active := True;
      if ADODataSet2.RecordCount = 0 then
        begin
          if (Messagedlg('Employee Number Does Not Exist!!!', mtWarning,[mbOk],0) = mrOk) then
            begin
              txtEmpName.Text := '';
              txtUserName.Text := '';
              txtPassword.Text := '';
              txtEmpNo.SetFocus;
              ADODataSet2.Close;
              exit;
            end;
        end
      else
        begin
          txtEmpName.Text := ADODataSet2.FieldByName('Employee_Name').AsString;
          ADODataSet2.Close;

          //check if emp no already exist in dtusers or already has users login
          ADODataSet2.Connection := ADOConn;
          vSQL := 'SELECT UserName, Password FROM dtaUsers WHERE Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';
          ADODataSet2.CommandText := vSQL;
          ADODataSet2.Active := True;
          if ADODataSet2.RecordCount > 0 then
            begin
              if (Messagedlg('Employee Number has already User''s Login!!!', mtWarning,[mbOk],0) = mrOk) then
                begin
                  txtEmpName.Text := '';
                  txtUserName.Text := '';
                  txtPassword.Text := '';
                  txtEmpNo.SetFocus;
                  ADODataSet2.Close;
                  exit;
                end;
            end
          else
            begin
              txtUserName.SetFocus;
              ADODataSet2.Close;
            end;
        end;
    end;
end;

procedure TfrmUsers.cmdDeleteClick(Sender: TObject);
var
  vSQL : string;
begin
  if txtEmpNo.Text = '' Then
    begin
      if (Messagedlg('Please choose record to delete!!!', mtWarning,[mbOk],0) = mrOk) then
      begin
        exit;
      end;
    end
  else
    begin
      if (Messagedlg('Delete this record?', mtConfirmation ,[mbNo,mbYes],0) = mrYes) then
      begin
        vSQL := '';
        vSQL := vSQL + 'DELETE FROM dtaUsers Where Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';

        ADOConn.Execute(vSQL);

        ADODataSet2.Close;
        ADODataSet2.Connection := ADOConn;

        ShowGrid;
        ClearTxt;
        CmdButton(True);
        DBGRID1.Refresh;
        cmdAdd.SetFocus;
      end;
    end;
end;

procedure TfrmUsers.dbEmployeeListClick(Sender: TObject);
var
  vSQL : string;
begin

  txtEmpName.Text := dbEmployeeList.Text;
  ADODataSet4.Connection := ADOConn;
  vSQL := 'SELECT * FROM dtaEmployees WHERE Employee_Name = '+ chr(39) + dbEmployeeList.Text + chr(39)+ '';
  ADODataSet4.CommandText := vSQL;

  ADODataSet4.Active := True;
  txtEmpNo.Text := ADODataSet4.FieldByName('Employee_PIN').AsString;
  ADODataSet4.Active := False;


end;

procedure TfrmUsers.EditLogUser;
var
  vSQL : string;
  vTmp : string;

begin
//  vTmp := '313';
  vSQL := 'INSERT INTO dtaLogFile ' ;
  vSQL := vSQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value ) ' ;
  vSQL := vSQL + 'VALUES ';
  vSQL := vSQL + '( ';
  vSQL := vSQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  vSQL := vSQL + IntToStr(gUser_ID) + ', ';
  vSQL := vSQL + chr(39) + 'System User Maintenance' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'Edit' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'dtaUser' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'UserName' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + vUserOldValue + chr(39) + ', ';
  vSQL := vSQL + chr(39) + vUserNewValue + chr(39);
  vSQL := vSQL + ')';
  ADOConn.Execute(vSQL);
end;

procedure TfrmUsers.EditLogPass;
var
  vSQL : string;
  vTmp : string;

begin
//  vTmp := '313';
  vSQL := 'INSERT INTO dtaLogFile ' ;
  vSQL := vSQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value ) ' ;
  vSQL := vSQL + 'VALUES ';
  vSQL := vSQL + '( ';
  vSQL := vSQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  vSQL := vSQL + IntToStr(gUser_ID) + ', ';
  vSQL := vSQL + chr(39) + 'System User Maintenance' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'Edit' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'dtaUser' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + 'Password' + chr(39) + ', ';
  vSQL := vSQL + chr(39) + vPassOldValue + chr(39) + ', ';
  vSQL := vSQL + chr(39) + vPassNewValue + chr(39);
  vSQL := vSQL + ')';
  ADOConn.Execute(vSQL);
end;

procedure TfrmUsers.txtEmpNoChange(Sender: TObject);
var
  vSQL : string;
begin
  ADODataSet5.Connection := ADOConn;
  vSQL := 'SELECT * FROM dtaUsers WHERE Employee_PIN = '+ chr(39) + txtEmpNo.Text + chr(39)+ '';
  ADODataSet5.CommandText := vSQL;
  ADODataSet5.Active := True;
  if ADODataSet5.Recordset.RecordCount<>0 then
    begin
      txtUserName.Text := ADODataSet5.FieldByName('UserName').AsString;
      txtPassword.Text := ADODataSet5.FieldByName('Password').AsString;
      vUserOldValue := ADODataSet5.FieldByName('UserName').AsString;
      vPassOldValue := ADODataSet5.FieldByName('Password').AsString;
    end
  else
    begin
      txtUserName.Clear;
      txtPassword.Clear;
      vUserOldValue := '';
      vPassOldValue := '';
    end;
  ADODataSet5.Active := False;
end;

procedure TfrmUsers.FormShow(Sender: TObject);
begin
  ShowGrid;
end;

procedure TfrmUsers.btnDecryptClick(Sender: TObject);
var
  s1 : string;
  PDecrypted : string;
begin

  s1 := 'SELECT * FROM dtaUsers ORDER BY Employee_PIN';
  ADODataSet5.Close;
  ADODataSet5.Connection := ADOConn;
  ADODataSet5.CommandText := s1;
  ADODataSet5.Active := TRUE;

  with ADODataSet5 do
  begin
    if RecordCount > 0 then
    begin
      First;
      while not Eof do
      begin
        PDecrypted := Desencripta(FieldByName('Password').AsString);
        Edit;
          FieldByName('PWord').AsString := PDecrypted;
        Post;

        Next;
      end;
    end;
  end;

  ADODataSet5.Close;
end;

procedure TfrmUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUsers.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);

  InsertToLogFile(sTranDate, sUserID, 'System Users Maintenance', 'Load', 'dtaUsers', '');
end;

procedure TfrmUsers.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
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
