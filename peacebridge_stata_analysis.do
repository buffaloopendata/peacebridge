set mem 10m
cd "C:\Users\nagowski\Dropbox\Peace Bridge Project";
ls

insheet using "peacebridge_data.csv", names


/* Convert to Date Format */

split  system_time, p(" ")
split  system_time2, p(":")
gen st_time = real( system_time21)*60 + real( system_time22)

gen date = system_time1

split date, p("/")
gen date1n = real(date1)
gen date2n = real(date2)
gen date3n = real(date3)
gen st_date = mdy(date1n,date2n,date3n)
format st_date %dD/M/CY
gen day_of_week  = dow(st_date)

drop date1 date2 date3 system_time1 system_time2  system_time21 system_time22


/* Convert Wait Time to Numeric */

foreach x in  usa_auto_peace  usa_auto_queen  usa_truck_peace  usa_truck_queen  usa_nexus_peace  usa_nexus_queen  canada_auto_peace  canada_auto_queen  canada_truck_peace  canada_truck_queen  canada_nexus_peace  canada_nexus_queen  {
	gen `x'_num = 0 if `x' == "No Delay"
	replace `x'_num = 0 if length(`x') == 0
	replace `x'_num = real(substr(`x',1,2)) if length(`x') == 6
	replace `x'_num = real(substr(`x',1,1))*60 + real(substr(`x',5,2))  if length(`x') == 9
}



twoway (line canada_auto_peace_num st_time, sort) if date1n >=12, by(day_of_week)



