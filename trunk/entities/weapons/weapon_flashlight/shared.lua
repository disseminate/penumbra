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
	
	SWEP.DrawCrosshair = false;

end

SWEP.WorldModel = "";
SWEP.ViewModel = "";


function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
