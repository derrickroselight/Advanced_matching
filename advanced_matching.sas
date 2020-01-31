/*Step 1.*/
PROC SQL; 
CREATE table match as select
a.id as case_id,
b.id as control_id,
a.agegroup as case_age,
b.agegroup as control_age,
a.id_sex as case_sex,
b.id_sex as control_sex,
a.location as case_location,
b.location as control_location,
a.year as case_year,
b.year as control_year
from light.case as a, light.control as b
where (a.agegroup = b.agegroup and a.id_sex = b.id_sex and a.location = b.location and a.year = b.year);
quit;

/*Step 2.*/
data match;
set match;
rand = ranuni(0);
run;

/*Step 3.*/
proc sort data = match;
by case_id rand;
run;


/* TEST *//* TEST *//* TEST *//* TEST *//* TEST *//* TEST */
data match1;
set match;
if _N_ <=4;
run;

proc sql;
create table match as
select * from match
where (case_id not in (select case_id from match1)) and (control_id not in (select control_id from match1));
quit;

proc sort data = match;
by case_id rand;
run;

data match2;
set match;
if _N_ <=4;
run;
/* TEST *//* TEST *//* TEST *//* TEST *//* TEST *//* TEST */

/*Step 4. 5. 6. 7.*/
%macro advanced_match();
 %do i = 1 %to 520;

  data match&i;
  set match;
  if _N_ <=4;
  run;

  proc sql;
  create table match as
  select * from match
  where (case_id not in (select case_id from match&i)) and (control_id not in (select control_id from match&i));
  quit;
 %end;
%mend advanced_match;

%advanced_match;

/*Step 8.*/
data final_match;
set match1 - match520;
run;

proc sql;
select count(distinct control_id)
from final_match;
quit;
