/****** Object:  StoredProcedure [dbo].[PayRep1_TwoPayrolls]    Script Date: 01/23/2018 12:47:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PayRep1_TwoPayrolls]
   @PayrollPeriod1 NVARCHAR(30),
   @PayrollPeriod2 NVARCHAR(30)
AS

BEGIN

truncate table dbo.xPayRep1

insert  into xPayRep1
   select @PayrollPeriod1 AS period1, p.empLoc AS [emp_loc],p.employeeName AS [Employee_Name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,p.employee_pin,
   sum(isnull(p.basic_pay1,0)+isnull(p.basic_pay2,0)) as basic_pay,
   sum(isnull(holiday_pay1,0)+isnull(holiday_pay2,0)) as holiday_pay,
   sum(isnull(ot_pay2,0)) as ot_pay2,sum(isnull(cola2,0)) as cola2,
   sum(isnull(day_off_pay2,0)) as day_off_pay2,
   sum(isnull(night_diff_pay2,0)) as night_diff_pay2,
   sum(isnull(unearned_pay,0)) as unearned_pay,
   sum(isnull(bonus_pay2,0)) as bonus_pay2,
   sum(isnull(other_earn1,0)+isnull(other_earn2,0)+isnull(other_earn3,0)) as other_earn_bef_tax,
   sum(isnull(other_ded1,0)+isnull(other_ded2,0)+isnull(other_ded3,0)) as other_ded_bef_tax,
   sum(isnull(gross_pay,0)) as gross_pay,sum(isnull(sla_5,0)) as sla_5,sum(isnull(sla_10,0)) as sla_10,
         sum(isnull(with_tax,0)) as with_tax,sum(isnull(sss_ee,0)) as sss_ee,
   sum(isnull(philhealth_ee,0)) as philhealth_ee,sum(isnull(pagibig_ee,0)) as pagibig_ee,
         sum(isnull(other_earn4,0)+isnull(other_earn5,0)) as other_earn_after_tax,
         sum(isnull(other_ded4,0)+isnull(other_ded5,0)) as other_ded_after_tax,
         sum(isnull(total_ded,0)) as total_ded,sum(isnull(net_pay,0)) as net_pay,

   isnull(p.atmNumber,'NO ATM') as atm_number,isnull(e.watm,'N') as watm,
   sum(isnull(sss_er,0)) as sss_er,sum(isnull(ecc_er,0)) as ecc_er,
   sum(isnull(philhealth_er,0)) as philhealth_er,sum(isnull(pagibig_er,0)) as pagibig_er,
   sum(isnull(m13thmo,0)) as m13thmo,isnull(e.ytd_13thmo,0) as ytd_13thmo,
   sum(isnull(ot_holiday,0)) as ot_holiday, sum(isnull(nd_holiday,0)) as nd_holiday,
   sum(isnull(ot_dayoff,0)) as ot_dayoff, sum(isnull(nd_dayoff,0)) as nd_dayoff,
   -- total payroll expenses
   sum(isnull(gross_pay,0)+isnull(sss_er,0)+
   isnull(ecc_er,0)+isnull(philhealth_er,0)+
   isnull(pagibig_er,0)+isnull(m13thmo,0)+(isnull(other_earn4,0)+isnull(other_earn5,0))+
   isnull(bonus_uph,0)+isnull(bonus_quality,0)+isnull(bonus_attendance,0)+isnull(bonus_retention,0)) as tpay_exp,
   sum(isnull((reg_hrs2+ot_hrs2),0)) as hrsWorked,

   sum(isnull(bonus_uph,0)) as bonus_uph,
   sum(isnull(bonus_quality,0)) as bonus_quality,
   sum(isnull(bonus_attendance,0)) as bonus_attendance,
   sum(isnull(bonus_retention,0)) as bonus_retention,
   sum(isnull(sb_cashadvance,0)) as sb_cashadvance,

   sum(isnull(mp2_ee,0)) as mp2_ee,
   sum(isnull(mp2_er,0)) as mp2_er,
   sum(isnull(ytd_mp2amount,0)) as ytd_mp2amount,
   sum(isnull(Bonus_PerfectAttendance,0)) as Bonus_PerfectAttendance

      from 
          dbo.dtapayrollprocess p
      left outer join dbo.dtaemployees e
      left outer join dbo.dtacodetables c
         on e.job_position_code = c.code and c.code_category='Job_Position'
      on p.employee_pin = e.employee_pin
      where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	  group by p.empLoc, p.employeeName, p.project, p.positionCode, c.hierarchy,p.employee_pin,
		p.atmNumber, e.watm, e.ytd_13thmo
      order by p.project,c.hierarchy,p.empLoc,p.employeeName

--if exists (select * from dbo.sysobjects where id = object_id(N'xPayRep2'))
--drop table dbo.xPayRep2
truncate table dbo.xPayRep2


/*      select primary_task_id,emp_loc,watm,sum(isnull(p.basic_pay,0)) as basic_pay,*/
insert into dbo.xPayRep2
      select primary_task_id,emp_loc,sum(isnull(p.basic_pay,0)) as basic_pay,
         sum(isnull(holiday_pay,0)) as holiday_pay,
         sum(isnull(ot_pay2,0)) as ot_pay,
         sum(isnull(ot_holiday,0)) as ot_holiday_pay,
   sum(isnull(ot_dayoff,0)) as ot_dayoff_pay,
         sum(isnull(cola2,0)) as cola,
   sum(isnull(day_off_pay2,0)) as day_off_pay,
         sum(isnull(night_diff_pay2,0)) as night_diff_pay,
         sum(isnull(nd_holiday,0)) as night_diff_holiday_pay,
   sum(isnull(nd_dayoff,0)) as night_diff_dayoff_pay,
   sum(isnull(unearned_pay,0)) as unearned_pay,
   sum(isnull(bonus_pay2,0)) as bonus_pay,
         sum(isnull(sla_5,0)) as sla_5,
         sum(isnull(sla_10,0)) as sla_10,
         sum(isnull(other_earn_bef_tax,0)) as other_earn_bef_tax,
         sum(isnull(other_ded_bef_tax,0)) as other_ded_bef_tax,
         sum(isnull(gross_pay,0)) as gross_pay,
         sum(isnull(with_tax,0)) as with_tax,
         sum(isnull(sss_ee,0)) as sss_ee,
         sum(isnull(philhealth_ee,0)) as philhealth_ee,
         sum(isnull(pagibig_ee,0)) as pagibig_ee,
         sum(isnull(other_earn_after_tax,0)) as other_earn_after_tax,
         sum(isnull(other_ded_after_tax,0)) as other_ded_after_tax,
         sum(isnull(total_ded,0)) as total_ded,
         sum(isnull(net_pay,0)) as net_pay,
         sum(isnull(sss_er,0)) as sss_er,
         sum(isnull(ecc_er,0)) as ecc_er,
         sum(isnull(philhealth_er,0)) as philhealth_er,
         sum(isnull(pagibig_er,0)) as pagibig_er,
         sum(isnull(m13thmo,0)) as m13thmo,
         sum(isnull(ytd_13thmo,0)) as ytd_13thmo,
   sum(isnull(tpay_exp,0)) as tpay_exp,
   count(*) as no_emp,
   sum(isnull(hrsWorked,0)) as hrsWorked,

   sum(isnull(bonus_uph,0)) as bonus_uph,
   sum(isnull(bonus_quality,0)) as bonus_quality,
   sum(isnull(bonus_attendance,0)) as bonus_attendance,
   sum(isnull(bonus_retention,0)) as bonus_retention,
   sum(isnull(sb_cashadvance,0)) as sb_cashadvance,

   sum(isnull(mp2_ee,0)) as mp2_ee,
   sum(isnull(mp2_er,0)) as mp2_er,
   sum(isnull(ytd_mp2amount,0)) as ytd_mp2amount,
   sum(isnull(Bonus_PerfectAttendance,0)) as Bonus_PerfectAttendance

      from dbo.xPayRep1 p
      where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
      group by primary_task_id,emp_loc
      order by primary_task_id,emp_loc

--if exists (select * from dbo.sysobjects where id = object_id(N'xPayRep3'))
--drop table dbo.xPayRep3
truncate table dbo.xPayRep3

insert into dbo.xPayRep3
      select emp_loc,watm,sum(isnull(p.basic_pay,0)) as basic_pay,
         sum(isnull(holiday_pay,0)) as holiday_pay,
         sum(isnull(ot_pay2,0)) as ot_pay,
         sum(isnull(ot_holiday,0)) as ot_holiday_pay,
   sum(isnull(ot_dayoff,0)) as ot_dayoff_pay,
         sum(isnull(cola2,0)) as cola,
   sum(isnull(day_off_pay2,0)) as day_off_pay,
         sum(isnull(night_diff_pay2,0)) as night_diff_pay,
         sum(isnull(nd_holiday,0)) as night_diff_holiday_pay,
   sum(isnull(nd_dayoff,0)) as night_diff_dayoff_pay,
   sum(isnull(unearned_pay,0)) as unearned_pay,
   sum(isnull(bonus_pay2,0)) as bonus_pay,
         sum(isnull(sla_5,0)) as sla_5,
         sum(isnull(sla_10,0)) as sla_10,
         sum(isnull(other_earn_bef_tax,0)) as other_earn_bef_tax,
         sum(isnull(other_ded_bef_tax,0)) as other_ded_bef_tax,
         sum(isnull(gross_pay,0)) as gross_pay,
         sum(isnull(with_tax,0)) as with_tax,
         sum(isnull(sss_ee,0)) as sss_ee,
         sum(isnull(philhealth_ee,0)) as philhealth_ee,
         sum(isnull(pagibig_ee,0)) as pagibig_ee,
         sum(isnull(other_earn_after_tax,0)) as other_earn_after_tax,
         sum(isnull(other_ded_after_tax,0)) as other_ded_after_tax,
         sum(isnull(total_ded,0)) as total_ded,
         sum(isnull(net_pay,0)) as net_pay,
         sum(isnull(sss_er,0)) as sss_er,
         sum(isnull(ecc_er,0)) as ecc_er,
         sum(isnull(philhealth_er,0)) as philhealth_er,
         sum(isnull(pagibig_er,0)) as pagibig_er,
         sum(isnull(m13thmo,0)) as m13thmo,
         sum(isnull(ytd_13thmo,0)) as ytd_13thmo,
   sum(isnull(tpay_exp,0)) as tpay_exp,
   count(*) as no_emp,
   sum(isnull(hrsWorked,0)) as hrsWorked,

   sum(isnull(bonus_uph,0)) as bonus_uph,
   sum(isnull(bonus_quality,0)) as bonus_quality,
   sum(isnull(bonus_attendance,0)) as bonus_attendance,
   sum(isnull(bonus_retention,0)) as bonus_retention,
   sum(isnull(sb_cashadvance,0)) as sb_cashadvance,

   sum(isnull(mp2_ee,0)) as mp2_ee,
   sum(isnull(mp2_er,0)) as mp2_er,
   sum(isnull(ytd_mp2amount,0)) as ytd_mp2amount,
   sum(isnull(Bonus_PerfectAttendance,0)) as Bonus_PerfectAttendance

      from dbo.xPayRep1 p
      where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
      group by emp_loc,watm
      order by emp_loc,watm

-- Preparation for the Payroll Adjustments Report --
--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Earnings Before Tax      ' as Adjustment,
   SUBSTRING(p.Other_Earn_Desc1,1,3) as Code,
   p.Other_Earn_Desc1 as Description,
   p.Other_Earn1 as Amount
INTO #Earn1
FROM
   dbo.dtaPayrollProcess p
    left outer join dbo.dtaemployees e
    left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
             on p.employee_pin = e.employee_pin
	WHERE Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Earn_Desc1,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Earnings Before Tax      ' as Adjustment,
   SUBSTRING(p.Other_Earn_Desc2,1,3) as Code,
   p.Other_Earn_Desc2 as Description,
   p.Other_Earn2 as Amount
INTO #Earn2
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Earn_Desc2,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Earnings Before Tax      ' as Adjustment,
   SUBSTRING(p.Other_Earn_Desc3,1,3) as Code,
   p.Other_Earn_Desc3 as Description,
   p.Other_Earn3 as Amount
INTO #Earn3
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
         left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Earn_Desc3,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Earnings After Tax       ' as Adjustment,
   SUBSTRING(p.Other_Earn_Desc4,1,3) as Code,
   p.Other_Earn_Desc4 as Description,
   p.Other_Earn4 as Amount
INTO #Earn4
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Earn_Desc4,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Earnings After Tax       ' as Adjustment,
   SUBSTRING(p.Other_Earn_Desc5,1,3) as Code,
   p.Other_Earn_Desc5 as Description,
   p.Other_Earn5 as Amount
INTO #Earn5
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Earn_Desc5,1,3))>0

--------------------------------------------------------------
--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Deduction Before Tax     ' as Adjustment,
   SUBSTRING(p.Other_Ded_Desc1,1,3) as Code,
   p.Other_Ded_Desc1 as Description,
   p.Other_Ded1 as Amount
INTO #Ded1
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Ded_Desc1,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Deduction Before Tax     ' as Adjustment,
   SUBSTRING(p.Other_Ded_Desc2,1,3) as Code,
   p.Other_Ded_Desc2 as Description,
   p.Other_Ded2 as Amount
INTO #Ded2
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Ded_Desc2,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Deduction Before Tax     ' as Adjustment,
   SUBSTRING(p.Other_Ded_Desc3,1,3) as Code,
   p.Other_Ded_Desc3 as Description,
   p.Other_Ded3 as Amount
INTO #Ded3
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Ded_Desc3,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Deduction After Tax      ' as Adjustment,
   SUBSTRING(p.Other_Ded_Desc4,1,3) as Code,
   p.Other_Ded_Desc4 as Description,
   p.Other_Ded4 as Amount
INTO #Ded4
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Ded_Desc4,1,3))>0

--------------------------------------------------------------
SELECT
   p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,e.employee_pin,
   'Deduction After Tax      ' as Adjustment,
   SUBSTRING(p.Other_Ded_Desc5,1,3) as Code,
   p.Other_Ded_Desc5 as Description,
   p.Other_Ded5 as Amount
INTO #Ded5
FROM dbo.dtaPayrollProcess p
         left outer join dbo.dtaemployees e
            left outer join dbo.dtacodetables c
            on e.job_position_code = c.code and c.code_category='Job_Position'
         on p.employee_pin = e.employee_pin
	where Period1 IN (@PayrollPeriod1, @PayrollPeriod2)
	and ISNUMERIC(SUBSTRING(Other_Ded_Desc5,1,3))>0

--------------------------------------------------------------
--if exists (select * from dbo.sysobjects where id = object_id(N'xPayRep1_Adj'))
--drop table dbo.xPayRep1_Adj
truncate table dbo.xPayRep1_Adj

--SELECT *   INTO dbo.xPayRep1_Adj FROM #Earn1

INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Earn1
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Earn2
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Earn3
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Earn4
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Earn5
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Ded1
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Ded2
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Ded3
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Ded4
INSERT INTO dbo.xPayRep1_Adj SELECT * FROM #Ded5

DROP TABLE #Earn1
DROP TABLE #Earn2
DROP TABLE #Earn3
DROP TABLE #Earn4
DROP TABLE #Earn5
DROP TABLE #Ded1
DROP TABLE #Ded2
DROP TABLE #Ded3
DROP TABLE #Ded4
DROP TABLE #Ded5

--SELECT * FROM xPayRep1_Adj

-- End --

END




GO


