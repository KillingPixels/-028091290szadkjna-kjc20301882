///ai_engage(Probability, Range, PlayerBias)
/*
Attempts to engage a nearby target.
*/
var a;

if irandom(100)<argument0
 a=ai_select_target(_group,argument1,argument2)
 else a=-1;
    
 if a>0 {
  _aiState=AI_STATE.hunt;
  _target=a;
  _tarX=_target.x;
  _tarY=_target.y;
  _moveMode=1;
  }
