local food_colouring = script.Parent
local ProximityPrompt = script.Parent.pahar_berzelius.Cylinder.ProximityPrompt

local holding = false

ProximityPrompt.Triggered:Connect(function(Player)
	if not holding then
		script.Parent.Parent=Player.Backpack

		holding = true
		ProximityPrompt.Enabled=false


	end
end)
