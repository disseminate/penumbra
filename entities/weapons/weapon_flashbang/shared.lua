if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.HoldType = "grenade";
	SWEP.FOVAmt = 20;
	
end

SWEP.PrintName = "Flashbang";

if( CLIENT ) then
	
	SWEP.Slot = 3;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = false;

end

SWEP.WorldModel = "models/Weapons/w_grenade.mdl";
SWEP.ViewModel = "models/Weapons/v_grenade.mdl";

function SWEP:PrimaryAttack()
	
	if( SERVER ) then
		
		local gren = ents.Create( "ent_flash" );
			gren:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 50 );
			gren:Spawn();
			gren.Owner = self.Owner;
			
			local phys = gren:GetPhysicsObject();
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 700 );
			
			self.Owner:StripWeapon( "weapon_flashbang" );
		
	end
	
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
