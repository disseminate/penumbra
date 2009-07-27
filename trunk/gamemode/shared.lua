DeriveGamemode( "sandbox" );

GM.Name = "Penumbra";
GM.Author = "Disseminate";

include( "shared_meta.lua" );


BUY_ITEMS = {
	
	{ "Laser Pointer", "Your standard pointing tool, now a shadow-killing death ray.", 150, "weapon_laserpoint", "models/weapons/w_pistol.mdl", function( ply ) ply.HasLaserPointer = true end },
	{ "Glowstick", "Creates an area-of-effect attack on shadows.", 300, "weapon_glowstick", "models/weapons/w_stunbaton.mdl", function( ply ) ply.HasGlowstick = true end },
	{ "Flashbang", "Special light-emitting grenade that causes a massive blast to shadows.", 400, "weapon_flashbang", "models/weapons/W_grenade.mdl", function( ply ) ply.HasFlashbang = true end },
	{ "Molotov Cocktail", "Think of it as a stationary turret, but cooler and with fire.", 600, "weapon_molotov", "models/props_junk/garbage_glassbottle003a.mdl", function( ply ) ply.HasMolotov = true end }
	
}