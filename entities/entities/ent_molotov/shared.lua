ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName 		= "Molotov Cocktail";
ENT.Author			= "Disseminate";
ENT.Contact 		= "";
ENT.Information		= "";
ENT.Category		= "Penumbra";

ENT.Spawnable 				= false;
ENT.AdminSpawnable 			= true;

ENT.AutomaticFrameAdvance 	= true;


function ENT:PhysicsCollide( data, physobj )
end
 

function ENT:PhysicsUpdate( physobj )
end


function ENT:SetAutomaticFrameAdvance( bUsingAnim )

	self.AutomaticFrameAdvance = bUsingAnim;

end
