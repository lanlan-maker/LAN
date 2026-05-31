-- Проанализировать, в каком порядке и с каким интервалом 
-- пользователь отправлял последнее верно выполненное задание каждого урока.
-- Учитывать только студентов, прошедших хотя бы один шаг из всех трех уроков

with get_max as
(  select student_id
, lesson_id
, max(submission_time) as max_sub
from step_student
join step using(step_id)
where result ='correct'
group by student_id, lesson_id    )
    ,
get_before_max_count_les as
(  select student_id
, lesson_id
, max_sub
, lag(max_sub) 
 over (partition by student_id order by max_sub)
 as before_max
 , count(lesson_id) 
over (partition by student_id) as count_les
 from get_max   )
,
get_three_les as
(  select student_id 
, lesson_id
, max_sub
, before_max
from get_before_max_count_les
where count_les = 3  )

select student_name
, concat(module_id,'.',lesson_position) as Урок
, from_unixtime(max_sub) as Пос_отпр
,  ifnull(ceil(
 (max_sub - before_max)/86400),'-') as Интервал
 
from get_three_les
 join student using(student_id)
 join lesson using(lesson_id)

order by 1, 3

 ; 
