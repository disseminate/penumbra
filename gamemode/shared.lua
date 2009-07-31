DeriveGamemode( "base" );

GM.Name = "Penumbra";
GM.Author = "Disseminate";

AddCSLuaFile( "shared_meta.lua" );
include( "shared_meta.lua" );


BUY_ITEMS = {
	-- For those reading: Name, desc, price, weapon, model, OnBuy, CheckIfOwned
	{ "Laser Pointer", "Your standard pointing tool, now a shadow-killing death ray.", 100, "weapon_laserpoint", "models/weapons/w_pistol.mdl", function( ply ) ply.HasLaserPointer = true end, function( ply ) return ply.HasLaserPointer end },
	{ "Glowstick", "Creates an area-of-effect attack on shadows.", 200, "weapon_glowstick", "models/weapons/w_stunbaton.mdl", function( ply ) ply.HasGlowstick = true end, function( ply ) return ply.HasGlowstick end },
	{ "Flashbang", "Special light-emitting grenade that causes a massive blast to shadows.", 350, "weapon_flashbang", "models/weapons/W_grenade.mdl", function( ply ) ply.HasFlashbang = true end, function( ply ) return ply.HasFlashbang end },
	{ "Molotov Cocktail", "Think of it as a stationary turret, but cooler and with fire.", 450, "weapon_molotov", "models/props_junk/garbage_glassbottle003a.mdl", function( ply ) ply.HasMolotov = true end, function( ply ) return ply.HasMolotov end }
	
}
