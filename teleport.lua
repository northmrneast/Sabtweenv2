
pcall(function()
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    -- Wait for everything
    repeat task.wait() until player and player:FindFirstChild("PlayerGui") and player.Character

    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local basePosition = humanoidRootPart and humanoidRootPart.Position or Vector3.new(0,5,0)

    -- CREATE IN COREGUI (UNBLOCKABLE)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FORCE_TPGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 60)
    button.Position = UDim2.new(0, 15, 0, 15)
    button.Text = "TP BASE"
    button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBlack
    button.TextSize = 18
    button.TextStrokeTransparency = 0.7
    button.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = button

    local function teleport()
        if humanoidRootPart and basePosition then
            TweenService:Create(humanoidRootPart, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {CFrame = CFrame.new(basePosition)}):Play()
        end
    end

    button.MouseButton1Click:Connect(function()
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:find("Brainrot") or tool.Name:find("tralalero")) then
            teleport()
        else
            teleport()
        end
    end)

    -- AUTO-UPDATE BASE + CHARACTER
    player.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
        task.wait(1.2)
        basePosition = humanoidRootPart.Position
    end)

    RunService.Heartbeat:Connect(function()
        if humanoidRootPart and humanoidRootPart.Parent then
            basePosition = humanoidRootPart.Position
        end
    end)

    -- FORCE SHOW
    task.wait(1)
    screenGui.Enabled = true
    button.Visible = true
end)
