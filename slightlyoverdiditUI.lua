-- SlightlyOverdidIt UI | Stylish Rayfield-style remake with Close button
local SlightlyOverdidIt = {}
SlightlyOverdidIt.__index = SlightlyOverdidIt

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Helper function
local function Create(inst, props)
    local obj = Instance.new(inst)
    for k,v in pairs(props) do obj[k] = v end
    return obj
end

-- Notification system
local function Notify(title, content, duration)
    local ScreenGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SlightlyOverdidItUI_Notifications")
    if not ScreenGui then
        ScreenGui = Create("ScreenGui", {Name = "SlightlyOverdidItUI_Notifications", Parent = Players.LocalPlayer:WaitForChild("PlayerGui")})
    end

    local notif = Create("Frame", {
        Size = UDim2.new(0, 250, 0, 70),
        Position = UDim2.new(1, -260, 0.5, -35),
        BackgroundColor3 = Color3.fromRGB(40,40,40),
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    notif.AnchorPoint = Vector2.new(1,0.5)
    notif.BackgroundTransparency = 1

    TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

    local titleLabel = Create("TextLabel", {
        Text = title,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255,255,255),
        TextSize = 18,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,25),
        Parent = notif
    })

    local contentLabel = Create("TextLabel", {
        Text = content,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(200,200,200),
        TextSize = 14,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1, -25),
        Position = UDim2.new(0,0,0,25),
        Parent = notif
    })

    delay(duration or 3, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        wait(0.3)
        notif:Destroy()
    end)
end

-- Main API
function SlightlyOverdidIt:CreateWindow(options)
    local Window = {}
    Window.__index = Window

    local ScreenGui = Create("ScreenGui", {Name = options.Name or "SlightlyOverdidItUI", ResetOnSpawn = false, Parent = Players.LocalPlayer:WaitForChild("PlayerGui")})
    local MainFrame = Create("Frame", {
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(35,35,35),
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    MainFrame.ClipsDescendants = true

    -- Rounded corners & shadow
    local corner = Create("UICorner", {CornerRadius = UDim.new(0, 15), Parent = MainFrame})
    local shadow = Create("Frame", {
        Size = UDim2.new(1, 10, 1, 10),
        Position = UDim2.new(0,-5,0,-5),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    shadow.ZIndex = -1
    local shadowCorner = Create("UICorner", {CornerRadius = UDim.new(0, 15), Parent = shadow})
    TweenService:Create(shadow, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()

    local Title = Create("TextLabel", {
        Size = UDim2.new(1, -50, 0, 50),
        BackgroundTransparency = 1,
        Text = options.Name or "SlightlyOverdidIt UI",
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamBold,
        TextSize = 24,
        Position = UDim2.new(0, 10, 0, 0),
        Parent = MainFrame
    })

    -- Close button
    local CloseButton = Create("TextButton", {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -50, 0, 5),
        BackgroundColor3 = Color3.fromRGB(255,50,50),
        Text = "X",
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        Parent = MainFrame
    })
    local cornerBtn = Create("UICorner", {CornerRadius = UDim.new(0,8), Parent = CloseButton})
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255,80,80)}):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255,50,50)}):Play()
    end)
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)

    Window.Tabs = {}

    -- Tab API
    function Window:CreateTab(name)
        local Tab = {}
        Tab.__index = Tab

        local SectionFrame = Create("ScrollingFrame", {
            Size = UDim2.new(1, -20, 1, -60),
            Position = UDim2.new(0,10,0,60),
            BackgroundTransparency = 1,
            CanvasSize = UDim2.new(0,0,0,0),
            ScrollBarThickness = 6,
            Parent = MainFrame
        })

        Tab.Sections = {}

        -- Section creation
        function Tab:CreateSection(sectionName)
            local section = Create("Frame", {
                Size = UDim2.new(1,0,0,120),
                BackgroundColor3 = Color3.fromRGB(55,55,55),
                BorderSizePixel = 0,
                Parent = SectionFrame
            })
            local corner = Create("UICorner", {CornerRadius = UDim.new(0,10), Parent = section})
            local label = Create("TextLabel", {
                Size = UDim2.new(1,0,0,25),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Color3.fromRGB(255,255,255),
                Font = Enum.Font.GothamBold,
                TextSize = 18,
                Parent = section
            })

            section.UIListLayout = Create("UIListLayout", {Parent = section})
            section.UIListLayout.Padding = UDim.new(0,5)

            -- Button
            function section:CreateButton(opts)
                local button = Create("TextButton", {
                    Size = UDim2.new(1, -10, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(100,100,250),
                    Text = opts.Name or "Button",
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 16,
                    Parent = section
                })
                local corner = Create("UICorner", {CornerRadius = UDim.new(0,10), Parent = button})
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120,120,255)}):Play()
                end)
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100,100,250)}):Play()
                end)
                button.MouseButton1Click:Connect(function()
                    if opts.Callback then opts.Callback() end
                    Notify("SlightlyOverdidIt", opts.Name.." clicked!", 2)
                end)
            end

            -- Toggle
            function section:CreateToggle(opts)
                local toggle = Create("TextButton", {
                    Size = UDim2.new(1,-10,0,40),
                    BackgroundColor3 = Color3.fromRGB(250,100,100),
                    Text = (opts.Name or "Toggle").." [OFF]",
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 16,
                    Parent = section
                })
                local corner = Create("UICorner",{CornerRadius = UDim.new(0,10), Parent = toggle})
                local state = false
                toggle.MouseButton1Click:Connect(function()
                    state = not state
                    toggle.Text = (opts.Name or "Toggle").." ["..(state and "ON" or "OFF").."]"
                    if opts.Callback then opts.Callback(state) end
                    Notify("SlightlyOverdidIt", toggle.Text, 2)
                end)
            end

            self.Sections[sectionName] = section
            return section
        end

        self.Tabs[name] = Tab
        return Tab
    end

    return setmetatable(Window, Window)
end

return setmetatable(SlightlyOverdidIt, SlightlyOverdidIt)
