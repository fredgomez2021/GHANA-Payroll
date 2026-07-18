IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaEmployees' AND COLUMN_NAME='WithAttendanceBonus')
ALTER TABLE [dtaEmployees] ADD [WithAttendanceBonus] [bit] NULL CONSTRAINT [DF_dtaEmployees_WithAttendanceBonus]  DEFAULT ((0))