local PickupProximityPrompt = script.Parent.Potasiu_Model.ProximityPrompt
local tool = script.Parent

PickupProximityPrompt.Triggered:Connect(function(Player)
	-- Create a copy of the object
	local copy = tool:Clone()
	-- Remove the ProximityPrompt from the copy
	if copy.Potasiu_Model:FindFirstChild("ProximityPrompt") then
		copy.Potasiu_Model.ProximityPrompt:Remove()
	end
	-- Put the copy in the player's backpack
	copy.Parent = Player.Backpack
end)
