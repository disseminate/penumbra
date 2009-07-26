DeriveGamemode( "sandbox" );

GM.Name = "Penumbra";
GM.Author = "Disseminate";

include( "shared_meta.lua" );


BUY_ITEMS = {
	
	{ "Glowstick", "Creates an area-of-effect attack on shadows.", 30, "weapon_glowstick", "models/weapons/w_stunbaton.mdl" },
	{ "Flashbang", "Special light-emitting grenade that causes a massive blast to shadows.", 40, "weapon_flashbang", "models/weapons/W_grenade.mdl" },
	{ "Laser Pointer", "Your standard pointing tool converted into a shadow-killing death ray.", 15, "weapon_laserpoint", "models/weapons/w_pistol.mdl" }
	
}