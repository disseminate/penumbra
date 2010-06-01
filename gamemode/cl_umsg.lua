LastGlowstick = -30;
MaxFlashlight = 100;
FlashlightPwr = 100;

function msgLastGlowstick( um )
	
	local t = um:ReadShort();
	LastGlowstick = t;
	
end
usermessage.Hook( "msgLastGlowstick", msgLastGlowstick );

function msgLaserAmmoLeft( um )
	
	local t = um:ReadShort();
	LocalPlayer().LaserAmmoLeft = t;
	
end
usermessage.Hook( "msgLaserAmmoLeft", msgLaserAmmoLeft );

function msgMaxFlashlight( um )
	
	local t = um:ReadShort();
	MaxFlashlight = t;
	
end
usermessage.Hook( "msgMaxFlashlight", msgMaxFlashlight );

function msgFlashlightPwr( um )
	
	local t = um:ReadShort();
	FlashlightPwr = t;
	
end
usermessage.Hook( "msgFlashlightPwr", msgFlashlightPwr );
