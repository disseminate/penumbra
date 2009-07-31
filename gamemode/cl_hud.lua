surface.CreateFont( "coolvetica", 40, 100, true, false, "PenumbraTextLarge" );
surface.CreateFont( "coolvetica", 20, 100, true, false, "PenumbraText" );

function GM:HUDShouldDraw( name )
	
	local nodraw = 
	{ 
		"CHudHealth",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudBattery",
	 }
	
	for k, v in pairs( nodraw ) do
	
		if( name == v ) then return false; end
	
	end

	return true;

end

function draw.ProgressBar( r, x, y, w, h, val, bg1, bg2 )
	
	draw.RoundedBox( r, x, y, w, h, bg1 );
	draw.RoundedBox( r, x + 2, y + 2, ( w - 4 ) * val, h - 4, bg2 );
	
end

function draw.GradBox( x, y, w, h, bg1, bg2 )
	
	local r1, g1, b1, a1 = bg2.r, bg2.g, bg2.b, bg2.a;
	local r2, g2, b2, a2 = bg1.r, bg1.g, bg1.b, bg1.a;
	local ri, gi, bi, ai = ( ( r2 - r1 ) / h ), ( ( g2 - g1 ) / h ), ( ( b2 - b1 ) / h ), ( ( a2 - a1 ) / h );
	for i = 1, h do
		
		draw.RoundedBox( 0, x, y + i, w, 1, Color( ri * i, gi * i, bi * i, ai * i ) );
		
	end
	
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
	surface.SetDrawColor( 0, 0, 0, 100 );
	surface.SetTextColor( 255, 255, 255, 255 );
	
	local money = LocalPlayer():Money() .. " ills";
	local x, y = surface.GetTextSize( money );
	
	surface.DrawRect( 0, 200, x + 50, y + 20 );
	surface.SetTextPos( 25, 210 );
	surface.DrawText( money );
	
end

function DrawTime()
	
	surface.SetFont( "PenumbraTextLarge" );
	surface.SetDrawColor( 0, 0, 0, 100 );
	surface.SetTextColor( 255, 255, 255, 255 );
	
	local t = "";
	if( DAY ) then
		
		t = "Day";
	
	else
		
		t = "Night";
		
	end
	
	local x, y = surface.GetTextSize( t );
	
	surface.DrawRect( ScrW() - x - 50, 200, x + 50, y + 20 );
	surface.SetTextPos( ScrW() - x - 25, 210 );
	surface.DrawText( t );
	
end

function DrawWepData() -- This code SUCKS ( as in sucks )
	
	if( LocalPlayer():Alive() ) then
		
		if( LocalPlayer():GetActiveWeapon() ) then
		
			if( LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" ) then
				
				draw.ProgressBar( 2, 0, ScrH() - 100, 200, 30, LocalPlayer():GetNWInt( "flashlightpwr" ) / 100, Color( 0, 0, 0, 200 ), Color( 220, 220, 220, 255 ) );
				draw.DrawText( math.Round( LocalPlayer():GetNWInt( "flashlightpwr" ) ) .. "%", "PenumbraText", 5, ScrH() - 95, Color( 0, 0, 0, 255 ), 0 );
				
			elseif( LocalPlayer():GetActiveWeapon():GetClass() == "weapon_glowstick" ) then
				
				local mul = 1;
				local LastGlow = LocalPlayer():GetNWInt( "LastGlowstick" );
				
				if( CurTime() - LastGlow <= 30 and CurTime() - LastGlow >= 0 ) then
					
					mul = ( 30 + -1 * ( CurTime() - LastGlow ) ) / 30;
					
				end
				
				draw.ProgressBar( 2, 0, ScrH() - 100, 200, 30, mul, Color( 0, 0, 0, 200 ), Color( 0, 200, 0, 255 ) );
				draw.DrawText( math.Round( mul * 30 ) .. "s", "PenumbraText", 5, ScrH() - 95, Color( 0, 0, 0, 255 ), 0 );
				
			elseif( LocalPlayer():GetActiveWeapon():GetClass() == "weapon_laserpoint" ) then
				
				local mul = LocalPlayer():GetActiveWeapon().AmmoLeft / 10;
				
				draw.ProgressBar( 2, 0, ScrH() - 100, 200, 30, mul, Color( 0, 0, 0, 200 ), Color( 200, 0, 0, 255 ) );
				draw.DrawText( mul * 10 .. "/10", "PenumbraText", 5, ScrH() - 95, Color( 0, 0, 0, 255 ), 0 );
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.DrawLine( ScrW() / 2 - 5, ScrH() / 2, ScrW() / 2 + 6, ScrH() / 2 );
				surface.DrawLine( ScrW() / 2, ScrH() / 2 - 5, ScrW() / 2, ScrH() / 2 + 6 );
				
			end
			
		end
		
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
		local ills = tr.Entity:Money();
		local pos = tr.Entity:EyePos():ToScreen();
		
		draw.DrawText( nick, "PenumbraTextLarge", pos.x, pos.y, Color( 255, 255, 255, 255 ), 1 );
		draw.DrawText( ills .. " ills", "PenumbraText", pos.x, pos.y + 35, Color( 255, 255, 255, 255 ), 1 );
		
	end
	
end

function GM:HUDPaint()
	
	DrawColorMod();
	DrawMoney();
	DrawTime();
	DrawWepData();
	DrawPlayerInfo();
	
end
