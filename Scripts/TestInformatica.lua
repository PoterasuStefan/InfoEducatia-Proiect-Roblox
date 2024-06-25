local Raspuns1Button = script.Parent.Frame["Raspuns 1"]
local Raspuns2Button = script.Parent.Frame["Raspuns 2"]
local Raspuns3Button = script.Parent.Frame["Raspuns 3"]
local CloseButton = script.Parent.LoseFrame.CloseButton
local CorrectAnswersLabel = script.Parent.Frame.CorrectAnswersLabel
local WrongAnswersLabel = script.Parent.Frame.WrongAnswersLabel
local ResetTimer = game:GetService("ServerScriptService"):WaitForChild("ResetTimer")
local MistakesLabel = script.Parent.Frame.MistakesLabel
local MainFrame = script.Parent.Frame
local LoseFrame = script.Parent.LoseFrame
local CurrentScoreLabel = LoseFrame.CurrentScoreLabel
local player = game.ServerStorage:WaitForChild("CurrentPlayer").Value


local Players = game:GetService("Players")
local prompt = game.Workspace["laborator (1)"]["baza laptop"].ProximityPart.ProximityPrompt
local HighScoreLabel=script.Parent.LoseFrame.HighScoreLabel


local CorrectAnswers = 0
local WrongAnswers = 0
local correctAnswer 

MainFrame.Visible=false
LoseFrame.Visible=false
-- Func?ie pentru a genera un numar aleatoriu între min ?i max
local function random(min, max)
	return math.random(min, max)
end

local function numarFrunze(tata)
	local frunze = #tata
	for i = 1, #tata do
		for j = 1, #tata do
			if tata[j] == i then
				frunze = frunze - 1
				break
			end
		end
	end
	return frunze
end

local function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
end
-- Generam un vector de tip tata cu un numar aleatoriu de noduri
-- Function to generate a new question
local function generateQuestion()
	
	-- Generate a random number of nodes
	local numarNoduri = random(4, 14)

	-- Generate the father and type vectors
	local tata = {}
	local tip = {}
	for i = 1, numarNoduri do
		if i == 1 then
			tata[i] = 0
			tip[i] = 0
		else
			tata[i] = random(1, i - 1)
			tip[i] = random(-1, 1)
		end
	end

	-- Calculate the correct number of leaves
	correctAnswer = numarFrunze(tata)

	-- Generate wrong answers
	local wrongAnswer1 = correctAnswer + random(1, 3)
	local wrongAnswer2 = correctAnswer - random(1, 3)
	if wrongAnswer2 < 0 then wrongAnswer2 = 0 end

	-- Generate the question text
	local questionText = "Câte frunze are arborele cu " .. numarNoduri .. " noduri dat de vectorul de tip tata: \n" .. table.concat(tata, ", ") .. "?"

	-- Display the question
	script.Parent.Frame.IntrebareFrame.Intrebare.Text = questionText

	-- Display the answers in the text buttons
	local answers = {tostring(correctAnswer), tostring(wrongAnswer1), tostring(wrongAnswer2)}

	shuffle(answers)

	-- Assign the shuffled answers to the buttons
	script.Parent.Frame["Raspuns 1"].Text = answers[1]
	script.Parent.Frame["Raspuns 2"].Text = answers[2]
	script.Parent.Frame["Raspuns 3"].Text = answers[3]
	
	
end




-- Call the function to generate the first question
prompt.Triggered:Connect(function(player)
	local TestInformaticaGui = Players[player.Name].PlayerGui.TestInformatica
	TestInformaticaGui.Enabled = true
	CorrectAnswers = 0
	WrongAnswers = 0
	CorrectAnswers=0
	WrongAnswers=0
	CorrectAnswersLabel.Text= "Raspunsuri corecte: 0"
	WrongAnswersLabel.Text="Raspunsuri gre?ite: 0"
	MistakesLabel.Text="Gre?eli: 0 / 5"
	
	MainFrame.Visible=true

	generateQuestion()
	
end)


local function onCorrectAnswer()
	CorrectAnswers += 1
	CorrectAnswersLabel.Text = "Raspunsuri corecte: " .. tostring(CorrectAnswers)
	-- Check if the current score is greater than the maximum score
	if CorrectAnswers > player.leaderstats.Scor.Value then
		-- Update the maximum score
		player.leaderstats.Scor.Value = CorrectAnswers
	end
	ResetTimer:Fire()
end

local function onWrongAnswer()
	if WrongAnswers<5 then
		WrongAnswers+=1
		WrongAnswersLabel.Text = "Raspunsuri gre?ite: " .. tostring(WrongAnswers)
		MistakesLabel.Text= "Gre?eli: "..WrongAnswers.. " / 5"
	else
		local HighScore = player.leaderstats.Scor.Value

		MainFrame.Visible=false
		LoseFrame.Visible=true
		CurrentScoreLabel.Text = "Scor Curent: "..CorrectAnswers
		HighScoreLabel.Text="Scor Maxim: "..HighScore
	end
end


local function onRaspuns1ButtonPress()
	if tonumber(Raspuns1Button.Text)==correctAnswer then
		onCorrectAnswer()

	else onWrongAnswer()
	end
	generateQuestion()
end
local function onRaspuns2ButtonPress()
	if tonumber(Raspuns2Button.Text)==correctAnswer then
		onCorrectAnswer()

	else onWrongAnswer()
	end
	generateQuestion()
end
local function onRaspuns3ButtonPress()
	if tonumber(Raspuns3Button.Text)==correctAnswer then
		onCorrectAnswer()

	else onWrongAnswer()
	end
	generateQuestion()
end


local function onCloseButtonPress()
	LoseFrame.Visible=false
	MainFrame.Visible=false
end



Raspuns1Button.MouseButton1Click:Connect(onRaspuns1ButtonPress)
Raspuns2Button.MouseButton1Click:Connect(onRaspuns2ButtonPress)
Raspuns3Button.MouseButton1Click:Connect(onRaspuns3ButtonPress)
CloseButton.MouseButton1Click:Connect(onCloseButtonPress)