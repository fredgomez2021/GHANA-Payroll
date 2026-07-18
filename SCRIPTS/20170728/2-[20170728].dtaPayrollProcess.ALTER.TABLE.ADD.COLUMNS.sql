IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_UPH')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_UPH] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_UPH]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Quality')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Quality] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_Quality]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Attendance')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Attendance] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_Attendance]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Retention')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Retention] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_Retention]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='SB_CashAdvance')
ALTER TABLE [dtaPayrollProcess] ADD [SB_CashAdvance] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_SB_CashAdvance]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Attendance_PeriodFrom')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Attendance_PeriodFrom] [smalldatetime] NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Attendance_PeriodTo')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Attendance_PeriodTo] [smalldatetime] NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Remarks')
ALTER TABLE [dtaPayrollProcess] ADD [Remarks] [nvarchar](500) NULL CONSTRAINT [DF_dtaPayrollProcess_Remarks]  DEFAULT ('')

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='LastMonthDayCount')
ALTER TABLE [dtaPayrollProcess] ADD [LastMonthDayCount] [smallmoney] NULL CONSTRAINT [DF_dtaPayrollProcess_LastMonthDayCount]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='LastMonthDayAbsentCount')
ALTER TABLE [dtaPayrollProcess] ADD [LastMonthDayAbsentCount] [smallint] NULL CONSTRAINT [DF_dtaPayrollProcess_LastMonthDayAbsentCount]  DEFAULT ((0))