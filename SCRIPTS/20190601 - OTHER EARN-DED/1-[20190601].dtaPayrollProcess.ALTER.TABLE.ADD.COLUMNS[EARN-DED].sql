IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn1_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn1_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Earn1_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn2_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn2_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Earn2_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn3_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn3_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Earn3_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn_Desc1_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn_Desc1_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn_Desc2_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn_Desc2_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Earn_Desc3_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Earn_Desc3_AfterTax] [varchar](100) NULL



IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded1_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded1_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded1_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded2_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded2_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded2_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded3_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded3_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded3_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded4_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded4_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded4_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded5_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded5_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded5_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded6_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded6_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded6_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded7_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded7_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded7_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded8_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded8_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded8_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded9_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded9_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded9_AfterTax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded10_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded10_AfterTax] [money] NULL CONSTRAINT [DF_dtaPayrollProcess_Other_Ded10_AfterTax]  DEFAULT ((0))



IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc1_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc1_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc2_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc2_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc3_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc3_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc4_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc4_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc5_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc5_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc6_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc6_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc7_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc7_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc8_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc8_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc9_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc9_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaPayrollProcess' AND COLUMN_NAME='Other_Ded_Desc10_AfterTax')
ALTER TABLE [dtaPayrollProcess] ADD [Other_Ded_Desc10_AfterTax] [varchar](100) NULL
