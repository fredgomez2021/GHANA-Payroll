unit PSDtaLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, DBTables, ComCtrls, CommonModule, ShellAPI;

type
  TfrmLogFile = class(TForm)
    btnPrint: TButton;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    ADODataSet2: TADODataSet;
    ADODataSet3: TADODataSet;
    ADODataSet4: TADODataSet;
    DataSource2: TDataSource;
    GroupBox1: TGroupBox;
    lblFrom: TLabel;
    lblTo: TLabel;
    dtpFrom: TDateTimePicker;
    dtpTo: TDateTimePicker;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    lblUser: TLabel;
    cboUserName: TComboBox;
    lblCommand: TLabel;
    cboCommand: TComboBox;
    btnProcess: TButton;
    Label1: TLabel;
    cboModule: TComboBox;
    Label2: TLabel;
    btnFilter: TButton;
    btnExport: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure dtpFromChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Grid_Load;
  private
    { Private declarations }
    strDateFrom : String;
    strDateTo : String;

  public
    { Public declarations }
  end;

var
  frmLogFile: TfrmLogFile;
  // frmMainMenu: TfrmMainMenu;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  Closed: Boolean;



implementation
uses comobj;
{$R *.dfm}

procedure TfrmLogFile.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;
end;

procedure TfrmLogFile.btnProcessClick(Sender: TObject);
begin
  Grid_Load;
end;

procedure TfrmLogFile.btnPrintClick(Sender: TObject);
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := 10;
  begin
    if not CreateProcess(nil,
      'Reports\RptDtaLogFile.exe', // pointer to command line string
      nil, // pointer to process security attributes
      nil, // pointer to thread security attributes
      False, // handle inheritance flag
      CREATE_NEW_CONSOLE or // creation flags
      NORMAL_PRIORITY_CLASS,
      nil, //pointer to new environment block
      nil, // pointer to current directory name
      StartupInfo, // pointer to STARTUPINFO
      // pointer to PROCESS_INFO
      ProcessInfo) then showMessage('Bad or Missing Executable');  end;
end;

procedure TfrmLogFile.Button1Click(Sender: TObject);
  begin
    frmLogFile.Close;
  end;

procedure TfrmLogFile.FormActivate(Sender: TObject);
begin
  dtpFrom.Date := Now;
  dtpTo.Date := Now;
end;

procedure TfrmLogFile.dtpFromChange(Sender: TObject);
begin
  if dtpFrom.Date > dtpTo.Date then
    dtpTo.Date := dtpFrom.Date;
end;

procedure TfrmLogFile.Grid_Load;
var
  strSqlSelect : String;
  FDate      : string;
  TDate      : string;
begin
  // Display query results in grid
  strDateFrom := chr(39) + DateToStr(dtpFrom.Date) + chr(39);
  strDateTo := chr(39) + DateToStr(dtpTo.Date) + chr(39);

  strSqlSelect := 'SELECT l.Tran_Date,e.Employee_Name, ' +
      'l.Module_Desc, l.Command, ' +
      'l.Table_Name, l.Id, ' +
      'l.Employee_PIN, l.Field_Name, ' +
      'l.Prev_Value, l.New_Value, ' +
      'l.Remarks, l.Work_Date ' +
      'FROM dtaLogFile l INNER JOIN dtaEmployees e ' +
      'ON l.User_ID=e.Employee_PIN ' +
      'WHERE l.Tran_Date BETWEEN ' + strDateFrom + ' AND ' + strDateTo + ' ' +
      'ORDER BY l.Tran_Date DESC';

  ADODataSet1.Close;
  ADODataSet1.CommandText := strSqlSelect;
  ADODataSet1.Active := TRUE;

  DBGrid1.Refresh;

  // Fill cboUserName

  strSqlSelect := 'SELECT DISTINCT e.Employee_Name, l.User_ID ' +
      'FROM dtaLogFile l INNER JOIN dtaEmployees e ' +
      'ON l.User_ID=e.Employee_PIN ' +
      'WHERE l.Tran_Date BETWEEN ' + strDateFrom + ' AND ' + strDateTo + ' ' +
      'ORDER BY e.Employee_Name';

  ADODataSet2.Close;
  ADODataSet2.CommandText := strSqlSelect;
  ADODataSet2.Open;
  cboUserName.Clear;
  cboUserName.AddItem('<ALL>', cboUserName);
  While not ADODataSet2.Eof do
  begin
    cboUserName.AddItem(ADODataSet2.FieldByName('Employee_Name').AsString, cboUserName);
    ADODataSet2.Next;
  end;
  cboUserName.ItemIndex := 0;

  // Fill cboCommand
  strSqlSelect := 'SELECT DISTINCT Command ' +
    'FROM dtaLogFile ' +
    'WHERE Tran_Date BETWEEN ' +
    strDateFrom + ' AND ' + strDateTo + ' ' +
    'ORDER BY Command';

  ADODataSet3.Close;
  ADODataSet3.CommandText := strSqlSelect;
  ADODataSet3.Open;

  cboCommand.Clear;
  cboCommand.AddItem('<ALL>', cboCommand);
  While not ADODataSet3.Eof do
  begin
    cboCommand.AddItem(ADODataSet3.FieldByName('Command').AsString, cboCommand);
    ADODataSet3.Next;
  end;
  cboCommand.ItemIndex := 0;

  // Fill cboModule
  strSqlSelect := 'SELECT DISTINCT Module_Desc ' +
    'FROM dtaLogFile ' +
    'WHERE Tran_Date BETWEEN ' +
    strDateFrom + ' AND ' + strDateTo + ' ' +
    'ORDER BY Module_Desc';

  ADODataSet3.Close;
  ADODataSet3.CommandText := strSqlSelect;
  ADODataSet3.Open;

  cboModule.Clear;
  cboModule.AddItem('<ALL>', cboModule);
  While not ADODataSet3.Eof do
  begin
    cboModule.AddItem(ADODataSet3.FieldByName('Module_Desc').AsString, cboModule);
    ADODataSet3.Next;
  end;
  cboModule.ItemIndex := 0;

end;

procedure TfrmLogFile.btnFilterClick(Sender: TObject);
var
  SQL : String;
  FDate      : string;
  TDate      : string;
begin
  // Display query results in grid
  strDateFrom := chr(39) + DateToStr(dtpFrom.Date) + chr(39);
  strDateTo := chr(39) + DateToStr(dtpTo.Date) + chr(39);

  SQL := 'SELECT l.Tran_Date,e.Employee_Name, ' +
      'l.Module_Desc, l.Command, ' +
      'l.Table_Name, l.Id, ' +
      'l.Employee_PIN, l.Field_Name, ' +
      'l.Prev_Value, l.New_Value, ' +
      'l.Remarks, l.Work_Date ' +
      'FROM dtaLogFile l INNER JOIN dtaEmployees e ' +
      'ON l.User_ID=e.Employee_PIN ' +
      'WHERE l.Tran_Date BETWEEN ' + strDateFrom + ' AND ' + strDateTo + ' ';

  if cboUserName.ItemIndex > 0 then
  begin
      SQL := SQL + 'AND e.Employee_Name = '''+cboUserName.Text+''' ';
  end;
  if cboCommand.ItemIndex > 0 then
  begin
      SQL := SQL + 'AND l.Command = '''+cboCommand.Text+''' ';
  end;
  if cboModule.ItemIndex > 0 then
  begin
      SQL := SQL + 'AND l.Module_Desc = '''+cboModule.Text+''' ';
  end;

  SQL := SQL + 'ORDER BY l.Tran_Date DESC';

  ADODataSet1.Close;
  ADODataSet1.CommandText := SQL;
  ADODataSet1.Active := TRUE;

  DBGrid1.Refresh;

end;

procedure TfrmLogFile.btnExportClick(Sender: TObject);
var
   oxl, owb, osheet : variant;
   row : Integer;
begin

  oxl := CreateOleObject('Excel.Application');
  owb := oxl.workbooks.add();
  osheet := owb.Sheets[1];

  row := 1;
  oSheet.Cells[row,1] := 'Log File Report';
  row := row + 1;
  oSheet.Cells[row,1] := 'From : ' + DateToStr( dtpFrom.Date ) +
                          '  To : ' + DateToStr( dtpTo.Date );

  row := row + 2;
  oSheet.Cells[row,1] := 'Tran. Date';
  oSheet.Cells[row,2] := 'Time';
  oSheet.Cells[row,3] := 'Employee Name';
  oSheet.Cells[row,4] := 'Module';
  oSheet.Cells[row,5] := 'Command';
  oSheet.Cells[row,6] := 'Table Name';
  oSheet.Cells[row,7] := 'ID';
  oSheet.Cells[row,8] := 'Employee PIN';
  oSheet.Cells[row,9] := 'Field name';
  oSheet.Cells[row,10] := 'Prev. Value';
  oSheet.Cells[row,11] := 'New Value';
  oSheet.Cells[row,12] := 'Remarks';

  with ADODataSet1 do begin
    First;
    while not EOF do begin
      //ShowMessage(FieldByName('Tran_Date').AsString);
      row := row + 1;
      oSheet.Cells[row,1] := FieldByName('Tran_Date').AsString;
      oSheet.Cells[row,2] := FieldByName('Tran_Date').AsString;
      oSheet.Cells[row,3] := FieldByName('Employee_Name').AsString;
      oSheet.Cells[row,4] := FieldByName('Module_Desc').AsString;
      oSheet.Cells[row,5] := FieldByName('Command').AsString;
      oSheet.Cells[row,6] := FieldByName('Table_Name').AsString;
      oSheet.Cells[row,7] := FieldByName('ID').AsString;
      oSheet.Cells[row,8] := FieldByName('Employee_PIN').AsString;
      oSheet.Cells[row,9] := FieldByName('Field_name').AsString;
      oSheet.Cells[row,10] := FieldByName('Prev_Value').AsString;
      oSheet.Cells[row,11] := FieldByName('New_Value').AsString;
      oSheet.Cells[row,12] := FieldByName('Remarks').AsString;
      Next;
    end;
  end;

  // formatting //
  oSheet.Range['A4:L4'].Font.Bold := true;
  oSheet.Columns['A:A'].NumberFormat := 'dddd, mm/dd/yy';
  oSheet.Columns['B:B'].NumberFormat := 'hh:mm AM/PM';
  oSheet.Columns['A:L'].EntireColumn.AutoFit;
  oSheet.Columns['A:A'].ColumnWidth := 19.86;
  oSheet.Range['A5'].Select;
  oxl.ActiveWindow.FreezePanes := true;
  oSheet.Range['A4:L'+IntToStr(row)].AutoFilter;
  oSheet.Range['A1'].Select;

  oxl.visible := true;

end;

procedure TfrmLogFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
