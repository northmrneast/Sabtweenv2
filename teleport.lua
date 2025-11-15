local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Base position (replace with your actual base coordinates)
local basePosition = Vector3.new(0, 5, 0) -- CHANGE THIS TO YOUR BASE

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 150, 0, 50)
teleportButton.Position = UDim2.new(0, 10, 0, 10)
teleportButton.Text = "Teleport to Base"
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.Parent = screenGui

-- Tween teleport function
local function teleportToBase()
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
    local goal = {CFrame = CFrame.new(basePosition)}
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
    tween:Play()
end

-- Button click
teleportButton.MouseButton1Click:Connect(function()
    -- Optional: Check if holding stolen item
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if tool and string.find(tool.Name:lower(), "brainrot") then
        teleportToBase()
    else
        teleportToBase() -- Teleport anyway if desired
    end
end)

-- Auto-reconnect on respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
end)
