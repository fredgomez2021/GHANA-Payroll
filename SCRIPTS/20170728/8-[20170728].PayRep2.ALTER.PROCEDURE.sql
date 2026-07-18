/****** Object:  StoredProcedure [dbo].[PayRep2]    Script Date: 07/29/2017 2:40:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PayRep2]
   @D1 AS VARCHAR(20),
   @D2 AS VARCHAR(20)
AS

BEGIN

--   PRINT @D1
--   PRINT @D2
/*
select employee_pin,ytd_13thmo
from dtaemployees
order by employee_pin
*/

--if exists (select * from dbo.sysobjects where id = object_id(N'xPayRep1'))
--drop table xPayRep1
truncate table xPayRep1

   insert into xPayRep1
      select p.period1,p.empLoc AS [emp_loc],p.employeeName AS [employee_name],p.project AS [primary_task_id],
   isnull(p.positionCode,'') as job_position_code,
   isnull(c.hierarchy,'') as hierarchy,p.employee_pin,
         isnull(p.basic_pay1,0)+isnull(p.basic_pay2,0) as basic_pay,
   isnull(holiday_pay1,0)+isnull(holiday_pay2,0) as holiday_pay,
         isnull(ot_pay2,0) as ot_pay2,isnull(cola2,0) as cola2,
   isnull(day_off_pay2,0) as day_off_pay2,
   isnull(night_diff_pay2,0) as night_diff_pay2,
   isnull(unearned_pay,0) as unearned_pay,
   isnull(bonus_pay2,0) as bonus_pay2,
   isnull(other_earn1,0)+isnull(other_earn2,0)+isnull(other_earn3,0) as other_earn_bef_tax,
         isnull(other_ded1,0)+isnull(other_ded2,0)+isnull(other_ded3,0) as other_ded_bef_tax,
   isnull(gross_pay,0) as gross_pay,isnull(sla_5,0) as sla_5,isnull(sla_10,0) as sla_10,
         isnull(with_tax,0) as with_tax,isnull(sss_ee,0) as sss_ee,
   isnull(philhealth_ee,0) as philhealth_ee,isnull(pagibig_ee,0) as pagibig_ee,
         isnull(other_earn4,0)+isnull(other_earn5,0) as other_earn_after_tax,
         isnull(other_ded4,0)+isnull(other_ded5,0) as other_ded_after_tax,
         isnull(total_ded,0) as total_ded,isnull(net_pay,0) as net_pay,
   isnull(p.atmNumber,'NO ATM') as atm_number,isnull(e.watm,'N') as watm,
   isnull(sss_er,0) as sss_er,isnull(ecc_er,0) as ecc_er,
   isnull(philhealth_er,0) as philhealth_er,isnull(pagibig_er,0) as pagibig_er,
   isnull(m13thmo,0) as m13thmo,isnull(e.ytd_13thmo,0) as ytd_13thmo,
   isnull(ot_holiday,0) as ot_holiday, isnull(nd_holiday,0) as nd_holiday,
   isnull(ot_dayoff,0) as ot_dayoff, isnull(nd_dayoff,0) as nd_dayoff,
   -- total payroll expenses
   isnull(gross_pay,0)+isnull(sss_er,0)+
   isnull(ecc_er,0)+isnull(philhealth_er,0)+
   isnull(pagibig_er,0)+isnull(m13thmo,0)+(isnull(other_earn4,0)+isnull(other_earn5,0))
--+ isnull(other_earn4,0)+isnull(other_earn5,0) -
--   ( isnull(other_ded4,0)+isnull(other_ded5,0) )
    as tpay_exp,
   isnull((reg_hrs2+ot_hrs2),0) as hrsWorked,

   isnull(bonus_uph,0) as bonus_uph,
   isnull(bonus_quality,0) as bonus_quality,
   isnull(bonus_attendance,0) as bonus_attendance,
   isnull(bonus_retention,0) as bonus_retention,
   isnull(sb_cashadvance,0) as sb_cashadvance

      from dtapayrollprocess p
      left outer join dtaemployees e
      left outer join dtacodetables c
         on e.job_position_code = c.code and c.code_category='Job_Position'
      on p.employee_pin = e.employee_pin
      where (period1=@D2 or period1=@D1)-- and p.employeeName is not null
      order by p.project,c.hierarchy,e.emp_loc,p.employeeName

--select * from xPayRep1
--select sum(ytd_13thmo) from xPayRep1

-- summary report 1 --

--if exists (select * from dbo.sysobjects where id = object_id(N'xPayRep2'))
--drop table xPayRep2
truncate table xPayRep2

   insert into xPayRep2
/*      select primary_task_id,emp_loc,watm,sum(isnull(p.basic_pay,0)) as basic_pay,*/
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
		   sum(isnull(sb_cashadvance,0)) as sb_cashadvance

      from xPayRep1 p
      where (period1=@D2 or period1=@D1)-- and employee_name is not null
/*      group by primary_task_id,emp_loc,watm
      order by primary_task_id,emp_loc,watm */
      group by primary_task_id,emp_loc
      order by primary_task_id,emp_loc

END


GO


