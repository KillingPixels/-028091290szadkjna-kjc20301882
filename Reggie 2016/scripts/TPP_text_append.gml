///TPP_text_append(Grid ID, String, Width, Sep, Justify)
/*

Appends text to an already parsed text / grid.

*/
var i,g,l,t,target,c_h;

target=argument0;

g=TPP_text_parse(argument1,0,0,0,0,0,argument2,argument3,argument4);

for (i=1; i<ds_grid_height(g); i+=1) {

  c_h=ds_grid_height(target);
  ds_grid_resize(target,4,c_h+1);
  
  target[#0,c_h]=g[#0,i];
  target[#1,c_h]=g[#1,i];
  target[#2,c_h]=g[#2,i];
  target[#3,c_h]=g[#3,i];

  }
  
l=target[#0,0];
t=g[#0,0];

l[|TPP_LIST.maxwidth] =max(l[|TPP_LIST.maxwidth], t[|TPP_LIST.maxwidth]);
l[|TPP_LIST.maxheight]=max(l[|TPP_LIST.maxheight],t[|TPP_LIST.maxheight]);

TPP_text_free(g);
