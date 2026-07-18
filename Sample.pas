unit Sample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DateUtils, DB, ADODB, StrUtils, Winsock, CommonModule;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    ADOConnection2: TADOConnection;
    ADODataSet2: TADODataSet;
    Button2: TButton;
    Button3: TButton;
    Open1: TOpenDialog;
    Edit3: TEdit;
    Button4: TButton;
    Button5: TButton;
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
//  Edit1.Text := '10/1/2005 10:00:00 PM';
  Edit1.Text := '';
  Edit2.Text := '';
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  myDate : TDateTime;
begin
  myDate := StrToDateTime(Edit1.Text);
  //ShowMessage(DateTimeToStr(myDate));

  myDate := IncMinute(myDate, 480);
  //ShowMessage(DateTimeToStr(myDate));

  Edit2.Text := DateTimeToStr(myDate);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ADODataSet1.Connection := ADOConnection1;
  ADODataSet1.CommandText := 'SELECT * FROM dtaBirTax';
  ADODataSet1.Active := TRUE;

  if ADODataSet1.RecordCount > 0 then
  begin
    ADODataSet2.Connection := ADOConnection2;
    ADODataSet2.CommandText := 'SELECT * FROM dtaTaxTable';
    ADODataSet2.Active := TRUE;

    with ADODataSet2 do
    begin

      while not (ADODataSet1.Eof) do
      begin
        Insert;
          FieldByName('Table_Category').AsString := ADODataSet1.FieldByName('TableName').AsString;
          FieldByName('Status').AsString := ADODataSet1.FieldByName('Status').AsString;
          FieldByName('Salary_Wage').AsFloat := ADODataSet1.FieldByName('SalaryWage').AsFloat;
          FieldByName('Discount').AsFloat := ADODataSet1.FieldByName('Discount').AsFloat;
          FieldByName('Exemption').AsFloat := ADODataSet1.FieldByName('Exemption').AsFloat;
        Post;
        ADODataSet1.Next;
      end;
    end
   end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  varDir : String;
  s1, s2 : String;
begin
  varDir := GetCurrentDir;
  //ShowMessage(varDir);

  //if FileExists('FingerID-Clark\FingerID.mdb') then
  //begin
  //  ShowMessage('It exists!');
  //end
  //else
  //  ShowMessage('It does not exists!');


  Open1.InitialDir := varDir;
  Open1.Options := [ofFileMustExist];
  Open1.Filter := 'MS Access Database|*.mdb';
  Open1.FilterIndex := 2;

  if Open1.Execute then
  begin
  //  ShowMessage('File: ' + Open1.FileName)
    s1 := Open1.FileName;
    s2 := AnsiLeftStr(s1, Length(s1) - 3) + 'tob';

    if FileExists(s1) then
    begin
      RenameFile(s1, s2);
      ChangeFileExt(s1, 'tob');

    end;
  end;
  //else
    //ShowMessage('Open file was cancelled');

  //Open1.Free;


  //Edit3.Text := Open1.FileName;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  Host, IP, Err: string;
begin
  if GetIPFromHost(Host, IP, Err) then begin
    Edit1.Text := Host;
    Edit2.Text := IP;
  end
  else
    MessageDlg(Err, mtError, [mbOk], 0);
end;
procedure TForm2.Button5Click(Sender: TObject);
begin
  ShowMessage(CommonModule.ActiveUserId);
end;

end.
