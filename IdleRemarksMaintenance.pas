// Name:  IdleRemarksMaintenance.pas
// Description:  This is an entry form where you can add, edit
//     or delete idle reasons / description for use during entry
//     of keyer idle time.

unit IdleRemarksMaintenance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdleEntry, DB, ADODB, IdleRemarks, CommonModule;

type
  TfrmIdleRemarksMaintenance = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    txtIdleCode: TEdit;
    Label1: TLabel;
    memIdle: TMemo;
    cmdViewIdleRemarks: TButton;
    ADOConnection: TADOConnection;
    ADODataSet: TADODataSet;
    cmdAdd: TButton;
    cmdEdit: TButton;
    cmdDelete: TButton;
    dsLogFile: TADODataSet;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdViewIdleRemarksClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure txtIdleCodeKeyPress(Sender: TObject; var Key: Char);

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

    procedure Edit_Log;
    procedure Delete_Log;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdleRemarksMaintenance: TfrmIdleRemarksMaintenance;
  varIdle : String;
  varLen : Integer;

  varKeyer : String;
  varEditKeyerID, varEditTaskID : String;


  gUser : String;
  gUser_ID : Integer;
  vEmpID : String;

  sUserID : string;
  sTranDate : string;

implementation

{$R *.dfm}

procedure TfrmIdleRemarksMaintenance.txtIdleCodeKeyPress(Sender: TObject; var Key: Char);
begin
    //If Key = #13 then
    //  ShowMessage('ok');
end;

procedure TfrmIdleRemarksMaintenance.cmdCloseClick(Sender: TObject);
begin
    frmIdleRemarksMaintenance.Close;
end;

procedure TfrmIdleRemarksMaintenance.cmdAddClick(Sender: TObject);
begin
//    frmIdleEntry.ADODataSet.Close;
    if (txtIdleCode.Text <> '') AND (memIdle.Text <> '') then
    begin
        with ADODataSet do
        begin
            Close;
            CommandText := 'SELECT * FROM dtaIdleRemarks WHERE Idle_Code = ' + txtIdleCode.Text;
            Open;

            If RecordCount > 0 then
                ShowMessage('Idle code already exists!  Please try again.')
            else
            begin
            Insert;
              FieldByName('Idle_Code').AsString := txtIdleCode.Text;
              FieldByName('Idle_Description').AsString := memIdle.Text;
            Post;

            ShowMessage('New idle remark was successfully added!');

            Close;

            end;
            txtIdleCode.Clear;
            memIdle.Clear;

            txtIdleCode.SetFocus;
          end;
    end
    else
          ShowMessage('Please verify your inputs!');

end;

procedure TfrmIdleRemarksMaintenance.FormCreate(Sender: TObject);
begin
  ADOConnection.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection.Connected := TRUE;

   memIdle.Clear;
end;

procedure TfrmIdleRemarksMaintenance.cmdEditClick(Sender: TObject);
begin

  if cmdEdit.Caption = '&EDIT' then
  begin

      varIdle := InputBox('Idle Code', 'Enter Idle Code',' ');

      varLen := StrLen(PChar(varIdle));

      if varLen > 1 then
      begin

      with ADODataSet do
      begin
          Close;
          CommandText := 'SELECT * FROM dtaIdleRemarks WHERE Idle_Code = ' + varIdle;
          Open;

          //ShowMessage(IntToStr(RecordCount));
          if RecordCount > 0 then
          begin
            cmdEdit.Caption := '&SAVE';
            cmdAdd.Enabled := FALSE;
            cmdDelete.Enabled := FALSE;
            txtIdleCode.Enabled := FALSE;

            txtIdleCode.Text := FieldByName('Idle_Code').AsString;
            memIdle.Text := FieldByName('Idle_Description').AsString;

//            txtIdleCode.SetFocus;
          end
          else
            ShowMessage('No idle code found in our database!');
//          Close;
      end;
      end
      else
        ShowMessage('Please key in a valid idle code!');
  end
  else
  begin
      cmdEdit.Caption := '&EDIT';
      cmdAdd.Enabled := TRUE;
      cmdDelete.Enabled := TRUE;
      txtIdleCode.Enabled := TRUE;

//      with ADODataSet1 do
//      begin

//        Close;
//        CommandText := 'SELECT * FROM dtaIdleRemarks WHERE Idle_Code = ' + txtIdleCode.Text;
//        Open;

//        if RecordCount > 0 then
//       begin
//           ShowMessage('Idle code already exists!  Please try again.');
//            txtIdleCode.SetFocus;
//        end
//        else
//        begin
          with ADODataSet do
          begin
              Edit;
 //               FieldByName('Idle_Code').AsString := txtIdleCode.Text;
                FieldByName('Idle_Description').AsString := memIdle.Text;
              Post;

              Edit_log;

              ShowMessage('Record was successfully updated!');

              txtIdleCode.Clear;
              memIdle.Clear;

              Close;
//          end;
//        end;
      end;
  end;
end;

procedure TfrmIdleRemarksMaintenance.cmdDeleteClick(Sender: TObject);
var
  varStr : String;
begin
      varIdle := InputBox('Idle Code', 'Enter Idle Code to delete',' ');

      varLen := StrLen(PChar(varIdle));

      if varLen > 1 then
      begin
      with ADODataSet do
      begin
        Close;
        CommandText := 'SELECT * FROM dtaIdleRemarks WHERE Idle_Code = ' + varIdle;
        Open;

        if RecordCount > 0 then
        begin
        txtIdleCode.Text := FieldByName('Idle_Code').AsString;
        memIdle.Text := FieldByName('Idle_Description').AsString;

        if MessageDlg('Delete idle remark?', mtConfirmation, mbYesNo, 0) = mrYes then
          with ADOConnection do
          begin

            Delete_log;
            
            Execute('DELETE FROM dtaIdleRemarks WHERE Idle_Code = ' + varIdle);

            txtIdleCode.Clear;
            memIdle.Clear;

            ShowMessage('Record was successfully deleted!');
          end;
        end
        else
          ShowMessage ('No idle code found in our database!');
        Close;
      end;
    end
    else
      ShowMessage('Please key in a valid idle code!');
end;

procedure TfrmIdleRemarksMaintenance.cmdViewIdleRemarksClick(Sender: TObject);
begin
//  frmIdleRemarks.Show;
  with TfrmIdleRemarks.Create(Application) do show;
end;


procedure TfrmIdleRemarksMaintenance.Edit_Log;
var
  SQL: String;
begin

  with ADODataSet do begin

    if( FieldByName('Idle_Description').AsString <> memIdle.Text ) then
    begin
      SQL :=       'INSERT INTO dtaLogFile ' ;
      SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value ) ' ;
      SQL := SQL + 'VALUES ';
      SQL := SQL + '( ';
      SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
      SQL := SQL + IntToStr(gUser_ID) + ', ';
      SQL := SQL + chr(39) + 'Idle Code Maintenance' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'dtaIdleRemarks' + chr(39) + ', ';
      SQL := SQL + chr(39) + 'Idle_Description' + chr(39) + ', ';
      SQL := SQL + chr(39) + FieldByName('Idle_Description').AsString + chr(39) + ', ';
      SQL := SQL + chr(39) + memIdle.Text + chr(39);
      SQL := SQL + ')';
      ADOConnection.Execute(SQL);
    end;
  end;
end;

procedure TfrmIdleRemarksMaintenance.Delete_Log;
var
  SQL: String;
begin
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Idle Code Maintanance' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Delete' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaIdleRemarks' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Idle_Description' + chr(39) + ', ';
  SQL := SQL + chr(39) + memIdle.Text + chr(39);
  SQL := SQL + ')';
  ADOConnection.Execute(SQL);
end;

procedure TfrmIdleRemarksMaintenance.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIdleRemarksMaintenance.FormActivate(Sender: TObject);
begin

  gUser := ActiveUserName;         // this is only temporary and must be modified by using the actual user who logged in
  gUser_ID := StrToInt(ActiveUserID);

  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);

  InsertToLogFile(sTranDate, sUserID, 'Idle Code Maintenance', 'Load', 'dtaIdeRemarks', '');
end;

procedure TfrmIdleRemarksMaintenance.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
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
