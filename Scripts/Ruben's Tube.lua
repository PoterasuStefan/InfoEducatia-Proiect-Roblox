-- Script for cloning and positioning TubeSection
local tubeSection = game.Workspace["Ruben's tube"]["Metal Tube"] -- Adjust path as necessary
local tubeLength = tubeSection.Size.Z  -- Assuming the tube extends along the Z axis
local PlaceholderPart = script.Parent.PlaceholderPart
local PitchGui = game.StarterGui.PitchGui
local VolumeMeter = PitchGui.SurfaceGui.Frame
local pitchTextDisplay = game.StarterGui.PitchGui.SurfaceGui.Frame.PitchTextDisplay -- Adjust path as necessary
local ContinuousSound = script.Parent.ContinuousSound
local continuousSound = game.Workspace["Ruben's tube"].ContinuousSound

-- Server-side Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Get the RemoteEvent
local FireToggleEvent = ReplicatedStorage:WaitForChild("FireToggleEvent")
local IncreasePitchEvent = ReplicatedStorage:WaitForChild("IncreasePitchEvent")
local LowerPitchEvent = ReplicatedStorage:WaitForChild("LowerPitchEvent")

local GetPitchTextFunction = Instance.new("RemoteFunction")
GetPitchTextFunction.Name = "GetPitchTextFunction"
GetPitchTextFunction.Parent = ReplicatedStorage


-- Create a PitchShiftSoundEffect
local pitchShift = Instance.new("PitchShiftSoundEffect")
pitchShift.Octave = 1 -- Change this value to shift the pitch
pitchShift.Parent = ContinuousSound

local GoingUp = true
local WaveLength = 1
local CurrentLifetime = 0
local WaveStep = 0.15
local MinimumLifespan = 0.05
local tubePieces = 34

local fireStarted = false -- Flag to track if fire is started





for i = 1, tubePieces do -- We already have one section, so we clone tubePieces more
	local clonedSection = tubeSection:Clone()
	clonedSection.Parent = game.Workspace["Ruben's tube"] -- Adjust destination as necessary
	clonedSection.Name = "TubeSection" .. i
	clonedSection.Position = Vector3.new(tubeSection.Position.X - tubeLength * i, tubeSection.Position.Y, tubeSection.Position.Z) -- Adjust as necessary
	for _, child in ipairs(clonedSection:GetChildren()) do
		if child.Name == "FirePart" or child.Name == "HoleForFire" then
			child.Position = child.Position + Vector3.new(-tubeLength*i, 0, 0) -- Adjust as necessary
		end
	end
end


-- Your loop code here
for i = 1, tubePieces do -- Assuming we have 50 sections now including original and clones
	local currentTubeSection = game.Workspace["Ruben's tube"]["TubeSection" .. (i)] -- Adjust path as necessary

	if currentTubeSection then 
		local Fire = currentTubeSection.FirePart.Fire -- Set Fire variable inside the loop
		if GoingUp and CurrentLifetime < WaveLength then
			CurrentLifetime+=WaveStep
			Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
			print("rise")

		end

		if GoingUp and CurrentLifetime >= WaveLength then
			CurrentLifetime+=WaveStep
			Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
			GoingUp=false
		end

		if not GoingUp and CurrentLifetime>MinimumLifespan then
			CurrentLifetime-=WaveStep
			Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
		end	

		if not GoingUp and CurrentLifetime<=MinimumLifespan then
			CurrentLifetime-=WaveStep
			Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
			GoingUp=true		
			print("fall")
		end




	end	


end



-- Add a variable to track if the button has been pressed
local isFirstPress = true
local function toggleFire(player)
	print("togglefire")
	
	
	

	-- Get all TubeSections
	local tubeSections = game.Workspace["Ruben's tube"]:GetChildren()

	-- Loop through each TubeSection
	for _, tubeSection in ipairs(tubeSections) do
		if tubeSection.Name:match("TubeSection%d") then -- Check if the name matches "TubeSection" followed by a number
			-- Check if the TubeSection has a FirePart
			local firePart = tubeSection:FindFirstChild("FirePart")
			if firePart then
				-- Check if the FirePart has a Fire object
				local fire = firePart:FindFirstChildOfClass("ParticleEmitter")
				if fire then
					print("disablefire")
					-- Toggle the Enabled property of the Fire object
					fire.Enabled = not fire.Enabled
				end
			end
		end
	end

	if isFirstPress then
		-- Your loop code here
		for i = 1, tubePieces do
			-- ...
		end
		isFirstPress = false
	end

	local continuousSound = game.Workspace["Ruben's tube"].ContinuousSound
	if continuousSound.IsLoaded then -- Check if the sound is fully loaded
		if continuousSound.IsPlaying then 
			continuousSound:Stop()
		else 
			continuousSound:Play()
		end
	else
		print("Sound is not fully loaded yet.")
	end
end

local tubeSections = game.Workspace["Ruben's tube"]:GetChildren()

-- Loop through each TubeSection
for _, tubeSection in ipairs(tubeSections) do
	if tubeSection.Name:match("TubeSection%d") then -- Check if the name matches "TubeSection" followed by a number
		-- Check if the TubeSection has a FirePart
		local firePart = tubeSection:FindFirstChild("FirePart")
		if firePart then
			-- Check if the FirePart has a Fire object
			local fire = firePart:FindFirstChildOfClass("ParticleEmitter")
			if fire then
				print("disablefire")
				-- Toggle the Enabled property of the Fire object
				fire.Enabled = not fire.Enabled
			end
		end
	end
end


local function increasePitch(player)
	print("increasepitch")
	
	-- Script for setting fixed lifetime properties per FirePart in each TubeSection
	for i = 1, tubePieces do -- Assuming we have 50 sections now including original and clones
		local currentTubeSection = game.Workspace["Ruben's tube"]["TubeSection" .. (i)] -- Adjust path as necessary

		if currentTubeSection then 
			local Fire = currentTubeSection.FirePart.Fire -- Set Fire variable inside the loop
			if GoingUp and CurrentLifetime < WaveLength then
				CurrentLifetime+=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				print("rise")

			end

			if GoingUp and CurrentLifetime >= WaveLength then
				CurrentLifetime+=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				GoingUp=false
			end

			if not GoingUp and CurrentLifetime>MinimumLifespan then
				CurrentLifetime-=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
			end	

			if not GoingUp and CurrentLifetime<=MinimumLifespan then
				CurrentLifetime-=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				GoingUp=true		
				print("fall")
			end




		end	


	end

	-- Call the RemoteFunction to get the pitch text from the client
	local pitchText = GetPitchTextFunction:InvokeClient(player)
	local currentPitch = tonumber(pitchText:match("(%d+)"))
	print(currentPitch)

	if currentPitch < 160 then -- Ensure that the pitch does not exceed 160
		currentPitch += 15
		WaveLength -= 0.15 
		print("Current pitch: " .. currentPitch)
		pitchTextDisplay.Text = tostring(currentPitch) .. "Hz"
		local pitchShift = ContinuousSound:FindFirstChildOfClass("PitchShiftSoundEffect")
		if pitchShift then
			pitchShift.Octave += 0.05 -- Increase the pitch
			continuousSound:Play()

		end
		local continuousSound = game.Workspace["Ruben's tube"].ContinuousSound -- Adjust path as necessary
		if continuousSound.IsPlaying then 
			continuousSound.Pitch = currentPitch -- Assuming 'Pitch' is a valid property of 'ContinuousSound'
		end	
	end	
end

local function lowerPitch(player)
	print("lowerpitch")
	
	-- Script for setting fixed lifetime properties per FirePart in each TubeSection
	for i = 1, tubePieces do -- Assuming we have 50 sections now including original and clones
		local currentTubeSection = game.Workspace["Ruben's tube"]["TubeSection" .. (i)] -- Adjust path as necessary

		if currentTubeSection then 
			local Fire = currentTubeSection.FirePart.Fire -- Set Fire variable inside the loop
			if GoingUp and CurrentLifetime < WaveLength then
				CurrentLifetime+=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				print("rise")

			end

			if GoingUp and CurrentLifetime >= WaveLength then
				CurrentLifetime+=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				GoingUp=false
			end

			if not GoingUp and CurrentLifetime>MinimumLifespan then
				CurrentLifetime-=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
			end	

			if not GoingUp and CurrentLifetime<=MinimumLifespan then
				CurrentLifetime-=WaveStep
				Fire.Lifetime=NumberRange.new(CurrentLifetime, CurrentLifetime)
				GoingUp=true		
				print("fall")
			end




		end	


	end

	-- Call the RemoteFunction to get the pitch text from the client
	local pitchText = GetPitchTextFunction:InvokeClient(player)
	local currentPitch = tonumber(pitchText:match("(%d+)"))
	print(currentPitch)

	if currentPitch > 30 then -- Ensure that the pitch does not go below 30
		currentPitch -= 15
		WaveLength +=0.15
		print("Current pitch: " .. currentPitch)
		pitchTextDisplay.Text = tostring(currentPitch) .. "Hz"
		local pitchShift = ContinuousSound:FindFirstChildOfClass("PitchShiftSoundEffect")
		if pitchShift then
			pitchShift.Octave -= 0.05 -- Decrease the pitch
			continuousSound:Play()

		end
		local continuousSound = game.Workspace["Ruben's tube"].ContinuousSound -- Adjust path as necessary
		if continuousSound.IsPlaying then 
			continuousSound.Pitch = currentPitch -- Assuming 'Pitch' is a valid property of 'ContinuousSound'
		end	
	end	
end





FireToggleEvent.OnServerEvent:Connect(toggleFire)
IncreasePitchEvent.OnServerEvent:Connect(increasePitch)
LowerPitchEvent.OnServerEvent:Connect(lowerPitch)
