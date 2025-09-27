-- SlightlyOverdidIt UI | Custom Rayfield-like remake
local SlightlyOverdidIt = {}
SlightlyOverdidIt.__index = SlightlyOverdidIt

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Screen GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlightlyOverdidItUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "SlightlyOverdidIt UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = MainFrame

-- Section Example
local function CreateSection(name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -20, 0, 100)
    section.Position = UDim2.new(0, 10, 0, 60)
    section.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    section.BorderSizePixel = 0
    section.Parent = MainFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = section

    return section
end

-- Button Example
local function CreateButton(section, name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 250)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.Parent = section

    button.MouseButton1Click:Connect(function()
        callback()
    end)
end

-- Example usage
local mainSection = CreateSection("Main Controls")
CreateButton(mainSection, "Click Me", function()
    print("Button clicked!")
end)

return SlightlyOverdidIt
