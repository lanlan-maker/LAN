-- Определить рейтинг студентов по каждому модулю, 
-- относительно максимально успешного

select module_id as Модуль, student_name as Студент
, count(distinct step_id) as Пройдено_шагов
, round((
    (count(distinct step_id) *100.0) /
   max(count(distinct step_id)) over (partition by module_id)
    ),1) as Относительный_рейтинг
from step_student
join step using(step_id)
join lesson using(lesson_id)
join student using(student_id)
where result = 'correct'
group by module_id, student_name
order by 1, 4 desc, 2
;
