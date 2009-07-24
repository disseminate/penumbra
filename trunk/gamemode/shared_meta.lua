local meta = FindMetaTable( "Player" );


function meta:SetMoney( amt )
	
	self:SetNWInt( "money", amt );
	
end


function meta:Money()
	
	return self:GetNWInt( "money" );
	
end


function meta:CanUseFlashlight()
	
	if( self:GetActiveWeapon() and self:GetActiveWeapon():GetClass() == "weapon_flashlight" ) then
		
		return true;
		
	end
	
	return false;
	
end
