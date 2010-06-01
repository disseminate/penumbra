AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

ENT.NextIllum = 0;
ENT.StartTime = 0;

function ENT:Initialize()

	self:SetModel( "models/alyx_EmpTool_prop.mdl" );
	
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );
	self:SetSolid( SOLID_VPHYSICS );
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	self.StartTime = CurTime();
	
	local phys = self.Entity:GetPhysicsObject();
	
	if( phys:IsValid() ) then
	
		phys:Wake();
		
	end
   
end

function ENT:Think()
	
	if( CurTime() > self.NextIllum ) then
		
		self:IllumSelf( self.Owner, 256, 0.2 );
		self.NextIllum = CurTime() + 0.2;
		
	end
	
	if( CurTime() - self.StartTime > 30 ) then
		
		self:Remove();
		
	end
	
end
