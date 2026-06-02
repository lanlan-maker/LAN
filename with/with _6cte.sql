-- Вычисление относительного времени попытки, 
-- с заменой времени попытки более часа на среднее значение
-- от суммы всех непревышающих часа.

with get_id as  
(  select student_id
  from student 
  where student_name = 'student_59' 
),
get_numb_diff as
(  select  student_id
  , step_id
  , concat(module_id,'.',lesson_position,'.',step_position) as Шаг
  , result
  , submission_time
  , submission_time - attempt_time            as dlit
  from get_id   
  join step_student using(student_id)
  join step using(step_id)
  join lesson using(lesson_id)
), 
get_avg as      
(   select  student_id
  , ceil( avg(dlit) )                         as srednee
  from get_numb_diff
  where dlit <=3600  
  group by student_id 
),
get_if_dlit as  
(   select student_id
  , step_id,  Шаг, result  , submission_time
  , if( dlit>=3600, srednee, dlit)            as длит
    from get_numb_diff    
    left join get_avg using(student_id)    
),
get_summ  as   
(   select step_id
  , sum(длит)                                 as summ
  from get_if_dlit   
  group by step_id  
), 
get_otnosit as  
(   select student_id
  , step_id, Шаг, result  , submission_time
  , длит
  , round(( (длит*100.0)/summ ),2)            as otnosit
  from get_if_dlit   
  join get_summ using(step_id)  
)
select student_name as Студент
, Шаг
, row_number() over (partition by step_id order by submission_time) as Номер_попытки
, result as Результат
, sec_to_time(Длит) as Время_попытки
, otnosit as Относительное_время
from get_otnosit 
join student using(student_id)
;
