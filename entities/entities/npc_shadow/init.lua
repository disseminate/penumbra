AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()
	
	table.insert( MAP.ShadowSpawns, self:GetPos() );
	
end
