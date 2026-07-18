unit ExtractedTimePeriods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, CommonModule;

type
  TfrmExtractedTimePeriods = class(TForm)
    GroupBox1: TGroupBox;
    dsourceTime: TDataSource;
    dsTime: TADODataSet;
    ADOTime: TADOConnection;
    dbTime: TDBGrid;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractedTimePeriods: TfrmExtractedTimePeriods;

implementation

{$R *.dfm}

procedure TfrmExtractedTimePeriods.FormCreate(Sender: TObject);
begin
  ADOTime.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOTime.Connected := TRUE;

end;

procedure TfrmExtractedTimePeriods.FormShow(Sender: TObject);
begin
  dsTime.Close;
  dsTime.CommandText := 'SELECT Extract_From, Extract_To, Branch_Code FROM dtaExtractedTimePeriods ORDER BY Extract_From';
  dsTime.Active := TRUE;

  if dsTime.RecordCount > 0 then
    dbTime.Refresh;
end;

procedure TfrmExtractedTimePeriods.Button1Click(Sender: TObject);
begin
  frmExtractedTimePeriods.Close;
end;

end.
