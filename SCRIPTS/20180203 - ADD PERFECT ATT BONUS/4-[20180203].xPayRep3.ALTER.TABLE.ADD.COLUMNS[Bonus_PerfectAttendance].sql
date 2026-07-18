IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='xPayRep3' AND COLUMN_NAME='Bonus_PerfectAttendance')
ALTER TABLE [xPayRep3] ADD [Bonus_PerfectAttendance] [money] NULL CONSTRAINT [DF_xPayRep3_Bonus_PerfectAttendance]  DEFAULT ((0))