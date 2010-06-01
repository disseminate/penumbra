IllumPositions = { };

function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		local fEnt = v:FlashlightEntity();
		
		if( fEnt and fEnt:IsValid() ) then
			
			if( fEnt:IsShadow() ) then
				
				fEnt:KillShadow( v );
				
			end
			
		end
		
		if( not v:CanUseFlashlight() and v:FlashlightIsOn() ) then
			
			v:Flashlight( false );
			
		end
		
		if( v:FlashlightIsOn() ) then
			
			v.FlashlightPwr = math.Clamp( v.FlashlightPwr - 0.25, 0, v.MaxFlashlight );
			umsg.Start( "msgFlashlightPwr", v );
				umsg.Short( v.FlashlightPwr );
			umsg.End();
			v.LastFlashUpdate = CurTime();
			
		else
			
			if( CurTime() - v.LastFlashUpdate >= 1 ) then
				
				v.FlashlightPwr = math.Clamp( v.FlashlightPwr + 0.125, 0, v.MaxFlashlight );
				umsg.Start( "msgFlashlightPwr", v );
					umsg.Short( v.FlashlightPwr );
				umsg.End();
				
			end
			
		end
		
		if( v:GetNWInt( "IllumR" ) > 0 ) then
			
			local r = v:GetNWInt( "IllumR" );
			local pos = v:GetPos();
			
			local ents = ents.FindInSphere( pos, r );
			
			for _, n in pairs( ents ) do
				
				if( n:IsShadow() ) then
					
					n:KillShadow( v );
					
				end
				
			end
			
		end
		
	end
	
	for _, v in pairs( IllumPositions ) do
		
		local ents = ents.FindInSphere( v[2], v[3] );
		
		for m, n in pairs( ents ) do
			
			if( n:IsShadow() ) then
				
				n:KillShadow( v[1] );
				
			end
			
		end
		
	end
	
end
