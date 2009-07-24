--It follows the nearest player. *shrug*

AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()

	self:SetModel( "models/zombie/fast.mdl" );
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
	self:SetSolid( SOLID_BBOX );
	self:SetMoveType( MOVETYPE_STEP );
	self:CapabilitiesAdd( CAP_MOVE_GROUND );
	self:SetMaxYawSpeed( 5000 );
	self:SetHealth( 100 ); -- idk
	self:SetColor( 255, 255, 255, 100 );
	self:SetMaterial( "models/weapons/v_stunbaton/w_shaft01a" );
   
end

function ENT:Think()
	
	for k, v in pairs( player.GetAll() ) do
		
		self:AddEntityRelationship( v, 1, 10 );
		
	end
	
	if( self:GetEnemy() ) then
		
		self:UpdateEnemyMemory( self:GetEnemy(), self:GetEnemy():GetPos() );
		
		if( self:OnGround() and self:GetEnemy():GetPos():Distance( self:GetPos() ) > 250 and self:GetEnemy():GetPos():Distance( self:GetPos() ) < 500 ) then
			
			local ppos = self:GetEnemy():GetPos() - self:GetPos();
			local epos = Vector( ppos.x * 100, ppos.y * 100, 250 );
			self:SetVelocity( epos );
			
		end
		
	end
	
	self:FindEnemy();

end

function ENT:SelectSchedule()

	if( self:GetEnemy() ) then
		
		self:UpdateEnemyMemory( self:GetEnemy(), self:GetEnemy():GetPos() );
		self:SetSchedule( SCHED_CHASE_ENEMY );
		
	end
	
end

function ENT:FindEnemy()
	
	local ply = self:FindClosestPly( player.GetAll() );
	
	if( ply ) then
		
		self:SetEnemy( ply );
		self:UpdateEnemyMemory( ply, ply:GetPos() );
		return;
		
	end
	
end

function ENT:FindClosestPly( enttab )
	
	local tab = enttab; -- table of players
	
	local len = 999999; -- max length - for sorting
	local pl = nil;
	
	for k, v in pairs( tab ) do
		
		local my = self:GetPos();
		local their = v:GetPos()
		
		local length = my:Distance( their );
		if( length < len ) then
			
			len = length;
			pl = v;
			
		end
		
	end
	
	return pl;
	
end

function ENT:Touch( ent )
	
	if( ent:IsPlayer() ) then
		
		ent:ShadowKill();
		
	end
	
end