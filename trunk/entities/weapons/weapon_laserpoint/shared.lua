if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.FOVAmt = 20;
	
end

SWEP.HoldType = "pistol";

SWEP.PrintName = "Laser Pointer";

if( CLIENT ) then
	
	SWEP.Slot = 1;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "models/Weapons/w_pistol.mdl";
SWEP.ViewModel = "models/Weapons/v_pistol.mdl";
SWEP.Primary.Automatic = false;

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	
end

function SWEP:PrimaryAttack()
	
	if( self.Owner.LaserAmmoLeft > 0 ) then
		
		local trace = { };
		trace.start = self.Owner:EyePos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 4096;
		trace.filter = self.Owner;
		
		local tr = util.TraceLine( trace );
		
		local own = self.Owner;
	
		if( SERVER ) then
			
			self:SetNextPrimaryFire( CurTime() + 0.01 );
			
			self.Owner.LaserAmmoLeft = self.Owner.LaserAmmoLeft - 1;
			umsg.Start( "msgLaserAmmoLeft", self.Owner );
				umsg.Short( self.Owner.LaserAmmoLeft );
			umsg.End();
			
			self.Owner:EmitSound( Sound( "buttons/lightswitch2.wav" ) );
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			
			if( tr.Entity and tr.Entity:IsValid() ) then
				
				if( tr.Entity:IsShadow() ) then
					
					tr.Entity:KillShadow( self.Owner );
					
				end
				
			end
			
			if( self.Owner.LaserAmmoLeft == 0 ) then
				
				if( self.Owner:HasWeapon( "weapon_laserpoint" ) ) then
				
					self.Owner:StripWeapon( "weapon_laserpoint" );
					
				end
				
			end
			
		end
		
		local effectdata = EffectData();
				effectdata:SetOrigin( tr.HitPos );
				effectdata:SetStart( own:EyePos() );
				effectdata:SetAttachment( 1 );
				effectdata:SetEntity( self );
			util.Effect( "laserpointer", effectdata );
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
		
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
