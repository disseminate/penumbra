function GM:PlayerBindPress( ply, bind )
	
	if( bind == "impulse 100" ) then
		
		if( not ply:CanUseFlashlight() ) then
			
			return true;
			
		end
		
	end
	
end
