ENT.Base = "base_ai";
ENT.Type = "ai";

ENT.PrintName 		= "Shadow";
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
