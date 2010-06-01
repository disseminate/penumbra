local meta = FindMetaTable( "Player" );


function meta:SetMoney( amt )
	
	self:SetNWInt( "money", amt );
	
end


function meta:Money()
	
	return self:GetNWInt( "money" );
	
end


function meta:CanUseFlashlight()
	
	if( self:Alive() ) then
	
		if( self:GetActiveWeapon():GetClass() == "weapon_flashlight" and ( ( CLIENT and FlashlightPwr > 0 ) or ( SERVER and self.FlashlightPwr > 0 ) ) ) then
			
			return true;
			
		end
		
	end
	
	return false;
	
end
