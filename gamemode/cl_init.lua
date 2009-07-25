include( "shared.lua" );
include( "cl_binds.lua" );
include( "cl_hud.lua" );
include( "cl_think.lua" );

DAY = false;

function msgUpdateDay( um )
	
	DAY = um:ReadBool();
	
end
usermessage.Hook( "msgUpdateDay", msgUpdateDay );
