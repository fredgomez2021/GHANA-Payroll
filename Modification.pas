unit Modification;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, DBCtrls, ComCtrls, EmployeeList,
  ExtCtrls, CommonModule;

type
  TfrmOvertimeValidation = class(TForm)
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    GroupBox1: TGroupBox;
    Grid: TDBGrid;
    chck1: TDBCheckBox;
    Button1: TButton;
    GroupBox2: TGroupBox;
    dtDate: TDateTimePicker;
    btnShow: TButton;
    Label1: TLabel;
    btnClose: TButton;
    Button2: TButton;
    Shape1: TShape;
    GroupBox3: TGroupBox;
    btnClear: TButton;
    btnCheckAll: TButton;
    lblRecordsFound: TLabel;
    Label2: TLabel;
    lblName: TLabel;
    dsName: TADODataSet;
    cmbBranch: TComboBox;
    Label3: TLabel;
    dsFillBranch: TADODataSet;
    dsFilter: TADODataSet;
    dsLogFile: TADODataSet;
    Button3: TButton;
    GroupBox5: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    txtUser: TEdit;
    txtUser_EmployeeName: TEdit;
    txtJobPosition: TEdit;
    ADODataSet2: TADODataSet;
    Label15: TLabel;
    cmbTaskID: TComboBox;
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure FillBranchCombo();

    procedure Button1Click(Sender: TObject);
    procedure chck1Click(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridColExit(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vId, vFieldName, vPIN, vPvalue, vNvalue, vWDate : String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOvertimeValidation: TfrmOvertimeValidation;
  ctr : Integer;
  varTaskID : String;
  IsLoad : string;

  gUser : String;
  gUser_ID : Integer;
implementation

{$R *.dfm}

procedure TfrmOvertimeValidation.FormCreate(Sender: TObject);
begin
//  IsLoad := 'False';

  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;

  //lblRecordsFound.Caption := '';
//  ADODataSet1.Close;
end;



//Including check boxes in a datagrid  -- source: www.delphi.about.com
//-- starts here

procedure TfrmOvertimeValidation.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
const IsChecked : array[Boolean] of Integer =
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  if (gdFocused in State) then
  begin
    if (Column.Field.FieldName = chck1.DataField) then
    begin
     chck1.Left := Rect.Left + Grid.Left + 2;
     chck1.Top := Rect.Top + Grid.top + 2;
     chck1.Width := Rect.Right - Rect.Left;
     chck1.Height := Rect.Bottom - Rect.Top;

     chck1.Visible := True;
    end
  end
  else
  begin
    if (Column.Field.FieldName = chck1.DataField) then
    begin
      DrawRect:=Rect;
      InflateRect(DrawRect,-1,-1);

      DrawState := ISChecked[Column.Field.AsBoolean];

      Grid.Canvas.FillRect(Rect);
      DrawFrameControl(Grid.Canvas.Handle, DrawRect,
                       DFC_BUTTON, DrawState);
    end;
  end;
end;

procedure TfrmOvertimeValidation.GridColExit(Sender: TObject);
begin
  if Grid.SelectedField.FieldName = chck1.DataField then
    chck1.Visible := False
end;

procedure TfrmOvertimeValidation.GridKeyPress(Sender: TObject; var Key: Char);
begin
//  if (key = Chr(8)) then Exit;
  if (key = Chr(8)) then Exit;

  if (Grid.SelectedField.FieldName = chck1.DataField) then
  begin
    chck1.SetFocus;
    SendMessage(chck1.Handle, WM_Char, word(Key), 0);
  end;

end;

procedure TfrmOvertimeValidation.chck1Click(Sender: TObject);
var
  varN : String;
  varWorkDate : String;
begin


    if chck1.Checked then
       chck1.Caption := chck1.ValueChecked
    else
    begin
{      if IsLoad = 'False' then
        begin
          IsLoad := 'True'
        end
      else
      begin}
        chck1.Caption := chck1.ValueUnChecked;
//        IsLoad := 'False';
      end;
//    end;


end;

//-- ends here



procedure TfrmOvertimeValidation.Button1Click(Sender: TObject);
//var
//  x : integer;
//  ListValue : string;
begin
  //update the authorizeOT field of the database
{  for x := 1 to ADODataSet1.RecordCount do
  begin
    ADODataSet1.Edit;
    ADODataSet1.RecNo := x;

    if (Grid.Fields[6].Value = null) then
      ListValue := 'No'
    else
      ListValue := Grid.Fields[6].Value;

    ADODataSet1.FieldByName('AuthorizeOT').AsString := ListValue;

    ADODataSet1.Post;
  end;

  ShowMessage('DTR Details was successfully updated!');
}
end;

//display the content of table timeinterval base on the selected date
procedure TfrmOvertimeValidation.btnShowClick(Sender: TObject);
var
  varDate : String;
begin

  isLoad := 'False';

  ADODataSet1.Close;
  ADODataSet1.Connection := ADOConnection1;

  varDate := DateToStr(dtDate.Date);

//  ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_Name, Actual_In, Actual_Out, Sched_In, Sched_Out, Regular_Hours, OT, Tardiness, Remarks, AuthorizeOT FROM dtaTime_Detail WHERE Work_Date = ' +
//      chr(39) + varDate + chr(39) + ' AND Branch_Code = ' + Chr(39) + cmbBranch.Text + Chr(39) + ' AND Task_ID = ' + Chr(39)+ varTaskID + Chr(39) + ' ORDER BY Employee_Name';

  ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_Name, Actual_In, Actual_Out, Regular_Hours, OT, Tardiness, Remarks, AuthorizeOT, Work_Date FROM dtaTime_Summary WHERE Work_Date = ' +
      chr(39) + varDate + chr(39) + ' AND Task_ID = ' + Chr(39) + cmbTaskID.Text + Chr(39) + ' AND Branch_Code = ' + Chr(39) + cmbBranch.Text + Chr(39) + ' AND OT <> 0' + ' ORDER BY Employee_Name';

  //ShowMessage (ADODataSet1.CommandText);
  ADODataSet1.Active := TRUE;

  if ADODataSet1.RecordCount > 0 then
  begin
    btnClear.Enabled := TRUE;
    btnCheckAll.Enabled := TRUE;

    Button1.Enabled := TRUE;
  end;

  lblRecordsFound.Caption := IntToStr(ADODataSet1.RecordCount) + ' records';
  end;

//check all checkboxes in the authorizeOT field
procedure TfrmOvertimeValidation.btnCheckAllClick(Sender: TObject);
begin
  ADODataSet1.First;
  for ctr := 1 to ADODataSet1.RecordCount do
  begin
    ADODataSet1.RecNo := ctr;
    ADODataSet1.Edit;

      ADODataSet1.FieldByName('AuthorizeOT').AsString := 'Yes';

      ADODataSet1.Next;
    //ADODataSet1.Post;
  end;
end;

//uncheck all checkboxes in the authorizeOT field
procedure TfrmOvertimeValidation.btnClearClick(Sender: TObject);
begin
  ADODataSet1.First;
  for ctr := 1 to ADODataSet1.RecordCount do
  begin
    ADODataSet1.RecNo := ctr;
    ADODataSet1.Edit;

      ADODataSet1.FieldByName('AuthorizeOT').AsString := 'No';
      ADODataSet1.Next;
    //ADODataSet1.Post;
  end;
end;

procedure TfrmOvertimeValidation.btnCloseClick(Sender: TObject);
begin
  ADODataSet1.Close;

  lblRecordsFound.Caption := '';
  lblName.Caption := '';

  btnClear.Enabled := FALSE;
  btnCheckAll.Enabled := FALSE;
  Button1.Enabled := FALSE;

  IsLoad := 'False';

  frmOvertimeValidation.Close;
end;

procedure TfrmOvertimeValidation.Button2Click(Sender: TObject);
begin
  frmEmployeeList.Show;
end;

procedure TfrmOvertimeValidation.FormShow(Sender: TObject);
begin
//  ShowMessage('Hello');


  chck1.DataSource := DataSource1;
  chck1.DataField := 'AuthorizeOT';
  chck1.Visible := False;
  chck1.Color := Grid.Color;
  chck1.Caption := '';

  chck1.ValueChecked := 'Yes';
  chck1.ValueUnchecked := 'No';

  FillBranchCombo();


  dsFilter.Close;
  dsFilter.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN = ' + Chr(39) + ActiveUserID + Chr(39);
  dsFilter.Active := TRUE;

  if dsFilter.RecordCount > 0 then
  begin
    varTaskID := dsFilter.FieldByName('Primary_Task_ID').AsString;
  end;
end;


procedure TfrmOvertimeValidation.FillBranchCombo();
var
  varBranch : String;
begin
  dsFillBranch.Close;
  dsFillBranch.CommandText := 'SELECT * FROM dtaBranches ORDER BY Branch_Code';
  dsFillBranch.Connection := ADOConnection1;
  dsFillBranch.Active := TRUE;

  cmbBranch.Clear;
  if dsFillBranch.RecordCount > 0 then
  begin
    dsFillBranch.First;
    while not dsFillBranch.Eof do
    begin
      varBranch := dsFillBranch.FieldByName('Branch_Code').AsString;

      cmbBranch.AddItem(varBranch, cmbBranch);

      dsFillBranch.Next;
    end;
  end;
end;


procedure TfrmOvertimeValidation.GridCellClick(Column: TColumn);
var
  ePIN  : String;
begin
 {       ePIN := ADODataSet1.FieldByName('Employee_PIN').AsString;

        dsName.Close;
        dsName.Connection := ADOConnection1;
        dsName.CommandText := 'SELECT Employee_Name FROM dtaEmployees WHERE Employee_PIN = ' + ePIN;
        dsName.Active := TRUE;

        if dsName.RecordCount > 0 then
        begin
          lblName.Font.Color := clNAVY;
          lblName.Caption := dsName.FieldByName('Employee_Name').AsString;
        end
        else
        begin
          lblName.Font.Color := clRED;
          lblName.Caption := 'No record found!';
        end;
 }
 end;

procedure TfrmOvertimeValidation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOvertimeValidation.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vId, vFieldName, vPIN, vPvalue, vNvalue, vWDate : String);
var
  valueRemarks : String;
begin
  //repeat
    valueRemarks := InputBox('Remarks entry', 'Please enter your remarks here!', '');
  //until valueRemarks <> '';

  //ShowMessage(value);

  dsLogFile.Close;
  dsLogFile.Connection := ADOConnection1;
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
      FieldByName('Id').AsString := vId;
      FieldByName('Field_Name').AsString := vFieldName;
      FieldByName('Employee_PIN').AsString := vPIN;
      FieldByName('Prev_value').AsString := vPvalue;
      FieldByName('New_value').AsString := vNvalue;
      FieldByName('Remarks').AsString := valueRemarks;
      FieldByName('Work_Date').AsString := vWDate;

    Post;

  end;
end;


procedure TfrmOvertimeValidation.FormActivate(Sender: TObject);
begin
  varModule := 'Overtime Validation';
  varTable := 'dtaTime_Summary';

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
//      cmbTaskID.ItemIndex := 0;
      cmbTaskID.Refresh;
//      ADODataSet1.Close;
//      ADODataSet1.CommandText := 'SELECT Employee_PIN, Employee_Name, Keyer_ID, Task_ID FROM vwKeyerRemarks WHERE Task_ID = ' + Chr(39) + cmbTaskID.Text + Chr(39) + ' ORDER BY Employee_Name';
//      ADODataSet1.Open;
//      DataSource1.DataSet := ADODataSet1;

      //GridTime.DataSource := DataSource1;
      //GridTime.Refresh;
    end;
    Close;
  end;

end;

procedure TfrmOvertimeValidation.Button3Click(Sender: TObject);
var
  varDate1, varN, varWorkDate : String;
begin
        varDate1 := DateToStr(Now) + ' ' + TimeToStr(Now);
        varN := ADODataSet1.FieldByName('Employee_PIN').AsString;
        varWorkDate := ADODataSet1.FieldByName('Work_Date').AsString;

        InsertToLogFile(varDate1, ActiveUserId, varModule, 'Edit', varTable, '', 'AuthorizeOT', varN, varPrevValue, varNewValue, varWorkDate);
end;

end.
