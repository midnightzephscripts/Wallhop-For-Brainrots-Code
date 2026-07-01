-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "CelestialToggleGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- Main Frame (Height increased to 335 to fit the new auto-rebirth row)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 335)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -167)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 45)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
header.Parent = mainFrame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "ZephHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

-- Row 1: Auto Pickup Celestials
local row = Instance.new("Frame")
row.Size = UDim2.new(1, -30, 0, 50)
row.Position = UDim2.new(0, 15, 0, 55)
row.BackgroundTransparency = 1
row.Parent = mainFrame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.65, 0, 1, 0)
label.Text = "Auto Pickup Celestials [P]"
label.Font = Enum.Font.GothamMedium
label.TextSize = 14
label.TextColor3 = Color3.fromRGB(200, 200, 200)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = row

local switchBG = Instance.new("TextButton")
switchBG.Size = UDim2.new(0, 55, 0, 28)
switchBG.Position = UDim2.new(1, -55, 0.5, -14)
switchBG.BackgroundColor3 = Color3.fromRGB(235, 64, 52)
switchBG.Text = ""
switchBG.AutoButtonColor = false
switchBG.Parent = row

Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)

local switchCircle = Instance.new("Frame")
switchCircle.Size = UDim2.new(0, 22, 0, 22)
switchCircle.Position = UDim2.new(0, 3, 0.5, -11)
switchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
switchCircle.BorderSizePixel = 0
switchCircle.Parent = switchBG

Instance.new("UICorner", switchCircle).CornerRadius = UDim.new(1, 0)


-- Row 2: Auto Collect All Cash
local row2 = Instance.new("Frame")
row2.Size = UDim2.new(1, -30, 0, 50)
row2.Position = UDim2.new(0, 15, 0, 110)
row2.BackgroundTransparency = 1
row2.Parent = mainFrame

local label2 = Instance.new("TextLabel")
label2.Size = UDim2.new(0.65, 0, 1, 0)
label2.Text = "Auto Collect All Cash [L]"
label2.Font = Enum.Font.GothamMedium
label2.TextSize = 14
label2.TextColor3 = Color3.fromRGB(200, 200, 200)
label2.BackgroundTransparency = 1
label2.TextXAlignment = Enum.TextXAlignment.Left
label2.Parent = row2

local switchBG2 = Instance.new("TextButton")
switchBG2.Size = UDim2.new(0, 55, 0, 28)
switchBG2.Position = UDim2.new(1, -55, 0.5, -14)
switchBG2.BackgroundColor3 = Color3.fromRGB(235, 64, 52)
switchBG2.Text = ""
switchBG2.AutoButtonColor = false
switchBG2.Parent = row2

Instance.new("UICorner", switchBG2).CornerRadius = UDim.new(1, 0)

local switchCircle2 = Instance.new("Frame")
switchCircle2.Size = UDim2.new(0, 22, 0, 22)
switchCircle2.Position = UDim2.new(0, 3, 0.5, -11)
switchCircle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
switchCircle2.BorderSizePixel = 0
switchCircle2.Parent = switchBG2

Instance.new("UICorner", switchCircle2).CornerRadius = UDim.new(1, 0)


-- Row 3: Auto Rebirth (NEW TOGGLE)
local rowRebirth = Instance.new("Frame")
rowRebirth.Size = UDim2.new(1, -30, 0, 50)
rowRebirth.Position = UDim2.new(0, 15, 0, 165)
rowRebirth.BackgroundTransparency = 1
rowRebirth.Parent = mainFrame

local labelRebirth = Instance.new("TextLabel")
labelRebirth.Size = UDim2.new(0.65, 0, 1, 0)
labelRebirth.Text = "Auto Rebirth [K]"
labelRebirth.Font = Enum.Font.GothamMedium
labelRebirth.TextSize = 14
labelRebirth.TextColor3 = Color3.fromRGB(200, 200, 200)
labelRebirth.BackgroundTransparency = 1
labelRebirth.TextXAlignment = Enum.TextXAlignment.Left
labelRebirth.Parent = rowRebirth

local switchBGRebirth = Instance.new("TextButton")
switchBGRebirth.Size = UDim2.new(0, 55, 0, 28)
switchBGRebirth.Position = UDim2.new(1, -55, 0.5, -14)
switchBGRebirth.BackgroundColor3 = Color3.fromRGB(235, 64, 52)
switchBGRebirth.Text = ""
switchBGRebirth.AutoButtonColor = false
switchBGRebirth.Parent = rowRebirth

Instance.new("UICorner", switchBGRebirth).CornerRadius = UDim.new(1, 0)

local switchCircleRebirth = Instance.new("Frame")
switchCircleRebirth.Size = UDim2.new(0, 22, 0, 22)
switchCircleRebirth.Position = UDim2.new(0, 3, 0.5, -11)
switchCircleRebirth.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
switchCircleRebirth.BorderSizePixel = 0
switchCircleRebirth.Parent = switchBGRebirth

Instance.new("UICorner", switchCircleRebirth).CornerRadius = UDim.new(1, 0)


-- Row 4: Regular Teleport Button (Shifted down)
local row3 = Instance.new("Frame")
row3.Size = UDim2.new(1, -30, 0, 50)
row3.Position = UDim2.new(0, 15, 0, 220)
row3.BackgroundTransparency = 1
row3.Parent = mainFrame

local label3 = Instance.new("TextLabel")
label3.Size = UDim2.new(0.55, 0, 1, 0)
label3.Text = "Teleport to Divine Zone"
label3.Font = Enum.Font.GothamMedium
label3.TextSize = 14
label3.TextColor3 = Color3.fromRGB(200, 200, 200)
label3.BackgroundTransparency = 1
label3.TextXAlignment = Enum.TextXAlignment.Left
label3.Parent = row3

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0, 90, 0, 30)
tpButton.Position = UDim2.new(1, -90, 0.5, -15)
tpButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tpButton.Text = "Teleport"
tpButton.Font = Enum.Font.GothamBold
tpButton.TextSize = 12
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Parent = row3

Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 6)

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(65, 65, 65)
buttonStroke.Thickness = 1
buttonStroke.Parent = tpButton


-- STATE
local enabled = false
local busy = false

local plotEnabled = false
local plotBusy = false

local rebirthEnabled = false

-- DRAGGING
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    local goal = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
    TweenService:Create(mainFrame, TweenInfo.new(0.05), {Position = goal}):Play()
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)


-- TELEPORT ON LOAD
local function teleportOnLoad()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 10)
    if not hrp then return end

    task.wait(0.2)
    hrp.CFrame = CFrame.new(-15, 3628, -201)
end

task.spawn(teleportOnLoad)

player.CharacterAdded:Connect(function()
    task.wait(0.2)
    teleportOnLoad()
end)


-- TOGGLE SYSTEM (Row 1)
local function setToggle(state)
    enabled = state

    local color = enabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(235, 64, 52)
    local pos = enabled and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)

    TweenService:Create(switchBG, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    TweenService:Create(switchCircle, TweenInfo.new(0.2), {Position = pos}):Play()
end

switchBG.MouseButton1Click:Connect(function()
    setToggle(not enabled)
end)


-- TOGGLE SYSTEM (Row 2)
local function setPlotToggle(state)
    plotEnabled = state

    local color = plotEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(235, 64, 52)
    local pos = plotEnabled and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)

    TweenService:Create(switchBG2, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    TweenService:Create(switchCircle2, TweenInfo.new(0.2), {Position = pos}):Play()
end

switchBG2.MouseButton1Click:Connect(function()
    setPlotToggle(not plotEnabled)
end)


-- TOGGLE SYSTEM (Row 3 - Auto Rebirth)
local function setRebirthToggle(state)
    rebirthEnabled = state

    local color = rebirthEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(235, 64, 52)
    local pos = rebirthEnabled and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)

    TweenService:Create(switchBGRebirth, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    TweenService:Create(switchCircleRebirth, TweenInfo.new(0.2), {Position = pos}):Play()
end

switchBGRebirth.MouseButton1Click:Connect(function()
    setRebirthToggle(not rebirthEnabled)
end)


-- HELPER FUNCTIONS
local function getHRP()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function pressEOnce()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end


-- BUTTON ACTIONS (Row 4)
tpButton.MouseButton1Click:Connect(function()
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = CFrame.new(-9, 7340, -60)
    end
end)


-- Keybinds handling
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.P then
        setToggle(not enabled)
    elseif input.KeyCode == Enum.KeyCode.L then
        setPlotToggle(not plotEnabled)
    elseif input.KeyCode == Enum.KeyCode.K then
        setRebirthToggle(not rebirthEnabled)
    end
end)


-- MAIN LOOP 1: Celestials Spawner
task.spawn(function()
    while true do
        task.wait(0.1)

        if enabled and not busy then
            busy = true
            local hrp = getHRP()
            local returnPos = CFrame.new(-81, 19, -931)

            local folder = workspace:FindFirstChild("ItemSpawners")
                and workspace.ItemSpawners:FindFirstChild("Celestial")

            if hrp and folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if not enabled then break end

                    if obj:IsA("Model") and obj.Name == "SpawnedItem" then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")

                        if part then
                            hrp.CFrame = part.CFrame
                            task.wait(0.5)

                            if enabled then pressEOnce() end
                            task.wait(0.2)

                            hrp.CFrame = returnPos
                            task.wait(0.5)
                        end
                    end
                end
            end
            busy = false
        end
    end
end)


-- MAIN LOOP 2: Plot Floor Slots Teleporter
task.spawn(function()
    while true do
        task.wait(0.1)

        if plotEnabled and not plotBusy then
            plotBusy = true
            
            local plotName = "Plot_" .. player.Name
            local plot = workspace:FindFirstChild(plotName)
            local hrp = getHRP()

            if hrp and plot then
                local floors = {"Floor1", "Floor2", "Floor3"}

                for _, floorName in ipairs(floors) do
                    if not plotEnabled then break end
                    
                    local floor = plot:FindFirstChild(floorName)
                    local slotsFolder = floor and floor:FindFirstChild("Slots")

                    if slotsFolder then
                        for _, model in ipairs(slotsFolder:GetChildren()) do
                            if not plotEnabled then break end

                            if model:IsA("Model") then
                                local collectTouch = model:FindFirstChild("CollectTouch")
                                
                                if collectTouch and collectTouch:IsA("BasePart") then
                                    hrp.CFrame = collectTouch.CFrame
                                    task.wait(0.3) 
                                end
                            end
                        end
                    end
                end
            end
            
            plotBusy = false
        end
    end
end)


-- MAIN LOOP 3: Auto Rebirth (Checks Bar.Progress Size X Scale >= 1)
task.spawn(function()
    local requestRebirthEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RequestRebirth")
    
    while true do
        task.wait(0.1)
        
        if rebirthEnabled then
            -- Safely look up the path before evaluating scale
            local progress = playerGui:FindFirstChild("GUI") 
                and playerGui.GUI:FindFirstChild("Frames")
                and playerGui.GUI.Frames:FindFirstChild("Rebirth")
                and playerGui.GUI.Frames.Rebirth:FindFirstChild("Bar")
                and playerGui.GUI.Frames.Rebirth.Bar:FindFirstChild("Progress")
                
            if progress and progress.Size.X.Scale >= 1 then
                requestRebirthEvent:FireServer()
            end
        end
    end
end)
