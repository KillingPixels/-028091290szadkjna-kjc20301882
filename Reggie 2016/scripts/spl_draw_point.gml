///spl_draw_point(x,y)
/*

*/
var surf;

if ((global.SPLAT_TIMER mod 2)==0)
  surf=global.SPLAT_SURF_1;
  else 
    surf=global.SPLAT_SURF_2;
    
draw_set_colour(c_black);
draw_set_alpha(0.9);

surface_set_target(surf);

  draw_circle(argument0,argument1,3,false);
  
surface_reset_target();
