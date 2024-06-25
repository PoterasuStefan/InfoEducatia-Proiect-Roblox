local TweenService = game:GetService("TweenService")

local Prompt = game.Workspace["Experiment Devil's Toothpaste"].Lighean.Cylinder.ProximityPrompt
local Liquid = script.Parent["Lichid Interior"]
local Foam = script.Parent.Foam

local ExperimentStage=0
local ExperimentStep=0

-- Create a Sound instance for the error sound
local errorSound = Instance.new("Sound")
errorSound.SoundId = "rbxassetid://9113085665" -- replace with your sound id
errorSound.Parent = game.Workspace

local SteamSfx = Instance.new("Sound")
SteamSfx.SoundId = "rbxassetid://17511074529" -- replace with your sound id
SteamSfx.Parent = game.Workspace

local WaterSfx = Instance.new("Sound")
WaterSfx.SoundId = "rbxassetid://17511063840" -- replace with your sound id
WaterSfx.Parent = game.Workspace

local hasH2O2 = false
local hasFoodColouring = false
local hasDishSoap = false

Liquid.Transparency=100

local function IncreaseLiquidVolume()
	if(Liquid.Transparency==100) then
		Liquid.Transparency=0.3
	end
	Liquid.Size = Liquid.Size + Vector3.new(0.05, 0, 0)
	Liquid.Position = Liquid.Position + Vector3.new(0, 0.025, 0)
end

local function UpdateProximityPrompt()
	local requiredTools = {}
	if not hasH2O2 then
		table.insert(requiredTools, "50%H2O2")
	end
	if not hasFoodColouring then
		table.insert(requiredTools, "Colorant")
	end
	if not hasDishSoap then
		table.insert(requiredTools, "Sapun de vase")
	end
	Prompt.ActionText = "Requires Substances: " .. table.concat(requiredTools, ", ")
end

-- Original and target size
local originalSize = Vector3.new(0.364, 0.387, 0.507)
local targetSize = Vector3.new(7.587, 8.059, 10.579)

-- Create a TweenInfo for growing
local growTweenInfo = TweenInfo.new(
	0.5, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.InOut, -- EasingDirection
	0, -- RepeatCount (0 implies the tween will play indefinitely)
	false, -- Reverses (tween will reverse and repeat from the beginning)
	0 -- DelayTime
)

-- Create a TweenInfo for shrinking
local shrinkTweenInfo = TweenInfo.new(
	10, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.InOut, -- EasingDirection
	0, -- RepeatCount (0 implies the tween will play indefinitely)
	false, -- Reverses (tween will reverse and repeat from the beginning)
	0 -- DelayTime
)

-- Create the Tween for growing
local growTween = TweenService:Create(Foam, growTweenInfo, {Size = targetSize})

-- Create the Tween for shrinking
local shrinkTween = TweenService:Create(Foam, shrinkTweenInfo, {Size = originalSize})

-- Function to start the Tween
local function startTween()
	growTween:Play()
end

-- Function to reverse the Tween
local function reverseTween()
	shrinkTween:Play()
end

Prompt.Triggered:Connect(function(Player)
	local H2O2 = Player.Character:FindFirstChild("50%H2O2 (Peroxid de hidrogen / Apa oxigenata)") -- replace with your tool name
	local FoodColouring = Player.Character:FindFirstChild("Colorant")
	local DishSoap = Player.Character:FindFirstChild("Sapun de vase") -- replace with your tool name
	local KI = Player.Character:FindFirstChild("50%KI (Iodura de potasiu)") -- replace with your tool name

	if ExperimentStep <=3 then
		if H2O2 then  -- If the tool is in the player's hand
			if hasH2O2 == false then
				WaterSfx:Play()
				ExperimentStep+=1
				H2O2:Remove() -- Remove the tool from the player's hand
				hasH2O2 = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		elseif FoodColouring then
			if hasFoodColouring == false then
				WaterSfx:Play()

				ExperimentStep+=1
				FoodColouring:Remove() -- Remove the tool from the player's hand
				hasFoodColouring = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		elseif DishSoap then
			if hasDishSoap == false then
				WaterSfx:Play()

				ExperimentStep+=1
				DishSoap:Remove() -- Remove the tool from the player's hand
				hasDishSoap = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		elseif not KI then
			-- Play the error sound
			errorSound:Play()
			UpdateProximityPrompt()
			-- Update the ProximityPrompt text
		end
	end
	if ExperimentStep == 3 then
		Prompt.ActionText=("Adauga KI (Iodura de potasiu)")
		if KI then 
			Foam.Transparency=0
			KI:Remove()
			print("Adding KI")
			SteamSfx:Play()
			-- Start the Tween
			startTween()
			wait(10)
			-- Reverse the Tween
			reverseTween()
			wait(10)
			ExperimentStep=0
			hasH2O2 = false
			hasFoodColouring = false
			hasDishSoap = false
			UpdateProximityPrompt()
			Foam.Transparency=1
		end
	end
end)
