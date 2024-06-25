local food_colouring = script.Parent
local ProximityPrompt = script.Parent["eprubeta (1)"].EprubetaModel.ProximityPrompt

ProximityPrompt.Triggered:Connect(function(Player)
	-- Create a copy of the object
	local copy = food_colouring:Clone()
	-- Remove the ProximityPrompt from the copy
	if copy["eprubeta (1)"].EprubetaModel:FindFirstChild("ProximityPrompt") then
		copy["eprubeta (1)"].EprubetaModel.ProximityPrompt:Remove()
	end
	-- Disable anchor of clone
	for _, part in ipairs(copy:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
		end
	end
	-- Put the copy in the player's backpack
	copy.Parent = Player.Backpack
end)
