AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()

	self:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS );
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS );
	self.Entity:SetSolid( SOLID_VPHYSICS );
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	local phys = self.Entity:GetPhysicsObject();
	
	if( phys:IsValid() ) then
	
		phys:Wake();
		
	end
   
end

function ENT:PhysicsCollide()
	
	if( SERVER ) then
		
		local fire = ents.Create( "env_fire" );
		fire:SetPos( self:GetPos() );
		fire:SetKeyValue( "health", 30 );
		fire:SetKeyValue( "firesize", 100 );
		fire:Spawn();
		fire:Fire( "enable", "", 0 );
		fire:Fire( "StartFire", "", 0 );
		
		timer.Simple( 30, function()
			
			if( fire ) then
				
				fire:Remove();
				
			end
			
		end );
		
		self:IllumSelf( self.Owner, 256, 30 );
		
		local snds = {
			"physics/glass/glass_impact_bullet1.wav",
			"physics/glass/glass_impact_bullet2.wav",
			"physics/glass/glass_impact_bullet3.wav",
			"physics/glass/glass_impact_bullet4.wav"
		}
		
		self:EmitSound( Sound( snds[math.random( 1, #snds )] ) );
		
		self:Remove();
		
	end
	
end

function ENT:Think()
	
end
