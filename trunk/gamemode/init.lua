AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "cl_binds.lua" );
AddCSLuaFile( "cl_hud.lua" );
AddCSLuaFile( "cl_think.lua" );
AddCSLuaFile( "cl_buymenu.lua" );
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_help.lua" );
AddCSLuaFile( "cl_umsg.lua" );

include( "shared.lua" );
include( "meta.lua" );
include( "think.lua" );
include( "player.lua" );
include( "buymenu.lua" );

resource.AddFile( "materials/penumbra/shadow.vmt" );
resource.AddFile( "materials/penumbra/uvlaser.vmt" );

resource.AddFile( "materials/IGWeapons/Gloves.vmt" );
resource.AddFile( "materials/IGWeapons/igraharms.vmt" );
resource.AddFile( "materials/IGWeapons/igresarms.vmt" );
resource.AddFile( "materials/IGWeapons/igresarms_norm.vmt" );
resource.AddFile( "materials/IGWeapons/RaArms.vmt" );
resource.AddFile( "materials/IGWeapons/vodka_bottle.vmt" );
resource.AddFile( "materials/IGWeapons/vodka_bottle_gib.vmt" );
resource.AddFile( "models/weapons/v_molotov.mdl" );

resource.AddFile( "maps/" .. game.GetMap() .. ".bsp" );

MAP = { };
MAP.ShadowSpawns = { };
local SpawnpointFile = file.FindInLua( "Penumbra/gamemode/spawnpoints/*.lua" );

for k, v in pairs( SpawnpointFile ) do
	include( "spawnpoints/" .. v );
end


DAY = false
SEC = 0

function GM:Initialize()
	
	timer.Create( "DayNightTimer", 1, 0, function()
		
		SEC = SEC + 1;
		if( DAY ) then
			
			if( SEC >= DAY_LEN ) then -- 1 min
				
				for _, v in pairs( player.GetAll() ) do
					
					v:PrintMessage( 3, "Night!" );
					
				end
				DAY = false;
				SEC = 0;
				
				for _, v in pairs( player.GetAll() ) do
				
					umsg.Start( "msgUpdateDay", v );
						umsg.Bool( DAY );
						umsg.Short( SEC );
					umsg.End();
					
				end
				
			end
			
		else
			
			if( SEC >= NIGHT_LEN ) then
				
				for _, v in pairs( player.GetAll() ) do
					
					v:PrintMessage( 3, "Day! Press F3 to buy new weapons." );
					
					if( v.HasLaserPointer ) then
						
						v.LaserAmmoLeft = 10;
						umsg.Start( "msgLaserAmmoLeft", v );
							umsg.Short( 10 );
						umsg.End();
						
						v:Give( "weapon_laserpoint" );
						
					end
					
					if( v.HasUVLauncher ) then
						
						v.UVAmmoLeft = 80;
						umsg.Start( "msgUVAmmoLeft", v );
							umsg.Short( 80 );
						umsg.End();
						
						v:Give( "weapon_uvlauncher" );
						
					end
					
					if( v.HasGlowstick ) then
						v:Give( "weapon_glowstick" );
					end
					
					if( v.HasFlashbang ) then
						v:Give( "weapon_flashbang" );
					end
					
					if( v.HasMolotov ) then
						v:Give( "weapon_molotov" );
					end
					
					if( v.HasFlare ) then
						v:Give( "weapon_flaregun" );
					end
					
				end
				DAY = true;
				SEC = 0;
				
				for _, v in pairs( ents.GetAll() ) do
					
					if( v:IsShadow() ) then
						
						v:EmitSound( Sound( "npc/stalker/go_alert2.wav" ) );
						v:Remove();
						
					end
					
				end
				
				for _, v in pairs( player.GetAll() ) do
				
					umsg.Start( "msgUpdateDay", v );
						umsg.Bool( DAY );
					umsg.End();
					
				end
				
			end
			
		end
		
	end )
	
	timer.Create( "SpawnShadows", 3, 0, function()
		
		if( not DAY ) then
			
			local num = 0;
			for _, v in pairs( ents.GetAll() ) do
				
				if( v:IsShadow() ) then
					
					num = num + 1;
					
				end
				
			end
			
			if( num < 30 ) then
			
				local randspawn = MAP.ShadowSpawns[math.random( 1, #MAP.ShadowSpawns )];
				ents.SpawnShadow( randspawn );
				
			end
			
		end
		
	end )
	
end


function GM:ShouldCollide( ent1, ent2 )
	
	if( ent1:IsShadow() ) then return false end
	if( ent2:IsShadow() ) then return false end
	
	return true;
	
end
