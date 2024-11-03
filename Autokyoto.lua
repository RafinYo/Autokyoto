-- Load the UI library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Alexisisback/Library/refs/heads/main/Library%20toraisme/Script.lua", true))()

-- Create the main window for the UI
local FarmWindow = library:CreateWindow("Kyoto Hub")

-- Add the "Main" tab
local MainTab = FarmWindow:AddTab("Main")

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UserPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
local teleportDistance = 18.42

-- Teleport forward function
local function teleportForward()
    local forwardDirection = humanoidRootPart.CFrame.LookVector
    local newPosition = humanoidRootPart.Position + forwardDirection * teleportDistance
    humanoidRootPart.CFrame = CFrame.new(newPosition)
end

-- Calculate wait time based on ping
local function calculateWaitTime(ping)
    local baseWaitTime = 1.45
    local adjustedWaitTime

    if ping <= 50 then
        adjustedWaitTime = baseWaitTime * 0.65
    elseif ping <= 100 then
        adjustedWaitTime = baseWaitTime * 0.75
    elseif ping <= 150 then
        adjustedWaitTime = baseWaitTime * 0.85
    elseif ping <= 200 then
        adjustedWaitTime = baseWaitTime * 0.95
    elseif ping <= 250 then
        adjustedWaitTime = baseWaitTime * 1.05
    else
        adjustedWaitTime = baseWaitTime * 1.15
    end

    return adjustedWaitTime
end

-- Display notification in Roblox
local function showRobloxNotification(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Kyoto Script",
        Text = text,
        Duration = 3,
    })
end

-- Check Ping & Start button
MainTab:AddButton({
    text = "Check Ping & Start",
    callback = function()
        local ping = UserPing:GetValue()
        local waitTime = calculateWaitTime(ping)
        showRobloxNotification("Ping: " .. math.floor(ping) .. " ms | Wait Time: " .. waitTime .. "s")
    end
})

-- Auto Kyoto button with new guidance notification
MainTab:AddButton({
    text = "Auto Kyoto",
    callback = function()
        local ping = UserPing:GetValue()
        local waitTime = calculateWaitTime(ping)
        
        showRobloxNotification("While using Flowing Water, spam Lethal Whirlwind Stream to maximize the combo!")
        pressKey1()
        wait(waitTime)
        teleportForward()
        pressKey2()
        showRobloxNotification("Auto Kyoto combo performed!")
    end
})

-- Join Our Discord Server button
MainTab:AddButton({
    text = "Join Our Discord Server",
    callback = function()
        setclipboard("https://discord.gg/3WtS2F7CaX")
        showRobloxNotification("Discord link copied to clipboard!")
    end
})

-- Define key press functions for Auto Kyoto combo
local function pressKey1()
    local tool = plr.Backpack:FindFirstChild("Flowing Water")
    if tool then
        tool.Parent = chr
        wait(1)
        tool.Parent = plr.Backpack
    end
end

local function pressKey2()
    local tool = plr.Backpack:FindFirstChild("Lethal Whirlwind Stream")
    if tool then
        tool.Parent = chr
        wait(1)
        tool.Parent = plr.Backpack
    end
end

showRobloxNotification("Loaded by Xyris Hub Team")

Libary:Init()
