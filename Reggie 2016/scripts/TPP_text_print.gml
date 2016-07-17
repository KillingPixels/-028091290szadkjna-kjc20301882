///TPP_text_print(X, Y, String, Colour, Alpha, Font, spr_vAlign, centerLine)
/*

*/
var xx,yy,work_str,col,alp,fnt,spr_valign;

//Set up variables:

xx=argument0;
yy=argument1;
work_str=argument2;
col=argument3;
alp=argument4;
fnt=argument5;
spr_valign=argument6;
cl=argument7;
  
//Set draw parameters:
draw_set_colour(col); 
draw_set_alpha(alp);
draw_set_font(fnt);
global.TPP_FONT=fnt;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
  
//Draw: 
var retval;

ds_stack_clear(global.TPP_STACK_CM);
ds_stack_clear(global.TPP_STACK_ID);

retval=tpp_print_line(xx,yy,work_str,0,spr_valign,cl);

return retval;  






