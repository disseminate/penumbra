function EFFECT:Init(data)

	local numParts = 60;
	local ePos = data:GetOrigin();
	local emitter = ParticleEmitter( ePos );
	
	for j = 1, numParts do
	
		local particle = emitter:Add( "penumbra/shadow", ePos );
		
		if( particle ) then
			
			particle:SetColor( 50, 50, 50 );
			particle:SetVelocity( Vector( math.random( -300, 300 ), math.random( -300, 300 ), math.random( 100, 300 ) ) );
			particle:SetAirResistance( 150 );
			particle:SetLifeTime( 0 );
			particle:SetDieTime( 5 );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( 30 );
			particle:SetEndSize( 30 );
			
		end
		
	end
	emitter:Finish();
end

function EFFECT:Think()
	return false;
end

function EFFECT:Render()
end