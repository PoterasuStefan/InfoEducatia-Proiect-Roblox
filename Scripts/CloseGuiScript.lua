local CloseButton = script.Parent
CloseButton.Parent.Parent.Enabled = false
-- Function to handle the button click
local function onCloseClick()
	-- Assuming 'ScreenGui' is the direct parent of the button
	CloseButton.Parent.Parent.Enabled = false
end

-- Connect the 'onCloseClick' function to the 'MouseButton1Click' event of the button
CloseButton.MouseButton1Click:Connect(onCloseClick)