unit PayRep2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, StrUtils, ExtCtrls, CommonModule, ComCtrls,
  DateUtils;

type
  TfrmPayRep2 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADODataSet1: TADODataSet;
    Label3: TLabel;
    Label4: TLabel;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    ADODataSet2: TADODataSet;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayRep2: TfrmPayRep2;
  sqlserver : string;
  sqldatabase : string;
  sqluser : string;
  sqlpwd : string;
  gUser : String;
  gUser_ID : Integer;
  SQL : string;

implementation
uses comobj; //, PayRep2;
{$R *.dfm}

procedure TfrmPayRep2.Button3Click(Sender: TObject);
begin
  opendialog1.Filter := 'Excel File(*.xls) | *.xls';
  opendialog1.Execute;
end;

procedure TfrmPayRep2.Button2Click(Sender: TObject);
begin
  frmPayRep2.close;
end;

procedure TfrmPayRep2.Button1Click(Sender: TObject);
var
   oxl, owb, osheet : variant;
   keyer: word;
   Tem : String;
   vKeyer_ID: String;
   vExtracted_Date : String;
   vProcessed: string;
   vTask_ID : string;
   vBatches : Integer;
   vClaims : Integer;
   vPulls : Integer;
   vMins : double;
   x: Integer;
   SQLupdate: String;
   rec_count : Integer;

   TimeDiff : string;
   Start_Time : string;
   vSQL : string;

    dt : TDateTime;
    day: Integer;
    sPeriod1, sPeriod2, tPeriod1, tPeriod2: String;
    sYear : String;
    I : Int64;
    row : Integer;

    xfile : TextFile;
    xfilename : String;
    xperiod : String;
    myDate : TDateTime;
    myYear, myMonth, myDay : Word;
    tstr : String;
    tstatus : String;

begin

    ADODATASET1.Close;
    ADODATASET1.Connection := ADOCONNECTION1;
    ADODATASET1.CommandText := 'Select distinct period1 from dtaPayrollProcess where Year(Period1)='+ComboBox1.Text+' AND Month(Period1)='+IntToStr(ComboBox2.ItemIndex+1);
    //ShowMessage(ADODATASET1.CommandText);
    ADODATASET1.Open;
    I := ADODataSet1.RecordCount;
    ADODataSet1.Close;
    if I = 0 then
    begin
      ShowMessage('Payroll Period does not have data on file.');
      exit;
    end;

    if (ComboBox2.ItemIndex+1) < 10 then
      xperiod := ComboBox1.Text + '0' + IntToStr(ComboBox2.ItemIndex+1)
    else
      xperiod := ComboBox1.Text + IntToStr(ComboBox2.ItemIndex+1);

    Edit2.Text := 'Preparing Header...';
    Edit2.Refresh;

//    xfilename := 'C:\' + xperiod + '.MCL';
    xfilename := 'TextFiles\' + xperiod + '.MCL';
    AssignFile(xfile,xfilename);
    Rewrite(xfile);

    // prepare MCL header //
                                            // Fieldname  Columns   Size
    Write(xfile,'00');                      // RECCD      1-2       2
    Write(xfile,'   ');                     // FILLER     3-5       3
    Write(xfile,'1');                       // TRTYP      6         1
    Write(xfile,xperiod);                   // DOCNO      7-12      6
    Write(xfile,'         ');               // FILLER     13-21     9

    myDate := DateTimePicker1.Date;
    DecodeDate(myDate, myYear, myMonth, myDay);
    tstr := FloatToStr(myYear);
    if myMonth < 10 then
      tstr := tstr + '0' + FloatToStr(myMonth)
    else
      tstr := tstr + FloatToStr(myMonth);
    if myDay < 10 then
      tstr := tstr + '0' + FloatToStr(myDay)
    else
      tstr := tstr + FloatToStr(myDay);
    Write(xfile,tstr);                      // DOCDT      22-29     8
    Write(xfile,xperiod);                   // APLDA      30-35     6
    ADODATASET1.CommandText := 'SELECT * FROM dtaSystemParameters';
    ADODATASET1.Open;
                                            // ERNAME     36-75     40
    Write(xfile,ADODataSet1.FieldByName('MCL_ERNAME').AsString);
                                            // ERID       76-85     10
    Write(xfile,ADODataSet1.FieldByName('MCL_ERID').AsString);
    ADODataSet1.Close;
    Write(xfile,'   ');                     // FILLER     86-89     3
    Writeln(xfile,'');

    ADODATASET1.CommandText :=
      'select p.employee_pin,e.employee_name, ' +
      '	e.emplname,e.empfname,e.empmname,e.sssno, ' +
      '	e.epf_year,e.epf_month,e.no_sss,e.dateofbirth, ' +
      ' e.date_hired,e.date_resigned, ' +
      '	sum(p.sss_ee) as sss_ee, ' +
      '	sum(p.sss_er) as sss_er, ' +
      ' sum(p.sss_ee+p.sss_er) as sss_both, '+
      '	sum(p.ecc_er) as ecc_er ' +
      'from dtapayrollprocess p ' +
      '	left outer join dtaemployees e ' +
      '	on p.employee_pin=e.employee_pin ' +
      'where year(p.period1)='+ComboBox1.Text+' ' +
      '	and month(p.period1)='+IntToStr(ComboBox2.ItemIndex+1)+' ' +
      '	and e.no_sss = 0 ' +
      'group by p.employee_pin,e.employee_name, ' +
      '	e.emplname,e.empfname,e.empmname,e.sssno, ' +
      '	e.epf_year,e.epf_month,e.no_sss,e.dateofbirth, ' +
      ' e.date_hired,e.date_resigned ' +
//      'order by p.employee_pin ';
      'order by e.sssno ';
    ADODATASET1.Open;
    while not ADODATASET1.Eof do
    begin

      Edit2.Text := ADODataSet1.FieldByName('Employee_Name').AsString;
      Edit2.Refresh;

      // MCL Details
                                              // Fieldname  Columns   Size
      Write(xfile,'20');                      // RECCD      1-2       2
      Write(xfile,'   ');                     // FILLER     3-5       3

      tstr := Trim(ADODataSet1.FieldByName('EmpLname').AsString);
      if length(tstr) > 19 then
        tstr := AnsiLeftStr(tstr,20)
      else
        tstr := tstr + AnsiLeftStr('                    ',20-length(tstr));
      Write(xfile,tstr);                      // SURNM      6-25      20

      tstr := Trim(ADODataSet1.FieldByName('EmpFname').AsString);
      if length(tstr) > 19 then
        tstr := AnsiLeftStr(tstr,20)
      else
        tstr := tstr + AnsiLeftStr('                    ',20-length(tstr));
      Write(xfile,tstr);                      // GIVNM      26-45     20

      tstr := AnsiLeftStr(Trim(ADODataSet1.FieldByName('EmpMname').AsString),1);
      if length(tstr) < 1 then tstr := ' ';
      Write(xfile,tstr);                      // MIDINIT    46        1

      tstr := AnsiLeftStr(Trim(ADODataSet1.FieldByName('SSSNo').AsString),10);
      if length(tstr) < 10 then
        tstr := tstr + AnsiLeftStr('          ',10-length(tstr));
      Write(xfile,tstr);                      // SSNUM      47-56     10

      tstr := FormatCurr('####0.00',ADODataSet1.FieldByName('sss_both').Value);
      if length(tstr) < 8 then
        tstr := AnsiLeftStr('        ',8-length(tstr)) + tstr;
      Write(xfile,tstr);                      // SSAMT      57-64     8

      Write(xfile,'    0.00');                // MCAMT      65-72     8

      tstr := FormatCurr('####0.00',ADODataSet1.FieldByName('ecc_er').Value);
      if length(tstr) < 8 then
        tstr := AnsiLeftStr('        ',8-length(tstr)) + tstr;
      Write(xfile,tstr);                      // ECAMT      73-80     8

      tStatus := ' ';

      if not ADODataSet1.FieldByName('Date_Hired').IsNull then
      begin
        myDate := ADODataSet1.FieldByName('Date_Hired').Value;
        DecodeDate(myDate, myYear, myMonth, myDay);
        // check if year and month of datehired is the same as year and month
        if (FloatToStr(myYear) = ComboBox1.Text) and
          (FloatToStr(myMonth) = IntToStr(ComboBox2.ItemIndex+1)) then
        begin
          // then status = '1' and date = datehired
          Write(xfile,FloatToStr(myYear));
          if myMonth < 10 then
            Write(xfile,'0'+FloatToStr(myMonth))
          else
            Write(xfile,FloatToStr(myMonth));
          if myDay < 10 then
            Write(xfile,'0'+FloatToStr(myDay))
          else
            Write(xfile,FloatToStr(myDay));
          tStatus := '1';
          Write(xfile,tStatus);
        end;
      end;

      if (not ADODataSet1.FieldByName('Date_Resigned').IsNull) and
          (tStatus = ' ') then
      begin
        myDate := ADODataSet1.FieldByName('Date_Resigned').Value;
        DecodeDate(myDate, myYear, myMonth, myDay);
        // check if year and month of date resigned is the same as year and month
        if (FloatToStr(myYear) = ComboBox1.Text) and
          (FloatToStr(myMonth) = IntToStr(ComboBox2.ItemIndex+1)) then
        begin
          // then status = '2' and date = dateresigned
          Write(xfile,FloatToStr(myYear));
          if myMonth < 10 then
            Write(xfile,'0'+FloatToStr(myMonth))
          else
            Write(xfile,FloatToStr(myMonth));
          if myDay < 10 then
            Write(xfile,'0'+FloatToStr(myDay))
          else
            Write(xfile,FloatToStr(myDay));
          tStatus := '2';
          Write(xfile,tStatus);
        end;
      end;

      // if status is not 1 or 2 then status = 3
      if tStatus = ' ' then
        begin
          Write(xfile,'        3');
        end;

      if CheckBox1.Checked then
          Write(xfile,' PIN=>'+ADODataSet1.FieldByName('Employee_PIN').AsString);

      Writeln(xfile,'');
      ADODATASET1.Next;
    end;
    ADODataSet1.Close;

    Edit2.Text := 'Preparing Footer..';
    Edit2.Refresh;

    ADODATASET1.CommandText :=
      'select ' +
      '	sum(p.sss_ee) as sss_ee, ' +
      '	sum(p.sss_er) as sss_er, ' +
      ' sum(p.sss_ee+p.sss_er) as sss_both, '+
      '	sum(p.ecc_er) as ecc_er ' +
      'from dtapayrollprocess p ' +
      '	left outer join dtaemployees e ' +
      '	on p.employee_pin=e.employee_pin ' +
      'where year(p.period1)='+ComboBox1.Text+' ' +
      '	and month(p.period1)='+IntToStr(ComboBox2.ItemIndex+1)+' ' +
      '	and e.no_sss = 0 ';
    ADODATASET1.Open;
    if not ADODATASET1.Eof then
    begin
      // MCL FOOTER //
                                              // Fieldname  Columns   Size
      Write(xfile,'99');                      // RECCD      1-2       2
      Write(xfile,'   ');                     // FILLER     3-5       3

      tstr := FormatCurr('########0.00',ADODataSet1.FieldByName('sss_both').Value);
      if length(tstr) < 12 then
        tstr := AnsiLeftStr('            ',12-length(tstr)) + tstr;
      Write(xfile,tstr);                      // SSAMT      6-17      12

      Write(xfile,'        0.00');            // MCAMT      18-29     12

      tstr := FormatCurr('########0.00',ADODataSet1.FieldByName('ecc_er').Value);
      if length(tstr) < 12 then
        tstr := AnsiLeftStr('            ',12-length(tstr)) + tstr;
      Write(xfile,tstr);                      // ECAMT      30-41     12

      Write(xfile,xperiod+'01');              // REFPONUM   42-49     8
      Write(xfile,'       ');                 // FILLER     50-56     7
      Writeln(xfile,'');
    end;

    ADODataSet1.Close;

    CloseFile(xfile);

    Edit2.Text := 'Please check this file. '+xfilename;
    Edit2.Refresh;

    ShowMessage('done..');

    exit;


    // log //
    SQL :=       'INSERT INTO dtaLogFile ' ;
    SQL := SQL + '   ( Tran_Date, User_id, Module_Desc, Command, Remarks ) ' ;
    SQL := SQL + 'VALUES ';
    SQL := SQL + '( ';
    SQL := SQL + chr(39) + DateToStr(Now) + ' ' + TimeToStr(Now) + chr(39) + ', ';
    SQL := SQL + IntToStr(gUser_ID) + ', ';
    SQL := SQL + chr(39) + frmPayRep2.Caption + chr(39) + ', ';
    SQL := SQL + chr(39) + 'Report' + chr(39) + ', ';
//    SQL := SQL + chr(39) + DateToStr(DateTimePicker1.Date) + '|' + DateToStr(DateTimePicker2.Date) + chr(39) ;
    SQL := SQL + ')';
//    ShowMessage(SQL);
    ADOConnection1.Execute(SQL);

    oxl.visible := true;
    //oxl.quit;

end;

procedure TfrmPayRep2.FormCreate(Sender: TObject);
begin
   ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
   ADOConnection1.Connected := TRUE;
end;

procedure TfrmPayRep2.FormActivate(Sender: TObject);
var
  myDate : TDateTime;
  myYear, myMonth, myDay : Word;
begin
//  DateTimePicker1.Date := Today;
  gUser := ActiveUserName;  // this is only temporary and must be modified
  gUser_ID := StrToInt(ActiveUserID);    // this is only temporary

  DateTimePicker1.Date := Now;

  ComboBox1.Clear;

  myDate := Now;
  DecodeDate(myDate, myYear, myMonth, myDay);

  ComboBox1.AddItem(FloatToStr(myYear),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-1),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-2),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-3),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-4),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-5),ComboBox1);
  ComboBox1.AddItem(FloatToStr(myYear-6),ComboBox1);
  ComboBox1.ItemIndex := 0;

  ComboBox2.Clear;
  ComboBox2.AddItem('January',ComboBox2);
  ComboBox2.AddItem('February',ComboBox2);
  ComboBox2.AddItem('March',ComboBox2);
  ComboBox2.AddItem('April',ComboBox2);
  ComboBox2.AddItem('May',ComboBox2);
  ComboBox2.AddItem('June',ComboBox2);
  ComboBox2.AddItem('July',ComboBox2);
  ComboBox2.AddItem('August',ComboBox2);
  ComboBox2.AddItem('September',ComboBox2);
  ComboBox2.AddItem('October',ComboBox2);
  ComboBox2.AddItem('November',ComboBox2);
  ComboBox2.AddItem('December',ComboBox2);
  ComboBox2.ItemIndex := myMonth-1;
end;

procedure TfrmPayRep2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
