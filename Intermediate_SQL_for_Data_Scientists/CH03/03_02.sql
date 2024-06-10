03_02


select
   ‘abcdefghijk’  test_string



-- İlk 3 karakteri istiyoruz

select
   substring(‘abcdefghijk’, 1,3) test_string




select
   substring(‘abcdefghijk’ from 1 for 3) test_string



-- 5. dizeden baslayıp sonuna kadar alacak
select
   substring(‘abcdefghijk’ from 5) test_string


select
  *
from
  employees




select
  *
from
  employees
where
   job_title like ‘%assistant%’






select
   job_title, (job_title like %assistant%) is_assistant
from
  employees
where
   job_title like ‘%assistant%’
select
   job_title, (job_title like %assistant%) is_assistant
from
  employees