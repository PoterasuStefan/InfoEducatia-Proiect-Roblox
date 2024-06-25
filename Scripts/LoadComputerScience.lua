
local ScreenGui = script.Parent.Parent.Parent.Parent
local ImageButton = script.Parent



local function onLoadClick()
	
	ScreenGui.Enabled=false
end

ImageButton.MouseButton1Click:Connect(onLoadClick)