FIRE_BRIGHTNESS = 0.00;
timer.Create( "FireRandomizer", 0.04, 0, function()
	
	FIRE_BRIGHTNESS = math.random( 4000, 6000 ) / 1000;
	
end );

function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:GetNWInt( "IllumR" ) > 0 ) then
		
			local dlight = DynamicLight( v:EntIndex() );
			
			if ( dlight ) then
				
				dlight.Pos = v:GetPos();
				dlight.r = 0;
				dlight.g = 255;
				dlight.b = 0;
				dlight.Brightness = 8;
				dlight.Size = 150;
				dlight.Decay = 150 * 5;
				dlight.DieTime = CurTime() + 0.1;
				
			end
			
		end
		
	end
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:GetClass() == "env_fire" ) then
			
			local dlight = DynamicLight( v:EntIndex() );
			
			if ( dlight ) then
				
				dlight.Pos = v:GetPos();
				dlight.r = 255;
				dlight.g = 200;
				dlight.b = 0;
				dlight.Brightness = FIRE_BRIGHTNESS; -- eg 5.512
				dlight.Size = 200;
				dlight.Decay = 200 * 5;
				dlight.DieTime = CurTime() + 0.1;
				
			end
			
		end
		
		if( v:GetClass() == "ent_flaregunflare" ) then
			
			local dlight = DynamicLight( v:EntIndex() );
			
			if ( dlight ) then
				
				dlight.Pos = v:GetPos();
				dlight.r = 255;
				dlight.g = 0;
				dlight.b = 0;
				dlight.Brightness = 8; -- eg 5.512
				dlight.Size = 150;
				dlight.Decay = 150 * 5;
				dlight.DieTime = CurTime() + 0.1;
				
			end
			
		end
		
	end
	
end
