include( "shared.lua" );
include( "cl_binds.lua" );
include( "cl_hud.lua" );
include( "cl_think.lua" );
include( "cl_buymenu.lua" );
include( "cl_scoreboard.lua" );

DAY = false;
DAY_LASTTRANS = 0;

function msgUpdateDay( um )
	
	DAY = um:ReadBool();
	DAY_LASTTRANS = CurTime();
	
end
usermessage.Hook( "msgUpdateDay", msgUpdateDay );
