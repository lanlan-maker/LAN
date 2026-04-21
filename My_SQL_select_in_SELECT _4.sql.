Запросы коррелированые, без джойнов. 

select name_author 
, ifnull((select sum(amount) from book b
   where b.author_id=a.author_id),0) as "Кол_во"
, if( (select sum(amount) from book b where b.author_id=a.author_id) >10,
      "Популярен", if
     ((select sum(amount) from book b where b.author_id=a.author_id) >0,
      "средне", "пусто") 
      )    as "Статус"
, ifnull((round(
    ( (select sum(price*amount) from book b where b.author_id=a.author_id)/
                (select sum(price*amount) from book b) ) *100)
   ),0) as "% от дохода"
from author a
;
