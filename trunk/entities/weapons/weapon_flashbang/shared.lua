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
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "models/Weapons/w_grenade.mdl";
SWEP.ViewModel = "models/Weapons/v_grenade.mdl";

function SWEP:PrimaryAttack()
	
	if( SERVER ) then
		
		self:SendWeaponAnim( ACT_VM_THROW );
		
		timer.Simple( 0.3, function()
			
			local gren = ents.Create( "ent_flash" );
				gren:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 50 );
				gren:Spawn();
				gren.Owner = self.Owner;
				
				local phys = gren:GetPhysicsObject();
				phys:ApplyForceCenter( self.Owner:GetAimVector() * 700 );
				phys:AddAngleVelocity( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) );
				
				self.Owner:StripWeapon( "weapon_flashbang" );
				
		end );
		
	end
	
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	
	self:SendWeaponAnim( ACT_VM_DRAW );
	umsg.Start( "msgCurWep", self.Owner );
		umsg.String( self:GetClass() );
	umsg.End();
	
end

function SWEP:Reload()
end
