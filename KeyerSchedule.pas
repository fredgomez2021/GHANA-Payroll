unit KeyerSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, DB, ADODB, DateUtils, CommonModule;

type
  TfrmKeyerSchedule = class(TForm)
    GroupBox1: TGroupBox;
    grpSchedule: TGroupBox;
    cmbName: TComboBox;
    cmdSearch: TButton;
    grpPeriod: TGroupBox;
    cmbMonth: TComboBox;
    opt115: TRadioButton;
    opt1631: TRadioButton;
    cmbYear: TComboBox;
    optWorkingDate: TRadioButton;
    dtDate: TDateTimePicker;
    optEmpName: TRadioButton;
    DataSource1: TDataSource;
    ADOSched: TADOConnection;
    dsSched: TADODataSet;
    dbSchedule: TDBGrid;
    dsEmployees: TADODataSet;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure optWorkingDateClick(Sender: TObject);
    procedure optEmpNameClick(Sender: TObject);

    procedure ViewKeyerSchedule();
    procedure LoadEmployees();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyerSchedule: TfrmKeyerSchedule;
  d1, d2 : String;
  days1, days2 : Integer;

implementation

{$R *.dfm}

procedure TfrmKeyerSchedule.optEmpNameClick(Sender: TObject);
begin
  if optEmpName.Checked = TRUE then
  begin
    cmbName.Enabled := TRUE;
    grpPeriod.Enabled := TRUE;

    dtDate.Enabled := FALSE;

  end;
end;

procedure TfrmKeyerSchedule.optWorkingDateClick(Sender: TObject);
begin
  if optWorkingDate.Checked = TRUE then
  begin
    optEmpName.Checked := FALSE;
    cmbName.Enabled := FALSE;
    grpPeriod.Enabled := FALSE;

    dtDate.Enabled := TRUE;
  end;
end;

procedure TfrmKeyerSchedule.cmdSearchClick(Sender: TObject);
begin
  if ((optEmpName.Checked = TRUE) and (cmbName.Text <> '')) then
    ViewKeyerSchedule()
  else
    ViewKeyerSchedule();

end;

procedure TfrmKeyerSchedule.ViewKeyerSchedule();
begin
//keyer schedule
  dsSched.Close;

  if optWorkingDate.Checked = TRUE then
  begin
    d1 := DateToStr(dtDate.Date);

    dsSched.CommandText := 'SELECT Employee_Name, dtaKeyerSchedule.Employee_PIN, Start_Time, End_Time FROM dtaKeyerSchedule, dtaEmployees WHERE dtaKeyerSchedule.Employee_PIN = dtaEmployees.Employee_PIN AND Work_Date = ' + Chr(39) + d1 + Chr(39) + ' ORDER BY dtaEmployees.Employee_Name';
    dsSched.Active := TRUE;

  end
  else if optEmpName.Checked = TRUE then
  begin
    if cmbMonth.Text <> '' then
    begin
      days1 := 0;
      days2 := 0;

      d1 := IntToStr(cmbMonth.ItemIndex + 1) + ' ' + cmbYear.Text;

      if opt115.Checked = TRUE then
      begin
        days1 := 1;
        days2 := 15;
      end
      else if opt1631.Checked = TRUE then
      begin
        d2 := IntToStr(DaysInAMonth(StrToInt(cmbYear.Text),cmbMonth.ItemIndex + 1));

        days1 := 16;
        days2 := StrToInt(d2);
      end;

      d1 :=  Chr(39) + IntToStr(cmbMonth.ItemIndex + 1) + '/' + IntToStr(days1) + '/' + cmbYear.Text + Chr(39);
      d2 :=  Chr(39) + IntToStr(cmbMonth.ItemIndex + 1) + '/' + IntToStr(days2) + '/' + cmbYear.Text + Chr(39);

      dsSched.CommandText := 'SELECT dtaKeyerSchedule.Employee_PIN, Start_Time, End_Time FROM dtaKeyerSchedule, dtaEmployees ' +
          'WHERE dtaKeyerSchedule.Employee_PIN = dtaEmployees.Employee_PIN AND Work_Date BETWEEN ' + d1 + ' AND ' + d2 + ' AND Employee_Name = ' + Chr(39) + cmbName.Text + Chr(39) + ' ORDER BY dtaEmployees.Employee_Name';
      dsSched.Active := TRUE;

    end;
  end;

//  if dsSched.RecordCount > 0 then
//  begin

//  end;


end;
procedure TfrmKeyerSchedule.FormCreate(Sender: TObject);
begin
  ADOSched.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOSched.Connected := TRUE;

end;

procedure TfrmKeyerSchedule.FormShow(Sender: TObject);
begin
  LoadEmployees();
end;

procedure TfrmKeyerSchedule.LoadEmployees();
begin
//employees
  dsEmployees.Close;
  dsEmployees.CommandText := 'SELECT * FROM dtaEmployees WHERE Employee_PIN <> 1 ORDER BY Employee_Name';
  dsEmployees.Active := TRUE;

  if dsEmployees.RecordCount > 0 then
  begin
    dsEmployees.First;
    cmbName.Clear;
    While not dsEmployees.Eof do
    begin
      cmbName.Items.Add(dsEmployees.FieldByName('Employee_Name').AsString);

      dsEmployees.Next;
    end;
  end;
end;

end.
