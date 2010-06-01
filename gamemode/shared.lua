DeriveGamemode( "base" );

GM.Name = "Penumbra";
GM.Author = "Disseminate";

AddCSLuaFile( "shared_meta.lua" );
include( "shared_meta.lua" );


BUY_ITEMS = {
	-- For those reading: Name, desc, price, weapon, model, OnBuy, CheckIfOwned
	-- this is BAD.
	{
		"Laser Pointer",
		"Your standard pointing tool, now a shadow-killing death ray.",
		50,
		"weapon_laserpoint",
		"models/weapons/w_pistol.mdl",
		function( ply )
			ply.HasLaserPointer = true;
		end,
		function( ply )
			return ply.HasLaserPointer
		end
	},
	{
		"Glowstick",
		"Creates an area-of-effect attack on shadows.",
		100,
		"weapon_glowstick",
		"models/weapons/w_stunbaton.mdl",
		function( ply )
			ply.HasGlowstick = true
		end,
		function( ply )
			return ply.HasGlowstick
		end
	},
	{
		"Flashlight Upgrade #1",
		"Get 150% of the regular flashlight power.",
		150,
		"",
		"models/props_lab/tpplug.mdl",
		function( ply )
			ply.MaxFlashlight = 150;
			ply.FlashlightPwr = 150;
			umsg.Start( "msgMaxFlashlight", ply );
				umsg.Short( 150 );
			umsg.End();
			umsg.Start( "msgFlashlightPwr", ply );
				umsg.Short( 150 );
			umsg.End();
		end,
		function( ply )
			return ( ply:GetNWInt( "MaxFlashlight" ) == 150 );
		end
	},
	{
		"Flashbang",
		"Special light-emitting grenade that causes a massive blast to shadows.",
		200,
		"weapon_flashbang",
		"models/weapons/W_grenade.mdl",
		function( ply )
			ply.HasFlashbang = true;
		end,
		function( ply )
			return ply.HasFlashbang;
		end
	},
	{
		"Ultraviolet Laser Pointer",
		"Ultraviolet? More like ultraVIOLENT.",
		275,
		"weapon_uvlauncher",
		"models/weapons/w_irifle.mdl",
		function( ply )
			ply.HasUVLauncher = true;
		end,
		function( ply )
			return ply.HasUVLauncher;
		end
	},
	{
		"Molotov Cocktail",
		"Think of it as a stationary turret, but cooler and with fire.",
		275,
		"weapon_molotov",
		"models/props_junk/garbage_glassbottle003a.mdl",
		function( ply )
			ply.HasMolotov = true;
		end,
		function( ply )
			return ply.HasMolotov;
		end
	},
	{
		"Flashlight Upgrade #2",
		"Get 300% of the regular flashlight power.",
		350,
		"",
		"models/props_lab/tpplug.mdl",
		function( ply )
			ply.MaxFlashlight = 300;
			ply.FlashlightPwr = 300;
			umsg.Start( "msgMaxFlashlight", ply );
				umsg.Short( 300 );
			umsg.End();
			umsg.Start( "msgFlashlightPwr", ply );
				umsg.Short( 300 );
			umsg.End();
		end,
		function( ply )
			return ( ply:GetNWInt( "MaxFlashlight" ) == 300 );
		end
	},
	{
		"Flare Launcher",
		"FWOOMP!",
		400,
		"weapon_flaregun",
		"models/weapons/w_rocket_launcher.mdl",
		function( ply )
			ply.HasFlare = true;
		end,
		function( ply )
			return ply.HasFlare;
		end
	},
}

NIGHT_LEN = 180;
DAY_LEN = 60;