///TPP_text_print_ext_part(X, Y, Grid ID, hAlign, vAlign, Start, End)
/*



*/
var i,g,l,xx,yy,xorig,temp,retval,line_s,line_e;

//Set parameters:
xorig=argument0;
yy=argument1;
g=argument2;
l=g[#0,0];
line_s=argument5;
line_e=argument6;

ds_stack_clear(global.TPP_STACK_CM);
ds_stack_clear(global.TPP_STACK_ID);

draw_set_colour(l[|TPP_LIST.colour]);
 draw_set_alpha(l[|TPP_LIST.alpha]);
  draw_set_font(l[|TPP_LIST.font]);
global.TPP_FONT=l[|TPP_LIST.font];

var  spr_vAlign=l[|TPP_LIST.spr_valign];
var centerlines=l[|TPP_LIST.centerlines];

//Adjust Y:
switch (argument4) {

  case fa_bottom:
    yy-=l[|TPP_LIST.maxheight];
    break;
  
  case fa_center:
    yy-=l[|TPP_LIST.maxheight]/2;
    break;
    
  default:
    break;  

  }

//Print:
retval="";
for (i=max(1,line_s); i<=min(line_e,ds_grid_height(g)-1); i+=1) {

  //Set X:
  switch (argument3) {

    case fa_right:
      xx=xorig-g[#1,i];
      break;
    
    case fa_center:
      xx=xorig-g[#1,i]/2;
      break;
      
    default:
      xx=xorig;
      break;

    }

  temp=tpp_print_line(xx,yy,g[#0,i],g[#3,i],spr_vAlign,centerlines);
  
  yy+=g[#2,i];
  
  if (retval=="")
    retval=temp;

  }

return retval;
