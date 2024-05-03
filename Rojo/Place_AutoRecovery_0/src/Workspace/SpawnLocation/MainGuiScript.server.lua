local Players = game:GetService("Players")
local prompt = game.Workspace.SpawnLocation.ProximityPrompt

prompt.Triggered:Connect(function(player)
	local ScreenGui = Players[player.Name].PlayerGui.MainScreenGui
	ScreenGui.Enabled = true
end)
