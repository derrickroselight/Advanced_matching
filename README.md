# Advanced_matching
Matching case/control groups is an essential step in clinical/public health research.  
By this easy-understanding and straightfoward SAS program, one can fulfill the truly one-on-one(Sampling Without Replacement) 1:4 matching.   
The following is the pseudocode: 
1. Duplicate the case_id(s) to control_id(s) they matched.   
2. Give each control_id an random number.  
3. Sort the whole dataset by 1)case_id and 2)random number.   
---Loop---
4. Take away the first case_id and first 4 control_id(s) from the whole dataset and name it match_1.  
5. Remove all the 5 ids(1 case & 4 controls) from the whole dataset.
6. Take away the first case_id and first 4 control_id(s) from the "REMAINING" dataset and name it match_2.
7. Do step 5. again(*remove from the "REMAINING" dataset).  
---Loop---
8. Merge match_1 to match_n.
9. End.
