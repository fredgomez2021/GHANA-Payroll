IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaBonusesDetails' AND COLUMN_NAME='Bonus_PerfectAttendance')
ALTER TABLE [dtaBonusesDetails] ADD [Bonus_PerfectAttendance] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_PerfectAttendance]  DEFAULT ((0))