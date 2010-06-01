if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.FOVAmt = 20;
	
end

SWEP.HoldType = "grenade";

SWEP.PrintName = "Molotov Cocktail";

if( CLIENT ) then
	
	SWEP.Slot = 3;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "";
SWEP.ViewModel = "models/weapons/v_molotov.mdl";

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	
end

function SWEP:PrimaryAttack()
	
	if( SERVER ) then
		
		self:SendWeaponAnim( ACT_VM_THROW );
		self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		timer.Simple( 0.3, function()
			
			local gren = ents.Create( "ent_molotov" );
				gren:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 50 );
				gren:Spawn();
				gren.Owner = self.Owner;
				
				local phys = gren:GetPhysicsObject();
				phys:ApplyForceCenter( self.Owner:GetAimVector() * 700 );
				phys:AddAngleVelocity( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) );
				
				self.Owner:StripWeapon( "weapon_molotov" );
				
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
