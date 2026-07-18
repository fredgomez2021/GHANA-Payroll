unit OvertimeVerification;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, StdCtrls, DB, ADODB, CommonModule;

type
  TfrmOvertimeVerification = class(TForm)
    GroupBox1: TGroupBox;
    cmdSearch: TButton;
    optWorkingDate: TRadioButton;
    dtDate: TDateTimePicker;
    grpSchedule: TGroupBox;
    dbOvertime: TDBGrid;
    ADOOvertime: TADOConnection;
    dsOvertime: TADODataSet;
    DataSource1: TDataSource;
    Label1: TLabel;
    btnClose: TButton;
    dsVerify: TADODataSet;
    GroupBox2: TGroupBox;
    optOvertime: TRadioButton;
    optLogTime: TRadioButton;
    btnVerify: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);

    procedure dbOvertimeCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOvertimeVerification: TfrmOvertimeVerification;

implementation

{$R *.dfm}

procedure TfrmOvertimeVerification.cmdSearchClick(Sender: TObject);
var
  d1 : String;
  varQuery : String;
begin
  d1 := DateToStr(dtDate.Date);

  dsOvertime.Close;

  if optOvertime.Checked = TRUE then
  begin
    varQuery := 'Overtime Validation';
     dsOvertime.CommandText := 'SELECT Work_Date, Employee_PIN, Employee_Name, Actual_In, Actual_Out, Regular_Hours, AuthorizeOT, Remarks, Date_Verified' +
      ' FROM vwOvertimeVerification WHERE Work_Date = ''' + d1 + ''' AND Date_Verified = ''' + ''' AND Module_Desc = ''' + varQuery + ''' ORDER BY Employee_PIN';
  end
  else if optLogTime.Checked = TRUE then
  begin
    varQuery := 'DTR Correction';
     dsOvertime.CommandText := 'SELECT Work_Date, Employee_PIN, Employee_Name, Actual_In, Actual_Out, Regular_Hours, AuthorizeOT, Remarks, Date_Verified' +
      ' FROM vwOvertimeVerification WHERE Work_Date = ''' + d1 + ''' AND Date_Verified = ''' + ''' AND Module_Desc = ''' + varQuery + ''' ORDER BY Employee_PIN';
  end;

  dsOvertime.Active := TRUE;

  if dsOvertime.RecordCount > 0 then
  begin
      dbOvertime.Refresh;
  end;
end;

procedure TfrmOvertimeVerification.FormCreate(Sender: TObject);
begin
  ADOOvertime.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOOvertime.Connected := TRUE;
end;

procedure TfrmOvertimeVerification.dbOvertimeCellClick(Column: TColumn);
var
  i : Integer;
  varOT : String;
begin
  if dbOvertime.SelectedRows.Count > 0 then
  begin
    with dbOvertime.DataSource.DataSet do
    begin
      for i := 0 to dbOvertime.SelectedRows.Count-1 do
      begin
        GotoBookmark(Pointer(dbOvertime.SelectedRows.Items[i]));


        //varOT := Trim(dsOvertime.FieldByName('AuthorizeOT').AsString);
        //ShowMessage(dsOvertime.FieldByName('Employee_Name').AsString);
      end;
    end;
  end;
end;

procedure TfrmOvertimeVerification.btnVerifyClick(Sender: TObject);
var
  i : Integer;
  varOT : String;
  varPIN, varWorkDate : String;
begin
  if dbOvertime.SelectedRows.Count > 0 then
  begin
    with dbOvertime.DataSource.DataSet do
    begin
      for i := 0 to dbOvertime.SelectedRows.Count-1 do
      begin
        GotoBookmark(Pointer(dbOvertime.SelectedRows.Items[i]));

        //varOT := Trim(dsOvertime.FieldByName('AuthorizeOT').AsString);
        //ShowMessage(dsOvertime.FieldByName('Employee_Name').AsString);
        varPIN := dsOvertime.FieldByName('Employee_PIN').AsString;
        varWorkDate := dsOvertime.FieldByName('Work_Date').AsString;

        ADOOvertime.Execute('UPDATE dtaLogFile SET Date_Verified = ''' + DateToStr(Now) + ''' WHERE Employee_PIN = ''' +
          varPIN + ''' AND Work_Date = ''' + varWorkDate + '''');


//        ShowMessage(dsVerify.CommandText);

        cmdSearchClick(frmOvertimeVerification);

      end;
    end;
  end;
end;

procedure TfrmOvertimeVerification.btnCloseClick(Sender: TObject);
begin
  frmOvertimeVerification.Close;
end;

end.
