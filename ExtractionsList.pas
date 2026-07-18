// Name:  ExtractionList.pas
// Description:  This window provides you with a list of projects
//     with extraction modules.  Selecting a particular project
//     loads the program extraction for the selected project.

unit ExtractionsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CommonModule, DB, ADODB, ExtractionAFLAC, ExtractionINDEXING,
  ExtractionARPI, ExtractionBCBS, ExtractionUHRC, ExtractionWELLPOINT, ExtractionUHGLatest,
  ExtractionGENERIC, BALLYSExtraction, ExtractionLCA, ExtractionWlpGeneric;

type
  TfrmExtractionsList = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lsExtractions: TListBox;
    cmdLoad: TButton;
    ADOProjects: TADOConnection;
    dsProjects: TADODataSet;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure LoadProjects();

    //current projects
    procedure LoadINDEXINGProject();
    procedure LoadAFLACProject();
    procedure LoadLCAProject();
    procedure LoadBCBSProject();
    procedure LoadARPIProject();
    procedure LoadUHRCProject();
    procedure LoadWELLPOINTProject();
    procedure LoadGENERICProject();
    procedure LoadUHGProject();
    procedure LoadBALLYS();
    procedure LoadWellpointGeneric();

    function StringToCaseSelect (Selector : string; CaseList: array of string): Integer;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtractionsList: TfrmExtractionsList;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;

  varCurDept :  Integer;

  pHandle : ^THandle;
implementation

{$R *.dfm}

procedure TfrmExtractionsList.cmdCloseClick(Sender: TObject);
begin
  frmExtractionsList.Close;

end;

procedure TfrmExtractionsList.FormCreate(Sender: TObject);
begin
  ADOProjects.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOProjects.Connected := TRUE;
end;

procedure TfrmExtractionsList.FormShow(Sender: TObject);
begin
  LoadProjects();
end;

procedure TfrmExtractionsList.LoadProjects();
begin
  dsProjects.Close;
  dsProjects.CommandText := 'SELECT * FROM dtaProjects WHERE Project_status = 1 ' +
    'ORDER BY Project_Description';
  dsProjects.Active := TRUE;

  if dsProjects.RecordCount > 0 then
  begin
    lsExtractions.Clear;
    while not dsProjects.Eof do
    begin
      lsExtractions.Items.Add(dsProjects.FieldByName('Project_Description').AsString);

      dsProjects.Next;
    end;
  end;
end;

procedure TfrmExtractionsList.cmdLoadClick(Sender: TObject);
var
  varIndex : Integer;
  varSelectedProj : String;
begin
  varIndex := lsExtractions.ItemIndex;
  varSelectedProj := lsExtractions.Items.Strings[varIndex];

  case StringToCaseSelect(varSelectedProj,
      ['INDEXING','AFLAC','BCBS', 'ARPI, AMS, IEHP', 'UHRC',
       'WELLPOINT','GENERIC','UHG_Latest', 'BALLYS', 'LCA', 'WELLPOINT GENERIC']) of
          0:LoadINDEXINGProject();
          1:LoadAFLACProject();
          2:LoadBCBSProject();
          3:LoadARPIProject();
          4:LoadUHRCProject();
          5:LoadWELLPOINTProject();
          6:LoadGENERICProject();
          7:LoadUHGProject();
          8:LoadBALLYS();
          9:LoadLCAProject();
          10:LoadWellpointGeneric();

  end;
end;

procedure TfrmExtractionsList.LoadUHGProject();
begin
//indexing
  //frmExtractionINDEXING.Show;
  //frmExtractionINDEXING.SetFocus;
    with TfrmExtractionUHGLatest.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadBALLYS();
begin
//indexing
  //frmExtractionINDEXING.Show;
  //frmExtractionINDEXING.SetFocus;
    with TfrmBALLYSExtraction.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadINDEXINGProject();
begin
//indexing
  //frmExtractionINDEXING.Show;
  //frmExtractionINDEXING.SetFocus;
    with TfrmExtractionINDEXING.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadAFLACProject();
begin
//aflac
//  frmExtractionAFLAC.Show;
//  frmExtractionAFLAC.SetFocus;
    with TfrmExtractionAFLAC.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadLCAProject();
begin
//aflac
//  frmExtractionAFLAC.Show;
//  frmExtractionAFLAC.SetFocus;
    with TfrmExtractionLCA.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadBCBSProject();
begin
//bcbs
//  frmExtractionBCBS.Show;
//  frmExtractionBCBS.SetFocus;

    with TfrmExtractionBCBS.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadARPIProject();
begin
//arpi
//  frmExtractionARPI.Show;
//  frmExtractionARPI.SetFocus;
    with TfrmExtractionARPI.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadUHRCProject();
begin
//uhrc
//  frmExtractionUHRC.Show;
//  frmExtractionUHRC.SetFocus;
    with TfrmExtractionUHRC.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadWELLPOINTProject();
begin
//WELLPOINT
//  frmExtractionWELLPOINT.Show;
//  frmExtractionWELLPOINT.SetFocus;
    with TfrmExtractionWELLPOINT.Create(Application) do show;
end;

procedure TfrmExtractionsList.LoadGENERICProject();
begin
//GENERIC
//  frmExtractionGENERIC.Show;
//  frmExtractionGENERIC.SetFocus;
    with TfrmExtractionGENERIC.Create(Application) do show;
end;

function TfrmExtractionsList.StringToCaseSelect
   (Selector : string;
CaseList: array of string): Integer;
var cnt: integer;
begin
   Result:=-1;
   for cnt:=0 to Length(CaseList)-1 do
begin
     if CompareText(Selector, CaseList[cnt]) = 0 then
     begin
       Result:=cnt;
       Break;
     end;
   end;
end;
procedure TfrmExtractionsList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmExtractionsList.LoadWellpointGeneric();
begin
//indexing
  //frmExtractionINDEXING.Show;
  //frmExtractionINDEXING.SetFocus;
    with TfrmExtractionWlpGeneric.Create(Application) do show;
end;

end.
