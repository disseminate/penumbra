surface.CreateFont( "coolvetica", 40, 100, true, false, "PenumbraTextLarge" );
surface.CreateFont( "coolvetica", 30, 100, true, false, "PenumbraTextMed" );
surface.CreateFont( "coolvetica", 20, 100, true, false, "PenumbraText" );

function GM:HUDShouldDraw( name )
	
	local nodraw = 
	{ 
		"CHudHealth",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudBattery",
	 }
	
	for _, v in pairs( nodraw ) do
	
		if( name == v ) then return false; end
	
	end

	return true;

end

function draw.ProgressBar( r, x, y, w, h, val, bg1, bg2 )
	
	draw.RoundedBox( r, x, y, w, h, bg1 );
	draw.RoundedBox( r, x, y + ( h / 2 ), w, h / 2, Color( 255, 255, 255, 20 ) ); -- shiny
	draw.RoundedBox( r, x + 2, y + 2, ( w - 4 ) * val, h - 4, bg2 );
	
end

function DrawColorMod()
	
	if( DAY ) then
		
		local mul = 1;
		
		if( CurTime() - DAY_LASTTRANS <= 3 ) then
		
			local timeSinceLast = math.Clamp( CurTime() - DAY_LASTTRANS, 0, 3 );
			mul = timeSinceLast / 3;
			
		end
		
		local tab = {}
		
		tab[ "$pp_colour_addr" ] = 0;
		tab[ "$pp_colour_addg" ] = 0;
		tab[ "$pp_colour_addb" ] = 0;
		tab[ "$pp_colour_brightness" ] = 0.06 * mul;
		tab[ "$pp_colour_contrast" ] = 1 + ( 1.54 * mul );
		tab[ "$pp_colour_colour" ] = 1;
		tab[ "$pp_colour_mulr" ] = 0;
		tab[ "$pp_colour_mulg" ] = 0; 
		tab[ "$pp_colour_mulb" ] = 0;
		
		DrawColorModify( tab );
		
	elseif( CurTime() - DAY_LASTTRANS <= 3 ) then
		
		local timeSinceLast = math.Clamp( CurTime() - DAY_LASTTRANS, 0, 3 );
		local mul = ( -timeSinceLast + 3 ) / 3;
		
		local tab = {}
		
		tab[ "$pp_colour_addr" ] = 0;
		tab[ "$pp_colour_addg" ] = 0;
		tab[ "$pp_colour_addb" ] = 0;
		tab[ "$pp_colour_brightness" ] = 0.06 * mul;
		tab[ "$pp_colour_contrast" ] = 1 + ( 1.54 * mul );
		tab[ "$pp_colour_colour" ] = 1;
		tab[ "$pp_colour_mulr" ] = 0;
		tab[ "$pp_colour_mulg" ] = 0; 
		tab[ "$pp_colour_mulb" ] = 0;
		
		DrawColorModify( tab );
		
	end

end

function DrawMoney()
	
	surface.SetFont( "PenumbraTextLarge" );
	surface.SetDrawColor( 0, 0, 0, 200 );
	surface.SetTextColor( 255, 255, 255, 255 );
	
	local money = "$" .. LocalPlayer():Money();
	local x, y = surface.GetTextSize( money );
	
	surface.DrawRect( ScrW() - x - 50 - 5, ScrH() - y - 20 - 35 - 30, x + 50, y + 20 ); -- oh god.
	surface.SetDrawColor( 255, 255, 255, 20 );
	surface.DrawRect( ScrW() - x - 50 - 5, ScrH() - y - 20 - 35 - 30 + ( ( y + 20 ) / 2 ), x + 50, ( y + 20 ) / 2 );
	surface.SetTextPos( ScrW() - x - 50 - 5 + 25, ScrH() - y - 20 - 35 - 30 + 10 );
	surface.DrawText( money );
	
end

function DrawTime()
	
	if( DAY ) then
		
		draw.ProgressBar( 2, ScrW() - 205, ScrH() - 35, 200, 30, -( SEC / DAY_LEN ) + 1, Color( 0, 0, 0, 200 ), Color( 255, 255, 190, 255 ) );
		draw.DrawText( string.sub( string.ToMinutesSeconds( -SEC + DAY_LEN ), 2 ), "PenumbraText", ScrW() - 200, ScrH() - 30, Color( 0, 0, 0, 255 ), 0 );
		
	else
		
		draw.ProgressBar( 2, ScrW() - 205, ScrH() - 35, 200, 30, SEC / NIGHT_LEN, Color( 0, 0, 0, 200 ), Color( 255, 255, 190, 255 ) );
		draw.DrawText( string.sub( string.ToMinutesSeconds( -SEC + NIGHT_LEN ), 2 ), "PenumbraText", ScrW() - 200, ScrH() - 30, Color( 0, 0, 0, 255 ), 0 );
		
	end
	
end

function DrawWepData() -- This code SUCKS ( as in sucks )
	
	local barX = ScrW() - 205;
	local barY = ScrH() - 35 - 30;
	
	local class = LocalPlayer():GetNWString( "CurWep" ); -- Hack.
	
	if( class == "weapon_flashlight" ) then
		
		draw.ProgressBar( 2, barX, barY, 200, 30, LocalPlayer():GetNWInt( "flashlightpwr" ) / LocalPlayer():GetNWInt( "MaxFlashlight" ), Color( 0, 0, 0, 200 ), Color( 220, 220, 220, 255 ) );
		draw.DrawText( math.Round( LocalPlayer():GetNWInt( "flashlightpwr" ) / LocalPlayer():GetNWInt( "MaxFlashlight" ) * 100 ) .. "%", "PenumbraText", barX + 5, barY + 5, Color( 0, 0, 0, 255 ), 0 );
		
	elseif( class == "weapon_glowstick" ) then
		
		local mul = 1;
		local LastGlow = LocalPlayer():GetNWInt( "LastGlowstick" );
		
		if( CurTime() - LastGlow <= 30 and CurTime() - LastGlow >= 0 ) then
			
			mul = ( 30 + -1 * ( CurTime() - LastGlow ) ) / 30;
			
		end
		
		draw.ProgressBar( 2, barX, barY, 200, 30, mul, Color( 0, 0, 0, 200 ), Color( 0, 200, 0, 255 ) );
		draw.DrawText( math.Round( mul * 30 ) .. "s", "PenumbraText", barX + 5, barY + 5, Color( 0, 0, 0, 255 ), 0 );
		
	elseif( class == "weapon_laserpoint" ) then
		
		local mul = LocalPlayer():GetNWInt( "LaserAmmoLeft" ) / 10;
		
		draw.ProgressBar( 2, barX, barY, 200, 30, mul, Color( 0, 0, 0, 200 ), Color( 200, 0, 0, 255 ) );
		draw.DrawText( mul * 10 .. "/10", "PenumbraText", barX + 5, barY + 5, Color( 0, 0, 0, 255 ), 0 );
		
	elseif( class == "weapon_flashbang" ) then
		
		draw.ProgressBar( 2, barX, barY, 200, 30, 1, Color( 0, 0, 0, 200 ), Color( 200, 200, 0, 255 ) );
		draw.DrawText( "1 Flashbang", "PenumbraText", barX + 5, barY + 5, Color( 0, 0, 0, 255 ), 0 );
		
	elseif( class == "weapon_molotov" ) then
		
		draw.ProgressBar( 2, barX, barY, 200, 30, 1, Color( 0, 0, 0, 200 ), Color( 255, 100, 0, 255 ) );
		draw.DrawText( "1 Molotov Cocktail", "PenumbraText", barX + 5, barY + 5, Color( 0, 0, 0, 255 ), 0 );
		
	end
	
end

function DrawPlayerInfo()
	
	local trace = { };
	trace.start = LocalPlayer():EyePos();
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 4096;
	trace.filter = LocalPlayer();
	
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
		
		local nick = tr.Entity:Nick();
		local money = tr.Entity:Money();
		local pos = tr.Entity:EyePos():ToScreen();
		
		draw.DrawText( nick, "PenumbraTextLarge", pos.x, pos.y, Color( 255, 255, 255, 255 ), 1 );
		draw.DrawText( "$" .. money, "PenumbraText", pos.x, pos.y + 35, Color( 255, 255, 255, 255 ), 1 );
		
	end
	
end

function DrawScoreboard()
	
	if( SCOREBOARD ) then
	
		local ORIGINX = ScrW() / 2;
		local ORIGINY = ScrH() / 2 - 200;
		
		local y = ( ORIGINY ) + ( math.cos( math.rad( 180 ) ) * math.sin( CurTime() ) * 10 );
		draw.DrawText( "Penumbra", "PenumbraTextLarge", ScrW() / 2, y - 100, Color( 255, 255, 255, 255 ), 1 );
		draw.DrawText( "By Disseminate", "PenumbraText", ScrW() / 2, y - 70, Color( 255, 255, 255, 255 ), 1 );
		
		surface.SetFont( "PenumbraText" );
		surface.SetTextColor( 255, 255, 255, 255 );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawRect( ORIGINX - 300, y - 40, 600, 30 );
		
		surface.SetTextPos( ORIGINX - 290, y - 35 );
		surface.DrawText( "Name" );
		
		surface.SetTextPos( ORIGINX + 100, y - 35 );
		surface.DrawText( "Money" );
		
		surface.SetTextPos( ORIGINX + 160, y - 35 );
		surface.DrawText( "Ping" );
		
		local off = 20;
		local i = 0;
		
		for _, v in pairs( player.GetAll() ) do
			
			local basex = ORIGINX - 300;
			local basey = y + off + ( i * 35 );
			
			if( i % 2 == 0 ) then
				surface.SetDrawColor( 0, 0, 0, 100 );
			else
				surface.SetDrawColor( 0, 0, 0, 50 );
			end
			
			surface.DrawRect( basex, basey, 600, 30 );
			
			surface.SetTextPos( basex + 10, basey + 5 );
			surface.DrawText( v:Nick() );
			
			surface.SetTextPos( basex + 400, basey + 5 );
			surface.DrawText( v:Money() );
			
			surface.SetTextPos( basex + 460, basey + 5 );
			surface.DrawText( v:Ping() );
			
			i = i + 1;
			
		end
		
	end
	
end

function GM:HUDPaint()
	
	DrawColorMod();
	DrawMoney();
	DrawTime();
	DrawWepData();
	DrawPlayerInfo();
	DrawScoreboard();
	
end
