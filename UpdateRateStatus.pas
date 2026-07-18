unit UpdateRateStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DB, ADODB, CommonModule, StdCtrls, DBGrids;

type
  TfrmUpdateRateStatus = class(TForm)
    ADOConn: TADOConnection;
    ADODataSet1: TADODataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    cboChooseOption: TComboBox;
    cmdClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    txtEmployee_PIN: TEdit;
    txtEmployee_Name: TEdit;
    Label3: TLabel;
    cboPayType: TComboBox;
    cmdEdit: TButton;
    cmdCancel: TButton;
    Super: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    txtName: TEdit;
    txtJob: TEdit;
    txtTaskID: TEdit;
    dsLogFile: TADODataSet;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure cboChooseOptionChange(Sender: TObject);

  procedure InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vId, vFieldName, vPIN, vPvalue, vNvalue : String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdateRateStatus: TfrmUpdateRateStatus;

implementation

{$R *.dfm}

procedure TfrmUpdateRateStatus.cboChooseOptionChange(Sender: TObject);
var
  vSQL : string;
begin
  ADODataSet1.Close;

  ADODataSet1.Connection := ADOConn;
  if cboChooseOption.ItemIndex = 0 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
    end
  else if cboChooseOption.ItemIndex = 1 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Isnull(Pay_Type ,'''') = '''' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name ';
    end
  else if cboChooseOption.ItemIndex = 2 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Base Pay'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
    end
  else if cboChooseOption.ItemIndex = 3 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Piece Rate'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
    end
  else if cboChooseOption.ItemIndex = 4 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Monthly'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
    end;

  ADODataSet1.CommandText := vSQL;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;

  ADODataSet1.Active := True;

  DBGrid1.Refresh;

  txtEmployee_PIN.Text := '';
  txtEmployee_Name.Text := '';
  cboPayType.Clear;

  cmdEdit.Enabled := false;
end;


procedure TfrmUpdateRateStatus.DBGrid1CellClick(Column: TColumn);
var
  sValue : Variant;
begin
  if ADODataSet1.Recordset.RecordCount > 0 then
    begin
      txtEmployee_PIN.Text :=  DBGrid1.Columns.Grid.Fields[0].CurValue;
      txtEmployee_Name.Text :=  DBGrid1.Columns.Grid.Fields[1].CurValue;
      sValue := DBGrid1.Columns.Grid.Fields[2].CurValue;
      if VarIsNull(sValue)  Then
        begin
          cboPayType.Clear;
        end
      else
        begin
          cboPayType.Clear;
          cboPayType.AddItem(DBGrid1.Columns.Grid.Fields[2].CurValue, pointer(0));
          cboPayType.ItemIndex := 0;
        end;
      cmdEdit.Enabled := true;
    end
  else
    begin
      txtEmployee_PIN.Text := '';
      txtEmployee_Name.Text := '';
      cboPayType.Clear;

      cmdEdit.Enabled := false;
    end
end;

procedure TfrmUpdateRateStatus.cmdEditClick(Sender: TObject);
var
  sValue : Variant;
  iAns : integer;
  vSQL : string;
begin
  if (cmdEdit.Caption = 'Edit') then
  begin
    sValue := DBGrid1.Columns.Grid.Fields[2].CurValue;
    if VarIsNull(sValue)  Then
      begin
        sValue := '';
      end;
    cboPayType.Clear;
    cboPayType.AddItem('Base Pay', pointer(0));
    cboPayType.AddItem('Piece Rate', pointer(1));
    cboPayType.AddItem('Monthly', pointer(2));
    cboPayType.ItemIndex := 0;

    cmdEdit.Caption := 'Update';
    cmdCancel.Enabled := true;
    
    cboChooseOption.Enabled := false;
    cmdClose.Enabled := false;
    DBGrid1.Enabled := false;

    varPrevValue := cboPayType.Text;
  end
  else if (cmdEdit.Caption = 'Update') then
  begin
    iAns := Application.MessageBox('Are you sure, you want to update this record?', 'Confirmation', MB_YESNO);

    if (iAns = 6) then
    begin
      vSQL := 'Update dtaEmployees Set Pay_Type = ' + chr(39) + cboPayType.Text + chr(39) + ' Where Employee_PIN =  ' + chr(39) + txtEmployee_PIN.text + chr(39)  ;
      ADOConn.Execute(vSQL);

      ADODataSet1.Close;
      ADODataSet1.Connection := ADOConn;
  if cboChooseOption.ItemIndex = 0 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees  Where Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name ';
    end
  else if cboChooseOption.ItemIndex = 1 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Isnull(Pay_Type ,'''') = '''' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name ';
    end
  else if cboChooseOption.ItemIndex = 2 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Base Pay'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name ';
    end
  else if cboChooseOption.ItemIndex = 3 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Piece Rate'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name ';
    end
  else if cboChooseOption.ItemIndex = 4 then
    begin
      vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees Where Pay_Type = '+ chr(39)  +'Monthly'+ chr(39) +' And Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
    end;


      ADODataSet1.CommandText := vSQL;
      DataSource1.DataSet := ADODataSet1;
      DBGrid1.DataSource := DataSource1;
      ADODataSet1.Active := True;

      cmdEdit.Caption := 'Edit';
      cmdCancel.Enabled := false;

      cboChooseOption.Enabled := true;
      cmdClose.Enabled := true;
      DBGrid1.Enabled := true;
      DBGrid1.Refresh;


      //log variables
      varDate := DateToStr(Date);
      varCommand := 'Edit';
      varFieldName := 'Pay Type';
      varPIN1 := txtEmployee_PIN.Text;
      varNewValue := cboPayType.Text;
      varModule := 'Update Rate Status Module';
      varTable := 'dtaEmployees';

     InsertToLogFile(varDate, ActiveUserID, varModule, varCommand, varTable, '', varFieldName, varPIN1, varPrevValue, varNewValue);

    end;
    
  end;
end;

procedure TfrmUpdateRateStatus.InsertToLogFile(vDate, vUser, vModule, vCommand, vTable, vId, vFieldName, vPIN, vPvalue, vNvalue : String);
var
  valueRemarks : String;
begin
  //repeat
    valueRemarks := InputBox('Remarks entry', 'Please enter your remarks here!', '');
  //until valueRemarks <> '';

  //ShowMessage(value);
  //valueRemarks := '';

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
      FieldByName('Id').AsString := vId;
      FieldByName('Field_Name').AsString := vFieldName;
      FieldByName('Employee_PIN').AsString := vPIN;
      FieldByName('Prev_value').AsString := vPvalue;
      FieldByName('New_value').AsString := vNvalue;
      FieldByName('Remarks').AsString := valueRemarks;

    Post;

  end;
end;


procedure TfrmUpdateRateStatus.cmdCancelClick(Sender: TObject);
var
  sValue : Variant;
begin
    sValue := DBGrid1.Columns.Grid.Fields[2].CurValue;
    cboPayType.Clear;
    if VarIsNull(sValue)  Then
      begin
        cboPayType.Clear;
      end
    else
      begin
        cboPayType.AddItem(DBGrid1.Columns.Grid.Fields[2].CurValue, pointer(0));
        cboPayType.ItemIndex := 0;
      end;

    cmdEdit.Caption := 'Edit';
    cmdCancel.Enabled := false;
    
    cboChooseOption.Enabled := true;
    cmdClose.Enabled := true;
    DBGrid1.Enabled := true;
end;

procedure TfrmUpdateRateStatus.cmdCloseClick(Sender: TObject);
begin
  close();
end;

procedure TfrmUpdateRateStatus.FormCreate(Sender: TObject);
begin
  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;
end;

procedure TfrmUpdateRateStatus.FormActivate(Sender: TObject);
var
  vSQL : string;
  sEmpNo : string;
begin

  sEmpNo := ActiveUserID;
  //sEmpNo := '313';
  vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type, Job_Position_Code, Primary_Task_ID From dtaEmployees Where Employee_PIN = ''' + sEmpNo + ''' Order By Employee_Name';

  ADODataSet1.Close;
  ADODataSet1.CommandText := vSQL;
  ADODataSet1.Active := True;
  txtName.Text := ADODataSet1.FieldByName('Employee_Name').AsString;
  txtJob.Text := ADODataSet1.FieldByName('Job_Position_Code').AsString;
  txtTaskID.Text := ADODataSet1.FieldByName('Primary_Task_ID').AsString;
  ADODataSet1.Close;


  vSQL := 'Select Employee_PIN, Employee_Name, Pay_Type From dtaEmployees  Where Primary_Task_ID = ''' + txtTaskID.Text + ''' Order By Employee_Name';
  ADODataSet1.CommandText := vSQL;

  DataSource1.DataSet := ADODataSet1;
  DBGrid1.DataSource := DataSource1;

  ADODataSet1.Active := True;

  cboChooseOption.ItemIndex := 0;
end;

end.
