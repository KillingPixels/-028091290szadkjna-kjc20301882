///tpp_print_line(X, Y, String, Padding, spr_vAlign, centerLines)
/*

Underlying TPP script.

Requires the font set up beforehand!

To do:
  Link cover colour/alpha generalization

*/
var i,t,w,c,c2,xx,yy,yorig,work_str,vn,stack,retval;
var oldhover,pad,valign,cl,hoveralp,mx,my;

//*** SET UP VARIABLES:

xx=argument0;
yy=argument1//+string_height("A")/2; // *
yorig=argument1;
work_str=argument2;

oldhover=global.TPP_LINK_HOVER_PREV;
retval="";

pad=argument3;
valign=argument4;
cl=argument5;

hoveralp=global.TPP_HOVER_ALPHA;
mx=global.TPP_CURSOR_X;
my=global.TPP_CURSOR_Y;

draw_set_valign(fa_top); // *
draw_set_halign(fa_left);

//*** ENTER LOOP:

w=0;
for (i=1; i<=string_length(work_str); i+=1) {

  c=string_copy(work_str,i,1);
  
  //FORMATTING:
  if (c=="[") {
  
    switch  (string_copy(work_str,i+1,4)) {
      
      case "col:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>":")
              vn+=c2;
              else
                break;          
            }          
          tpp_push(TPP.c_colour,draw_get_colour());
          draw_set_colour(global.TPP_VARMAP[?vn]);
          i=t;
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
                    
          var h1=string_height("A");
          draw_set_font(global.TPP_VARMAP[?vn]);
          var h2=string_height("A");
          yy=yy-(h2-h1)/(cl+1);
          
          global.TPP_FONT=global.TPP_VARMAP[?vn];
          i=t;
          continue;
        break;
        
      case "alp:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>":")
              vn+=c2;
              else
                break;          
            }
          tpp_push(TPP.c_alpha,draw_get_alpha());
          draw_set_alpha(global.TPP_VARMAP[?vn]);
          i=t;
          continue;
        break;
        
      case "aln:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>":")
              vn+=c2;
              else
                break;          
            }
          tpp_push(TPP.c_alpha,draw_get_alpha());
          draw_set_alpha(real(vn));
          i=t;
          continue;
        break;
      
      case "spr:":
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>"]")
              vn+=c2;
              else
                break;          
            }
          var ind=global.TPP_VARMAP[?vn],syy;
          
          switch (valign) {
          
            case fa_top:
              syy=yy;
              break;
              
            case fa_bottom:
              syy=yy+string_height("A")-sprite_get_height(ind);
              break;
              
            case fa_center:
              syy=yy+(string_height("A")-sprite_get_height(ind))/2;
              break;
              
            default:
              break;
          
            }
          
          draw_sprite(ind,-1,xx+w,syy);
          
          //Linked image:
          if (global.TPP_LINK_CURRENT<>"") {          
          
            // GEN
            var flag=point_in_rectangle(mx,my,xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind));
            
            if (flag==true) {
            
              global.TPP_LINK_HOVER=global.TPP_LINK_CURRENT;
            
              var oc=draw_get_color(),
                  oa=draw_get_alpha();

              draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
              draw_set_alpha(hoveralp);
              
              draw_rectangle(xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind),false);
              
              draw_set_color(oc);
              draw_set_alpha(oa);
        
              if (global.TPP_CURSOR_FLAG)
                retval=global.TPP_LINK_CURRENT;
                
              }
              else if (global.TPP_LINK_CURRENT==oldhover or global.TPP_LINK_CURRENT==global.TPP_LINK_HOVER) {
              
                var oc=draw_get_color(),
                    oa=draw_get_alpha();

                draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
                draw_set_alpha(hoveralp);
              
                draw_rectangle(xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind),false);
              
                draw_set_color(oc);
                draw_set_alpha(oa);              
              
                }
          
            }
                      
          w+=sprite_get_width(ind)+pad;
          i=t;
          continue;
        break;
        
      case "spe:": // OK except Y
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>"]")
              vn+=c2;
              else
                break;          
            }
          var ind=global.TPP_VARMAP[?vn],syy;
          
          switch (valign) {
          
            case fa_top:
              syy=yy;
              break;
              
            case fa_bottom:
              syy=yy+string_height("A")-sprite_get_height(ind);
              break;
              
            case fa_center:
              syy=yy+string_height("A")-sprite_get_height(ind)/2;
              break;
              
            default:
              break;
          
            }
          
          draw_sprite_ext(ind,-1,xx+w,syy,1,1,0,draw_get_colour(),draw_get_alpha());
          
          //Linked image:
          if (global.TPP_LINK_CURRENT<>"") {          
          
            // GEN
            var flag=point_in_rectangle(mx,my,xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind));
            
            if (flag==true) {
            
              global.TPP_LINK_HOVER=global.TPP_LINK_CURRENT;
            
              var oc=draw_get_color(),
                  oa=draw_get_alpha();

              draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
              draw_set_alpha(hoveralp);
              
              draw_rectangle(xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind),false);
              
              draw_set_color(oc);
              draw_set_alpha(oa);
        
              if (global.TPP_CURSOR_FLAG)
                retval=global.TPP_LINK_CURRENT;
                
              }
              else if (global.TPP_LINK_CURRENT==oldhover or global.TPP_LINK_CURRENT==global.TPP_LINK_HOVER) {
              
                var oc=draw_get_color(),
                    oa=draw_get_alpha();

                draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
                draw_set_alpha(hoveralp);
              
                draw_rectangle(xx+w,syy,xx+w+sprite_get_width(ind),syy+sprite_get_height(ind),false);
              
                draw_set_color(oc);
                draw_set_alpha(oa);              
              
                }
                
            }

          w+=sprite_get_width(ind)+pad;
          i=t;
          continue;
        break;
      
      case "lnk:": // OK
      case "clk:": // OK
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>":")
              vn+=c2;
              else
                break;          
            }
          tpp_push(TPP.c_link,global.TPP_LINK_CURRENT);
          global.TPP_LINK_CURRENT=vn;
          i=t;
          continue;
        break;
        
      case "exe:":
          vn="";
          for (t=i+5; true; t+=1) {          
            c2=string_copy(work_str,t,1);
            if (c2<>"]")
              vn+=c2;
              else
                break;          
            }
          TPP_execute_code(xx,yy,vn,i);
          continue;
        break;
      
      default:
        break;
    
      }
  
    }
    else if (c=="]" && string_copy(work_str,i-1,1)<>"\") {
    
    
      var h1=string_height("A");
      tpp_pop_execute();
      var h2=string_height("A");
      yy=yy-(h2-h1)/(cl+1);
      continue;
    
      }
      else if (c=="\" && string_copy(work_str,i+1,1)=="]") {
        
        continue;
        
        }
        else if (c=="\" && string_copy(work_str,i+1,1)=="n") {
        
          w=0;
          yy=yorig+string_height("A");
          i+=1;
          continue;
        
          }
          else if (c=="\" && string_copy(work_str,i+1,1)=="#") {
        
            c="\#";
        
            }
    
  //DRAWING:
  if (global.TPP_LINK_CURRENT=="") {
        
    //Draw regular letter:
    draw_text(xx+w,yy,c);
    w+=string_width(c)+pad;
    
    }
    else {
    
      //Draw clickable letter:
      draw_text(xx+w,yy,c);
      w+=string_width(c)+pad;
      
      //GEN
      var flag=point_in_rectangle(mx,my,xx+w-pad-string_width(c),yy,xx+w,yy+string_height("A"));
    
      if (flag==true) {
        
        global.TPP_LINK_HOVER=global.TPP_LINK_CURRENT;
                  
        var oc=draw_get_color(),
            oa=draw_get_alpha();
            
        draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
        draw_set_alpha(hoveralp);
        
        draw_rectangle(xx+w-pad-string_width(c),yy,xx+w-1,yy+string_height("A"),false);
        
        draw_set_color(oc);
        draw_set_alpha(oa);
        
        if (global.TPP_CURSOR_FLAG==true)
          retval=global.TPP_LINK_CURRENT;
        
        }
        else if (global.TPP_LINK_CURRENT==oldhover or global.TPP_LINK_CURRENT==global.TPP_LINK_HOVER) {
        
          var oc=draw_get_color(),
              oa=draw_get_alpha();

          draw_set_color(tpp_link_colour(global.TPP_LINK_CURRENT));
          draw_set_alpha(hoveralp);
        
          draw_rectangle(xx+w-pad-string_width(c),yy,xx+w-1,yy+string_height("A"),false);
        
          draw_set_color(oc);
          draw_set_alpha(oa);                
        
          }
    
      }

  }
  
return retval;
