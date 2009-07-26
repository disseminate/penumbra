surface.CreateFont( "coolvetica", 40, 100, true, false, "PenumbraTextLarge" );
surface.CreateFont( "coolvetica", 20, 100, true, false, "PenumbraText" );
surface.CreateFont( "coolvetica", 12, 100, true, false, "PenumbraTextSmall" );

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
	
	surface.SetFont( "PenumbraText" );
	surface.SetDrawColor( 0, 0, 0, 100 );
	surface.SetTextColor( 255, 255, 255, 255 );
	
	local t = "";
	if( DAY ) then
		
		t = "Day";
	
	else
		
		t = "Night";
		
	end
	
	local x, y = surface.GetTextSize( t );
	
	surface.DrawRect( 0, 300, x + 30, y + 12 );
	surface.SetTextPos( 15, 306 );
	surface.DrawText( t );
	
end

function DrawFlashlight()
	
	draw.ProgressBar( 2, 0, ScrH() - 100, 200, 12, LocalPlayer():GetNWInt( "flashlightpwr" ) / 100, Color( 0, 0, 0, 200 ), Color( 220, 220, 220, 255 ) );
	draw.DrawText( math.Round( LocalPlayer():GetNWInt( "flashlightpwr" ) ) .. "%", "PenumbraTextSmall", 5, ScrH() - 99, Color( 0, 0, 0, 255 ), 0 );
	
end

function GM:HUDPaint()
	
	DrawColorMod();
	DrawMoney();
	DrawTime();
	DrawFlashlight();
	
end
