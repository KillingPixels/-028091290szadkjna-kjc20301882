/* Turbo Print Parser v1.0 - Documentation

>>INITIALIZATION:
  To initialize the parser call TPP_initialize() before calling any other
  TPP_* functions.
  
>>FREEING MEMORY:
  To free the memory used by the parser call TPP_free(). Note that any ds_grids
  created by TPP_text_parse() will NOT be freed like this and for that you must
  use TPP_text_free() manually.
  
>>PRINTING TEXT:
   -Formatting text:
    Apart from the usual functionality when printing text there are some tags
    similar to those in HTML to extend the possibilities. Every tag follows the
    same basic format: [keyword:variable/identifier:text]. Every keyword
    consists of three letters, and here's a list of possible keywords:
    
      [col:var:text] - Changes colour
      [fnt:var:text] - Changes font
      [alp:var:text] - Changes alpha
      [aln:num:text] - Changes alpha in a different way
      [clk:ide:text] - Creates clickable text / link
      [lnk:ide:text] - Same as above
      [spr:var] - Prints a sprite
      [spe:var] - Prints a sprite, extended
      [exe:var] - Executes custom code
      
    >col, fnt, alp:
    Notice how some keywords require a variable after them but before the text.
    These are not real static variables but rather entries in a global ds_map.
    To define a variable use TPP_define_var(Key, Value). Key must be a string.
    For example you may want to define red colour, and for that you'd use
    TPP_define_var("red",c_red); After that, you will be able to use the "col"
    tag when printing text, for example:
    "I like [col:red:apples]." - When this string gets printed to the screen
    the word apples will be in red colour. Tags "fnt" and "alp" work much in the
    same way, except for that you'd define a variable for "fnt" as an index of
    one of the fonts, and the variable for "alp" would be a real value between
    zero and one.
    
    >aln:
    Aln also changes alpha of the text being printed, but instead of providing
    a variable you just provide a real number between 0 and 1. For example:
    "I'm afraid of [aln:0.5:ghosts]!" - Here the word "ghosts" would be printed
    with alpha=0.5.
    
    >clk, lnk:
    These tags are completely synonymous and you can use either of them to print
    interactible / clickable text (or even sprites, with "spr" and "spe" tags,
    look below). They do not require any predefined variables, but rather just
    an identifier, which can be any string which is not a valid tag or operator
    for printing text. All text printing functions will return the appropriate
    identifier of the link that is being clicked, or an empty string if no link
    has been clicked. For example:
    var r=TPP_text_print(x,y,"[lnk:ABC:This] is a link.",...); - Here "r" will
    receive the value "ABC" if the user presses the link and "" otherwise.
    
    NOTE: There are some additional functions that you'll need to use in order to
          utilize links - TPP_link_get_hover(), TPP_link_clear_hover() and
          TPP_set_cursor(). They will be described further below.
          
    NOTE: Printing links is much slower that printing regular text, so use with
          caution.
      
    >spr, spe:
    Now these two tags are both used for printing sprites (like emoticons and
    such, but they can be large sprites too) but unlike the previous two they are
    not synonymous. With "spr" the sprite will be printed in its default state,
    while with "spe" it will be blended with the colour and alpha currently in
    effect. Additionally, with previous tags you can make clickable sprites in
    text. But note that you'll have it assign the sprite's ID to a key.
    
    >exe:
    <Work in progress>

    >Other notable things:
    An opening square bracket ( [ ) is not considered an operator without a tag after
    it, so you can use it freely. A closed square bracket ( ] ) IS an operator, so in
    order to print it without ending the current tag's effect type "\]", where "\" is
    an escape character.
    Tags may be nested in each other and you won't have issues as long as they're
    closed properly.
    A hashtag ( # ) is NOT considered a new-line character, and it doesn't have any
    special purpose. In odred to break line, type "\n".
    
   -TPP_text_print(X, Y, String, Colour, Alpha, Font, spr_vAlign, centerLine):
    This is the simplest text printing function. It requires no preparation but it
    can only print text with top/left alignment. The arguments are the following:
      X, Y - (Real) Coordinates for printing
      String - (String) Text to print
      Colour - (Real) Starting colour
      Alpha - (Real) Starting alpha
      Font - (Real) Starting font
      spr_vAlign - (Real) Vertical alignment of printed sprites relative to the text
                   Can be either fa_center, fa_top or fa_bottom.
      centerLine - (Real) Whether the text in a single line should be vertically
                   centered, in the case of use of different fonts of different sizes
                   within the same line. Use 1 for Yes and 0 for No.
                   
   -TPP_text_parse(String, Colour, Alpha, Font, spr_vAlign, centerLines, Width, Sep, Justify):
    The first thing to note is that this function does NOT draw text - it's used to parse it
    and prepare it for use with TPP_text_print_ext(). For arguments "String" through 
    "spr_vAlign" see the function above. The rest arguments are the following:
      Width - (Real) Maximum width (in pixels) of a line of text if you want the parser to
              split the text into multiple lines (much like GM's draw_text_ext()). If you
              want the whole text to be in a single line just put a very large value.
      Sep - (Real) Separation (in pixels) between two consecutive lines of text. Put -1 for
            automatic.
            NOTE: If you use automatic, it's recommended to set "spr_vAlign" to fa_top.
      Justify - (Real) Maximum justification. About 1 to 2 is enough for regular-sized fonts.
                If you don't want your text justified, put zero.
    This function will return a numerical handle (an ID) of a ds_grid that will be created to
    store the parsed text. Don't forget to destroy it afterwards with TPP_text_free(), and
    don't use ds_grid_destroy() because of nested data structures).
    
   -TPP_text_print_ext(X, Y, Grid ID, hAlign, vAlign):
    Use this function to draw the text that has previously been prepared through the use of
    TPP_text_parse(). As the "Grid ID" argument put the value the parsing script returned.
    The first two arguments are the coordinates to print at. For "hAlign" you must put one
    of these: fa_left, fa_center, fa_right. For "vAlign" you must put one of these: fa_top,
    fa_center, fa_bottom.    
    
>>MISCELLANEOUS:
   -TPP_clear_definitions():
    No arguments.
    Deletes all variable definitions created using TPP_define_var().
    
   -TPP_define_defaults():
    <Work in progress>
    
   -TPP_set_cursor(X, Y, Flag):
    This functions is only needed if you want to make links in text. As no assumptions
    are made regarding what represents the sursor in your program, so in order to use
    links you need to 'tell' the engine what are the X and Y coordinates of the cursor
    (the first two arguments) and whether the cursor is active (currently clicking - 
    the third argument). Usually you'd put mouse_x and mouse_y as X and Y, and
    mouse_check_button_pressed(mb_left) as Flag, but of course it's not mandatory. Note
    that this script needs to be called once every step before the Draw event
    (preferrably in Step, End Step or Pre-Draw event). However, since GUI coordinates
    are not the same as world coordinates, if you're printing anything in GUI you'll
    also need to call it once after the Draw event but before Draw GUI event (so
    preferrably in Post_draw event).      
    
   -TPP_link_get_hover():
    No arguments.
    Returns the identifier of the link currently being hovered over by the cursor, or
    an empty string if the cursor isn't hovering over any links.
    
   -TPP_clear_hover():
    No arguments.
    This functions is only needed if you want to make links in text. It prepares some
    variables that are needed for drawing links correctly and you will encounter
    visual errors if you don't use this function correctly. It's important to call
    this script at the very end of a step (so after all drawing is done) OR before
    any drawing is done. Just remember that you need to call this script exactly ONCE
    per step.
    
   -TPP_execute_code():
    <Work in progress>
    
   -TPP_string_width():
    <Currently doesn't work>
        
>>SETTINGS:
   -TPP_settings(HoverCol_1, HoverCol_2, HoverAlpha):
    Use this function to set some general parameters for the parser.
      HoverCol_1 - (Real) Colour of link backdrop that's drawn when the cursor is
                   hovering over the link.
      HoverCol_2 - (Real) Colour of link backdrop that's drawn when the cursor is
                   clicking or otherwise activating the link.
      HoverAlpha - (Real) Alpha of the backdrops mentioned above.


      
      
      
