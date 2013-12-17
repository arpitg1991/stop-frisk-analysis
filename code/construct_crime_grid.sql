

CREATE TABLE `stop_and_frisk` (
  `precinct` int(11) DEFAULT NULL,
  `time_stop` varchar(45) DEFAULT NULL
);


CREATE TABLE `stop_and_frisk_by_time` (
  `precinct` int(11) DEFAULT NULL,
  `time_hr` varchar(2) DEFAULT NULL,
  `time_min` varchar(2) DEFAULT NULL
);


CREATE TABLE `stops_by_hour` (
  `precinct` int(11) DEFAULT NULL,
  `time_hr` varchar(2) DEFAULT NULL,
  `stop_count` int(11) DEFAULT NULL
);




select a.*, char_length(a.time_stop), right(a.time_stop, 2) from test.stop_and_frisk a;
delete from test.stop_and_frisk;


select precinct, count(*) from test.stop_and_frisk group by precinct;
select count(*) from test.stop_and_frisk;
delete from test.stop_and_frisk_by_time;


insert into test.stop_and_frisk_by_time 
select precinct,
 case char_length(a.time_stop)
  when 1 then '0'
  when 2 then '0'
  when 3 then left(a.time_stop, 1)
  when 4 then left(a.time_stop, 2)
end as time_hr,
right(a.time_stop, 2) as time_min
from test.stop_and_frisk a;


select * from test.stop_and_frisk_by_time;
delete from test.stops_by_hour;


insert into test.stops_by_hour 
select precinct, time_hr, count(time_hr) from test.stop_and_frisk_by_time group by precinct, time_hr order by precinct, time_hr;

select count(*) from test.stops_by_hour;

select distinct(cast(time_hr as unsigned)) as time_hr_int from test.stops_by_hour order by time_hr_int;

select precinct, max(h0000), max(h0100), max(h0200), max(h0300), max(h0400), max(h0500), max(h0600), max(h0700), max(h0800),
max(h0900), max(h1000), max(h1100), max(h1200), max(h1300), max(h1400), max(h1500), max(h1600), max(h1700), max(h1800),
max(h1900), max(h2000), max(h2100), max(h2200), max(h2300)
from 
(
select precinct,
 case time_hr when 0 then stop_count end as h0000,
 case time_hr when 1 then stop_count end as h0100,
 case time_hr when 2 then stop_count end as h0200,
 case time_hr when 3 then stop_count end as h0300,
 case time_hr when 4 then stop_count end as h0400,
 case time_hr when 5 then stop_count end as h0500,
 case time_hr when 6 then stop_count end as h0600,
 case time_hr when 7 then stop_count end as h0700,
 case time_hr when 8 then stop_count end as h0800,
 case time_hr when 9 then stop_count end as h0900,
 case time_hr when 10 then stop_count end as h1000,
 case time_hr when 11 then stop_count end as h1100,
 case time_hr when 12 then stop_count end as h1200,
 case time_hr when 13 then stop_count end as h1300,
 case time_hr when 14 then stop_count end as h1400,
 case time_hr when 15 then stop_count end as h1500,
 case time_hr when 16 then stop_count end as h1600,
 case time_hr when 17 then stop_count end as h1700,
 case time_hr when 18 then stop_count end as h1800,
 case time_hr when 19 then stop_count end as h1900,
 case time_hr when 20 then stop_count end as h2000,
 case time_hr when 21 then stop_count end as h2100,
 case time_hr when 22 then stop_count end as h2200,
 case time_hr when 23 then stop_count end as h2300
from test.stops_by_hour
) as inner_table
group by precinct


