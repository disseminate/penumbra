function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:GetNWInt( "IllumR" ) > 0 ) then
		
			local dlight = DynamicLight( v:EntIndex() );
			
			if ( dlight ) then
				
				dlight.Pos = v:GetPos();
				dlight.r = 255;
				dlight.g = 0;
				dlight.b = 0;
				dlight.Brightness = 8;
				dlight.Size = 150;
				dlight.Decay = 150 * 5;
				dlight.DieTime = CurTime() + 0.1;
				
			end
			
		end
		
	end
	
end
