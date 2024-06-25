local PickupProximityPrompt = script.Parent.Sodiu_Model.ProximityPrompt
local tool = script.Parent

PickupProximityPrompt.Triggered:Connect(function(Player)
	-- Create a copy of the object
	local copy = tool:Clone()
	-- Remove the ProximityPrompt from the copy
	if copy.Sodiu_Model:FindFirstChild("ProximityPrompt") then
		copy.Sodiu_Model.ProximityPrompt:Remove()
	end
	-- Put the copy in the player's backpack
	copy.Parent = Player.Backpack
end)
