-- Вычислить разницу в "день,ч:м:с" между временем выполнения заданий
   -- , где разница между  выполнением не более суток. 
 -- Легко вычислить любого студента, поменяв только Имя

select Студент, Шаг, Дата_отправки, Разница

from  (select student_name as Студент, concat(left(step_name,20),'...') as Шаг
, result as Результат, from_UNIXTIME(submission_time) as Дата_отправки
, (submission_time - lag(submission_time, 1 , submission_time) 
    over (partition by student_id order by submission_time)) as Секунды_разницы

, sec_to_time(submission_time - lag(submission_time, 1 , submission_time) 
    over (partition by student_id order by submission_time)) as Разница         
from step_student st
join student using(student_id)
join step using(step_id) 
       ) as tmp

where Секунды_разницы <=86400
and Студент = 'student_43'
;

;
