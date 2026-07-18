unit daily_extract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls,CommonModule, DateUtils;

type
  TfrmDailySchedExtract = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADODataSet1: TADODataSet;
    Button2: TButton;
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
  frmDailySchedExtract: TfrmDailySchedExtract;

implementation
uses comobj;
{$R *.dfm}

procedure TfrmDailySchedExtract.Button3Click(Sender: TObject);
begin
opendialog1.Filter := 'Excel File(*.xls) | *.xls';
opendialog1.Execute;
edit1.Text := opendialog1.FileName;
end;

procedure TfrmDailySchedExtract.Button2Click(Sender: TObject);
begin
frmDailySchedExtract.close;
end;

procedure TfrmDailySchedExtract.Button1Click(Sender: TObject);
var
   oxl, owb      : variant;
   osheet        : variant;
   keyer         : word;
   vEmployee_PIN : string;
   vTask_ID      : String;
   vWork_Date    : String;
   vStart_Time   :String;
   vEnd_time     : String;
   vDate_Start   : String;
   vDate_End     : String;
   SQLupdate     : String;
   rec_count     : Integer;
   ctr           : Integer;
   strNAme       : string;
   sQuery        : string;
   tmpEmpPIN     : string;
   End_Time       : TDateTime;

begin
   edit2.Text := 'Starting...';
   edit2.Refresh;

   oxl := CreateOleObject('Excel.Application');

   owb := oxl.workbooks.open(Edit1.Text);
   osheet := owb.ActiveSheet;

   keyer := 1;

   edit2.Text := 'Opening dtaKeyerScheduleStruct Table...';
   edit2.Refresh;

   ADOQuery1.Connection := ADOConnection1;
   ADOQuery1.SQL.Add('Select * From dtaKeyerSchedule');
   ADOQuery1.Active:= True;

   // Initialize pointer for EDS PIN # on the 11th row
   ctr:=0;
   while ctr <= 30 do
    begin
      vEmployee_PIN := (osheet.Cells[Keyer,1]);
      vTask_ID      := (osheet.Cells[Keyer,3]);
      vWork_Date    := (osheet.Cells[Keyer,4]);
      vStart_Time   := (osheet.Cells[Keyer,6]);
      vEnd_Time     := (osheet.Cells[Keyer,7]);
      vDate_start   := (vWork_Date + vStart_time);
      vDate_end     := (vWork_Date + vEnd_Time);
      strName       := (osheet.Cells[Keyer,2]);

      //if (((vEmployee_PIN <> '') AND (vEmployee_PIN <> 'EDS PIN #')) AND (vTask_ID <> '') AND (vWork_Date <> '') AND  (vStart_Time <> '') AND (vEnd_Time <> '') AND (vDate_start <> '') AND (vDate_end <> '')) then
      if   ((vTask_ID <> '') AND (vTask_ID <> 'Task Id')) then
        begin
          if (vEmployee_PIN <> '') then
            begin
              tmpEmpPIN := vEmployee_PIN;
            end
          else
            begin
              vEmployee_PIN  := tmpEmpPIN;
            end;


         //Concatenation of start and end time
         vDate_start   := vWork_Date + ' ' + timetostr(osheet.Cells[Keyer,6]);
         //vDate_end     := vWork_Date + ' ' + timetostr(osheet.Cells[Keyer,7]);

         //increase minutes to end time
         End_Time := StrToDateTime(vDate_Start);
         End_Time := IncMinute(End_Time, 480);


         //ShowMessage(DateTimeToStr(End_Time));

         ctr:=0;
         edit2.Text := 'Extracting AFLAC Report...' + vEmployee_PIN + vTask_ID + vWork_Date + vDate_start + vDate_end;
         edit2.Refresh;

         ADODATASET1.Connection := ADOCONNECTION1;
         sQuery := 'Select * from dtaKeyerSchedule where Employee_Pin = ' + vEmployee_PIN + ' and Task_ID = '+ chr(39) + vTask_ID+ chr(39) + ' and Work_Date = ' + chr(39) + vWork_Date+ chr(39);
         ADODATASET1.CommandText := sQuery;
         ADODATASET1.Open;

         rec_count := rec_count+1;
         if (ADODATASET1.RecordCount=0) then
          begin
           // Insert Records to dtaALFAC Table(No Duplicate Records Found)

            SQLUpdate := 'INSERT INTO dtaKeyerSchedule ' +
                         '( Employee_PIN, Task_ID, Work_Date, Start_Time, End_Time)' +
                         'VALUES'
                         +
                         '('+ vEmployee_PIN + ',' + chr(39) + (vTask_ID) + chr(39) + ',' + chr(39) + vWork_Date+ chr(39)+
                         ',' + chr(39) + vDate_start + chr(39) + ',' + chr(39) + DateTimeToStr(End_Time) + chr(39)+ ')';
                         //showmessage(SQLUpdate);
            ADOCONNECTION1.Execute(SQLUpdate);
          end
         else // If there are Duplicate Records found
          begin
            SQLUpdate := 'UPDATE dtaKeyerSchedule ' +
                         ' SET Work_Date = '+ chr(39) + vWork_Date + chr(39) +', Start_Time = '+ chr(39) + vDate_Start + chr(39) +' , End_Time = '+ chr(39) + DateTimeToStr(End_Time) + chr(39) +
                         ' WHERE Employee_PIN = '+ vEmployee_PIN +' and Task_ID = '+ chr(39) + (vTask_ID)+chr(39) + ' and Work_Date = ' + chr(39) + vWork_Date+ chr(39);
            ADOCONNECTION1.Execute(SQLupdate);
          end;
          ADODATASET1.Close;
          keyer := Keyer + 1;
        end
      else
        begin
          keyer := Keyer + 1;
          ctr:=ctr+1;
        end
    end;
   oXL.Quit;
   ADOQUERY1.Close;
   ADOQUERY1.Active := False;
   edit2.Text := 'Extraction of '+intToStr(rec_count)+ ' ' + 'Daily Schedule records is Complete!';
end;

procedure TfrmDailySchedExtract.FormCreate(Sender: TObject);
begin

   ADOConnection1.ConnectionString := CommonModule.ReadInitConn(CommonModule.ToConnect('Null'));
   ADOConnection1.Connected := TRUE;
end;

end.
