local Players = game:GetService("Players")
local prompt = game.Workspace.carti.InvisiblePart.ProximityPromptBook

prompt.Triggered:Connect(function(player)
	local ComputerScienceLessonsGui = Players[player.Name].PlayerGui.ComputerScienceLessonsGui
	ComputerScienceLessonsGui.Enabled = true
end)
