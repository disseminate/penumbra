function buyItem( ply, cmd, args )
	
	if( not DAY ) then
		
		ply:PrintMessage( 3, "It must be day to buy an item!" );
		return;
		
	end
	
	local name = args[1];
	
	local itemdata = { };
	
	for _, v in pairs( BUY_ITEMS ) do
		
		if( v[1] == name ) then
			
			itemdata = v;
			
		end
		
	end
	
	if( itemdata[1] ) then
		
		local name = itemdata[1];
		local amt = itemdata[3];
		local wep = itemdata[4];
		
		if( ply:Money() - amt < 0 ) then
			
			ply:PrintMessage( 3, "You don't have enough money to buy this!" );
			return;
			
		end
		
		if( ply:HasWeapon( wep ) or itemdata[7]( ply ) ) then
			
			ply:PrintMessage( 3, "You already have this!" );
			return;
			
		end
		
		ply:SetMoney( ply:Money() - amt );
		if( wep ~= "" ) then
			ply:Give( wep );
		end
		if( wep == "weapon_laserpoint" ) then
			
			umsg.Start( "msgLaserAmmoLeft", ply );
				umsg.Short( 10 );
			umsg.End();
			
			ply.LaserAmmoLeft = 10;
			
		end
		if( wep == "weapon_uvlauncher" ) then
			
			umsg.Start( "msgUVAmmoLeft", ply );
				umsg.Short( 80 );
			umsg.End();
			
			ply.UVAmmoLeft = 80;
			
		end
		itemdata[6]( ply );
		ply:SaveData();
		ply:PrintMessage( 3, "You recieved a " .. name .. "." );
		
	else
	
		ply:PrintMessage( 3, "Invalid item!" );
		
	end
	
end
concommand.Add( "pen_buyitem", buyItem );