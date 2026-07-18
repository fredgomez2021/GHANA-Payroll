IF NOT EXISTS (
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dtaOther_Earn_Ded' AND COLUMN_NAME='payslip_note')
ALTER TABLE [dtaOther_Earn_Ded] ADD [payslip_note] [nvarchar](500) NULL