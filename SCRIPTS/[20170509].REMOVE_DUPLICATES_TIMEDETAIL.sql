select * from dtatime_detail where work_date between '2017-06-01' and '2017-06-15'
and time_id not in (select datein from dtatime_detail where work_date between '2017-05-16' and '2017-05-31')
--and employee_pin=2468
order by employee_pin, work_date




declare @timeId int
declare @tempTimeId int
declare @actualIn datetime
declare @empPin int
declare @rowCount int

declare cur_detail cursor for (select time_id, actual_in, employee_pin from dtatime_detail where work_date between '2017-12-01' and '2017-12-15'
	and time_id not in (select datein from dtatime_detail where work_date between '2017-11-16' and '2017-11-30')
	and actual_in is not null and actual_out is not null)

open cur_detail

fetch next from cur_detail into @timeId, @actualIn, @empPin

while @@fetch_status = 0
begin

	set @rowCount = (select count(employee_pin) from dtatime_detail where work_date between '2017-12-01' and '2017-12-15'
		and time_id not in (select datein from dtatime_detail where work_date between '2017-11-16' and '2017-11-30')
		and actual_in = @actualIn and employee_pin = @empPin and time_id <> @timeId and actual_out is null)

	if @rowCount > 0
	begin
		 delete from dtatime_detail from dtatime_detail where work_date between '2017-12-01' and '2017-12-15'
			and time_id not in (select datein from dtatime_detail where work_date between '2017-11-16' and '2017-11-30')
			and actual_in = @actualIn and employee_pin = @empPin and time_id <> @timeId and actual_out is null

		--print @timeId
	end

	fetch next from cur_detail into @timeId, @actualIn, @empPin

end

close cur_detail
deallocate cur_detail
