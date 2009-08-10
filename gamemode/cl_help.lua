function PenHelp()
	
	Help = vgui.Create( "DFrame" );
	Help:SetSize( 450, 220 );
	Help:Center();
	Help:SetTitle( "Help" );
	Help.Paint = function( self )
		
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 100 ) );
		
	end
	Help:MakePopup();

	Help.text = vgui.Create( "DLabel", Help );
	Help.text:SetPos( 8, 28 );
	Help.text:SetText( [[Penumbra is a unique gamemode where players try to eliminate as many NPCs as possible.
	What makes it unique is that the NPCs are creatures called shadows. They
	will kill you if they touch you - you don't have any second chances. However,
	you do have light, a shadow's only weakness. Use your flashlight (and other
	improvised photon emitters) to kill as many shadows as possible.
	
	In the lower right corner of your screen is three HUD elements: a money counter,
	an ammo counter and a timer. The money counter counts money. You get $1 per kill
	and lose $10 per death. The ammo counter varies depending on what weapon you
	have out. The timer represents the time of day - or rather, time to the end of
	the current day/night. During day, all shadows die and you can buy new weapons
	with F3. During night, shadows spawn randomly.
	
	Good luck, and may the flashlight be with you.]] );
	Help.text:SizeToContents();
	
end
usermessage.Hook( "PenHelp", PenHelp );