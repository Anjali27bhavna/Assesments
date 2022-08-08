create database airlines

use airlines

create table Route(routno numeric primary key, rdescription nvarchar(40))
insert into Route values(3,'Delhi-Mumbai')
insert into Route values(4,'Hyderabad-Patna')
insert into Route values(6,'Delhi-Chandigarh')
insert into Route values(7,'Goa-Delhi')
insert into Route values(9,'Jaipur-Chennai')
insert into Route values(11,'Haridwar-Pune')
insert into Route values(13,'Chennai-Delhi')

select * from Route

create table Fares(faretype nvarchar(20) primary key, fdescription nvarchar(40))
insert into Fares values('BUR','Business Return')
insert into Fares values('SDS','Standard Single')
insert into Fares values('SDR','Standard Return')
insert into Fares values('KFS','Key Fare Single')
insert into Fares values('SBS','Stanby Single')
insert into Fares values('APR','Advanced Purchase Return')
insert into Fares values('SXR','Supepex Return')

select * from Fares

create table tariff(routno numeric , constraint fk_t_rn foreign key (routno) references Route(routno),faretype nvarchar(20) ,constraint fk_t_ft foreign key (faretype) references Fares(faretype),price numeric)
insert into tariff values(3,'BUR',117)
insert into tariff values(3,'SDR',158)
insert into tariff values(3,'SDS',79)
insert into tariff values(4,'SDR',162)
insert into tariff values(4,'SBS',49)
insert into tariff values(6,'BUR',117)
insert into tariff values(6,'SBS',42)
insert into tariff values(7,'SDR',128)
insert into tariff values(8,'SDS',74)
insert into tariff values(9,'APR',95)
insert into tariff values(11,'SDR',110)
insert into tariff values(13,'SBS',33)

select * from tariff

create table Flight(flightno nvarchar(20) primary key, deptime numeric,arrtime numeric, routno numeric,constraint fk_f_rn foreign key (routno) references Route(routno))
insert into Flight values('DG80',0725,0840,3)
insert into Flight values('DG82',0930,1045,3)
insert into Flight values('DG91',1730,1840,3)
insert into Flight values('DG95',2120,2230,3)
insert into Flight values('DG54',1040,1155,4)
insert into Flight values('DG51',0710,0825,4)
insert into Flight values('DG412',0850,0945,6)
insert into Flight values('DG413',1145,1235,6)
insert into Flight values('DG419',1020,1115,7)
insert into Flight values('DG580',0810,1940,7)
insert into Flight values('DG332',1925,2015,7)
insert into Flight values('DG690',0730,0935,8)
insert into Flight values('DG340',1500,1705,9)
insert into Flight values('DG657',1730,1935,9)
insert into Flight values('DG772',1230,1455,11)
insert into Flight values('DG777',1310,1355,11)
insert into Flight values('DG577',1810,2220,13)

create table passenger(pid numeric primary key, pname nvarchar(20))
insert into passenger values(26,'Anjali Saini')
insert into passenger values(28,'Swati Pandey')
insert into passenger values(29,'Nilesh Tiwari')
insert into passenger values(30,'Dipesh Singh')
insert into passenger values(34,'Naina')
insert into passenger values(90,'Devesh Singh')
insert into passenger values(91,'Shivam')
insert into passenger values(24,'Mehul')

create table passroute(pid numeric,constraint fk_p_pid foreign key(pid) references passenger(pid),routno numeric,constraint fk_p_rtn foreign key(routno) references Route(routno)) 
insert into passroute values(26,3)
insert into passroute values(28,4)
insert into passroute values(29,6)
insert into passroute values(30,7)
insert into passroute values(34,8)
insert into passroute values(90,9)
insert into passroute values(91,11)
insert into passroute values(24,13)


--fare of the flight for a specific route and paseenger

create procedure sp_fare_bur
as
begin 
select r.routno,r.rdescription,p.pname,t.price from Route as r
inner join tariff as t
on r.routno=t.routno 
inner join passroute as pr
on t.routno=pr.routno
inner join passenger as p
on pr.pid=p.pid
where t.faretype='BUR'
end

exec sp_fare_bur

--flights available for specific routes
create procedure sp_fl_info
as
begin
select f.flightno,t.faretype,f.routno,t.price from Flight as f
inner join tariff as t
on f.routno=t.routno
where t.routno=4
end

exec sp_fl_info








