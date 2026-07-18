// Name:  IdleRemarks.pas
// Description:  This is simply a list of all possible idle reasons
//     / description that can be selected during entry of keyer idle time.

unit IdleRemarks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, IdleEntry, CommonModule;

type
  TfrmIdleRemarks = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    cmdRefresh: TButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdRefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdleRemarks: TfrmIdleRemarks;

implementation

{$R *.dfm}

procedure TfrmIdleRemarks.FormCreate(Sender: TObject);
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
}
  ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConnection1.Connected := TRUE;

    //with frmIdleEntry do
    //begin
      ADODataSet1.Close;
      ADODataSet1.CommandText := 'SELECT *  FROM dtaIdleRemarks ORDER BY Idle_Code';
      ADODataSet1.Open;
      //ADODataSet1.Refresh;

      DataSource1.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource1;
      DBGrid1.Refresh;
    //end;
end;

procedure TfrmIdleRemarks.Button1Click(Sender: TObject);
begin
    frmIdleRemarks.Close;
end;

procedure TfrmIdleRemarks.cmdRefreshClick(Sender: TObject);
begin
    ADOConnection1.Close;
    FormCreate(frmIdleRemarks);
end;

procedure TfrmIdleRemarks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
