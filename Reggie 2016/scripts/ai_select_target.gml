///ai_select_target(Group, Range, PlayerBias)
/*
Selects one visible target for an AI.
*/
var __grid, rv;

__grid=ds_grid_create(2,0);

//Gather possible targets:
with (bodyParObj) {
 
 var __d, __c, c_h;
 
 if _group<>argument0 {
 
  __d=point_distance(x,y,other.x,other.y)<=argument1;

  if (__d) {
 
   __c=!HG_collision_line(-1,x,y,other.x,other.y-other._eyesY,GLOBAL.precision);
  
   if (__c) {
  
    c_h=ds_grid_height(__grid);
    ds_grid_resize(__grid,2,c_h+1);
    ds_grid_add(__grid,0,c_h,id);
    ds_grid_add(__grid,1,c_h,__d);
   
    }
   
   }
   
  }

 }
 
if ds_grid_height(__grid)=0
 return -1;
 
//Player bias:
if irandom(100)<argument2 {
 if ds_grid_value_exists(__grid,0,0,0,ds_grid_height(__grid)-1,global.player_obj_id)
  return (global.player_obj_id).id;
 }
 
//Sort:
ds_grid_sort(__grid,1,true);
 
rv=__grid[#0,0];

ds_grid_destroy(__grid);

return rv;
