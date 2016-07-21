///TPP_text_print_ext(X, Y, Grid ID, hAlign, vAlign)
/*

A more complex text printing function. Requires a Grid ID
returned by TPP_text_parse().

Returns: (String) Identifier of the activated link or an
         empty string if no link was activated.

*/
var i,g,l,xx,yy,xorig,temp,retval;

//Set parameters:
xorig=argument0;
yy=argument1;
g=argument2;
l=g[#0,0];

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
for (i=1; i<ds_grid_height(g); i+=1) {

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
  //draw_text(xx+400,yy,"F: "+g[#0,i]);
  
  yy+=g[#2,i];
  
  if (retval=="")
    retval=temp;

  }

return retval;
