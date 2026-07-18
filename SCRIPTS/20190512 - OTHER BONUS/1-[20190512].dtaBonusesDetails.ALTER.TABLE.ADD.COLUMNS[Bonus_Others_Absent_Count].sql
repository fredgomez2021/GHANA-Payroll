IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaBonusesDetails' AND COLUMN_NAME='Bonus_Others')
ALTER TABLE [dtaBonusesDetails] ADD [Bonus_Others] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_Others]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaBonusesDetails' AND COLUMN_NAME='Absent_Count')
ALTER TABLE [dtaBonusesDetails] ADD [Absent_Count] [decimal](10, 2) NULL CONSTRAINT [DF_dtaBonusesDetails_Absent_Count]  DEFAULT ((0))
