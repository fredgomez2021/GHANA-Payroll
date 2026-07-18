// Name:  UserLogIn.pas
// Description:  This is the first form of the Momentum Payroll
//     System.  You must have an authorized account to be able to
//     use and access the system and enjoy its functionalities.

unit UserLogIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, CommonModule,
  jpeg, MainMenu, ExtCtrls, ImgList;

type
  TfrmUserLogIn = class(TForm)
    GroupBox1: TGroupBox;
    txtUsername: TEdit;
    txtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dsLogIn: TADODataSet;
    ADOLogIn: TADOConnection;
    ImageList1: TImageList;
    Label3: TLabel;
    Label4: TLabel;
    cmdLogIn: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdLogInClick(Sender: TObject);

    procedure LogMeInNow(Uname, Pword : String);

    function Encrypta(const S: String): String;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUserLogIn: TfrmUserLogIn;

implementation

{$R *.dfm}

procedure TfrmUserLogIn.cmdLogInClick(Sender: TObject);
var
  vUname, vPword : String;
  buttonSelected : Integer;
begin

  vUname := Trim(txtUsername.Text);
  vPword := Encrypta(Trim(txtPassword.Text));

  if ((vUname <> '') and (vPword <> '')) then
    LogMeInNow(vUname, vPword)
  else
  begin
    buttonSelected := MessageDlg('Please fill out the username and password fields', mtWarning, mbOkCancel, 0);

    if buttonSelected = mrOK then
      txtUsername.SetFocus
    else if buttonSelected = mrCancel then
      frmUserLogin.Close;
  end;
end;

procedure TfrmUserLogIn.FormCreate(Sender: TObject);
begin
  ADOLogIn.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
  ADOLogIn.Connected := TRUE;
end;

procedure TfrmUserLogIn.LogMeInNow(Uname, Pword : String);
var
  pHandle:^THandle;
begin
  pHandle :=@Application.MainForm.ClientHandle;
  pHandle^:=ClientHandle;

  dsLogIn.Close;
  dsLogIn.Connection := ADOLogIn;
  dsLogIn.CommandText := 'SELECT * FROM dtaUsers WHERE UserName = ' + Chr(39) + Uname + Chr(39) +
 //   ' AND Password = ' + Pword;
    ' AND Password = ' + Chr(39) + Pword + Chr(39);
  dsLogIn.Active := TRUE;

  if dsLogIn.RecordCount > 0 then
  begin
    ActiveUserId := dsLogIn.FieldByName('Employee_PIN').AsString;
    ActiveUserName := dsLogIn.FieldByName('UserName').AsString;

    with TfrmMenu.Create(Application) do show;
    //frmMenu.Show;

    txtUsername.Clear;
    txtPassword.Clear;

    txtUsername.SetFocus;
    frmUserLogIn.Hide;
  end
  else
    ShowMessage('The system cannot logged you in!');
end;

procedure TfrmUserLogIn.cmdCancelClick(Sender: TObject);
begin
  frmUserLogIn.Close;
end;


function TfrmUserLogIn.Encrypta(const S: String): String;
var
  I: byte;
  Key: Word;
  ls : string;
const
  {C1 y C2 aon usadas para encriptar la cadena de la clave}
  C1 = 52845;
  C2 = 11719;
begin
  Key := 1674;
  SetLength(ls,Length(S));
  Result := '';
  for I := 1 to Length(S) do begin
    ls[I] := char(byte(S[I]) xor (Key shr 8));
    Result := Result + IntToHex(byte(ls[I]),2);
    Key := (byte(ls[I]) + Key) * C1 + C2;
  end;

end;

procedure TfrmUserLogIn.Button1Click(Sender: TObject);
begin
  halt(0);
end;

end.
