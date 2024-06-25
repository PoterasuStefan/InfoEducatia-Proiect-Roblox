local LigheanModel = game.Workspace["Alkali Metals"].Lighean
LigheanModel.PrimaryPart = LigheanModel.Cylinder -- Set the PrimaryPart of the model to the Cylinder
local Prompt =script.Parent["Lichid Interior"].ProximityPrompt
local Lichid_Interior = script.Parent["Lichid Interior"]

-- Create the error sound
local errorSound = Instance.new("Sound")
errorSound.SoundId = "rbxassetid://9113085665" -- replace with your sound id
errorSound.Parent = game.Workspace

local reactionSound = Instance.new("Sound")
reactionSound.SoundId = "rbxassetid://17408685066" -- replace with your sound id
reactionSound.Parent = game.Workspace

local InitialSplashSound = Instance.new("Sound")
InitialSplashSound.SoundId = "rbxassetid://17414763085" -- replace with your sound id
InitialSplashSound.Parent = game.Workspace

local tools = {
	Potasiu = {
		model = game.Workspace["Alkali Metals"].Potasiu.Potasiu_Model,
		handle = game.Workspace["Alkali Metals"].Potasiu.Handle,
		Tool =game.Workspace["Alkali Metals"].Potasiu
		-- Add other properties specific to this tool
	},
	Litiu = {
		model=game.Workspace["Alkali Metals"].Litiu.Litiu_Model,
		handle=game.Workspace["Alkali Metals"].Litiu.Handle,
		Tool=game.Workspace["Alkali Metals"].Litiu
	},
	Sodiu = {
		model=game.Workspace["Alkali Metals"].Sodiu.Sodiu_Model,
		handle=game.Workspace["Alkali Metals"].Sodiu.Handle,
		Tool=game.Workspace["Alkali Metals"].Sodiu
	}
}

-- Function to shrink the tool
local function shrinkTool(tool)
	for i = 1, 50 do
		tool.model.Size = tool.model.Size - Vector3.new(0.01, 0.01, 0.01) -- decrease the size
		wait(0.2) -- wait for 0.5 seconds
	end
	tool.model:Remove() -- remove the tool after it has shrunk
end

-- Function to drop the tool
local function dropTool(player, tool)

	-- Check if the player is holding the correct tool
	local toolInBackpack = player.Backpack:FindFirstChild(tool.model.Parent.Name)
	local toolInCharacter = player.Character:FindFirstChild(tool.model.Parent.Name)

	if toolInBackpack or toolInCharacter then
		print("Correct tool detected. Proceeding with drop.")
		--Make the tool that the player is currently holding become a child of workspace
		tool.Tool.Parent = game.Workspace
		tool.handle.CFrame = Lichid_Interior.CFrame + Vector3.new(0, 1.5, 0) -- position it 10 cm above the model

		-- Prevent the player from picking up the tool
		tool.CanBeDropped = false
		tool.RequiresHandle = false

		Prompt.Enabled = false
		reactionSound.Playing=true
		InitialSplashSound.Playing=true

		wait(0.5)

		LigheanModel["Lichid Interior"].BrickColor=BrickColor.new(Color3.fromRGB(125, 0, 119))
		tool.model.BrickColor = BrickColor.new(Color3.fromRGB(255, 89, 89)) -- set the color to 255, 89, 89
		tool.model.Material = Enum.Material.Neon -- set the material to Neon

		tool.model.Fire.Enabled=true
		Lichid_Interior["Innitial Blast"].Enabled=true
		Lichid_Interior.Smoke.Enabled=true
		Lichid_Interior.Sparks.Enabled=true

		wait(1)
		Lichid_Interior["Innitial Blast"].Enabled=false

		-- Start shrinking the tool
		shrinkTool(tool)

		Lichid_Interior.Smoke.Enabled=false
		Lichid_Interior.Sparks.Enabled=false

		-- Wait for 10 seconds
		wait(10)

		-- Enable the Proximity Prompt
		Prompt.Enabled = true
	else
		-- Play the error sound
		print("Wrong tool")

		errorSound:Play()
	end
end

Prompt.Triggered:Connect(function(Player)
	local correctToolFound = false

	-- Get the tool the player is currently holding
	local heldTool = Player.Character:FindFirstChildWhichIsA('Tool')

	if heldTool then
		-- Check if the held tool is in the tools table
		local tool = tools[heldTool.Name]

		if tool then
			dropTool(Player, tool)
			correctToolFound = true
		end
	end

	if not correctToolFound then
		print("Wrong tool")
		errorSound:Play()
	end
end)


