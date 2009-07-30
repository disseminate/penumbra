function EFFECT:Init(data)

	local numParts = 60;
	local ePos = data:GetOrigin();
	local emitter = ParticleEmitter( ePos );
	
	for j = 1, numParts do
	
		local particle = emitter:Add( "sprites/shadow", ePos );
		
		if( particle ) then
			
			particle:SetColor( 100, 100, 100, 255 );
			particle:SetGravity( Vector( 0, 0, -60 ) );
			particle:SetVelocity( Vector( math.random( -20, 20 ), math.random( -20, 20 ), math.random( 100, 300 ) ) );
			particle:SetLifeTime( 0 );
			particle:SetDieTime( 10 );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 255 );
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