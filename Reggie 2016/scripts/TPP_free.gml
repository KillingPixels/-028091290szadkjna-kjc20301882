///TPP_free()
/*

*/

ds_map_destroy(global.TPP_VARMAP);
ds_stack_destroy(global.TPP_STACK_CM);
ds_stack_destroy(global.TPP_STACK_ID);

global.TPP_LINK_CURRENT="";
global.TPP_LINK_HOVER="";
global.TPP_LINK_HOVER_PREV="";
