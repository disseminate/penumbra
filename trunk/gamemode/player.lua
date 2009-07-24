function GM:PlayerInitialSpawn( ply )
	
	ply:SetTeam( TEAM_UNASSIGNED )
	ply:SetMoney( 0 );
	ply:SetNWInt( "IllumR", r );
	
	ply:LoadData();
	
end

function GM:PlayerSpawn( ply )
	
	ply:UnSpectate()
	hook.Call( "PlayerLoadout", GAMEMODE, ply );
	hook.Call( "PlayerSetModel", GAMEMODE, ply );
	
end

function GM:PlayerLoadout( ply )
	
	ply:Give( "weapon_flashlight" );
	ply:Give( "weapon_glowstick" );
	ply:Give( "weapon_blblblbtest" );
	
end

function GM:PlayerDeathSound() return true end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	
	ply:SetNWInt( "IllumR", 0 );
	
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
