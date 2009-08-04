local meta = FindMetaTable( "Player" );


function meta:SetMoney( amt )
	
	self:SetNWInt( "money", amt );
	
end


function meta:Money()
	
	return self:GetNWInt( "money" );
	
end


function meta:CanUseFlashlight()
	
	if( self:Alive() ) then
	
		if( self:GetNWString( "CurWep" ) == "weapon_flashlight" and self:GetNWInt( "flashlightpwr" ) > 0 ) then
			
			return true;
			
		end
		
	end
	
	return false;
	
end
