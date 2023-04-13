use pregatire_practic;

create table R(
	fk1 int not null,
	fk2 int not null,
	c1 varchar(255),
	c2 varchar(255),
	c3 int not null,
	c4 int not null,
	c5 varchar(30)
);

alter table R add primary key(fk1, fk2);

insert into R(fk1, fk2, c1, c2, c3, c4, c5)
values 
	(1, 1, 'Pisica pe acoperisul fierbinte', 'Tennessee Williams', 100, 20, 'AB'),
	(1, 2, 'Conul Leonida fata cu reactiunea', 'Ion Luca Caragiale', 50, 50, 'CQ'),
	(1, 3, 'Concert din muzica de Bach', 'Hortensia Papadat-Bengescu', 50, 10, 'QC'),
	(2, 1, 'Fata babei si fata mosneagului', 'Ion Creanga', 100, 100, 'QM'),
	(2, 2, 'Frumosii nebuni ai marilor orase', 'Fanus Neagu', 10, 10, 'BA'),
	(2, 3, 'Frumoasa calatorie a ursilor panda povestita de un saxofonist care avea o iubita la Frankfurt', 'Matei Visniec', 100, 20, 'MQ'),
	(3, 1, 'Mansarda la Paris cu vedere spre moarte', 'Matei Visniec', 200, 10, 'PQ'),
	(3, 2, 'Richard al III-lea se interzice sau Scene din viata lui Meyerhold', 'Matei Visniec', 100, 50, 'PQ'),
	(3, 3, 'Masinaria Cehov. Nina sau despre fragilitatea pescarusilor impaiati', 'Matei Visniec', 100, 100, 'AZ'),
	(4, 1, 'Omul de zapada care voia sa intalneasca soarele', 'Matei Visniec', 100, 100, 'CP'),
	(4, 2, 'Extraterestrul care isi dorea ca amintire o pijama', 'Matei Visniec', 50, 10, 'CQ'),
	(4, 3, 'O femeie draguta cu o floare si ferestre spre nord', 'Edvard Radzinski', 10, 100, 'CP'),
	(4, 4, 'Trenul din zori nu mai opreste aici', 'Tennessee Williams', 200, 200, 'MA')
;

select c2, sum(c3) Totalc3, AVG(c3) Avgc3
from R
where c3 >= 100 or c1 like '%Pisica%'
group by c2
having sum(c3) > 100

select *
from
	(select fk1, fk2, c3+c4 TotalC3C4
	from R
	where fk1 = fk2) r1
	inner join
	(select fk1, fk2, c5
	from R
	where c5 like '%Q%')r2
	on r1.fk1 = r2.fk1 and r1.fk2 = r2.fk2

go
create or alter trigger TrOnUpdate
	on R
	for update
as
	declare @total int = 0
	select @total = sum(i.c3 - d.c3)
	from deleted d inner join inserted i on d.fk1 = i.fk1 and d.fk2 = i.fk2
	where d.c3 < i.c3
	print @total

update R
set c3 = 300
where fk1 < fk2



select *
from R