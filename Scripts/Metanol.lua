local VasModel = script.Parent.cupa.VasModel
local MetanolLichid = script.Parent.cupa.MetanolLichid
local Prompt = MetanolLichid.ProximityPrompt
local SprinkleMineralsEmitter = script.Parent.SprinkleMineralsEmitter
local Fire = MetanolLichid.FirePart.Fire


local HasMethanol = false
local HasColouring = false
MetanolLichid.Transparency = 1
Fire.Enabled=false
Fire.Color=Color3.new(1, 0.627451, 0.101961)
SprinkleMineralsEmitter.Enabled=false
Prompt.ActionText=("Introduce Metanol")

local FireSound = Instance.new("Sound")
FireSound.SoundId = "rbxassetid://743947235" -- replace with your sound id
FireSound.Parent = game.Workspace


Prompt.Triggered:Connect(function(Player)
	local Metanol = Player.Character:FindFirstChild("CH3OH (Metanol)")
	local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")

	if Metanol and HasMethanol == false then
		Prompt.ActionText=("Introduce element chimic")

		Metanol:Remove()
		HasMethanol = true
		MetanolLichid.Transparency = 0
	elseif HasMethanol and HasColouring == false then
		SprinkleMineralsEmitter.Enabled=false
		-- Create a new Animation instance
		local SprinkleMineralsAnimation = Instance.new("Animation")

		-- Set the AnimationId to the ID of your uploaded animation
		SprinkleMineralsAnimation.AnimationId = "rbxassetid://17501476451"

		-- Now you can load this animation onto the Humanoid
		local Animation = Humanoid:LoadAnimation(SprinkleMineralsAnimation)


		-- Play the animation
		Animation:Play()

		-- Place the emitter on the player's right hand
		SprinkleMineralsEmitter.Parent = Player.Character:FindFirstChild("RightHand")

		

		-- Wait for one second
		wait(3)
		SprinkleMineralsEmitter.Enabled = true
		-- Turn off the emitter
		wait(1)
		SprinkleMineralsEmitter.Enabled = false
		HasColouring=true
		print("Poured")
		Prompt.ActionText=("Aprinde")
	elseif HasColouring==true then
		Fire.Enabled=true
		FireSound:Play()
		Fire.Color=Color3.new(0.290196, 0.623529, 0.145098)
		Prompt.Enabled=false
		wait(10)
		FireSound:Stop()
		Prompt.Enabled=true
		Prompt.ActionText=("Introduce metanol")

		HasMethanol = false
		HasColouring = false
		HasColouring=false
	
	
		
	end
	
	
end)
