-- среднее время выполнения урока --

select row_number() over () as Номер
, Урок, Среднее_время
from
    (select
Урок, round(avg(Время_урок)/3600,2) as Среднее_время
from
    (select Урок, student_id, sum(Время_шаг) as Время_урок
from
  (  select concat(module_Id,'.',lesson_position,' ',lesson_name)
     as Урок, student_id
    , sum(submission_time-attempt_time) as Время_шаг
from step_student sst
join step st using(step_id)
join lesson les using(lesson_id)
join module modu using(module_id) 
where (submission_time-attempt_time) <=14400   
  group by lesson_id, step_id, student_id  ) as tmp
    group by урок, student_id                     ) as tmp2
group by Урок
order by Среднее_время ) as tmp3
;
