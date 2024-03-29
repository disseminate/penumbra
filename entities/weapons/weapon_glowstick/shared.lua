if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.FOVAmt = 20;
	
end

SWEP.HoldType = "melee";

SWEP.PrintName = "Glowstick";

if( CLIENT ) then
	
	SWEP.Slot = 2;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "models/weapons/W_stunbaton.mdl";
SWEP.ViewModel = "models/weapons/v_stunstick.mdl";
SWEP.UsedUp = false;

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	
end

function SWEP:PrimaryAttack()
	
	if( SERVER ) then
	
		if( not self.UsedUp ) then
		
			self.Owner:IllumSelf( 150, 30 );
			
			local snds = {
				"weapons/stunstick/spark1.wav",
				"weapons/stunstick/spark2.wav",
				"weapons/stunstick/spark3.wav"
			}
			self.Owner:EmitSound( Sound( snds[math.random( 1, #snds )] ) );
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			
			umsg.Start( "msgLastGlowstick", self.Owner );
				umsg.Short( CurTime() );
			umsg.End();
			
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

function SWEP:Deploy()
	
	self:SendWeaponAnim( ACT_VM_DRAW );
	umsg.Start( "msgCurWep", self.Owner );
		umsg.String( self:GetClass() );
	umsg.End();
	
end

function SWEP:Reload()
end
