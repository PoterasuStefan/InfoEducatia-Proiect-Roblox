local prompt = game.Workspace["Elephant Toothpaste Experiment"].ElephantToothpasteflask.ProximityPrompt
local part = game.Workspace["Elephant Toothpaste Experiment"].ElephantToothpasteflask
local particles = game.Workspace["Elephant Toothpaste Experiment"].ElephantToothpasteflask.ParticleEmitter
local i=0
particles.Enabled=false

prompt.Triggered:Connect(function()
	particles.Enabled=true
	wait(5)
	
	particles.Enabled=false
	
end)