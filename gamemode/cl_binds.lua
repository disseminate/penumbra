function GM:PlayerBindPress( ply, bind )
	
	if( bind == "impulse 100" ) then
		
		if( not ply:CanUseFlashlight() ) then
			
			return true;
			
		end
		
	end
	
end

function GM:KeyPress( ply, key )
	
	if( key == KEY_Q ) then
		
		return !ply:IsAdmin();
		
	end
	
end
