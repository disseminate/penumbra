IllumPositions = { };

function GM:Think()
	
	for k, v in pairs( player.GetAll() ) do
		
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
		
		if( v:GetTable().IllumR > 0 ) then
			
			local r = v:GetTable().IllumR;
			local pos = v:GetPos();
			
		end
		
	end
	
end
