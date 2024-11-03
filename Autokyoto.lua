local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local AutoKyotoButton = Instance.new("TextButton")
local PingButton = Instance.new("TextButton")
local DiscordButton = Instance.new("TextButton")
local ToggleButton = Instance.new("ImageButton")
local NoticeLabel = Instance.new("TextLabel")  -- Notice label for instructions

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UserPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]

local teleportDistance = 18.42
local uiVisible = true  -- Variable to track UI visibility

local function teleportForward()
    local forwardDirection = humanoidRootPart.CFrame.LookVector
    local newPosition = humanoidRootPart.Position + forwardDirection * teleportDistance
    humanoidRootPart.CFrame = CFrame.new(newPosition)
end

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 20, 90)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.Active = true
MainFrame.Draggable = true

TitleLabel.Parent = MainFrame
TitleLabel.Text = "Kyoto by Xyris Hub Team"
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.TextScaled = true
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 10, 60)
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
TitleLabel.BorderSizePixel = 0

NoticeLabel.Parent = MainFrame
NoticeLabel.Text = "While in 'Flowing Water,' spam 2nd move 'Lethal Whirlwind Stream' to perform the Kyoto combo!"
NoticeLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
NoticeLabel.Position = UDim2.new(0.05, 0, 0.22, 0)
NoticeLabel.TextScaled = true
NoticeLabel.BackgroundColor3 = Color3.fromRGB(40, 10, 70)
NoticeLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
NoticeLabel.BorderSizePixel = 0
NoticeLabel.TextWrapped = true

PingButton.Parent = MainFrame
PingButton.Text = "Check Ping & Start"
PingButton.BackgroundColor3 = Color3.fromRGB(60, 30, 100)
PingButton.Size = UDim2.new(0.8, 0, 0.15, 0)
PingButton.Position = UDim2.new(0.1, 0, 0.45, 0)
PingButton.TextScaled = true
PingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PingButton.BorderSizePixel = 0

AutoKyotoButton.Parent = MainFrame
AutoKyotoButton.BackgroundColor3 = Color3.fromRGB(70, 20, 110)
AutoKyotoButton.Size = UDim2.new(0.8, 0, 0.15, 0)
AutoKyotoButton.Position = UDim2.new(0.1, 0, 0.65, 0)
AutoKyotoButton.Text = "Auto Kyoto"
AutoKyotoButton.TextScaled = true
AutoKyotoButton.Visible = false
AutoKyotoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoKyotoButton.BorderSizePixel = 0

DiscordButton.Parent = MainFrame
DiscordButton.Text = "Join Our Discord Server"
DiscordButton.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
DiscordButton.Size = UDim2.new(0.8, 0, 0.15, 0)
DiscordButton.Position = UDim2.new(0.1, 0, 0.85, 0)
DiscordButton.TextScaled = true
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.BorderSizePixel = 0

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/3WtS2F7CaX")
    game.StarterGui:SetCore("SendNotification", {Title = "Kyoto Script", Text = "Discord link copied!", Duration = 2})
end)

ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.9, -30, 0.05, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "rbxassetid://114282177083923"

ToggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = uiVisible
end)

local function calculateWaitTime(ping)
    local baseWaitTime = 1.45
    if ping <= 50 then return baseWaitTime * 0.65
    elseif ping <= 100 then return baseWaitTime * 0.75
    elseif ping <= 150 then return baseWaitTime * 0.85
    elseif ping <= 200 then return baseWaitTime * 0.95
    elseif ping <= 250 then return baseWaitTime * 1.05
    else return baseWaitTime * 1.15 end
end

local function showRobloxNotification(text)
    game.StarterGui:SetCore("SendNotification", {Title = "Kyoto Script", Text = text, Duration = 3})
end

PingButton.MouseButton1Click:Connect(function()
    local ping = UserPing:GetValue()
    local waitTime = calculateWaitTime(ping)
    showRobloxNotification("Ping: " .. math.floor(ping) .. " ms | Wait Time: " .. waitTime .. "s")
    AutoKyotoButton.Visible = true
end)

local function pressKey1()
    local tool = plr.Backpack:FindFirstChild("Flowing Water")
    if tool then tool.Parent = chr wait(1) tool.Parent = plr.Backpack end
end

local function pressKey2()
    local tool = plr.Backpack:FindFirstChild("Lethal Whirlwind Stream")
    if tool then tool.Parent = chr wait(1) tool.Parent = plr.Backpack end
end

AutoKyotoButton.MouseButton1Click:Connect(function()
    local ping = UserPing:GetValue()
    local waitTime = calculateWaitTime(ping)
    pressKey1()
    wait(waitTime)
    teleportForward()
    pressKey2()
    showRobloxNotification("Auto Kyoto combo performed!")
end)

showRobloxNotification("Loaded by Xyris Hub Team")
