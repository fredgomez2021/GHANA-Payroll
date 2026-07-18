IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='xPayRep1' AND COLUMN_NAME='Bonus_PerfectAttendance')
ALTER TABLE [xPayRep1] ADD [Bonus_PerfectAttendance] [money] NULL CONSTRAINT [DF_xPayRep1_Bonus_PerfectAttendance]  DEFAULT ((0))