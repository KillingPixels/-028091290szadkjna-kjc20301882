///string_crop_ext(String, Condition)
/*

*/
var cond_str,work_str;

work_str=argument0;
cond_str=argument1;

//Crop from the beginning:
while (string_copy(work_str,1,string_length(cond_str))=cond_str) {

 work_str=string_delete(work_str,1,string_length(cond_str));

 }
  
//Crop from the end:
while (string_copy(work_str,string_length(work_str)-string_length(cond_str),string_length(cond_str))=cond_str) {

 work_str=string_delete(work_str,string_length(work_str)-string_length(cond_str),string_length(cond_str));

 }
 
return work_str;
