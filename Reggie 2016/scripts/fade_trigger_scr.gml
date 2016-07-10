///fade_trigger_scr(color, script, override)

if (argument2)
{
    with (fadeTriggerObj)
        instance_destroy();
}
else if (instance_exists(fadeTriggerObj))
     return 0;

var __id = instance_create(0,0,fadeTriggerObj);
__id._color = argument0;

if (asset_get_type(argument1) != asset_script)
    show_error("Asset must be a script!", true);

__id._script = asset_get_index(argument1);
