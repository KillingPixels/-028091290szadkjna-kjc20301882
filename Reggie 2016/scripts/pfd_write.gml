///pfd_write()
/*

*/
var w,h,g,s;
var size=8;

w=ceil(room_width/size);
h=ceil(room_height/size);

g=ds_grid_create(w,h);

mp_grid_to_ds_grid(global.pfd_grid,g);

s=ds_grid_write(g);

ds_grid_destroy(g);

return s;
