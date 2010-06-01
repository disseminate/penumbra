if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.FOVAmt = 20;
	
end

SWEP.HoldType = "rpg";

SWEP.PrintName = "Flare Gun";

if( CLIENT ) then
	
	SWEP.Slot = 1;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl";
SWEP.ViewModel = "models/weapons/v_rpg.mdl";
SWEP.Fired = false;

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	
end

function SWEP:PrimaryAttack()
	
	if( SERVER and not self.Fired ) then
		
		self.Fired = true;
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
		self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		self:EmitSound( Sound( "weapons/grenade_launcher1.wav" ) );
		
		local gren = ents.Create( "ent_flaregunflare" );
			gren:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 50 );
			gren:Spawn();
			gren.Owner = self.Owner;
			
			local phys = gren:GetPhysicsObject();
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 1400 );
			phys:AddAngleVelocity( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) );
		
		timer.Simple( 1, function()
			
			self.Owner:StripWeapon( "weapon_flaregun" );
			
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
