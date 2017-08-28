# 2a
select count(address_id)
from address;
# 2b
select count(town_city_id)
from town_city;
# 2c
select * from address
where address_number=20 
and route_id=(select route_id from route where full_road_name='Kirkwood Avenue');
# 2d
select* from locality;
# 2e
select * from route
where locality_id in (select locality_id from locality where town_city_id is not Null);
# 3.1
create table SCIRT_jobs
(
job_id int,
description varchar(400),
routes varchar(4000),
locality varchar(400),
delivery_team varchar(255),
start_date varchar(255),
end_date varchar(255),
primary key (job_id)
);
# 3.2
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\SCIRT_jobs.csv'
ignore into table scirt_jobs
fields terminated by ','  optionally enclosed by ''''
lines terminated by '\r\n'
ignore 1 lines
(job_id, description, routes, locality, delivery_team, @start_date, @end_date)
set start_date =str_to_date(@start_date, '%b-%y'),
end_date =str_to_date(@start_date, '%b-%y');
# 4
#create new talbe scirt_job_route
DROP TABLE IF EXISTS `scirt_job_route`;
CREATE TABLE `scirt_job_route` (
  `job_id` int NOT NULL,
  `routes` varchar(4000) DEFAULT NULL,
  KEY `id_foreign` (`job_id`),
  CONSTRAINT `id_foreign` FOREIGN KEY (`job_id`) REFERENCES `scirt_jobs` (`job_id`)
);

delimiter $$

# Create a function to split delimited strings.
DROP FUNCTION IF EXISTS `str_split_by_coma`;
create function str_split_by_coma(x varchar(21845), delim varchar(100), pos integer) 
returns varchar(21845)
begin
  declare output varchar(21845);
  set output = replace(substring(substring_index(x, delim, pos)
                 , length(substring_index(x, delim, pos - 1)) + 1)
                 , delim
                 , '');
  if output = '' then set output = null; end if;
  return trim(output);
end $$

# Create a procedure to extract values from delimited strings and insert them into a new table.
DROP PROCEDURE IF EXISTS `scirt_jobs_to_scirt_job_route`;
create procedure scirt_jobs_to_scirt_job_route()
begin
  declare i integer;

  set i = 1;
  repeat
    insert into scirt_job_route (job_id, routes)
      select job_id, str_split_by_coma(routes, ',', i)from scirt_jobs
      where str_split_by_coma(routes, ',', i) is not null;
    set i = i + 1;
    until row_count() = 0
  end repeat;
end $$

delimiter ;

# Call scirt_jobs_to_scirt_job_route procedure.
call scirt_jobs_to_scirt_job_route();

select *
	from scirt_job_route;
# 5a
select delivery_team, count(*) as count
from scirt_jobs
group by delivery_team
order by count desc;
# 5b
select locality
from scirt_jobs
left join locality on scirt_jobs.locality=locality.suburb_locality
where locality.suburb_locality is null;
# 5c
select routes
from scirt_job_route
left join route on scirt_job_route.routes=route.full_road_name
where route.full_road_name is null;
# 5d
select scirt_jobs.locality, count(scirt_jobs.job_id) as count
from scirt_jobs
group by scirt_jobs.locality
order by count desc;
# 5e
select address_id from address where route_id in(
select route_id from route where full_road_name in(
select routes from scirt_jobs
where delivery_team = 'City Care' 
and routes in (select routes from scirt_job_route where routes='Dublin Street')
)
);

