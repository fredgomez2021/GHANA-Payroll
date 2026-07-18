IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='xPayRep2' AND COLUMN_NAME='Bonus_PerfectAttendance')
ALTER TABLE [xPayRep2] ADD [Bonus_PerfectAttendance] [money] NULL CONSTRAINT [DF_xPayRep2_Bonus_PerfectAttendance]  DEFAULT ((0))
