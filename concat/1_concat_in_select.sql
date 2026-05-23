# Наименования с многоуровневой нумерацией.

SELECT concat(module_id,'.',lesson_position,'.'
      ,if(step_position<10, concat(0,step_position),step_position)
      ,' ',step_name) as Шаг
from step st
join lesson les using(lesson_id)
join module modu using(module_id)
join step_keyword stke using(step_id)
join keyword ke using(keyword_id)
 where keyword_name in ('max' ,'avg') 
 group by step_id
 having count(keyword_name)=2
 order by 1
 ; 
