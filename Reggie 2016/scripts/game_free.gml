///game_free()
/*
Releases all memory in use by the game.
*/

instance_activate_all();

//SYSTEMS:
crafting_free();
journal_free();
repair_free();
sett_free();
terr_free();
buf_free();
inv_free();
txt_free();
ptc_free();

NSP_free(true);

//PENDING:
  //heart_free();  -- probs not needed
  //barter_free(); -- probs not needed
  global.barter_string="";
  
//BODIES:
with (bodyParObj) {
 buf_instance_recover();
 buf_instance_free();
 }
  
//OTHER:

 //Pathfinding:
 pfd_free();
 
 with (obj_tracker) {
  instance_destroy();
  }  
  
//CHECK REMAINING DATA STRUCTURES:
var i=true,s,l;

if (i=true)
 for (i=0; i<=1000; i+=1) {
 
 if (ds_exists(i,ds_type_priority)) {show_message("Mem dealloc fail. ("+string(i)+") : Priority"); }
 if (ds_exists(i,ds_type_stack))    {show_message("Mem dealloc fail. ("+string(i)+") : Stack"); }
 if (ds_exists(i,ds_type_queue))    {show_message("Mem dealloc fail. ("+string(i)+") : Queue"); }
 if (ds_exists(i,ds_type_grid))     {show_message("Mem dealloc fail. ("+string(i)+") : Grid"); }
 if (ds_exists(i,ds_type_list))     {show_message("Mem dealloc fail. ("+string(i)+") : List"); }
 if (ds_exists(i,ds_type_map))      {show_message("Mem dealloc fail. ("+string(i)+") : Map"); 
    /*s=ds_map_find_first(i);
    l=ds_map_find_last(i);
    while (true) {
     show_message(s);
     if (s=l) break;
     s=ds_map_find_next(i,s);
     }*/
 
  }
 
 }
 
 
 
 
 
