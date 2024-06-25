local food_colouring = script.Parent
local ProximityPrompt = script.Parent["Round Bottom Glass"].Cylinder.ProximityPrompt

ProximityPrompt.Triggered:Connect(function(Player)
	-- Create a copy of the object
	local copy = food_colouring:Clone()
	-- Remove the ProximityPrompt from the copy
	if copy["Round Bottom Glass"].Cylinder:FindFirstChild("ProximityPrompt") then
		copy["Round Bottom Glass"].Cylinder.ProximityPrompt:Remove()
	end
	for _, part in ipairs(copy:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
		end
	end
	-- Put the copy in the player's backpack
	copy.Parent = Player.Backpack
end)
