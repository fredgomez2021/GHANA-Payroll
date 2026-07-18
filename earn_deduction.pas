// Name:  Earn_Deduction.pas
// Description:  This window is used for entry of payroll details
//     (earnings or deductions) of employees that are beyond the
//     scope of payroll such as those earnings and deductions before
//     and after tax.  These entries are made before the processing of payroll.

unit earn_deduction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DateUtils, DBGrids, CommonModule, ComCtrls, ExtCtrls,
  DBCtrls;

type
  TfrmEarnDed = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    dtDate1: TDateTimePicker;
    Label2: TLabel;
    dtDate2: TDateTimePicker;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    tbEmp_pin: TEdit;
    Label4: TLabel;
    tbEmp_name: TEdit;
    ADODataSet2: TADODataSet;
    cmdAdd: TButton;
    cmdEdit: TButton;
    cmdDelete: TButton;
    cmdSave: TButton;
    cmdCancel: TButton;
    Label23: TLabel;
    txtDaysAbsent: TEdit;
    txtDayOffHrsWork: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    cmdGo: TButton;
    ADODataSet3: TADODataSet;
    dbEmployeeList: TDBLookupComboBox;
    DataSource2: TDataSource;
    GroupBox8: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    SLA5: TRadioButton;
    SLA10: TRadioButton;
    ADODataSet4: TADODataSet;
    GroupBox7: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    tbDDesc4: TEdit;
    tbDAmt4: TEdit;
    tbDAmt5: TEdit;
    tbDDesc5: TEdit;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Label26: TLabel;
    tbEDesc4: TEdit;
    tbEDesc5: TEdit;
    tbEAmt5: TEdit;
    tbEAmt4: TEdit;
    GroupBox5: TGroupBox;
    Label18: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    tbDDesc2: TEdit;
    tbDAmt2: TEdit;
    tbDAmt1: TEdit;
    tbDDesc1: TEdit;
    tbDDesc3: TEdit;
    tbDAmt3: TEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    tbEDesc1: TEdit;
    tbEAmt1: TEdit;
    tbEDesc2: TEdit;
    tbEAmt2: TEdit;
    tbEAmt3: TEdit;
    tbEDesc3: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    txtFile: TEdit;
    btnOpen: TButton;
    btnExtract: TButton;
    OpenDialog1: TOpenDialog;
    dsOther: TADODataSet;
    ADOConn: TADOConnection;
    dsOther1: TADODataSet;
    dsPeriod: TADODataSet;
    dsLogFile: TADODataSet;
    btnClearSLA: TButton;
    procedure btnClearSLAClick(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dbEmployeeListClick(Sender: TObject);
    procedure cmdGoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure tbEmp_pinKeyPress(Sender: TObject; var Key: Char);
    procedure tbEmp_pinEnter();
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    //procedure dtDate1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure dtDate1Change(Sender: TObject);
//    procedure dtdate1DrapDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Grid_Load;
    procedure Add_log;
    procedure Edit_log;
    procedure Delete_Log( tbEmp_pin: String);

    procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);

    //procedure txtEmp_PINKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEarnDed: TfrmEarnDed;
  Status_mode : string;
  varPin : String;
  gUser : String;
  gUser_ID : Integer;

  sUserID : string;
  sTranDate : string;

implementation
  uses ComObj;

{$R *.dfm}

{procedure TTformEarnDed.txtEmp_PINKeyPress(Sender: TObject; var Key: Char);
{begin
  if Key = #13 then
  begin
    ADODataSet1.Close;
    ADODataSet1.CommandText := 'SELECT Employee_name FROM dtaEmployees WHERE Employee_PIN = ' + Chr(39) + txtEmp_PIN.Text + Chr(39);
    ADODataSet1.Active := TRUE;

    if ADODataSet1.RecordCount > 0 then
    begin
      txtEmp_name.Text := ADODataSet1.FieldByName('Employee_Name').AsString;
      dbgrid1.Hide;
    end;
  end;
end;}

{procedure TTformEarnDed.dtdate1DrapDrop(Sender, Source: TObject; X, Y: Integer);
begin
      showmessage('hello');
end;}

procedure TfrmEarnDed.dtDate1Change(Sender: TObject);
var
  dt : TDateTime;
  myYear, myMonth, myDay : Word;
begin

  DecodeDate(dtDate1.Date, myYear, myMonth, myDay);

  if(DayOfTheMonth(dtDate1.Date))= 1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
    dtDate2.Date := dt;
    dtDate2.Refresh;

end;

procedure TfrmEarnDed.FormCreate(Sender: TObject);
begin
    cmdSave.Hide;
    cmdCancel.Hide;
    cmdCancel.Top := cmdSave.Top;
//    dbgrid1.Visible := false;

    ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
    ADOConnection1.Connected := TRUE;

    ADODataSet3.Close;
    ADODataSet3.CommandText := 'SELECT Employee_Name, Employee_PIN FROM dtaEmployees ORDER BY Employee_Name';
    ADODataSet3.Active := TRUE;

    dbEmployeeList.ListSource := DataSource2;
    dbEmployeeList.ListField := 'Employee_Name';
    dbEmployeeList.KeyField := 'Employee_PIN';

end;

procedure TfrmEarnDed.DBGrid1CellClick(Column: TColumn);
begin

 // ShowMessage(IntToStr(dbgrid1.));

    ADODataSet1.Close;
    ADODataSet1.CommandText := 'select * from dtaOther_Earn_ded where payroll_period = ' + Chr(39) +  DateToStr(dtDate1.Date) + Chr(39) + ' AND Employee_PIN = ' + ADODataSet2.FieldByName('Employee_PIN').AsString;
    ADODataSet1.Active := TRUE;

    //if ADODataSet1.RecordCount > 0 then
    //begin
      tbEmp_pin.text  := ADODataSet1.FieldByName('Employee_Pin').asString;
      tbEmp_name.text := ADODataSet2.FieldByName('Employee_Name').asString;

      txtDaysAbsent.text  := ADODataSet1.FieldByName('DaysAbsent').asString;
      txtDayOffHrsWork.text  := ADODataSet1.FieldByName('DayOffHrsWork').asString;

      tbEDesc1.Text   := ADODataSet1.FieldByName('other_earn_description1').asString;
      tbEDesc2.Text   := ADODataSet1.FieldByName('other_earn_description2').asString;
      tbEDesc3.Text   := ADODataSet1.FieldByName('other_earn_description3').asString;
      tbEDesc4.Text   := ADODataSet1.FieldByName('other_earn_description4').asString;
      tbEDesc5.Text   := ADODataSet1.FieldByName('other_earn_description5').asString;
      tbEAmt1.Text    := ADODataSet1.FieldByName('other_earn_amount1').asString;
      tbEAmt2.Text    := ADODataSet1.FieldByName('other_earn_amount2').asString;
      tbEAmt3.Text    := ADODataSet1.FieldByName('other_earn_amount3').asString;
      tbEAmt4.Text    := ADODataSet1.FieldByName('other_earn_amount4').asString;
      tbEAmt5.Text    := ADODataSet1.FieldByName('other_earn_amount5').asString;
      tbDDesc1.Text   := ADODataSet1.FieldByName('other_ded_description1').asString;
      tbDDesc2.Text   := ADODataSet1.FieldByName('other_ded_description2').asString;
      tbDDesc3.Text   := ADODataSet1.FieldByName('other_ded_description3').asString;
      tbDDesc4.Text   := ADODataSet1.FieldByName('other_ded_description4').asString;
      tbDDesc5.Text   := ADODataSet1.FieldByName('other_ded_description5').asString;
      tbDAmt1.Text    := ADODataSet1.FieldByName('other_ded_amount1').asString;
      tbDAmt2.Text    := ADODataSet1.FieldByName('other_ded_amount2').asString;
      tbDAmt3.Text    := ADODataSet1.FieldByName('other_ded_amount3').asString;
      tbDAmt4.Text    := ADODataSet1.FieldByName('other_ded_amount4').asString;
      tbDAmt5.Text    := ADODataSet1.FieldByName('other_ded_amount5').asString;
      if ADODataSet1.FieldByName('SLA5').AsVariant=true then
        begin
          sla5.Checked    := true;
          sla10.Checked    := false;
        end
      else if ADODataSet1.FieldByName('SLA10').AsVariant=true then
        begin
          sla10.Checked    := true;
          sla5.Checked    := false;
        end
      else
        begin
          sla10.Checked    := false;
          sla5.Checked    := false;
        end;
      // Disable all fields
      tbEmp_pin.Enabled  := False;
      txtDaysAbsent.Enabled := False;
      txtDayOffHrsWork.Enabled := False;
      tbEmp_name.Enabled := False;
      tbEDesc1.Enabled   := False;
      tbEDesc2.Enabled   := False;
      tbEDesc3.Enabled   := False;
      tbEDesc4.Enabled   := False;
      tbEDesc5.Enabled   := False;
      tbEAmt1.Enabled    := False;
      tbEAmt2.Enabled    := False;
      tbEAmt3.Enabled    := False;
      tbEAmt4.Enabled    := False;
      tbEAmt5.Enabled    := False;
      tbDDesc1.Enabled   := False;
      tbDDesc2.Enabled   := False;
      tbDDesc3.Enabled   := False;
      tbDDesc4.Enabled   := False;
      tbDDesc5.Enabled   := False;
      tbDAmt1.Enabled    := False;
      tbDAmt2.Enabled    := False;
      tbDAmt3.Enabled    := False;
      tbDAmt4.Enabled    := False;
      tbDAmt5.Enabled    := False;


    //end;
end;

{procedure TTformEarnDed.dtDate1Click(Sender: TObject);
var
  dt: TDateTime;
  myYear, myMonth, myDay : Word;
begin
    DecodeDate(dtDate1.Date, myYear, myMonth, myDay);
  if(DayOfTheMonth(dtDate1.Date))=1 then
    dt := EncodeDate( myYear, myMonth, 15)
  else
    begin
      dt := EndOfAMonth( myYear, myMonth );
      DecodeDate( dt, myYear, myMonth, myDay );
      dt := EncodeDate( myYear, myMonth, myDay );
    end;
  dtDate2.Date := dt;
  dtDate2.Refresh;

    ADODataSet1.Close;
    ADODataSet1.CommandText := 'SELECT employee_pin, EMployee_Name FROM vwOther_Earn_Ded where payroll_period = '  + Chr(39) +  DateToStr(dtDate1.Date) + Chr(39);
    ADODataSet1.Open;

    if ADODATASET1.RecordCount > 0 then
      begin
        DataSource1.DataSet := ADODataSet1;
        DBGrid1.DataSource := DataSource1;
        DBGrid1.Refresh;
      end
    else
    ShowMessage('NO RECORD FOUND');
end; }

procedure TfrmEarnDed.cmdCloseClick(Sender: TObject);
begin
//TformEarnDed.close;
end;

procedure TfrmEarnDed.cmdAddClick(Sender: TObject);
begin
      status_mode := 'Add';
      // Clear all fields
      tbEmp_pin.Clear;
      tbEmp_name.Clear;
      txtDaysAbsent.Clear;
      txtDayOffHrsWork.Clear;
      tbEDesc1.Clear;
      tbEDesc2.Clear;
      tbEDesc3.Clear;
      tbEDesc4.Clear;
      tbEDesc5.Clear;
      tbEAmt1.Clear;
      tbEAmt2.Clear;
      tbEAmt3.Clear;
      tbEAmt4.Clear;
      tbEAmt5.Clear;
      tbDDesc1.Clear;
      tbDDesc2.Clear;
      tbDDesc3.Clear;
      tbDDesc4.Clear;
      tbDDesc5.Clear;
      tbDAmt1.Clear;
      tbDAmt2.Clear;
      tbDAmt3.Clear;
      tbDAmt4.Clear;
      tbDAmt5.Clear;

      //Enable all fields
      tbEmp_pin.Enabled  := True;
      tbEmp_name.Enabled := True;
      txtDaysAbsent.Enabled  := True;
      //txtDayOffHrsWork.Enabled := True;
      tbEDesc1.Enabled   := True;
      tbEDesc2.Enabled   := True;
      tbEDesc3.Enabled   := True;
      tbEDesc4.Enabled   := True;
      tbEDesc5.Enabled   := True;
      tbEAmt1.Enabled    := True;
      tbEAmt2.Enabled    := True;
      tbEAmt3.Enabled    := True;
      tbEAmt4.Enabled    := True;
      tbEAmt5.Enabled    := True;
      tbDDesc1.Enabled   := True;
      tbDDesc2.Enabled   := True;
      tbDDesc3.Enabled   := True;
      tbDDesc4.Enabled   := True;
      tbDDesc5.Enabled   := True;
      tbDAmt1.Enabled    := True;
      tbDAmt2.Enabled    := True;
      tbDAmt3.Enabled    := True;
      tbDAmt4.Enabled    := True;
      tbDAmt5.Enabled    := True;

      //Display Save and Cancel Button

      cmdSave.Visible   := True;
      cmdCancel.Visible := True;
      cmdAdd.Visible    := False;
      cmdEdit.Visible   := False;
      cmdDelete.Visible := False;
//      cmdClose.Visible  := False;

      SLA5.Checked := false;
      SLA10.Checked := false;

      tbEmp_pin.SetFocus;
end;

procedure TfrmEarnDed.cmdSaveClick(Sender: TObject);

begin
// Save for Add Function
if(status_mode = 'Add') then
begin
if(tbEmp_pin.Text <> '') AND (tbEmp_name.Text <> '') then
   with ADODataset1 do
   begin
      close;
      CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin = ' + tbEmp_pin.text + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39);
      open;

      if ADODataset1.RecordCount > 0 then
         showmessage('Record already exists!')
      else
      begin

        insert;
          FieldByName('Employee_Pin').asString              :=  tbEmp_pin.text;
          FieldByName('DaysAbsent').AsString            :=  txtDaysAbsent.Text;
          FieldByName('DayOffHrsWork').AsString            :=  txtDayOffHrsWork.Text;
          FieldByName('payroll_period').AsString            :=  DateToStr(dtdate1.Date);
          //ADODataset2.FieldByName('Employee_Name').asString := tbEmp_name.text;
          FieldByName('other_earn_description1').asString   := tbEDesc1.Text;
          FieldByName('other_earn_description2').asString   := tbEDesc2.Text;
          FieldByName('other_earn_description3').asString   := tbEDesc3.Text;
          FieldByName('other_earn_description4').asString   := tbEDesc4.Text;
          FieldByName('other_earn_description5').asString   := tbEDesc5.Text;
          FieldByName('other_earn_amount1').asString        := tbEAmt1.Text;
          FieldByName('other_earn_amount2').asString        := tbEAmt2.Text;
          FieldByName('other_earn_amount3').asString        := tbEAmt3.Text;
          FieldByName('other_earn_amount4').asString        := tbEAmt4.Text;
          FieldByName('other_earn_amount5').asString        := tbEAmt5.Text;
          FieldByName('other_ded_description1').asString    := tbDDesc1.Text;
          FieldByName('other_ded_description2').asString    := tbDDesc2.Text;
          FieldByName('other_ded_description3').asString    := tbDDesc3.Text;
          FieldByName('other_ded_description4').asString    := tbDDesc4.Text;
          FieldByName('other_ded_description5').asString    := tbDDesc5.Text;
          FieldByName('other_ded_amount1').asString         := tbDAmt1.Text;
          FieldByName('other_ded_amount2').asString         := tbDAmt2.Text;
          FieldByName('other_ded_amount3').asString         := tbDAmt3.Text;
          FieldByName('other_ded_amount4').asString         := tbDAmt4.Text;
          FieldByName('other_ded_amount5').asString         := tbDAmt5.Text;
          FieldByName('SLA5').AsVariant         := sla5.Checked;
          FieldByName('SLA10').AsVariant        := sla10.Checked;        post;
        Grid_Load;
        ShowMessage('New Employee record was successfully added!');

        Close;

        Add_Log;
        
      end;
    end;
end

else
// Save for Edit Function

if(status_mode = 'Edit')then
begin
  with ADODataset1 do
   begin
      close;
//      CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin ='  + Chr(39) +  tbEmp_pin.text + Chr(39);
      CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin = ' + tbEmp_pin.text + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39);
      open;
      edit_log;
        Edit;
          FieldByName('DaysAbsent').AsString            :=  txtDaysAbsent.Text;
          FieldByName('DayOffHrsWork').AsString            :=  txtDayOffHrsWork.Text;
          FieldByName('other_earn_description1').asString   := tbEDesc1.Text;
          FieldByName('other_earn_description2').asString   := tbEDesc2.Text;
          FieldByName('other_earn_description3').asString   := tbEDesc3.Text;
          FieldByName('other_earn_description4').asString   := tbEDesc4.Text;
          FieldByName('other_earn_description5').asString   := tbEDesc5.Text;
          FieldByName('other_earn_amount1').asString        := tbEAmt1.Text;
          FieldByName('other_earn_amount2').asString        := tbEAmt2.Text;
          FieldByName('other_earn_amount3').asString        := tbEAmt3.Text;
          FieldByName('other_earn_amount4').asString        := tbEAmt4.Text;
          FieldByName('other_earn_amount5').asString        := tbEAmt5.Text;
          FieldByName('other_ded_description1').asString    := tbDDesc1.Text;
          FieldByName('other_ded_description2').asString    := tbDDesc2.Text;
          FieldByName('other_ded_description3').asString    := tbDDesc3.Text;
          FieldByName('other_ded_description4').asString    := tbDDesc4.Text;
          FieldByName('other_ded_description5').asString    := tbDDesc5.Text;
          FieldByName('other_ded_amount1').asString         := tbDAmt1.Text;
          FieldByName('other_ded_amount2').asString         := tbDAmt2.Text;
          FieldByName('other_ded_amount3').asString         := tbDAmt3.Text;
          FieldByName('other_ded_amount4').asString         := tbDAmt4.Text;
          FieldByName('other_ded_amount5').asString         := tbDAmt5.Text;
          FieldByName('SLA5').AsVariant         := sla5.Checked;
          FieldByName('SLA10').AsVariant        := sla10.Checked;
        post;
        ShowMessage('Record was successfully updated!');
   end;

end;
      cmdSave.Visible   := False;
      cmdCancel.Visible := False;
      cmdAdd.Visible    := True;
      cmdEdit.Visible   := True;
      cmdDelete.Visible := True;
//      cmdClose.Visible  := True;

      // Disable all fields
      tbEmp_pin.Enabled  := False;
      txtDaysAbsent.Enabled := False;
      txtDayOffHrsWork.Enabled := False;
      tbEmp_name.Enabled := False;
      tbEDesc1.Enabled   := False;
      tbEDesc2.Enabled   := False;
      tbEDesc3.Enabled   := False;
      tbEDesc4.Enabled   := False;
      tbEDesc5.Enabled   := False;
      tbEAmt1.Enabled    := False;
      tbEAmt2.Enabled    := False;
      tbEAmt3.Enabled    := False;
      tbEAmt4.Enabled    := False;
      tbEAmt5.Enabled    := False;
      tbDDesc1.Enabled   := False;
      tbDDesc2.Enabled   := False;
      tbDDesc3.Enabled   := False;
      tbDDesc4.Enabled   := False;
      tbDDesc5.Enabled   := False;
      tbDAmt1.Enabled    := False;
      tbDAmt2.Enabled    := False;
      tbDAmt3.Enabled    := False;
      tbDAmt4.Enabled    := False;
      tbDAmt5.Enabled    := False;
end;

{procedure TTformEarnDed.tbEmp_pinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    ADODataSet1.Close;
    ADODataSet1.CommandText := 'select Employee_Name from dtaEmployees where employee_pin = ' + Chr(39) +  tbEmp_pin.Text + Chr(39);
    ADODataSet1.Active := TRUE;

    tbEmp_name.text := ADODataSet1.FieldByName('Employee_Name').asString;
end; }

procedure TfrmEarnDed.tbEmp_pinEnter();
begin
    ADODataSet1.Close;
    ADODataSet1.CommandText := 'select Employee_Name from dtaEmployees where employee_pin = ' + Chr(39) +  tbEmp_pin.Text + Chr(39);
    ADODataSet1.Active := TRUE;

    if ADODataSet1.RecordCount > 0 then
      tbEmp_name.text := ADODataSet1.FieldByName('Employee_Name').asString
    else
      ShowMessage('No record found!');
end;

procedure TfrmEarnDed.tbEmp_pinKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    tbEmp_pinEnter();
end;

procedure TfrmEarnDed.Grid_Load;
begin
    ADODataSet2.Close;
    ADODataSet2.CommandText := 'SELECT employee_pin, Employee_Name FROM vwOther_Earn_Ded where payroll_period = '  + Chr(39) +  DateToStr(dtDate1.Date) + Chr(39) + 'order by employee_name';
    ADODataSet2.Open;

    if ADODATASET2.RecordCount > 0 then
      begin
        DataSource1.DataSet := ADODataSet2;
        DBGrid1.DataSource := DataSource1;
        DBGrid1.Refresh;
      end

    else
    showmessage('NO RECORD FOUND!');
    //dbgrid1.Visible := false;
end;

procedure TfrmEarnDed.cmdCancelClick(Sender: TObject);
begin
      cmdSave.Visible   := False;
      cmdCancel.Visible := False;
      cmdAdd.Visible    := True;
      cmdEdit.Visible   := True;
      cmdDelete.Visible := True;
//      cmdClose.Visible  := True;

       // Disable all fields
      tbEmp_pin.Enabled  := False;
      txtDaysAbsent.Enabled := False;
      txtDayOffHrsWork.Enabled := False;
      tbEmp_name.Enabled := False;
      tbEDesc1.Enabled   := False;
      tbEDesc2.Enabled   := False;
      tbEDesc3.Enabled   := False;
      tbEDesc4.Enabled   := False;
      tbEDesc5.Enabled   := False;
      tbEAmt1.Enabled    := False;
      tbEAmt2.Enabled    := False;
      tbEAmt3.Enabled    := False;
      tbEAmt4.Enabled    := False;
      tbEAmt5.Enabled    := False;
      tbDDesc1.Enabled   := False;
      tbDDesc2.Enabled   := False;
      tbDDesc3.Enabled   := False;
      tbDDesc4.Enabled   := False;
      tbDDesc5.Enabled   := False;
      tbDAmt1.Enabled    := False;
      tbDAmt2.Enabled    := False;
      tbDAmt3.Enabled    := False;
      tbDAmt4.Enabled    := False;
      tbDAmt5.Enabled    := False;

      // Clear all fields
      tbEmp_pin.Clear;
      txtDaysAbsent.Clear;
      txtDayOffHrsWork.Clear;
      tbEmp_name.Clear;
      tbEDesc1.Clear;
      tbEDesc2.Clear;
      tbEDesc3.Clear;
      tbEDesc4.Clear;
      tbEDesc5.Clear;
      tbEAmt1.Clear;
      tbEAmt2.Clear;
      tbEAmt3.Clear;
      tbEAmt4.Clear;
      tbEAmt5.Clear;
      tbDDesc1.Clear;
      tbDDesc2.Clear;
      tbDDesc3.Clear;
      tbDDesc4.Clear;
      tbDDesc5.Clear;
      tbDAmt1.Clear;
      tbDAmt2.Clear;
      tbDAmt3.Clear;
      tbDAmt4.Clear;
      tbDAmt5.Clear;
end;

procedure TfrmEarnDed.cmdEditClick(Sender: TObject);
begin
status_mode := 'Edit';
  // Diable Employee pin and Employee Name Field
      tbEmp_pin.Enabled  := False;
      tbEmp_name.Enabled := False;

  // Enable Input Fields
      txtDaysAbsent.Enabled := True;
      //txtDayOffHrsWork.Enabled := True;
      tbEDesc1.Enabled   := True;
      tbEDesc2.Enabled   := True;
      tbEDesc3.Enabled   := True;
      tbEDesc4.Enabled   := True;
      tbEDesc5.Enabled   := True;
      tbEAmt1.Enabled    := True;
      tbEAmt2.Enabled    := True;
      tbEAmt3.Enabled    := True;
      tbEAmt4.Enabled    := True;
      tbEAmt5.Enabled    := True;
      tbDDesc1.Enabled   := True;
      tbDDesc2.Enabled   := True;
      tbDDesc3.Enabled   := True;
      tbDDesc4.Enabled   := True;
      tbDDesc5.Enabled   := True;
      tbDAmt1.Enabled    := True;
      tbDAmt2.Enabled    := True;
      tbDAmt3.Enabled    := True;
      tbDAmt4.Enabled    := True;
      tbDAmt5.Enabled    := True;

      cmdSave.Visible   := True;
      cmdCancel.Visible := True;
      cmdAdd.Visible    := False;
      cmdEdit.Visible   := False;
      cmdDelete.Visible := False;
//      cmdClose.Visible  := False;

end;

procedure TfrmEarnDed.cmdDeleteClick(Sender: TObject);
begin
      status_mode := 'Delete';
  // Disable all fields
      tbEmp_pin.Enabled  := False;
      txtDaysAbsent.Enabled := False;
      txtDayOffHrsWork.Enabled := False;
      tbEmp_name.Enabled := False;
      tbEDesc1.Enabled   := False;
      tbEDesc2.Enabled   := False;
      tbEDesc3.Enabled   := False;
      tbEDesc4.Enabled   := False;
      tbEDesc5.Enabled   := False;
      tbEAmt1.Enabled    := False;
      tbEAmt2.Enabled    := False;
      tbEAmt3.Enabled    := False;
      tbEAmt4.Enabled    := False;
      tbEAmt5.Enabled    := False;
      tbDDesc1.Enabled   := False;
      tbDDesc2.Enabled   := False;
      tbDDesc3.Enabled   := False;
      tbDDesc4.Enabled   := False;
      tbDDesc5.Enabled   := False;
      tbDAmt1.Enabled    := False;
      tbDAmt2.Enabled    := False;
      tbDAmt3.Enabled    := False;
      tbDAmt4.Enabled    := False;
      tbDAmt5.Enabled    := False;

      with ADODATASET1 do
      begin
        close;
        //commandtext := 'select * from dtaOther_Earn_Ded where Employee_pin ='  + Chr(39) +  tbEmp_pin.Text + Chr(39);
        CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin = ' + tbEmp_pin.text + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39);
        open;

        if RecordCount > 0 then
        begin
           tbEmp_pin.text  := ADODataSet1.FieldByName('Employee_Pin').asString;
           tbEmp_name.text := ADODataSet2.FieldByName('Employee_Name').asString;
           txtDaysAbsent.text := ADODataSet1.FieldByName('DaysAbsent').asString;
           txtDayOffHrsWork.text := ADODataSet1.FieldByName('DayOffHrsWork').asString;
           tbEDesc1.Text   := ADODataSet1.FieldByName('other_earn_description1').asString;
           tbEDesc2.Text   := ADODataSet1.FieldByName('other_earn_description2').asString;
           tbEDesc3.Text   := ADODataSet1.FieldByName('other_earn_description3').asString;
           tbEDesc4.Text   := ADODataSet1.FieldByName('other_earn_description4').asString;
           tbEDesc5.Text   := ADODataSet1.FieldByName('other_earn_description5').asString;
           tbEAmt1.Text    := ADODataSet1.FieldByName('other_earn_amount1').asString;
           tbEAmt2.Text    := ADODataSet1.FieldByName('other_earn_amount2').asString;
           tbEAmt3.Text    := ADODataSet1.FieldByName('other_earn_amount3').asString;
           tbEAmt4.Text    := ADODataSet1.FieldByName('other_earn_amount4').asString;
           tbEAmt5.Text    := ADODataSet1.FieldByName('other_earn_amount5').asString;
           tbDDesc1.Text   := ADODataSet1.FieldByName('other_ded_description1').asString;
           tbDDesc2.Text   := ADODataSet1.FieldByName('other_ded_description2').asString;
           tbDDesc3.Text   := ADODataSet1.FieldByName('other_ded_description3').asString;
           tbDDesc4.Text   := ADODataSet1.FieldByName('other_ded_description4').asString;
           tbDDesc5.Text   := ADODataSet1.FieldByName('other_ded_description5').asString;
           tbDAmt1.Text    := ADODataSet1.FieldByName('other_ded_amount1').asString;
           tbDAmt2.Text    := ADODataSet1.FieldByName('other_ded_amount2').asString;
           tbDAmt3.Text    := ADODataSet1.FieldByName('other_ded_amount3').asString;
           tbDAmt4.Text    := ADODataSet1.FieldByName('other_ded_amount4').asString;
           tbDAmt5.Text    := ADODataSet1.FieldByName('other_ded_amount5').asString;

          if MessageDlg('Delete Employee?', mtConfirmation, mbYesNo, 0) = mrYes then

          with ADOConnection1 do
          begin
            delete_log(tbEmp_pin.Text);
            Execute('Delete from dtaOther_earn_ded where Employee_pin = ' + tbEmp_pin.text + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39) );
            Grid_load;
            showmessage('Record was successfully Deleted!');
          end

        else
          showmessage('No Record was found on the database!');
        end;

      end;
end;

procedure TfrmEarnDed.FormShow(Sender: TObject);
begin
  {if gUser <> 'Admin' then
  begin
      ShowMessage('Only Admin user is allowed!!');

      cmdAdd.Enabled := FALSE;
      cmdEdit.Enabled := FALSE;
      cmdDelete.Enabled := FALSE;
  end;}
end;

procedure TfrmEarnDed.Add_Log;
var
  ID: String;
  SQL: String;
begin
  with ADODataSet4 do begin
    Close;
    CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin = ' + tbEmp_pin.text + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39);
    Open;
    ID:='0';
    if RecordCount > 0 then ID:=FieldByName('ID').AsString;
    Close;
  end;
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Employee_PIN, ID, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Add' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaOthers_Earn_ded' + chr(39) + ', ';
  SQL := SQL + tbEmp_Pin.Text + ', ';
  SQL := SQL + ID + ', ';
  SQL := SQL + chr(39) + tbEmp_pin.Text + '|' + DateToStr(dtDate1.Date) + '|' +
                txtDaysAbsent.Text + '|' + txtDayOffHrsWork.Text + '|' +
                trim(tbEDesc1.Text) + '|' +trim(tbEAmt1.Text) + '|' +
                trim(tbEDesc2.Text) + '|' +trim(tbEAmt2.Text) + '|' +
                trim(tbEDesc3.Text) + '|' +trim(tbEAmt3.Text) + '|' +
                trim(tbDDesc1.Text) + '|' +trim(tbDAmt1.Text) + '|' +
                trim(tbDDesc2.Text) + '|' +trim(tbDAmt2.Text) + '|' +
                trim(tbDDesc3.Text) + '|' +trim(tbDAmt3.Text) + '|' +
                trim(tbEDesc4.Text) + '|' +trim(tbEAmt4.Text) + '|' +
                trim(tbEDesc5.Text) + '|' +trim(tbEAmt5.Text) + '|' +
                trim(tbDDesc4.Text) + '|' +trim(tbDAmt4.Text) + '|' +
                trim(tbDDesc5.Text) + '|' +trim(tbDAmt5.Text) + '|';
                if SLA5.Checked = TRUE then
                  SQL := SQL + '1|'
                else
                  SQL := SQL + '0|';
                if SLA10.Checked = TRUE then
                  SQL := SQL + '1'
                else
                  SQL := SQL + '0';
                SQL := SQL + chr(39);
  SQL := SQL + ')';
  ADOConnection1.Execute(SQL);
end;

procedure TfrmEarnDed.Edit_Log;
var
SQL: string;
begin
    //Edit_Log (Earning Description)
    with ADODataSet1 do
    begin
         if( FieldByName('Other_Earn_Description1').AsString <> tbEDesc1.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Description1' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Description1').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeDesc1.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Description2').AsString <> tbEDesc2.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Description2' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Description2').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeDesc2.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Description3').AsString <> tbEDesc3.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Description3' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Description3').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeDesc3.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Description4').AsString <> tbEDesc4.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Description4' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Description4').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeDesc4.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Description5').AsString <> tbEDesc5.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Description5' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Description5').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeDesc5.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         //Edit_Log(Earning Amounts)
         if( FieldByName('Other_Earn_Amount1').AsString <> tbEAmt1.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Amount1' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Amount1').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeAmt1.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Amount2').AsString <> tbEAmt2.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Amount2' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Amount2').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeAmt2.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Amount3').AsString <> tbEAmt3.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Amount3' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Amount3').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeAmt3.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Amount4').AsString <> tbEAmt4.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Amount4' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Amount4').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeAmt4.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Earn_Amount5').AsString <> tbEAmt5.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Earn_Amount5' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Earn_Amount5').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbeAmt5.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         //Edit_Log (Deduction_Description)
         if( FieldByName('Other_ded_Description1').AsString <> tbDDesc1.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Description1' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Description1').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDDesc1.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_ded_Description2').AsString <> tbDDesc2.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Description2' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Description2').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDDesc2.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_ded_Description3').AsString <> tbDDesc3.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Description3' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Description3').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDDesc3.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_ded_Description4').AsString <> tbDDesc4.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Description4' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Description4').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDDesc4.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_ded_Description5').AsString <> tbDDesc5.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Description5' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Description5').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDDesc5.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         //Edit_Log(Deduction Amount)
         if( FieldByName('Other_Ded_Amount1').AsString <> tbDAmt1.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Amount1' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Amount1').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDAmt1.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Ded_Amount2').AsString <> tbDAmt2.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Amount2' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Amount2').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDAmt2.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Ded_Amount3').AsString <> tbDAmt3.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Amount3' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Amount3').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDAmt3.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Ded_Amount4').AsString <> tbDAmt4.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Amount4' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Amount4').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDAmt4.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('Other_Ded_Amount5').AsString <> tbDAmt5.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Other_Ded_Amount5' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('Other_Ded_Amount5').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + tbDAmt5.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('DaysAbsent').AsString <> txtDaysAbsent.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'DaysAbsent' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('DaysAbsent').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + txtDaysAbsent.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('DayOffHrsWork').AsString <> txtDayOffHrsWork.Text ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'DayOffHrsWork' + chr(39) + ', ';
            SQL := SQL + chr(39) + FieldByName('DayOffHrsWork').AsString + chr(39) + ', ';
            SQL := SQL + chr(39) + txtDayOffHrsWork.Text + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('SLA5').Value <> SLA5.Checked ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'SLA5' + chr(39) + ', ';
            if( FieldByName('SLA5').Value ) then
              SQL := SQL + chr(39) + 'True' + chr(39) + ', '
            else
              SQL := SQL + chr(39) + 'False' + chr(39) + ', ';
            if( SLA5.Checked ) then
              SQL := SQL + chr(39) + 'True' + chr(39) + ', '
            else
              SQL := SQL + chr(39) + 'False' + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

         if( FieldByName('SLA10').Value <> SLA10.Checked ) then
         begin
            SQL :=       'INSERT INTO dtaLogFile ' ;
            SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Field_Name, Prev_Value, New_Value, ID, Employee_PIN ) ' ;
            SQL := SQL + 'VALUES ';
            SQL := SQL + '( ';
            SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
            SQL := SQL + IntToStr(gUser_ID) + ', ';
            SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'Edit' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'dtaOther_Earn_Ded' + chr(39) + ', ';
            SQL := SQL + chr(39) + 'SLA10' + chr(39) + ', ';
            if( FieldByName('SLA10').Value ) then
              SQL := SQL + chr(39) + 'True' + chr(39) + ', '
            else
              SQL := SQL + chr(39) + 'False' + chr(39) + ', ';
            if( SLA10.Checked ) then
              SQL := SQL + chr(39) + 'True' + chr(39) + ', '
            else
              SQL := SQL + chr(39) + 'False' + chr(39) + ', ';
            SQL := SQL + FieldByName('ID').AsString+', ';
            SQL := SQL + FieldByName('Employee_Pin').AsString;
            SQL := SQL + ')';
            ADOConnection1.Execute(SQL);
         end;

    end;
end;

procedure TfrmEarnDed.Delete_Log(tbEmp_pin : String);
var
  ID: String;
  SQL: String;
begin
  with ADODataSet4 do begin
    Close;
    CommandText := 'Select * from dtaOther_earn_Ded where Employee_pin = ' + tbEmp_pin + ' and Payroll_period = ' + Chr(39) + DateToStr(dtdate1.Date)+ chr(39);
    Open;
    ID:='0';
    if RecordCount > 0 then ID:=FieldByName('ID').AsString;
    Close;
  end;
  SQL :=       'INSERT INTO dtaLogFile ' ;
  SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Table_Name, Employee_PIN, ID, Remarks ) ' ;
  SQL := SQL + 'VALUES ';
  SQL := SQL + '( ';
  SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
  SQL := SQL + IntToStr(gUser_ID) + ', ';
  SQL := SQL + chr(39) + 'Other Earnings/Deductions' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'Delete' + chr(39) + ', ';
  SQL := SQL + chr(39) + 'dtaOthers_Earn_ded' + chr(39) + ', ';
  SQL := SQL + tbEmp_Pin + ', ';
  SQL := SQL + ID + ', ';
  SQL := SQL + chr(39) + tbEmp_pin + '|' + DateToStr(dtDate1.Date) + '|' +
                txtDaysAbsent.Text + '|' + txtDayOffHrsWork.Text + '|' +
                trim(tbEDesc1.Text) + '|' +trim(tbEAmt1.Text) + '|' +
                trim(tbEDesc2.Text) + '|' +trim(tbEAmt2.Text) + '|' +
                trim(tbEDesc3.Text) + '|' +trim(tbEAmt3.Text) + '|' +
                trim(tbDDesc1.Text) + '|' +trim(tbDAmt1.Text) + '|' +
                trim(tbDDesc2.Text) + '|' +trim(tbDAmt2.Text) + '|' +
                trim(tbDDesc3.Text) + '|' +trim(tbDAmt3.Text) + '|' +
                trim(tbEDesc4.Text) + '|' +trim(tbEAmt4.Text) + '|' +
                trim(tbEDesc5.Text) + '|' +trim(tbEAmt5.Text) + '|' +
                trim(tbDDesc4.Text) + '|' +trim(tbDAmt4.Text) + '|' +
                trim(tbDDesc5.Text) + '|' +trim(tbDAmt5.Text) + '|';
                if SLA5.Checked = TRUE then
                  SQL := SQL + '1|'
                else
                  SQL := SQL + '0|';
                if SLA10.Checked = TRUE then
                  SQL := SQL + '1'
                else
                  SQL := SQL + '0';
                SQL := SQL + chr(39);
  SQL := SQL + ')';
  //showmessage(SQL);
  ADOConnection1.Execute(SQL);
end;

procedure TfrmEarnDed.cmdGoClick(Sender: TObject);
begin
  Grid_Load;
end;

procedure TfrmEarnDed.dbEmployeeListClick(Sender: TObject);
begin
  tbEmp_name.Text := dbEmployeeList.Text;
  tbEmp_pin.Text := dbEmployeeList.KeyValue;
end;

procedure TfrmEarnDed.FormActivate(Sender: TObject);
begin
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary


  sTranDate := DateToStr(Now) + ' ' + TimeToStr(Now);
  sUserID := IntToStr(gUser_ID);

  
  dtDate1.Date := Date();
  dtDate2.Date := Date();


  InsertToLogFile(sTranDate, sUserID, 'Other Earnings and Deductions', 'Load', 'dtaOther_earn_ded', '');

end;

procedure TfrmEarnDed.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmEarnDed.btnOpenClick(Sender: TObject);
begin
  opendialog1.InitialDir := 'C:\';
  opendialog1.Filter := 'Excel Files (*.xls) | *.xls';
  opendialog1.Execute;
  txtFile.Text := OpenDialog1.Filename;
end;

procedure TfrmEarnDed.btnExtractClick(Sender: TObject);
var
   oXL, oWB, oSheet: Variant;
   vSQL : String;
   line : Integer;
   colNum : Integer;
   curColumn : Integer;

   tFile : string;
   tEarnings : string;
   tDeductions : string;

   tPeriod : string;
   PIN : string;

   earn1, earn2, earn3, earn4, earn5 : string;
   earn1amt, earn2amt, earn3amt, earn4amt, earn5amt : string;

   ded1, ded2, ded3, ded4, ded5 : string;
   ded1amt, ded2amt, ded3amt, ded4amt, ded5amt : string;

   colDesc : string;
   colAmount : string;


   sla5, sla10 : string;

   varFile : string;

begin
    if txtFile.text <> '' Then
    begin
      varFile := txtFile.text;


      //txtFile.Text := 'start..';
      //txtFile.Refresh;

      //oXL.Visible := True;
      oXL := CreateOleObject('Excel.Application');

      //Workbook
      oWB := oXL.Workbooks.Open(txtFile.text);
      oSheet := oWB.ActiveSheet;

      line := 1;

      tFile := oSheet.Cells[line,1];

      line := line + 1;
      tPeriod := oSheet.Cells[line, 2];

      line := 5;
      tEarnings := oSheet.Cells[line, 1];

      tDeductions := oSheet.Cells[line, 10];


      vSQL := 'SELECT * ' +
        'FROM dtaLockPayPeriod ' +
        'WHERE period1 = ''' + tPeriod + '''';

      dsPeriod.Close;
      dsPeriod.Connection := ADOConnection1;
      dsPeriod.CommandText := vSQL;
      dsPeriod.Open;

      if dsPeriod.RecordCount = 0 then
      begin

          vSQL := 'DELETE FROM dtaOther_earn_ded WHERE payroll_period = ''' + tPeriod + '''';
          ADOConnection1.Execute(vSQL);


          if ((tFile = 'SRCP Other earnings and deductions') and (tEarnings = 'earnings before tax')
            and (tDeductions = 'deductions before tax')) then
          begin
              //proceed to the first row
              line := 8;
              colNum := 1;
              curColumn := 1;

              repeat
                repeat

                  PIN := oSheet.Cells[line, curColumn];

                  if (colNum = 11) then
                  begin

                    sla5 := oSheet.Cells[line, curColumn + 1];
                    sla10 := oSheet.Cells[line, curColumn + 2];

                  end
                  else
                  begin
                    colDesc := Trim(oSheet.Cells[line, curColumn + 1]);
                    colAmount := oSheet.Cells[line, curColumn + 2];
                  end;


                  if (PIN <> '') then
                  begin

                    dsOther.Close;
                    dsOther.Connection := ADOConnection1;
                    dsOther.CommandText := 'SELECT * FROM dtaOther_Earn_Ded WHERE payroll_period = ''' +
                      tPeriod + ''' AND Employee_PIN = ''' + PIN + '''';
                    dsOther.Open;

                    if dsOther.RecordCount > 0 then
                    begin

                      with dsOther do
                      begin

                        Edit;

                        if ((colNum = 1) or (colNum = 2) or (colNum = 3)) then
                        begin

                        if (FieldByName('other_earn_description1').AsString = '') then
                        begin
                          FieldByName('other_earn_description1').AsString := colDesc;
                          FieldByName('other_earn_amount1').AsString := colAmount;
                        end
                        else if (FieldByName('other_earn_description2').AsString = '') then
                        begin
                          FieldByName('other_earn_description2').AsString := colDesc;
                          FieldByName('other_earn_amount2').AsString := colAmount;
                        end
                        else if (FieldByName('other_earn_description3').AsString = '') then
                        begin
                          FieldByName('other_earn_description3').AsString := colDesc;
                          FieldByName('other_earn_amount3').AsString := colAmount;
                        end;

                      end
                      else if ((colNum = 4) or (colNum = 5) or (colNum = 6)) then
                      begin

                        if (FieldByName('other_ded_description1').AsString = '') then
                        begin
                          FieldByName('other_ded_description1').AsString := colDesc;
                          FieldByName('other_ded_amount1').AsString := colAmount;
                        end
                        else if (FieldByName('other_ded_description2').AsString = '') then
                        begin
                          FieldByName('other_ded_description2').AsString := colDesc;
                          FieldByName('other_ded_amount2').AsString := colAmount;
                        end
                        else if (FieldByName('other_ded_description3').AsString = '') then
                        begin
                          FieldByName('other_ded_description3').AsString := colDesc;
                          FieldByName('other_ded_amount3').AsString := colAmount;
                        end

                      end
                      else if ((colNum = 7) or (colNum = 8)) then
                      begin

                        if (FieldByName('other_earn_description4').AsString = '') then
                        begin
                          FieldByName('other_earn_description4').AsString := colDesc;
                          FieldByName('other_earn_amount4').AsString := colAmount;
                        end
                        else if (FieldByName('other_earn_description5').AsString = '') then
                        begin
                          FieldByName('other_earn_description5').AsString := colDesc;
                          FieldByName('other_earn_amount5').AsString := colAmount;
                        end

                      end
                      else if ((colNum = 9) or (colNum = 10)) then
                      begin

                        if (FieldByName('other_ded_description4').AsString = '') then
                        begin
                          FieldByName('other_ded_description4').AsString := colDesc;
                          FieldByName('other_ded_amount4').AsString := colAmount;
                        end
                        else if (FieldByName('other_ded_description5').AsString = '') then
                        begin
                          FieldByName('other_ded_description5').AsString := colDesc;
                          FieldByName('other_ded_amount5').AsString := colAmount;
                        end

                      end
                      else if (colNum = 11) then
                      begin

                        FieldByName('SLA5').Value := sla5;
                        FieldByName('SLA10').Value := sla10;

                      end;

                      Post;

                    //end with
                    end;

                  //if no record was found
                  end

                  else
                  begin

                    with dsOther do
                    begin

                      Insert;

                      FieldByName('employee_pin').AsString := PIN;
                      FieldByName('payroll_period').AsString := tPeriod;

                      if ((colNum = 1) or (colNum = 2) or (colNum = 3)) then
                      begin

                        FieldByName('other_earn_description1').AsString := colDesc;
                        FieldByName('other_earn_amount1').AsString := colAmount;

                      end
                      else if ((colNum = 4) or (colNum = 5) or (colNum = 6)) then
                      begin

                        FieldByName('other_ded_description1').AsString := colDesc;
                        FieldByName('other_ded_amount1').AsString := colAmount;

                      end
                      else if ((colNum = 7) or (colNum = 8)) then
                      begin

                        FieldByName('other_earn_description4').AsString := colDesc;
                        FieldByName('other_earn_amount4').AsString := colAmount;

                      end
                      else if ((colNum = 9) or (colNum = 10)) then
                      begin

                        FieldByName('other_ded_description4').AsString := colDesc;
                        FieldByName('other_ded_amount4').AsString := colAmount;

                      end
                      else if (colNum = 11) then
                      begin

                        FieldByName('SLA5').Value := sla5;
                        FieldByName('SLA10').Value := sla10;

                      end;

                      Post;

                    //end with
                    end;
                  end;

                  line := line + 1;

                end;

              until (PIN = '');

              colNum := colNum + 1;
              line := 8;
              curColumn := curColumn + 3;

            until (colNum > 11);


            vSQL := 'UPDATE dtaOther_earn_ded SET sla5 = 0, sla10 = 0 WHERE sla5 IS NULL AND sla10 IS NULL ' +
              'AND payroll_period = ''' + tPeriod + '''';

            ADOConnection1.Execute(vSQL);
        
        
            txtFile.Text := 'Extraction complete!';

          end
          else
          begin

            ShowMessage('Invalid earnings and deductions file, choose another ...');

            txtFile.Text := 'Invalid file ...';
          end;


          oXL.Quit;

        end
        else
        begin

          ShowMessage('File to extract has been previously processed, choose another ...');

          oXL.Quit;
        end;
    end
    else
      ShowMessage('Please select a file to extract ...');

end;

procedure TfrmEarnDed.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vPIN: String);
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


procedure TfrmEarnDed.btnClearSLAClick(Sender: TObject);
begin
  SLA5.Checked := false;
  SLA10.Checked := false;
end;

end.
