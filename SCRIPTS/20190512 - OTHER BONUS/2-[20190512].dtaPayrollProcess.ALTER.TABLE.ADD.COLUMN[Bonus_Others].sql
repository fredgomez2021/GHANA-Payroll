IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Bonus_Others')
ALTER TABLE [dtaPayrollProcess] ADD [Bonus_Others] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Bonus_Others]  DEFAULT ((0))
