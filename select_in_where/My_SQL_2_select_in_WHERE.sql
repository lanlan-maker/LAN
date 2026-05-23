# Спавнительный анали объема продаж и выручки соавторских книг за 2019 - 2020 года.
   # Найти книги которые в 2020 году принесли больше прибыли , чем в 2019

select distinct title, author
, ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2020')),0) as 'кол20'
,  ifnull(((select sum(price*amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2020' )),0) as 'дох20'
,  ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2019' )),0) as 'кол19'
,  ifnull(((select sum(price*amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2019' )),0) as 'дох19'    
from orrder o
where  ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
       and year(sell_date) = '2020')),0)
>     ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
       and year(sell_date) = '2019' )),0)
order by author;

select 
  sum(дох20) as 'приб_лид_20'
, sum(дох19) as 'приб_лид_19'
from 
(select distinct title, author
, ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2020')),0) as 'кол20'
,  ifnull(((select sum(price*amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2020' )),0) as 'дох20'
,  ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2019' )),0) as 'кол19'
,  ifnull(((select sum(price*amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
   and year(sell_date) = '2019' )),0) as 'дох19'    
from orrder o
where  ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
       and year(sell_date) = '2020')),0)
>     ifnull(((select sum(amount) from orrder o2 where o.title=o2.title and o.author<=>o2.author
       and year(sell_date) = '2019' )),0)
    ) as report
    ;
