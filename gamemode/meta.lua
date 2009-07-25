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


function entity:IllumSelf( r, t, pos )
	
	table.insert( IllumPositions, { pos, r } );
	
	timer.Simple( t, function()
		table.remove( IllumPositions, table.FindVal( IllumPositions, { pos, r } ) );
	end );
	
end


function entity:IsShadow()
	
	return ( self:GetClass() == "npc_shadow" );
	
end


function player:ShadowKill()
	
	self:SetMoney( self:Money() - 15 );
	self:PrintMessage( 3, "A shadow has touched you!" );
	self:SaveData();
	self:Kill();
	
end


function entity:KillShadow( ply )
	
	self:EmitSound( Sound( "npc/stalker/go_alert2.wav" ) );
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
		
	end
	
end


function player:SaveData()
	
	local sid = string.gsub( string.gsub( self:SteamID(), ":", "" ), "_", "" );
	
	local str = {
		self:Money(),
		"lol"
	};
	
	file.Write( "penumbra/" .. sid .. ".txt", string.Implode( "$", str ) );
	
end
