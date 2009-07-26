surface.CreateFont( "coolvetica", 12, 400, true, false, "BasicTestFont" );

function ScaleLines( text, width )
	
	local modtext = text;
	surface.SetFont( "BasicTestFont" );
	local x, y = surface.GetTextSize( "m" );
	
	local amtLetters = string.len( modtext );
	local curWidth = 0;
	
	for i = 1, amtLetters do
		
		curWidth = curWidth + x;
		
		if( curWidth > width ) then
			
			curWidth = 0;
			local str1 = string.sub( modtext, 1, i - 1 );
			local str2 = string.sub( modtext, i );
			modtext = str1 .. "\n" .. str2;
			
		end
		
	end
	
	return modtext;
	
end

function msgBuyMenu()
	
	BuyPanel = vgui.Create( "DFrame" );
	BuyPanel:SetSize( 300, 500 );
	BuyPanel:Center();
	BuyPanel:SetTitle( "Buy Menu" );
	BuyPanel:MakePopup();
	
	BuyPanel.List = vgui.Create( "DPanelList", BuyPanel );
	BuyPanel.List:SetPos( 25, 45 );
	BuyPanel.List:SetSize( 250, 430 );
	BuyPanel.List:EnableHorizontal( false );
	BuyPanel.List:EnableVerticalScrollbar( true );
	BuyPanel.List:SetSpacing( 15 );
	
	for k, v in pairs( BUY_ITEMS ) do
		
		BuyPanel.List[v[1]] = vgui.Create( "DPanel", BuyPanel.List );
		BuyPanel.List[v[1]]:SetSize( 250, 64 );
		
		BuyPanel.List[v[1]].Icon = vgui.Create( "SpawnIcon", BuyPanel.List[v[1]] );
		BuyPanel.List[v[1]].Icon:SetPos( 0, 0 );
		BuyPanel.List[v[1]].Icon:SetSize( 64, 64 );
		BuyPanel.List[v[1]].Icon:SetModel( v[5] );
		BuyPanel.List[v[1]].Icon.DoClick = function()
			
			LocalPlayer():ConCommand( "pen_buyitem \"" .. v[1] .. "\"\n" );
			
		end
		
		BuyPanel.List[v[1]].Name = vgui.Create( "DLabel", BuyPanel.List[v[1]] );
		BuyPanel.List[v[1]].Name:SetPos( 70, 5 );
		BuyPanel.List[v[1]].Name:SetText( v[1] );
		BuyPanel.List[v[1]].Name:SizeToContents();
		
		BuyPanel.List[v[1]].Desc = vgui.Create( "DLabel", BuyPanel.List[v[1]] );
		BuyPanel.List[v[1]].Desc:SetPos( 70, 20 );
		BuyPanel.List[v[1]].Desc:SetText( ScaleLines( v[2], 250 ) );
		BuyPanel.List[v[1]].Desc:SizeToContents();
		
		BuyPanel.List[v[1]].Cost = vgui.Create( "DLabel", BuyPanel.List[v[1]] );
		BuyPanel.List[v[1]].Cost:SetPos( 220, 5 );
		BuyPanel.List[v[1]].Cost:SetText( v[3] .. " ills" );
		BuyPanel.List[v[1]].Cost:SizeToContents();
		
		BuyPanel.List:AddItem( BuyPanel.List[v[1]] );
		
	end
	
end
usermessage.Hook( "msgBuyMenu", msgBuyMenu );