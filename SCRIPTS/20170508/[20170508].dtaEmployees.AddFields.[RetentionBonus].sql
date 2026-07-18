IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaEmployees' AND COLUMN_NAME='RetentionBonus_Rate')
ALTER TABLE [dtaEmployees] ADD [RetentionBonus_Rate] [smallmoney] NULL CONSTRAINT [DF_dtaEmployees_RetentionBonus_Rate]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaEmployees' AND COLUMN_NAME='YTD_RetentionBonus')
ALTER TABLE [dtaEmployees] ADD [YTD_RetentionBonus] [money] NULL CONSTRAINT [DF_dtaEmployees_YTD_RetentionBonus]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='RetentionBonus_Rate')
ALTER TABLE [dtaPayrollProcess] ADD [RetentionBonus_Rate] [smallmoney] NULL CONSTRAINT [DF_dtaPayrollProcess_RetentionBonus_Rate]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='MRetentionBonus')
ALTER TABLE [dtaPayrollProcess] ADD [MRetentionBonus] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_MRetentionBonus]  DEFAULT ((0))