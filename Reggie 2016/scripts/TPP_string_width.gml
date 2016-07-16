///TPP_string_width(String, Font, Padding)
/*

Returns the length of the input string when formatted.
Needs a cleared stack.

*/
var i,t,w,c,c2,xx,yy,work_str,vn,stack,oldhover,pad;

//*** SET UP VARIABLES:

work_str=argument0;

oldhover=global.TPP_LINK_HOVER;
global.TPP_LINK_HOVER="";

draw_set_font(argument1);
global.TPP_FONT=argument1;

ds_stack_clear(global.TPP_STACK_CM);
ds_stack_clear(global.TPP_STACK_ID);

pad=argument2;

//*** ENTER LOOP / COUNT:

w=0;
for (i=1; i<=string_length(work_str); i+=1) {

  c=string_copy(work_str,i,1);
  
  //FORMATTING:
  if (c=="[") {
  
    switch  (string_copy(work_str,i+1,4)) {
      
      case "col:": // OK
          continue;  
        break;
      
      case "fnt:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>":")
              vn+=c2;
              else
                break;          
            }
          tpp_push(TPP.c_font,global.TPP_FONT);
          draw_set_font(global.TPP_VARMAP[?vn]);
          global.TPP_FONT=global.TPP_VARMAP[?vn];
          i=t;
          continue;
        break;
        
      case "alp:": // OK
          continue;
        break;
        
      case "aln:": // OK
          continue;
        break;
      
      case "spr:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>"]")
              vn+=c2;
              else
                break;          
            }
          var ind=global.TPP_VARMAP[?vn];
          w+=sprite_get_width(ind);
          i=t;
          continue;
        break;
        
      case "spe:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>"]")
              vn+=c2;
              else
                break;          
            }
          var ind=global.TPP_VARMAP[?vn];
          w+=sprite_get_width(ind);
          i=t;
          continue;
        break;
      
      case "clk:": // OK
          continue;
        break;
        
      case "exe:":
          continue;
        break;
      
      default:
        break;
    
      }
  
    }
    else if (c=="]" && string_copy(work_str,i-1,1)<>"\") {
    
      tpp_pop_execute();
      continue;
    
      }
      else if (c=="\" && string_copy(work_str,i+1,1)=="]") {
        
        continue;
        
        }
    
  //ADDING CHAR WIDTH:
  w+=string_width(c);

  }
  
return w;
