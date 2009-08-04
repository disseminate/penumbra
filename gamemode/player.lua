function GM:PlayerInitialSpawn( ply )
	
	ply:SetTeam( TEAM_UNASSIGNED )
	ply:SetMoney( 0 );
	ply:SetNWInt( "IllumR", r );
	ply:SetNWInt( "flashlightpwr", 100 );
	ply:SetNWInt( "lastFlashUpdate", 0 );
	ply:SetNWInt( "LastGlowstick", -30 );
	ply:SetNWInt( "CurWep", "weapon_flashlight" );
	
	ply.HasLaserPointer = false;
	ply.HasGlowstick = false;
	ply.HasFlashbang = false;
	ply.HasMolotov = false;
	
	umsg.Start( "msgUpdateDay", ply );
		umsg.Bool( DAY );
	umsg.End();
	
	if( not ply:SaveExists() ) then
		
		ply:PrintMessage( 3, "Welcome to Penumbra for the first time, " .. ply:Nick() .. "." );
		
	else
		
		ply:PrintMessage( 3, "Welcome to Penumbra, " .. ply:Nick() .. "." );
		
	end
	
	ply:LoadData();
	
	timer.Simple( 1, function()
		if( ply.HasLaserPointer ) then
			ply:SetNWInt( "LaserAmmoLeft", 10 );
			ply:Give( "weapon_laserpoint" );
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
	end );
	
end

function GM:PlayerSpawn( ply )
	
	ply:UnSpectate()
	hook.Call( "PlayerLoadout", GAMEMODE, ply );
	hook.Call( "PlayerSetModel", GAMEMODE, ply );
	
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

function GM:PlayerDeathSound() return true end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	
	ply:SetNWInt( "IllumR", 0 );
	ply:SetNWInt( "flashlightpwr", 100 );
	ply:SetNWInt( "lastFlashUpdate", 0 );
	ply:SetNWInt( "LastGlowstick", -30 );
	
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
