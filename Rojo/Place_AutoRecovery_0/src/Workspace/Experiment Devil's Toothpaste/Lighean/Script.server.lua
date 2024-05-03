local Prompt = game.Workspace["Experiment Devil's Toothpaste"].Lighean.Cylinder.ProximityPrompt
local Liquid = script.Parent["Lichid Interior"]
local ExperimentStage=0
local ExperimentStep=0

-- Create a Sound instance for the error sound
local errorSound = Instance.new("Sound")
errorSound.SoundId = "rbxassetid://9113085665" -- replace with your sound id
errorSound.Parent = game.Workspace

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
		table.insert(requiredTools, "Săpun de vase")
	end
	Prompt.ActionText = "Requires Substances: " .. table.concat(requiredTools, ", ")
end

Prompt.Triggered:Connect(function(Player)
	local H2O2 = Player.Character:FindFirstChild("50%H2O2 (Peroxid de hidrogen / Apă oxigenată)") -- replace with your tool name
	local FoodColouring = Player.Character:FindFirstChild("Colorant")
	local DishSoap = Player.Character:FindFirstChild("Săpun de vase") -- replace with your tool name
	local KI = Player.Character:FindFirstChild("50%KI (Iodură de potasiu)") -- replace with your tool name


	if ExperimentStep <=3 then

		if H2O2 then  -- If the tool is in the player's hand
			if hasH2O2 == false then
				ExperimentStep+=1
				H2O2:Remove() -- Remove the tool from the player's hand
				hasH2O2 = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		elseif FoodColouring then
			if hasFoodColouring == false then
				ExperimentStep+=1
				FoodColouring:Remove() -- Remove the tool from the player's hand
				hasFoodColouring = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		elseif DishSoap then
			if hasDishSoap == false then
				ExperimentStep+=1
				DishSoap:Remove() -- Remove the tool from the player's hand
				hasDishSoap = true -- Update the variable
				IncreaseLiquidVolume()
				UpdateProximityPrompt()
			end
		else
			-- Play the error sound
			errorSound:Play()
			UpdateProximityPrompt()
			-- Update the ProximityPrompt text

		end


	end
	if ExperimentStep == 3 then
		Prompt.ActionText=("Adaugă KI (Iodură de potasiu)")
		if KI then 
			wait(0.1)
			
		end
		
	end





end)
