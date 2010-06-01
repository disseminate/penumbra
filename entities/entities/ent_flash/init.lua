AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()

	self:SetModel( "models/Weapons/w_grenade.mdl" );
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS );
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS );
	self.Entity:SetSolid( SOLID_VPHYSICS );
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	local phys = self.Entity:GetPhysicsObject();
	
	if( phys:IsValid() ) then
	
		phys:Wake();
		
	end
	
	timer.Simple( 3, function()
		
		self:EmitSound( Sound( "Flashbang.Explode" ) );
		
		for _, v in pairs( player.GetAll() ) do
			
			if( self:GetPos():Distance( v:GetPos() ) < 1500 ) then
				
				v:SetNWFloat( "FLASHED_END_START", CurTime() );
				v:SetNWFloat( "FLASHED_END", CurTime() + 3 );
				
			end
			
		end
		
		local ents = ents.FindInSphere( self:GetPos(), 1000 );
		
		for _, v in pairs( ents ) do
			
			if( v:IsShadow() ) then
				
				v:KillShadow( self.Owner );
				
			end
			
		end
		
		self:Remove();
		
	end )
   
end

function ENT:Think()

end
