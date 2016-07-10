///nsp_list_string(Start, End);
/*
Underlying NSP script.
*/
var nspListStr=global.nspListStr;
var i,s;

s="";
for (i=argument0; i<=argument1; i+=1) begin

 s+=nspListStr[|i]+" ~ ";

end;

return s;
