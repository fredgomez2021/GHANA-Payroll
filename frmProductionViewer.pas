// Name:  frmProductionViewer.pas
// Description:  This form is designed for production supervisor
//     and team leads.  This allows them to view production details
//     per project or per employee on a specified date range.  This
//     is very much useful in monitoring keyer production (daily or
//     periodically).

unit frmProductionViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, DB, ADODB, CommonModule, DateUtils,
  ShellAPI;

type
  TProductionViewer = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dtDate1: TDateTimePicker;
    dtDate2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    cmbEmployees: TComboBox;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    dGridProduction: TDBGrid;
    dSourceProd: TDataSource;
    ADOProd: TADOConnection;
    dsProd: TADODataSet;
    Label6: TLabel;
    Label7: TLabel;
    lblTotalDocs: TLabel;
    lblTimeTaken: TLabel;
    Label9: TLabel;
    lblTotalKS: TLabel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    cmbPrimaryTaskID: TComboBox;
    dsEmployees: TADODataSet;
    cmbTaskID: TComboBox;
    dsTaskID: TADODataSet;
    dsPrimaryTaskID: TADODataSet;
    chkTaskID: TCheckBox;
    chkEmployeeName: TCheckBox;
    dsEmpName: TADODataSet;
    chkLocation: TCheckBox;
    cboLocation: TComboBox;
    procedure cboLocationChange(Sender: TObject);
    procedure chkLocationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkTaskIDClick(Sender: TObject);
    procedure chkEmployeeNameClick(Sender: TObject);
    procedure cmbEmployeesChange(Sender: TObject);
    procedure cmbTaskIDChange(Sender: TObject);
    procedure cmbPrimaryTaskIDChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure LoadComboEmployees;
    procedure LoadProductionProject;
    function GetEmployeeName(sPIN : String) : String;
    procedure GetTotals(sDataSet : TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProductionViewer: TProductionViewer;

  varEditEmp_Name, varEditTaskID : String;
  gUser : String;
  gUser_ID : Integer;
  vEmpID : String;
  vID : String;

  varName : String;
  varPosition : String;

  varDateFrom : string;
  varDateTo : String;

implementation

{$R *.dfm}

procedure TProductionViewer.FormCreate(Sender: TObject);
begin
  ADOProd.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOProd.CommandTimeout := 0;
  ADOProd.Connected := TRUE;
end;

procedure TProductionViewer.Button1Click(Sender: TObject);
begin
  ProductionViewer.Close;
  //ShowMessage(Format('%n', [12345.678]));
end;

procedure TProductionViewer.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  With dsProd do
  begin
    Close;
    CommandText := 'SELECT * FROM vwUsers WHERE UserName=' + chr(39) + gUser + chr(39);
    Open;
    if RecordCount = 1 then begin
      varName := FieldByName('Employee_Name').AsString;
      varPosition := FieldByName('Job_Position_Code').AsString;
      end
    else begin
      ShowMessage('Multiple user found for this username [' + gUser + ']');
      //Halt(0);
      end;
    Close;
  end;

  //populate task id combo box with its corresponding
  cmbTaskID.Clear;
  With dsProd do
  begin
    Close;
    CommandText := 'SELECT * FROM dtaSupervisor_Task WHERE Employee_PIN = '+IntToStr(gUser_ID) + ' ORDER by Task_ID';
    Open;

    cmbPrimaryTaskID.Clear;
    if RecordCount > 0 then
    begin
      First;
      While Not eof do
      begin
        cmbPrimaryTaskID.AddItem(FieldByName('Task_ID').AsString, cmbPrimaryTaskID);
        Next;
      end;
    end;
    Close;
  end;

  lblTotalDocs.Caption := '0';
  lblTimeTaken.Caption := '0';
  lblTotalKS.Caption := '0';

  dtDate1.Date := Date();
  dtDate2.Date := Date();

end;

procedure TProductionViewer.LoadComboEmployees;
begin
  cmbEmployees.Clear;
  With dsProd do
  begin
    Close;
    CommandText := 'SELECT Employee_PIN, Employee_Name FROM dtaEmployees WHERE Primary_Task_ID = ''' + cmbTaskID.Text + ''' ORDER BY Employee_Name';
    Open;

    if RecordCount > 0 then
    begin
      First;
      While Not eof do
      begin
        cmbEmployees.AddItem(FieldByName('Employee_Name').AsString, cmbEmployees);
      end;
      cmbEmployees.ItemIndex := 0;
      cmbEmployees.Refresh;
    end;

    Close;
  end;
end;

procedure TProductionViewer.LoadProductionProject;
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';

  LoadComboEmployees;

  //load production by project
  with dsProd do
  begin
    Close;
    CommandText
  end;
end;

procedure TProductionViewer.cmbPrimaryTaskIDChange(Sender: TObject);
var
  xName : string;
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';
//  varDateTo := DateToStr(dtDate2.Date);
//  varDateTo := DateToStr(IncDay(StrtoDate(varDateTo), 1)) + ' 11:59:59 AM';

  dsPrimaryTaskID.Close;
  dsPrimaryTaskID.CommandText := 'SELECT Task_ID FROM dtaTaskRemarks WHERE Task_Description = ''' + cmbPrimaryTaskID.Text + '''';
  dsPrimaryTaskID.Open;

  if dsPrimaryTaskID.RecordCount > 0 then
  begin
    dsTaskID.Close;
    dsTaskID.CommandText := 'SELECT DISTINCT Tran_Date, Employee_PIN, Keyer_ID, Task_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProduction WHERE Task_ID IN (' + dsPrimaryTaskID.CommandText + ') ' +
      'AND Tran_Date BETWEEN ''' + varDateFrom + ''' AND ''' + varDateTo + ''' ORDER BY Tran_Date, Keyer_ID';
    dsTaskID.Open;

    //view production on grid and compute for total
    dSourceProd.DataSet := dsTaskID;
    dGridProduction.DataSource := dSourceProd;
    dGridProduction.Refresh;

    GetTotals(dsTaskID);


    dsEmpName.Close;
//    dsEmpName.CommandText := 'SELECT DISTINCT Employee_PIN, Employee_Name FROM vwProductionViewer WHERE Task_ID IN (' + dsPrimaryTaskID.CommandText + ') ' +
//      'AND Tran_Date BETWEEN ''' + varDateFrom + ''' AND ''' + varDateTo + ''' ORDER BY Employee_Name';
    dsEmpName.CommandText := 'SELECT DISTINCT Employee_PIN FROM vwProduction WHERE Task_ID IN (' + dsPrimaryTaskID.CommandText + ') ' +
      'AND Tran_Date BETWEEN ''' + varDateFrom + ''' AND ''' + varDateTo + ''' ORDER BY Employee_pin';
    dsEmpName.Open;

    cmbEmployees.Clear;
    with dsEmpName do
    begin
      First;

      while not eof do
      begin
        xName := GetEmployeeName(FieldByName('Employee_PIN').AsString);

        if (xName <> '') then
          cmbEmployees.AddItem(xName, cmbEmployees);

        Next;
      end;
    end;


    cmbTaskID.Clear;
    with dsPrimaryTaskID do
    begin
      First;

      while not eof do
      begin
        cmbTaskID.AddItem(FieldByName('Task_ID').AsString, cmbTaskID);

        Next;
      end;
    end;
  end;
end;

procedure TProductionViewer.GetTotals(sDataSet : TDataSet);
var
  vDocs, vKS : Extended;
  vTimeTaken : Extended;
begin
//label totals
  vDocs := 0;
  vTimeTaken := 0;
  vKS := 0;

  sDataSet.First;
  while not sDataSet.Eof do
  begin
    if (sDataSet.FieldByName('Docs').IsNull = false) then
      vDocs := vDocs + sDataSet.FieldByName('Docs').Value;

    if (sDataSet.FieldByName('Time_Taken').IsNull = false) then
      vTimeTaken := vTimeTaken + sDataSet.FieldByName('Time_Taken').Value;

    if (sDataSet.FieldByName('KS').IsNull = false) then
      vKS := vKS + sDataSet.FieldByName('KS').Value;

    sDataSet.Next;
  end;

  lblTotalDocs.Caption := FloatToStrF(vDocs, ffNumber, 12, 2);
  lblTimeTaken.Caption := FloatToStrF(vTimeTaken, ffNumber, 12, 2) + ' minutes';
  lblTotalKS.Caption := FloatToStrF(vKS, ffNumber, 12, 2);

end;

function TProductionViewer.GetEmployeeName(sPIN : String) : String;
begin
//get employee name
  dsEmployees.Close;
  dsEmployees.CommandText := 'SELECT Employee_Name FROM dtaEmployees WHERE Employee_PIN = ''' + sPIN + '''';
  dsEmployees.Open;

  if dsEmployees.RecordCount > 0 then
  begin
    GetEmployeeName := dsEmployees.FieldByName('Employee_Name').AsString;
  end;
end;

procedure TProductionViewer.cmbTaskIDChange(Sender: TObject);
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';
//  varDateTo := DateToStr(dtDate2.Date);
//  varDateTo := DateToStr(IncDay(StrtoDate(varDateTo), 1)) + ' 11:59:59 AM';

  dsProd.Close;
  dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProduction WHERE Task_ID = ''' + cmbTaskID.Text + ''' AND Tran_Date BETWEEN ''' +
      varDateFrom + ''' AND ''' + varDateTo + ''' ORDER BY Tran_Date, Keyer_ID';
  dsProd.Open;

  dSourceProd.DataSet := dsProd;
  dGridProduction.DataSource := dSourceProd;
  dGridProduction.Refresh;

  GetTotals(dsProd);
end;

procedure TProductionViewer.cmbEmployeesChange(Sender: TObject);
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';
//  varDateTo := DateToStr(dtDate2.Date);
//  varDateTo := DateToStr(IncDay(StrtoDate(varDateTo), 1)) + ' 11:59:59 AM';

  dsProd.Close;

  if (chkTaskID.Checked = true) then
  begin
    dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProductionViewer WHERE Task_ID = ''' + cmbTaskID.Text + ''' AND Tran_Date BETWEEN ''' +
      varDateFrom + ''' AND ''' + varDateTo + ''' AND Employee_Name = ''' + cmbEmployees.Text +
      ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Employee_Name = ''' + cmbEmployees.text +
      ''' AND Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
      ''') ORDER BY Tran_Date, Keyer_ID';

      if (chkLocation.Checked = true) then
      begin

        dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
          'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProductionViewer WHERE Task_ID = ''' + cmbTaskID.Text + ''' AND Tran_Date BETWEEN ''' +
          varDateFrom + ''' AND ''' + varDateTo + ''' AND Employee_Name = ''' + cmbEmployees.Text +
          ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Employee_Name = ''' + cmbEmployees.text +
          ''' AND Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
          ''') AND Emp_Loc = ''' + cboLocation.Text + ''' ORDER BY Tran_Date, Keyer_ID';

      end;

  end
  else if (chkTaskID.Checked = false) then
  begin
    dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProductionViewer WHERE Task_ID IN (SELECT Task_ID FROM dtaTaskRemarks WHERE Task_Description = ''' +
      cmbPrimaryTaskID.Text + ''') AND Employee_Name = ''' + cmbEmployees.Text + ''' AND Tran_Date BETWEEN ''' +
      varDateFrom + ''' AND ''' + varDateTo + //''' ORDER BY Extracted_Tran_Date, Keyer_ID';
      ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Employee_Name = ''' + cmbEmployees.text +
      ''' AND Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
      ''') ORDER BY Tran_Date, Keyer_ID';

      if (chkLocation.Checked = true) then
      begin

        dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
          'Doc_Rate, Doc_Amt, Batchname, KS FROM vwProductionViewer WHERE Task_ID IN (SELECT Task_ID FROM dtaTaskRemarks WHERE Task_Description = ''' +
          cmbPrimaryTaskID.Text + ''') AND Employee_Name = ''' + cmbEmployees.Text + ''' AND Tran_Date BETWEEN ''' +
          varDateFrom + ''' AND ''' + varDateTo + //''' ORDER BY Extracted_Tran_Date, Keyer_ID';
          ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Employee_Name = ''' + cmbEmployees.text +
          ''' AND Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
          ''') AND Emp_Loc = ''' + cboLocation.Text + ''' ORDER BY Tran_Date, Keyer_ID';

      end;

  end;
  dsProd.Open;

  dSourceProd.DataSet := dsProd;
  dGridProduction.DataSource := dSourceProd;
  dGridProduction.Refresh;

  GetTotals(dsProd);
end;

procedure TProductionViewer.chkEmployeeNameClick(Sender: TObject);
begin
  if (chkEmployeeName.Checked = true) then
    cmbEmployees.Enabled := true
  else if (chkEmployeeName.Checked = false) then
    cmbEmployees.Enabled := false;
end;

procedure TProductionViewer.chkTaskIDClick(Sender: TObject);
begin
  if (chkTaskID.Checked = true) then
    cmbTaskID.Enabled := true
  else if (chkTaskID.Checked = false) then
    cmbTaskID.Enabled := false;
end;

procedure TProductionViewer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TProductionViewer.chkLocationClick(Sender: TObject);
begin
  if (chkLocation.Checked = true) then
    cboLocation.Enabled := true
  else if (chkLocation.Checked = false) then
    cboLocation.Enabled := false;
end;

procedure TProductionViewer.cboLocationChange(Sender: TObject);
begin
  varDateFrom := DateToStr(dtDate1.Date) + ' 12:00:00 AM';
  varDateTo := DateToStr(dtDate2.Date) + ' 11:59:59 PM';
//  varDateTo := DateToStr(dtDate2.Date);
//  varDateTo := DateToStr(IncDay(StrtoDate(varDateTo), 1)) + ' 11:59:59 AM';

  dsProd.Close;

  if (chkTaskID.Checked = true) then
  begin
    dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS, Emp_Loc FROM vwProductionViewer WHERE Task_ID = ''' + cmbTaskID.Text + ''' AND Tran_Date BETWEEN ''' +
      varDateFrom + ''' AND ''' + varDateTo + ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
      ''') AND emp_loc = ''' + cboLocation.Text + ''' ORDER BY Tran_Date, Keyer_ID';
  end
  else if (chkTaskID.Checked = false) then
  begin
    dsProd.CommandText := 'SELECT DISTINCT Tran_Date, Task_ID, Keyer_ID, Batches, Docs, Pulls, Time_Taken, ' +
      'Doc_Rate, Doc_Amt, Batchname, KS, Emp_Loc FROM vwProductionViewer WHERE Task_ID IN (SELECT Task_ID FROM dtaTaskRemarks WHERE Task_Description = ''' +
      cmbPrimaryTaskID.Text + ''') AND Tran_Date BETWEEN ''' +
      varDateFrom + ''' AND ''' + varDateTo + //''' ORDER BY Extracted_Tran_Date, Keyer_ID';
      ''' AND Time_ID IN (SELECT Time_ID FROM dtaTime_Summary WHERE Work_date BETWEEN ''' + DateToStr(dtDate1.Date) + ''' AND ''' + DateToStr(dtDate2.Date) +
      ''') AND emp_loc = ''' + cboLocation.Text + ''' ORDER BY Tran_Date, Keyer_ID';

  end;
  dsProd.Open;

  dSourceProd.DataSet := dsProd;
  dGridProduction.DataSource := dSourceProd;
  dGridProduction.Refresh;

  GetTotals(dsProd);
end;

end.
