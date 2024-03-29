local player = FindMetaTable( "Player" );
local entity = FindMetaTable( "Entity" );


function table.FindVal( tab, val )
	
	local pos = 1;
	
	for k, v in pairs( tab ) do
		
		if( v == val ) then
			
			pos = k;
			
		end
		
	end
	
	return pos;
	
end


function ents.SpawnShadow( pos )
	
	local npc = ents.Create( "npc_shadow" );
		npc:SetPos( pos );
		npc:Spawn();
	
end


function player:FlashlightEntity()
	
	if( self:FlashlightIsOn() ) then
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetAimVector() * 150;
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			return tr.Entity;
			
		end
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetAimVector() * 150 + Vector( 0, 0, 75 );
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			return tr.Entity;
			
		end
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetAimVector() * 150 + Vector( 0, 0, -75 );
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			return tr.Entity;
			
		end
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetAimVector() * 150 + self:GetRight() * 75;
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			return tr.Entity;
			
		end
		
		local trace = { };
		trace.start = self:EyePos();
		trace.endpos = trace.start + self:GetAimVector() * 150 + self:GetRight() * -75;
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
			
			return tr.Entity;
			
		end
		
	end
	
	return;
	
end


function player:IllumSelf( r, t )
	
	self:SetNWInt( "IllumR", r );
	
	timer.Simple( t, function()
		self:SetNWInt( "IllumR", 0 );
	end );
	
end


function entity:IllumSelf( ply, r, t )
	
	local pos = self:GetPos();
	
	table.insert( IllumPositions, { ply, pos, r } );
	
	timer.Simple( t, function()
		table.remove( IllumPositions, table.FindVal( IllumPositions, { pos, r } ) );
	end );
	
end


function entity:IsShadow()
	
	return ( self:GetClass() == "npc_shadow" );
	
end


function player:ShadowKill( ent )
	
	if( CurTime() - self.LastSpawn > 5 ) then -- Spawn protection
		
		self:SetMoney( self:Money() - 5 );
		if( self:Money() < 0 ) then self:SetMoney( 0 ) end
		
		self:SaveData();
		self:Kill();
		
	end
	
end


function entity:KillShadow( ply )
	
	local effectdata = EffectData();
		effectdata:SetStart( self:GetPos() + Vector( 0, 0, 50 ) );
		effectdata:SetOrigin( self:GetPos() );
		effectdata:SetScale( 1 );
	util.Effect( "shadowsmoke", effectdata );
	
	self:EmitSound( Sound( "npc/stalker/go_alert2.wav" ) );
	self:EmitSound( Sound( "NPC_Antlion_Grub.Explode" ) );
	self:Remove();
	ply:SetMoney( ply:Money() + 1 );
	ply:SaveData();
	
end

function player:SaveExists()
	
	local sid = string.gsub( string.gsub( self:SteamID(), ":", "" ), "_", "" );
	
	if( file.Exists( "penumbra/" .. sid .. ".txt" ) ) then
		
		return true;
		
	end
	
	return false;
	
end


function player:LoadData()
	
	local sid = string.gsub( string.gsub( self:SteamID(), ":", "" ), "_", "" );
	
	if( self:SaveExists() ) then
		
		local fstr = file.Read( "penumbra/" .. sid .. ".txt" );
		local ftab = string.Explode( "$", fstr );
		
		self:SetMoney( tonumber( ftab[1] ) );
		self.HasLaserPointer = tobool( ftab[2] );
		self.HasUVLauncher = tobool( ftab[3] );
		self.HasGlowstick = tobool( ftab[4] );
		self.HasFlashbang = tobool( ftab[5] );
		self.HasMolotov = tobool( ftab[6] );
		self.HasFlare = tobool( ftab[7] );
		self.MaxFlashlight = tonumber( ftab[8] );
		umsg.Start( "msgMaxFlashlight", self );
			umsg.Short( self.MaxFlashlight );
		umsg.End();
		
	end
	
end


function player:SaveData()
	
	local sid = string.gsub( string.gsub( self:SteamID(), ":", "" ), "_", "" );
	
	local str = {
		self:Money(),
		tostring( self.HasLaserPointer ),
		tostring( self.HasUVLauncher ),
		tostring( self.HasGlowstick ),
		tostring( self.HasFlashbang ),
		tostring( self.HasMolotov ),
		tostring( self.HasFlare ),
		tostring( self.MaxFlashlight )
	};
	
	file.Write( "penumbra/" .. sid .. ".txt", string.Implode( "$", str ) );
	
end
