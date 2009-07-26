DeriveGamemode( "sandbox" );

GM.Name = "Penumbra";
GM.Author = "Disseminate";

include( "shared_meta.lua" );


BUY_ITEMS = {
	
	{ "Laser Pointer", "Your standard pointing tool, now a shadow-killing death ray.", 15, "weapon_laserpoint", "models/weapons/w_pistol.mdl" },
	{ "Glowstick", "Creates an area-of-effect attack on shadows.", 30, "weapon_glowstick", "models/weapons/w_stunbaton.mdl" },
	{ "Flashbang", "Special light-emitting grenade that causes a massive blast to shadows.", 40, "weapon_flashbang", "models/weapons/W_grenade.mdl" },
	{ "Molotov Cocktail", "Think of it as a stationary turret, but cooler and with fire.", 60, "weapon_molotov", "models/props_junk/garbage_glassbottle003a.mdl" }
	
}