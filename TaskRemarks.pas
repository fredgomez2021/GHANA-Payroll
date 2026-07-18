// Name:  TaskRemarks.pas
// Description:  This window allows you to view all task IDs of
//     various projects.

unit TaskRemarks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ADODB, CommonModule;

type
  TfrmTaskRemarks = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    cmdRefresh: TButton;
    Label1: TLabel;
    txtTaskID: TEdit;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtTaskIDChange(Sender: TObject);
    procedure cmdRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTaskRemarks: TfrmTaskRemarks;

implementation

{$R *.dfm}

procedure TfrmTaskRemarks.cmdCloseClick(Sender: TObject);
begin
  frmTaskRemarks.Close;
end;

procedure TfrmTaskRemarks.FormCreate(Sender: TObject);
var
  sqlserver : String;
  sqldatabase : String;
  sqluser : String;
  sqlpwd : String;
  xIni : TextFile;
  xData : String;
  xDir : String;
begin
{  xDir :=  GetCurrentDir;
  AssignFile(xIni, xDir + '\PSYSTEM.INI');
  reset(xIni);

  repeat
    readln(xIni, xData);
    if(pos('Server=',xData)>0) then sqlserver := Copy(xData,8,100);
    if(pos('User=',xData)>0) then sqluser := Copy(xData,6,100);
    if(pos('Database=',xData)>0) then sqldatabase := Copy(xData,10,100);
    if(pos('Password=',xData)>0) then sqlpwd := Copy(xData,10,100);
  until (eof(xIni));

  CloseFile(xIni);
//Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=Payroll;Data Source=RM02RT01
//  ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+SqlUser+';Initial Catalog=' + sqlDatabase + ';Data Source='+sqlServer;
  ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=' + sqluser + ';Initial Catalog='+sqldatabase + ';Data Source='+sqlserver;
  ADOConnection1.Connected := TRUE;
}
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;

    //with frmIdleEntry do
    //begin
      ADODataSet1.Close;
      ADODataSet1.CommandText := 'SELECT *  FROM dtaTaskRemarks ORDER BY Task_ID';
      ADODataSet1.Open;
      //ADODataSet1.Refresh;

      DataSource1.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource1;
      DBGrid1.Refresh;
end;
procedure TfrmTaskRemarks.cmdRefreshClick(Sender: TObject);
begin
    ADOConnection1.Close;
    FormCreate(frmTaskRemarks);
end;

procedure TfrmTaskRemarks.txtTaskIDChange(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText := 'SELECT * FROM dtaTaskRemarks WHERE Task_ID LIKE ' + Chr(39) + '%' + txtTaskID.Text + '%' + Chr(39) + ' ORDER BY Task_ID';

  ADODataSet1.Open;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Refresh;
end;

procedure TfrmTaskRemarks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
