# Вычислить разницу в "день,ч:м:с" между временем выполнения заданий

select student_name as Студент
, concat(left(step_name,20),'...') as Шаг, result as Результат
, from_unixtime(submission_time) as Дата_отправки
,  sec_to_time(
    
  submission_time - lag(submission_time,1,submission_time)
    over (order by submission_time)  )    
     as Разница
from step_student
join student using(student_id)
join step using(step_id)
where student_name = 'student_61'
order by submission_time
;
