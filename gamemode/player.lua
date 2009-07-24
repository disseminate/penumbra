function GM:PlayerInitialSpawn( ply )
	
	ply:SetTeam( TEAM_UNASSIGNED )
	ply:SetMoney( 0 );
	ply:GetTable().IllumR = 0;
	
	ply:LoadData();
	
end

function GM:PlayerSpawn( ply )
	
	ply:UnSpectate()
	hook.Call( "PlayerLoadout", GAMEMODE, ply );
	hook.Call( "PlayerSetModel", GAMEMODE, ply );
	
end

function GM:PlayerLoadout( ply )
	
	ply:Give( "weapon_flashlight" );
	ply:Give( "weapon_blblblbtest" );
	
end
