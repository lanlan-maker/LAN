-- Проанализировать, в каком порядке и с каким интервалом 
-- пользователь отправлял последнее верно выполненное задание каждого урока.
-- Учитывать только студентов, прошедших хотя бы один шаг из всех трех уроков

with count_step as
(    select student_id
        , lesson_id,    step_id,    submission_time                    -- для связки --
    , concat(module_id,'.',lesson_position)           as Урок
    , max(submission_time)
         over(partition by lesson_id, student_id)     as max_sub
    from step_student
    join step using(step_id)
    join lesson using(lesson_id)      where result = 'correct'
),
    find_step as
(    select student_id  
         , lesson_id,    step_id,    max_sub                           -- для связки --
     , count(lesson_id) over (partition by student_id) as lesn_count  -- кол_во уроков --
     , Урок
     , from_unixtime(submission_time)                   as Макс_время_отправки 
     , lag(max_sub)
         over (partition by student_id order by max_sub) as before_max
     from count_step
     where submission_time = max_sub
 )

select student_name as Студент 
, Урок
, Макс_время_отправки
, ifnull(( ceil((max_sub-before_max)/86400) ),'-') as Интервал
from find_step 
join student using(student_id)
join lesson using(lesson_id) 
where  lesn_count >=3
order by 1, 3           
;
