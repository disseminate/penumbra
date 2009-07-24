if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.HoldType = "melee";
	SWEP.FOVAmt = 20;
	
end

SWEP.PrintName = "Glowstick";

if( CLIENT ) then
	
	SWEP.Slot = 2;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = false;

end

SWEP.WorldModel = "models/weapons/W_stunbaton.mdl";
SWEP.ViewModel = "models/weapons/v_stunstick.mdl";
SWEP.UsedUp = false;

function SWEP:PrimaryAttack()
	
	if( SERVER ) then
	
		if( not self.UsedUp ) then
		
			self.Owner:IllumSelf( 150, 30 );
			self.UsedUp = true;
			
		end
		
		local own = self.Owner;
		
		timer.Simple( 30, function()
			
			if( own:HasWeapon( "weapon_glowstick" ) ) then
			
				own:StripWeapon( "weapon_glowstick" );
				
			end
			
		end );
		
	end
	
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end