local totalPages = 3 -- Total number of pages in the book
local bookGui = script.Parent -- Adjust this to the correct path of your book GUI
local currentPage = 1 -- Start on the first page
print("hey")
-- Get references to the buttons
local previousButton = bookGui.PreviousPageButton
local nextButton = bookGui.NextPageButton

-- Function to close all pages
local function closePages()
	bookGui.Page1.Visible = false
	bookGui.Page2.Visible = false
	bookGui.Page3.Visible = false
end

-- Function to update the button states and page visibility
local function updateButtonStates()
	closePages() -- Close all pages before showing the current one
	if currentPage == 1 then
		bookGui.Page1.Visible = true
		script.Parent.PreviousPageButton.Visible=false

	elseif currentPage == 2 then
		bookGui.Page2.Visible = true
		script.Parent.PreviousPageButton.Visible=true
		script.Parent.NextPageButton.Visible=true

	elseif currentPage == 3 then
		bookGui.Page3.Visible = true
		script.Parent.NextPageButton.Visible=false
		script.Parent.PreviousPageButton.Visible=true


	end
	
end

	
script.Parent.NextPageButton.Visible=true
script.Parent.PreviousPageButton.Visible=true
closePages()
updateButtonStates()

-- Function to handle the Previous button press
local function onPreviousButtonPress()
	if currentPage > 1 then
		currentPage = currentPage - 1
		updateButtonStates()
	end
end

-- Function to handle the Next button press
local function onNextButtonPress()
	print(	"nextpage")
	if currentPage < totalPages then
		currentPage = currentPage + 1
		updateButtonStates()
	end
end

-- Connect the button press events to the functions
previousButton.MouseButton1Click:Connect(onPreviousButtonPress)
nextButton.MouseButton1Click:Connect(onNextButtonPress)

