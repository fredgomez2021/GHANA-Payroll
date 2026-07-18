IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_amount1_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_amount1_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_earn_amount1_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_amount2_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_amount2_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_earn_amount2_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_amount3_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_amount3_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_earn_amount3_aftertax]  DEFAULT ((0))



IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_description1_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_description1_aftertax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_description2_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_description2_aftertax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_earn_description3_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_earn_description3_aftertax] [varchar](100) NULL




IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount1_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount1_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount1_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount2_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount2_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount2_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount3_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount3_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount3_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount4_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount4_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount4_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount5_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount5_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount5_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount6_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount6_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount6_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount7_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount7_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount7_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount8_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount8_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount8_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount9_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount9_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount9_aftertax]  DEFAULT ((0))

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='other_ded_amount10_aftertax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [other_ded_amount10_aftertax] [money] NULL CONSTRAINT [DF_dtaOther_Earn_Ded_other_ded_amount10_aftertax]  DEFAULT ((0))


IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description1_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description1_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description2_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description2_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description3_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description3_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description4_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description4_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description5_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description5_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description6_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description6_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description7_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description7_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description8_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description8_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description9_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description9_AfterTax] [varchar](100) NULL

IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='Other_Ded_Description10_AfterTax')
ALTER TABLE [dtaOther_Earn_Ded] ADD [Other_Ded_Description10_AfterTax] [varchar](100) NULL




