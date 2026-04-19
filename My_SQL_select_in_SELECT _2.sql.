select name_genre
, sum(amount) as "всего книг"
, ( select min(price) 
    from book b2
    where b2.genre_id=g.genre_id ) as "Мин цена"
, (select name_author
    from author a
    join book b2 using(author_id)
    where b2.genre_id=g.genre_id
   group by author_id
   order by count(b2.title) desc limit 1  ) as "лидер разнообр."
, (select count(title)
   from book b2
   where b2.genre_id=g.genre_id) as "кол-во наимен"
, round(avg(amount)) as "сред кол-во наимен"

from genre g
left join book b using(genre_id)
left join author a using(author_id) 
group by genre_id, name_genre
;
