if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.FOVAmt = 20;
	
end

SWEP.HoldType = "ar2";

SWEP.PrintName = "Ultraviolet Laser Pointer";

if( CLIENT ) then
	
	SWEP.Slot = 1;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "models/Weapons/w_irifle.mdl";
SWEP.ViewModel = "models/Weapons/v_irifle.mdl";
SWEP.Primary.Automatic = true;

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	
end

function SWEP:PrimaryAttack()
	
	if( self.Owner.UVAmmoLeft > 0 ) then
		
		local trace = { };
		trace.start = self.Owner:EyePos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 4096;
		trace.filter = self.Owner;
		
		local tr = util.TraceLine( trace );
		
		local own = self.Owner;
	
		if( SERVER ) then
			
			self:SetNextPrimaryFire( CurTime() + 0.1 );
			
			self.Owner.UVAmmoLeft = self.Owner.UVAmmoLeft - 1;
			umsg.Start( "msgUVAmmoLeft", self.Owner );
				umsg.Short( self.Owner.UVAmmoLeft );
			umsg.End();
			
			self.Owner:EmitSound( Sound( "physics/surfaces/underwater_impact_bullet3.wav" ) );
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			
			if( tr.Entity and tr.Entity:IsValid() ) then
				
				if( tr.Entity:IsShadow() ) then
					
					tr.Entity:KillShadow( self.Owner );
					
				end
				
			end
			
			if( self.Owner.UVAmmoLeft == 0 ) then
				
				if( self.Owner:HasWeapon( "weapon_uvlauncher" ) ) then
				
					self.Owner:StripWeapon( "weapon_uvlauncher" );
					
				end
				
			end
			
		end
		
		local effectdata = EffectData();
				effectdata:SetOrigin( tr.HitPos );
				effectdata:SetStart( own:EyePos() );
				effectdata:SetAttachment( 1 );
				effectdata:SetEntity( self );
			util.Effect( "uvround", effectdata );
		
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
