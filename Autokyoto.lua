-- Create the main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local AutoKyotoButton = Instance.new("TextButton")
local PingButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")  -- Open/Close Button

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UserPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]

local teleportDistance = 18.42
local isOpen = true  -- Track if the UI is open or closed

-- Function to toggle the UI visibility
local function toggleUI()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    ToggleButton.Text = isOpen and "Close" or "Open"
end

-- Function to teleport the player forward
local function teleportForward()
    local forwardDirection = humanoidRootPart.CFrame.LookVector
    local newPosition = humanoidRootPart.Position + forwardDirection * teleportDistance
    humanoidRootPart.CFrame = CFrame.new(newPosition)
end

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- GUI Styling (Smaller size)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true  -- Initially visible

TitleLabel.Parent = MainFrame
TitleLabel.Text = "Kyoto by Xyris Hub Team!"
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.TextScaled = true
TitleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.BorderSizePixel = 0

PingButton.Parent = MainFrame
PingButton.Text = "Check Ping & Start"
PingButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
PingButton.Size = UDim2.new(0.8, 0, 0.2, 0)
PingButton.Position = UDim2.new(0.1, 0, 0.4, 0)
PingButton.TextScaled = true
PingButton.TextColor3 = Color3.new(1, 1, 1)
PingButton.BorderSizePixel = 0

AutoKyotoButton.Parent = MainFrame
AutoKyotoButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
AutoKyotoButton.Size = UDim2.new(0.8, 0, 0.2, 0)
AutoKyotoButton.Position = UDim2.new(0.1, 0, 0.7, 0)
AutoKyotoButton.Text = "Auto Kyoto"
AutoKyotoButton.TextScaled = true
AutoKyotoButton.Visible = false
AutoKyotoButton.TextColor3 = Color3.new(1, 1, 1)
AutoKyotoButton.BorderSizePixel = 0

ToggleButton.Parent = MainFrame
ToggleButton.Text = "Close"  -- Initial text when UI is open
ToggleButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
ToggleButton.Size = UDim2.new(0.8, 0, 0.2, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.TextScaled = true
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BorderSizePixel = 0

-- Toggle button click event
ToggleButton.MouseButton1Click:Connect(toggleUI)

-- Ping Button click event
PingButton.MouseButton1Click:Connect(function()
    local ping = UserPing:GetValue()
    local waitTime = calculateWaitTime(ping)
    showRobloxNotification("Ping: " .. math.floor(ping) .. " ms | Wait Time: " .. waitTime .. "s")
    AutoKyotoButton.Visible = true
end)

-- Auto Kyoto button click event
AutoKyotoButton.MouseButton1Click:Connect(function()
    local ping = UserPing:GetValue()
    local waitTime = calculateWaitTime(ping)
    pressKey1()
    wait(waitTime)
    teleportForward()
    pressKey2()
    showRobloxNotification("Auto Kyoto combo performed!")
end)

-- Initial Notification when GUI is loaded
showRobloxNotification("Loaded by Xyris Hub Team")
