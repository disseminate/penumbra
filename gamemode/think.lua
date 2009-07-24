IllumPositions = { };

function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		local fEnt = v:FlashlightEntity();
		
		if( fEnt and fEnt:IsValid() ) then
			
			if( fEnt:IsShadow() ) then
				
				fEnt:EmitSound( Sound( "npc/stalker/go_alert2.wav" ) );
				fEnt:Remove();
				v:SetMoney( v:Money() + 1 );
				
			end
			
		end
		
		if( not v:CanUseFlashlight() and v:FlashlightIsOn() ) then
			
			v:Flashlight( false );
			
		end
		
		if( v:GetNWInt( "IllumR" ) > 0 ) then
			
			local r = v:GetNWInt( "IllumR" );
			local pos = v:GetPos();
			
			local ents = ents.FindInSphere( pos, r );
			
			for _, n in pairs( ents ) do
				
				if( n:IsShadow() ) then
					
					n:EmitSound( Sound( "npc/stalker/go_alert2.wav" ) );
					n:Remove();
					v:SetMoney( v:Money() + 1 );
					
				end
				
			end
			
		end
		
	end
	
end
