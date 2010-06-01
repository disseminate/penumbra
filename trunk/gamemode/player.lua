function GM:PlayerInitialSpawn( ply )
	
	ply:SetTeam( TEAM_UNASSIGNED )
	ply:SetMoney( 0 );
	ply:SetNWInt( "IllumR", r );
	ply.LastFlashUpdate = 0;
	ply.MaxFlashlight = 100;
	ply.FlashlightPwr = 100;
	umsg.Start( "msgMaxFlashlight", ply );
		umsg.Short( ply.MaxFlashlight );
	umsg.End();
	umsg.Start( "msgFlashlightPwr", ply );
		umsg.Short( ply.FlashlightPwr );
	umsg.End();
	
	ply.HasLaserPointer = false;
	ply.HasUVLauncher = false;
	ply.HasGlowstick = false;
	ply.HasFlashbang = false;
	ply.HasMolotov = false;
	ply.HasFlare = false;
	
	umsg.Start( "msgUpdateDay", ply );
		umsg.Bool( DAY );
		umsg.Short( SEC );
	umsg.End();
	
	ply.LastSpawn = CurTime();
	
	if( not ply:SaveExists() ) then
		
		ply:PrintMessage( 3, "Welcome to Penumbra for the first time, " .. ply:Nick() .. "." );
		ply:PrintMessage( 3, "Press F1 for help." );
		
	else
		
		ply:PrintMessage( 3, "Welcome to Penumbra, " .. ply:Nick() .. "." );
		
	end
	
	ply:LoadData();
	
	ply.FlashlightPwr = ply.MaxFlashlight;
	umsg.Start( "msgFlashlightPwr", ply );
		umsg.Short( ply.MaxFlashlight );
	umsg.End();
	
	timer.Simple( 1, function()
		if( ply.HasLaserPointer ) then
			ply.LaserAmmoLeft = 10;
			umsg.Start( "msgLaserAmmoLeft", ply );
				umsg.Short( 10 );
			umsg.End();
			ply:Give( "weapon_laserpoint" );
		end
		
		if( ply.HasUVLauncher ) then
			ply.UVAmmoLeft = 80;
			umsg.Start( "msgUVAmmoLeft", ply );
				umsg.Short( 80 );
			umsg.End();
			ply:Give( "weapon_uvlauncher" );
		end
		
		if( ply.HasGlowstick ) then
			ply:Give( "weapon_glowstick" );
		end
		
		if( ply.HasFlashbang ) then
			ply:Give( "weapon_flashbang" );
		end
		
		if( ply.HasMolotov ) then
			ply:Give( "weapon_molotov" );
		end
		
		if( ply.HasFlare ) then
			ply:Give( "weapon_flare" );
		end
	end );
	
end

function GM:PlayerSpawn( ply )
	
	ply:UnSpectate()
	hook.Call( "PlayerLoadout", GAMEMODE, ply );
	hook.Call( "PlayerSetModel", GAMEMODE, ply );
	ply.LastSpawn = CurTime();
	
end

function GM:PlayerLoadout( ply )
	
	ply:Give( "weapon_flashlight" );
	
end

function GM:ShowSpare1( ply )
	
	if( DAY ) then
		
		umsg.Start( "msgBuyMenu", ply );
		umsg.End();
		
	end
	
end

function GM:ShowHelp( ply )
	
	umsg.Start( "PenHelp", ply );
	umsg.End();
	
end

function GM:PlayerDeathSound() return true end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	
	ply:SetNWInt( "IllumR", 0 );
	ply.LastFlashUpdate = 0;
	
	ply.FlashlightPwr = ply.MaxFlashlight;
	umsg.Start( "msgFlashlightPwr", ply );
		umsg.Short( ply.MaxFlashlight );
	umsg.End();
	
	umsg.Start( "msgLastGlowstick", ply );
		umsg.Short( -30 );
	umsg.End();
	
	ply:CreateRagdoll() -- Below is base code
	
	ply:AddDeaths( 1 )
	
	if ( attacker:IsValid() && attacker:IsPlayer() ) then
	
		if ( attacker == ply ) then
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )
		end
		
	end
	
end
