local prompt = game.Workspace["Elephant Toothpaste Experiment"].ElephantToothpasteflask.ProximityPrompt
local ball = game.Workspace["Elephant Toothpaste Experiment"].ElephantFoam
local ground = game.Workspace.Ground
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
-- When the prompt is triggered, clone the ball 100 times, shoot them out, and let them fall to the ground
prompt.Triggered:Connect(function()
    for i = 1, 100 do
        local clone = ball:Clone()
        clone.Parent = game.Workspace
        clone.Velocity = Vector3.new(math.random(-50, 50), math.random(100, 200), math.random(-50, 50)) -- shoot out in a random direction
        clone.Anchored = false -- let the clone fall to the ground
        clone.CanCollide = false -- prevent the clones from interacting with each other
        clone.Touched:Connect(function(hit)
			if hit == ground then
				wait(0.15)-- if the clone touches a part (like the ground)
				clone.Anchored = true
				wait(10)
				local tweenInfo = TweenInfo.new(10) -- duration of 10 seconds
				local goal = {Size = Vector3.new(0, 0, 0)} -- target size
				local tween = TweenService:Create(clone, tweenInfo, goal)

				-- Start the Tween
				tween:Play()

				-- Schedule the clone to be removed after 10 seconds
				Debris:AddItem(clone, 10)-- make the clone stay still
            end
        end)
        local sizeMultiplier = math.random(70, 140) / 100 -- randomize the size from 0.7x to 1.4x the original
        clone.Size = clone.Size * sizeMultiplier
        wait(0.01) -- wait a little bit before creating the next clone
    end
end)