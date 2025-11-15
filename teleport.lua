
repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for character
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Base pos (auto-update)
local basePosition = humanoidRootPart.Position

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotTP_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 160, 0, 50)
button.Position = UDim2.new(0, 10, 0, 10)
button.Text = "TP HOME"
button.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Teleport function
local function tp()
    if humanoidRootPart and basePosition then
        TweenService:Create(humanoidRootPart, TweenInfo.new(0.4), {CFrame = CFrame.new(basePosition)}):Play()
    end
end

-- Click
button.MouseButton1Click:Connect(tp)

-- Respawn handler
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    wait(1.5)
    basePosition = humanoidRootPart.Position
end)

-- Keep base updated
spawn(function()
    while wait(2) do
        if humanoidRootPart and character.Parent then
            basePosition = humanoidRootPart.Position
        end
    end
end)

-- FORCE GUI VISIBLE
wait(1)
if screenGui and screenGui.Parent then
    screenGui.Enabled = true
end
