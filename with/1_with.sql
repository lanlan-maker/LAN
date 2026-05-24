
WITH get_count_correct (st_n_c, count_correct) 
  AS (
      SELECT step_id, count(*)
      FROM 
          step 
          INNER JOIN step_student USING (step_id)
      WHERE result = "correct"
      GROUP BY step_id
   ),
  get_count_wrong (st_n_w, count_wrong) 
  AS (
    SELECT step_id, count(*)
    FROM 
        step 
        INNER JOIN step_student USING (step_id)
    WHERE result = "wrong"
    GROUP BY step_id
   )  
SELECT left(step_name,10) AS Шаг, 
    ROUND(ifnull(count_correct,0)/( ifnull(count_correct,0) + ifnull(count_wrong,0)) * 100) AS Успешность
FROM  
    get_count_correct 
    left JOIN get_count_wrong ON st_n_c = st_n_w
    join step st on st_n_c=st.step_id 
    union 
 SELECT left(step_name,10) AS Шаг, 
    ROUND(ifnull(count_correct,0)/(
ifnull(count_correct,0) + ifnull(count_wrong,0))
* 100) AS Успешность
FROM  
    get_count_correct 
    right JOIN get_count_wrong ON st_n_c = st_n_w
    join step st on  st_n_w= st.step_id
 
    ;



