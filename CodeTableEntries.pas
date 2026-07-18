unit CodeTableEntries;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB;

type
  TfrmCodeTableEntries = class(TForm)
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cmbCodeCategory: TComboBox;
    gridDetails: TDBGrid;
    Label1: TLabel;
    lblRecords: TLabel;
    Label2: TLabel;
    txtCode: TEdit;
    txtDescription: TEdit;
    cmbHierarchy: TComboBox;
    cmdAdd: TButton;
    cmdEdit: TButton;
    cmdDelete: TButton;
    cmdClose: TButton;
    ADOConn: TADOConnection;
    dsCategory: TADODataSet;
    dSource: TDataSource;
    cmbJobCategory: TComboBox;
    Label3: TLabel;
    dsJobCategory: TADODataSet;
    dsCategoryGrid: TADODataSet;
    dsEntry: TADODataSet;
    dsEntry1: TADODataSet;
    lblHierarchy: TLabel;
    lblJobCategory: TLabel;
    procedure gridDetailsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure gridDetailsCellClick(Column: TColumn);
    procedure cmdAddClick(Sender: TObject);
    procedure cmbCodeCategoryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure enableFields(sValue : Boolean);
    procedure clearFields();
    procedure loadCodeCategories();
    procedure loadJobCategories();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCodeTableEntries: TfrmCodeTableEntries;
  varSql : String;
  sCodeCategory : String;
  sCode : String;
  sDescription : String;
  sHierarchy : String;
  sJobCategory : String;
  sCodeID : Integer;

implementation

uses CommonModule;

{$R *.dfm}

procedure TfrmCodeTableEntries.FormCreate(Sender: TObject);
begin

  ADOConn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOConn.Connected := TRUE;

end;

procedure TfrmCodeTableEntries.FormShow(Sender: TObject);
begin
  loadCodeCategories();
  loadJobCategories();
end;

procedure TfrmCodeTableEntries.loadJobCategories();
begin
  //code here
  cmbJobCategory.Clear;

  varSql := 'SELECT DISTINCT jobCategory ' +
    'FROM dtaCodeTables (nolock) ' +
    'WHERE jobCategory IS NOT NULL ' +
    'ORDER BY jobCategory';

  dsJobCategory.Close;
  dsJobCategory.CommandText := varSql;
  dsJobCategory.Open;

  if dsJobCategory.RecordCount > 0 then
  begin
    while not dsJobCategory.eof do
    begin
      cmbJobCategory.Items.Add(dsJobCategory.FieldByName('jobCategory').AsString);
      dsJobCategory.Next;
    end;
  end;

  dsJobCategory.Close;

end;

procedure TfrmCodeTableEntries.loadCodeCategories();
begin

  cmbCodeCategory.Clear;

  varSql := 'SELECT DISTINCT Code_Category ' +
    'FROM dtaCodeTables (nolock) ' +
    'ORDER BY Code_Category';

  dsCategory.Close;
  dsCategory.CommandText := varSql;
  dsCategory.Open;

  if dsCategory.RecordCount > 0 then
  begin
    while not dsCategory.eof do
    begin
      cmbCodeCategory.Items.Add(dsCategory.FieldByName('Code_Category').AsString);
      dsCategory.Next;
    end;
  end;

  dsCategory.Close;

  //enableFields(False);

end;

procedure TfrmCodeTableEntries.cmbCodeCategoryClick(Sender: TObject);
begin

  varSql := 'SELECT CodeID, Code, Description, Hierarchy, jobCategory ' +
    'FROM dtaCodeTables ' +
    'WHERE Code_Category = ''' + cmbCodeCategory.Text +
    ''' ORDER BY Description';

  dsCategoryGrid.Close;
  dsCategoryGrid.CommandText := varSql;
  dsCategoryGrid.Open;

  dSource.DataSet := dsCategoryGrid;
  gridDetails.DataSource := dSource;
  gridDetails.Refresh;

  lblRecords.Caption := IntToStr(dsCategoryGrid.RecordCount) + ' record(s)';

end;

procedure TfrmCodeTableEntries.cmdAddClick(Sender: TObject);
begin

  if cmdAdd.Caption = '&ADD' then
  begin
    cmdAdd.Caption := '&SAVE';
    cmdEdit.Enabled := False;
    cmdDelete.Enabled := False;

    enableFields(True);
    clearFields();

    txtCode.SetFocus;

  end
  else if cmdAdd.Caption = '&SAVE' then
  begin

    //store to variables
    sCodeCategory := cmbCodeCategory.Text;
    sCode := UpperCase(txtCode.Text);
    sDescription := UpperCase(txtDescription.Text);
    sHierarchy := cmbHierarchy.Text;
    sJobCategory := cmbJobCategory.Text;

    with dsEntry do
    begin
      Close;
      CommandText := 'SELECT * FROM dtaCodeTables (nolock) ' +
        'WHERE Code_Category = ''' + sCodeCategory +
        ''' AND (Description = ''' + sDescription +
        ''' OR Code = ''' + sCode + ''')';
      Open;

      if RecordCount > 0 then
      begin
        ShowMessage('Description or code already exists for this Code Category, please key in another!');
        txtCode.SetFocus;

      end
      else
      begin
        Insert;

        FieldByName('Code_Category').AsString := sCodeCategory;
        FieldByName('Code').AsString := sCode;
        FieldByName('Description').AsString := sDescription;
        FieldByName('Hierarchy').AsString := sHierarchy;
        FieldByName('jobCategory').AsString := sJobCategory;

        Post;

        ShowMessage('New entry has been successfully saved!');

        Close;

        cmdAdd.Caption := '&ADD';

        enableFields(False);

        cmbCodeCategoryClick(cmbCodeCategory);

      end;
    end;

  end;

end;

procedure TfrmCodeTableEntries.enableFields(sValue : Boolean);
begin

  txtCode.Enabled := sValue;
  txtDescription.Enabled := sValue;
  cmbHierarchy.Enabled := sValue;
  cmbJobCategory.Enabled := sValue;

end;

procedure TfrmCodeTableEntries.clearFields();
begin

  txtCode.Text := '';
  txtDescription.Text := '';
//  cmbHierarchy.Enabled := sValue;
//  cmbJobCategory.Enabled := sValue;

end;

procedure TfrmCodeTableEntries.gridDetailsCellClick(Column: TColumn);
var
  i : Integer;
begin
  if gridDetails.SelectedRows.Count > 0 then
  begin
    with gridDetails.DataSource.DataSet do
    begin
      for i := 0 to gridDetails.SelectedRows.Count-1 do
      begin
        GotoBookmark(Pointer(gridDetails.SelectedRows.Items[i]));

        sCodeID := dsCategoryGrid.FieldByName('CodeID').AsInteger;
        txtCode.Text := dsCategoryGrid.FieldByName('Code').AsString;
        txtDescription.Text := dsCategoryGrid.FieldByName('Description').AsString;
        lblHierarchy.Caption := dsCategoryGrid.FieldByName('Hierarchy').AsString;
        lblJobCategory.Caption := dsCategoryGrid.FieldByName('jobCategory').AsString;

        cmdEdit.Enabled := True;
        cmdDelete.Enabled := True;

      end;
    end;
  end
end;

procedure TfrmCodeTableEntries.cmdEditClick(Sender: TObject);
begin

  if cmdEdit.Caption = '&EDIT' then
  begin
    cmdEdit.Caption := '&UPDATE';
    cmdAdd.Enabled := False;
    cmdDelete.Enabled := False;

    enableFields(True);

  end
  else if cmdEdit.Caption = '&UPDATE' then
  begin

     //store to variables
    sCodeCategory := cmbCodeCategory.Text;
    sCode := UpperCase(txtCode.Text);
    sDescription := UpperCase(txtDescription.Text);
    sHierarchy := cmbHierarchy.Text;
    sJobCategory := cmbJobCategory.Text;

    with dsEntry do
    begin
      Close;
      //table ID should be added
      CommandText := 'SELECT * FROM dtaCodeTables (nolock) ' +
        'WHERE codeID = ''' + IntToStr(sCodeID) + '''';
      Open;

      if RecordCount > 0 then
      begin

        //before saving entries, check if details modified already exists
        varSql := 'SELECT * FROM dtaCodeTables (nolock) ' +
          'WHERE Code_Category = ''' + sCodeCategory +
          ''' AND (Description = ''' + sDescription +
          ''' OR Code = ''' + sCode + ''')';

        dsEntry1.Close;
        dsEntry1.CommandText := varSql;
        dsEntry1.Open;

        if dsEntry1.RecordCount > 0 then
        begin
          ShowMessage('Description or code already exists for this Code Category, please key in another!');
          txtCode.SetFocus;

        end
        else
        begin
          Edit;

          FieldByName('Code_Category').AsString := sCodeCategory;
          FieldByName('Code').AsString := sCode;
          FieldByName('Description').AsString := sDescription;
          FieldByName('Hierarchy').AsString := sHierarchy;
          FieldByName('jobCategory').AsString := sJobCategory;

          Post;

          ShowMessage('Selected entry has been updated!');

          Close;

          cmdEdit.Caption := '&EDIT';
          cmdEdit.Enabled := False;
          cmdAdd.Enabled := True;
          cmdDelete.Enabled := False;

          enableFields(False);

          cmbCodeCategoryClick(cmbCodeCategory);
        end;
      end;
    end;
  end;

end;

procedure TfrmCodeTableEntries.cmdCloseClick(Sender: TObject);
begin

  if cmdAdd.Caption = '&SAVE' then
  begin
    cmdAdd.Caption := '&ADD';
    cmdEdit.Enabled := False;
    cmdDelete.Enabled := False;

    enableFields(False);

  end
  else if cmdEdit.Caption = '&UPDATE' then
  begin
    cmdEdit.Caption := '&EDIT';
    cmdEdit.Enabled := False;

    cmdAdd.Enabled := True;
    cmdDelete.Enabled := False;

    enableFields(False);

  end;

end;

procedure TfrmCodeTableEntries.cmdDeleteClick(Sender: TObject);
begin

  if MessageDlg('Delete code entry?', mtConfirmation, mbYesNo, 0) = mrYes then
  with ADOConn do
  begin
    varSql := 'DELETE FROM dtaCodeTables ' +
      'WHERE codeID = ''' + IntToStr(sCodeID) + '''';

    ADOConn.Execute(varSql);

    ShowMessage('Code table entry has been successfully deleted!');

    cmbCodeCategoryClick(cmbCodeCategory);

  end;
end;

procedure TfrmCodeTableEntries.gridDetailsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//        sCodeID := dsEntry.FieldByName('CodeID').AsInteger;
//        txtCode.Text := dsEntry.FieldByName('Code').AsString;
//        txtDescription.Text := dsEntry.FieldByName('Description').AsString;
//        cmbHierarchy.Text := dsEntry.FieldByName('Hierarchy').AsString;
//        cmbJobCategory.Text := dsEntry.FieldByName('jobCategory').AsString;

//        cmdEdit.Enabled := True;
//        cmdDelete.Enabled := True;
end;

end.
