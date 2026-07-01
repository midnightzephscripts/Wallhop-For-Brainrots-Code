-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "CelestialToggleGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 160)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
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
title.Text = "WallHop For Brainrots"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

-- Row
local row = Instance.new("Frame")
row.Size = UDim2.new(1, -30, 0, 50)
row.Position = UDim2.new(0, 15, 0, 60)
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

-- Toggle UI
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

-- STATE
local enabled = false
local busy = false

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


-- TELEPORT ON LOAD (after UI + character ready)
local function teleportOnLoad()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 10)
    if not hrp then return end

    -- small delay to ensure UI is fully created/rendered
    task.wait(0.2)

    hrp.CFrame = CFrame.new(-15, 3628, -201)
end

task.spawn(teleportOnLoad)

-- also handle respawn safety (optional but recommended)
player.CharacterAdded:Connect(function()
    task.wait(0.2)
    teleportOnLoad()
end)




-- TOGGLE SYSTEM (FIXED)
local function setToggle(state)
    enabled = state

    local color = enabled and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(235, 64, 52)

    local pos = enabled and UDim2.new(1, -25, 0.5, -11)
        or UDim2.new(0, 3, 0.5, -11)

    TweenService:Create(switchBG, TweenInfo.new(0.2), {
        BackgroundColor3 = color
    }):Play()

    TweenService:Create(switchCircle, TweenInfo.new(0.2), {
        Position = pos
    }):Play()
end

switchBG.MouseButton1Click:Connect(function()
    setToggle(not enabled)
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.P then
        setToggle(not enabled)
    end
end)

-- PLAYER
local function getHRP()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function pressEOnce()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- MAIN LOOP (FIXED ANTI-SPAM)
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
                    if not enabled then
                        busy = false
                        break
                    end

                    if obj:IsA("Model") and obj.Name == "SpawnedItem" then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")

                        if part then
                            -- 1. teleport to item
                            hrp.CFrame = part.CFrame

                            -- 2. wait 0.5s
                            task.wait(0.5)

                            -- 3. press E once
                            if enabled then
                                pressEOnce()
                            end

                            -- 4. wait 0.2s
                            task.wait(0.2)

                            -- 5. teleport back
                            hrp.CFrame = returnPos

                            -- 6. wait 0.5s
                            task.wait(0.5)
                        end
                    end
                end
            end

            busy = false
        end
    end
end)