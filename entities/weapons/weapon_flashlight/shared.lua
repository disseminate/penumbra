if( SERVER ) then
	
	AddCSLuaFile( "shared.lua" );
	SWEP.HoldType = "melee";
	SWEP.FOVAmt = 20;
	
end

SWEP.PrintName = "Flashlight";

if( CLIENT ) then
	
	SWEP.Slot = 2;
	SWEP.SlotPos = 1;
	SWEP.ViewModelFOV = 50;
	SWEP.ViewModelFlip		= false	
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.DrawCrosshair = true;

end

SWEP.WorldModel = "";
SWEP.ViewModel = "";


function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	
	umsg.Start( "msgCurWep", self.Owner );
		umsg.String( self:GetClass() );
	umsg.End();
	
end

function SWEP:Reload()
end
