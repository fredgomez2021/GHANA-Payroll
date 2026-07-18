IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_PerfectAttendance')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_PerfectAttendance] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_PerfectAttendance]  DEFAULT ((0))