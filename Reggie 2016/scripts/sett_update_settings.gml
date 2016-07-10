///sett_update_settings()
/*

*/

//Gameplay:
 
//Graphics:
gui_set_scale( real(string_digits(sett_get_value("GUI Scale")))/100 );
 gui_refresh();
 
texture_set_interpolation(sett_get_value("Interpolation")="On");
display_reset(real(string_digits(sett_get_value("Anti-Alias"))),
              sett_get_value("V-Sync")=="On");
              
HG_world_lighting_set_blur(-1, ite(sett_get_value("Smooth lighting"),"On",8,0), 1);
 
//Sound:
 
//Misc. (Other):

