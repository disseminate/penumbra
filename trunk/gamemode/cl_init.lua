include( "shared.lua" );
include( "cl_binds.lua" );
include( "cl_hud.lua" );
include( "cl_think.lua" );
include( "cl_buymenu.lua" );
include( "cl_scoreboard.lua" );
include( "cl_help.lua" );

DAY = false;
SEC = 0;
DAY_LASTTRANS = 0;

function msgUpdateDay( um )
	
	DAY = um:ReadBool();
	SEC = um:ReadShort();
	DAY_LASTTRANS = CurTime();
	
end
usermessage.Hook( "msgUpdateDay", msgUpdateDay );

function clUpdateSec()
	
	SEC = math.Clamp( SEC + 1, 0, NIGHT_LEN );
	
end
timer.Create( "clUpdateSec", 1, 0, clUpdateSec );