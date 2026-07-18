// Name:  Access.pas
// Description:  This window allows you to see all the access
//     rights granted on a particular user.  You can also use
//     this form to set and unset access rights on various users
//     of the Payroll System.

unit Access;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CommonModule, DB, ADODB;

type
  TfrmAccess = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    listAccessRights: TListBox;
    listUserAccess: TListBox;
    Label1: TLabel;
    cmbUsername: TComboBox;
    lblEmployee_Name: TLabel;
    Label3: TLabel;
    btnMoveAll: TButton;
    btnBackAll: TButton;
    btnMove1: TButton;
    btnBack1: TButton;
    ADOUser: TADOConnection;
    dsUser: TADODataSet;
    dsEmployee: TADODataSet;
    dsRights: TADODataSet;
    Label2: TLabel;
    Label4: TLabel;
    dsModule: TADODataSet;
    btnSaveAccessRights: TButton;
    dsLogFile: TADODataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBackAllClick(Sender: TObject);
    procedure btnMoveAllClick(Sender: TObject);
    procedure btnBack1Click(Sender: TObject);
    procedure listUserAccessClick(Sender: TObject);
    procedure listAccessRightsClick(Sender: TObject);
    procedure btnMove1Click(Sender: TObject);

    procedure btnSaveAccessRightsClick(Sender: TObject);
    procedure cmbUsernameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

    procedure LoadUsers();
    procedure LoadUserAccessRights();
    procedure LoadAccessRights();
    procedure CheckListUserAccessRights();
    procedure CheckListAccessRights();
    procedure SaveUserAccessRights();

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAccess: TfrmAccess;
  varPIN, varAccessID, varModule : String;

  gUser : String;
  gUser_ID : Integer;

  sUserID : string;
  sTranDate : string;

 implementation

{$R *.dfm}

procedure TfrmAccess.btnCloseClick(Sender: TObject);
begin
  frmAccess.Close;
end;

procedure TfrmAccess.FormShow(Sender: TObject);
begin

  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);


  lblEmployee_Name.Caption := '';
  listAccessRights.Clear;
  listUserAccess.Clear;

  LoadUsers();

  //if ((ActiveUserName = 'admin') OR (ActiveUserName = 'fred')) then
    btnSaveAccessRights.Enabled := TRUE;


  InsertToLogFile(sTranDate, sUserID, 'Access Rights Maintenance', 'Load', 'dtaUser_access_rights', '');

end;

procedure TfrmAccess.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
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


procedure TfrmAccess.FormCreate(Sender: TObject);
begin
  ADOUser.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOUser.Connected := TRUE;
end;

procedure TfrmAccess.LoadUsers();
begin
  dsUser.Close;
  dsUser.Connection := ADOUser;
  dsUser.CommandText := 'SELECT * FROM dtaUsers ORDER BY UserName';
  dsUser.Active := TRUE;

  with dsUser do
    if RecordCount > 0 then
    begin
      cmbUserName.Clear;
      First;
      while not eof do
      begin
        cmbUserName.Items.Add(FieldByName('UserName').AsString);

        Next;
      end;
    end;

end;

procedure TfrmAccess.cmbUsernameClick(Sender: TObject);
begin
  dsUser.Close;
  dsUser.Connection := ADOUser;
  dsUser.CommandText := 'SELECT * FROM dtaUsers WHERE UserName = ' + chr(39) + cmbUserName.Text + chr(39);
  dsUser.Active := TRUE;

  if dsUser.RecordCount > 0 then
  begin
    varPIN := dsUser.FieldByName('Employee_PIN').AsString;

    dsEmployee.Close;
    dsEmployee.Connection := ADOUser;
    dsEmployee.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + Chr(39) + varPIN + Chr(39);
    dsEmployee.Active := TRUE;

    if dsEmployee.RecordCount > 0 then
      lblEmployee_Name.Caption := dsEmployee.FieldByName('Employee_Name').AsString;


    LoadUserAccessRights();
    LoadAccessRights();
    //CheckListUserAccessRights();
    //CheckListAccessRights();
  end;
end;

procedure TfrmAccess.LoadUserAccessRights();
begin
  dsUser.Close;
  dsUser.Connection := ADOUser;
  dsUser.CommandText := 'SELECT * FROM dtaUser_Access_Rights WHERE User_Id = ' + Chr(39) + varPIN + Chr(39);
  dsUser.Active := TRUE;

  //clears the list access rights;
  listUserAccess.Clear;
  if dsUser.RecordCount > 0 then
  begin

   dsUser.First;
    while not dsUser.eof do
    begin

      varAccessID := dsUser.FieldByName('Access_ID').AsString;

      dsRights.Close;
      dsRights.Connection := ADOUser;
      dsRights.CommandText := 'SELECT * FROM dtaAccess_Rights_Codes WHERE Access_ID = ' + varAccessID;
      dsRights.Active := TRUE;

      if dsRights.RecordCount > 0 then
        listUserAccess.Items.Add(dsRights.FieldByName('Program_Module').AsString);

      dsUser.Next;
    end;
  end;
end;

procedure TfrmAccess.LoadAccessRights();
begin
  dsRights.Close;
  dsRights.Connection := ADOUser;
//  dsRights.CommandText := 'SELECT DISTINCT Program_Module FROM dtaAccess_Rights_Codes ORDER BY Program_Module';
  dsRights.CommandText := 'SELECT Program_Module, Access_ID FROM dtaAccess_Rights_Codes ORDER BY Program_Module';
  dsRights.Active := TRUE;

  listAccessRights.Clear;
  if dsRights.RecordCount > 0 then
  begin
    dsRights.First;
    while not dsRights.Eof do
    begin
      varModule := dsRights.FieldByName('Program_Module').AsString;

      dsModule.Close;
      dsModule.CommandText := 'SELECT Access_ID FROM dtaAccess_Rights_Codes WHERE Program_Module = ' + chr(39) + varModule + Chr(39);
      dsModule.Active := TRUE;

      if dsModule.RecordCount > 0 then

        varAccessID := dsModule.FieldByName('Access_id').AsString;
//        varAccessID := dsRights.FieldByName('Access_id').AsString;


      dsUser.Close;
      dsUser.Connection := ADOUser;
      dsUser.CommandText := 'SELECT * FROM dtaUser_Access_Rights WHERE Access_Id = ' + varAccessID + ' AND User_Id = ' + Chr(39) + varPIN + Chr(39);
      dsUser.Active := TRUE;

      if dsUser.RecordCount = 0 then

        listAccessRights.Items.Add(varModule);

      dsRights.Next;
    end;
  end;
end;

procedure TfrmAccess.CheckListUserAccessRights();
begin
  if listUserAccess.Items.Count = 0 then
  begin
    btnBack1.Enabled := FALSE;
    btnBackAll.Enabled := FALSE;
  end
  else
  begin
    btnBack1.Enabled := TRUE;
    btnBackAll.Enabled := TRUE;
  end;
end;

procedure TfrmAccess.CheckListAccessRights();
begin
  if listAccessRights.Items.Count = 0 then
  begin
    btnMove1.Enabled := FALSE;
    btnMoveAll.Enabled := FALSE;
  end
  else
  begin
    btnMove1.Enabled := TRUE;
    btnMoveAll.Enabled := TRUE;
  end;
end;


procedure TfrmAccess.btnSaveAccessRightsClick(Sender: TObject);
begin
  if cmbUserName.Text <> '' then
    SaveUserAccessRights();
end;

procedure TfrmAccess.SaveUserAccessRights();
var
  ctr : Integer;
begin

  ADOUser.Execute('DELETE FROM dtaUser_Access_Rights WHERE User_ID = ' + Chr(39) + varPIN + Chr(39));

  dsUser.Close;
  dsUser.Connection := ADOUser;
  dsUser.CommandText := 'SELECT * FROM dtaUser_Access_Rights';
  dsUser.Active := TRUE;


  for ctr := 0 to listUserAccess.Items.Count - 1 do
  begin
    dsRights.Close;
    dsRights.Connection := ADOUser;
    dsRights.CommandText := 'SELECT * FROM dtaAccess_Rights_Codes WHERE Program_Module = ' + chr(39) +
      listUserAccess.Items.Strings[ctr] + chr(39);
    dsRights.Active := TRUE;

    varAccessID := dsRights.FieldByName('Access_ID').AsString;

    dsUser.Insert;
      dsUser.FieldByName('User_ID').AsString := varPIN;
      dsUser.FieldByName('Access_ID').AsString := varAccessID;
    dsUser.Post;

  end;

  ShowMessage('User Access Rights was successfully saved!');

end;

procedure TfrmAccess.btnMove1Click(Sender: TObject);
var
  var2 : Integer;
begin
  if listAccessRights.Selected[listAccessRights.ItemIndex] = TRUE then
  begin
    var2 := listAccessRights.ItemIndex;
    listUserAccess.Items.Add(listAccessRights.Items.Strings[var2]);

    listAccessRights.Items.Delete(var2);
    btnMove1.Enabled := FALSE;
  end;
end;

procedure TfrmAccess.listAccessRightsClick(Sender: TObject);
begin
  btnMove1.Enabled := TRUE;
end;

procedure TfrmAccess.listUserAccessClick(Sender: TObject);
begin
  btnBack1.Enabled := TRUE;
end;

procedure TfrmAccess.btnBack1Click(Sender: TObject);
var
  var2 : Integer;
begin
  if listUserAccess.Selected[listUserAccess.ItemIndex] = TRUE then
  begin
    var2 := listUserAccess.ItemIndex;
    listAccessRights.Items.Add(listUserAccess.Items.Strings[var2]);

    listUserAccess.Items.Delete(var2);
    btnBack1.Enabled := FALSE;
  end;
end;

procedure TfrmAccess.btnMoveAllClick(Sender: TObject);
var
  xctr : Integer;
begin
  if listAccessRights.Items.Count > 0 then
    xctr := 0;
    while listAccessRights.Items.Count <> 0 do
    begin
      listUserAccess.Items.Add(listAccessRights.Items.Strings[xctr]);
      listAccessRights.Items.Delete(xctr);
    end;

end;

procedure TfrmAccess.btnBackAllClick(Sender: TObject);
var
  xctr : Integer;
begin
  if listUserAccess.Items.Count > 0 then
    xctr := 0;
    while listUserAccess.Items.Count <> 0 do
    begin
      listAccessRights.Items.Add(listUserAccess.Items.Strings[xctr]);
      listUserAccess.Items.Delete(xctr);
    end;
end;

procedure TfrmAccess.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
