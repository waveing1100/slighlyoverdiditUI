-- SlightlyOverdidIt UI | Draggable Modern Version
local SlightlyOverdidIt = {}
SlightlyOverdidIt.__index = SlightlyOverdidIt

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Helper function
local function Create(inst, props)
    local obj = Instance.new(inst)
    for k,v in pairs(props) do obj[k] = v end
    return obj
end

-- Notifications
local function Notify(title, content, duration)
    local ScreenGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SlightlyOverdidItUI_Notifications")
    if not ScreenGui then
        ScreenGui = Create("ScreenGui",{Name="SlightlyOverdidItUI_Notifications",Parent=Players.LocalPlayer:WaitForChild("PlayerGui")})
    end
    local notif = Create("Frame",{
        Size=UDim2.new(0,250,0,70),
        Position=UDim2.new(1,-260,0.5,-35),
        BackgroundColor3=Color3.fromRGB(40,40,40),
        BorderSizePixel=0,
        Parent=ScreenGui
    })
    notif.AnchorPoint=Vector2.new(1,0.5)
    notif.BackgroundTransparency=1
    TweenService:Create(notif,TweenInfo.new(0.3),{BackgroundTransparency=0}):Play()

    local titleLabel = Create("TextLabel",{
        Text=title,
        Font=Enum.Font.GothamBold,
        TextColor3=Color3.fromRGB(255,255,255),
        TextSize=18,
        BackgroundTransparency=1,
        Size=UDim2.new(1,0,0,25),
        Parent=notif
    })
    local contentLabel = Create("TextLabel",{
        Text=content,
        Font=Enum.Font.Gotham,
        TextColor3=Color3.fromRGB(200,200,200),
        TextSize=14,
        BackgroundTransparency=1,
        Size=UDim2.new(1,0,1,-25),
        Position=UDim2.new(0,0,0,25),
        Parent=notif
    })
    delay(duration or 3,function()
        TweenService:Create(notif,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        wait(0.3)
        notif:Destroy()
    end)
end

-- Draggable function
local function MakeDraggable(frame)
    local dragging=false
    local dragInput,mousePos,framePos
    local function update(input)
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging=true
            mousePos=input.Position
            framePos=frame.Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then
                    dragging=false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement then
            dragInput=input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input==dragInput and dragging then
            update(input)
        end
    end)
end

-- Main API
function SlightlyOverdidIt:CreateWindow(options)
    local Window = {}
    Window.__index = Window

    local ScreenGui = Create("ScreenGui",{Name=options.Name or "SlightlyOverdidItUI",ResetOnSpawn=false,Parent=Players.LocalPlayer:WaitForChild("PlayerGui")})

    -- Main Frame with gradient background and shadow
    local MainFrame = Create("Frame",{
        Size=UDim2.new(0,500,0,400),
        Position=UDim2.new(0.5,-250,0.5,-200),
        BackgroundColor3=Color3.fromRGB(35,35,35),
        BorderSizePixel=0,
        Parent=ScreenGui
    })
    local corner = Create("UICorner",{CornerRadius=UDim.new(0,15),Parent=MainFrame})
    local shadow = Create("ImageLabel",{
        Size=UDim2.new(1,30,1,30),
        Position=UDim2.new(0,-15,0,-15),
        BackgroundTransparency=1,
        Image="rbxassetid://6014261993",
        ScaleType=Enum.ScaleType.Slice,
        SliceCenter=Rect.new(10,10,118,118),
        Parent=MainFrame
    })
    local UIGradient = Create("UIGradient",{Color=ColorSequence.new(Color3.fromRGB(45,45,80),Color3.fromRGB(80,45,45)),Parent=MainFrame})

    MakeDraggable(MainFrame)

    -- Title
    local Title = Create("TextLabel",{
        Size=UDim2.new(1,-50,0,50),
        BackgroundTransparency=1,
        Text=options.Name or "SlightlyOverdidIt UI",
        TextColor3=Color3.fromRGB(255,255,255),
        Font=Enum.Font.GothamBold,
        TextSize=24,
        Position=UDim2.new(0,10,0,0),
        Parent=MainFrame
    })

    -- Close button
    local CloseButton = Create("TextButton",{
        Size=UDim2.new(0,40,0,40),
        Position=UDim2.new(1,-50,0,5),
        BackgroundColor3=Color3.fromRGB(255,50,50),
        Text="X",
        TextColor3=Color3.fromRGB(255,255,255),
        Font=Enum.Font.GothamBold,
        TextSize=20,
        Parent=MainFrame
    })
    local cornerBtn = Create("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseButton})
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(255,80,80)}):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(255,50,50)}):Play()
    end)
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)

    Window.Tabs = {}

    -- Tab creation function
    function Window:CreateTab(name)
        local Tab = {}
        Tab.__index = Tab

        local SectionFrame = Create("ScrollingFrame",{
            Size=UDim2.new(1,-20,1,-60),
            Position=UDim2.new(0,10,0,60),
            BackgroundTransparency=1,
            CanvasSize=UDim2.new(0,0,0,0),
            ScrollBarThickness=6,
            Parent=MainFrame
        })

        Tab.Sections = {}

        -- Section creation
        function Tab:CreateSection(sectionName)
            local section = Create("Frame",{
                Size=UDim2.new(1,0,0,120),
                BackgroundColor3=Color3.fromRGB(55,55,55),
                BorderSizePixel=0,
                Parent=SectionFrame
            })
            local corner = Create("UICorner",{CornerRadius=UDim.new(0,10),Parent=section})
            local label = Create("TextLabel",{
                Size=UDim2.new(1,0,0,25),
                BackgroundTransparency=1,
                Text=sectionName,
                TextColor3=Color3.fromRGB(255,255,255),
                Font=Enum.Font.GothamBold,
                TextSize=18,
                Parent=section
            })
            section.UIListLayout = Create("UIListLayout",{Parent=section})
            section.UIListLayout.Padding=UDim.new(0,5)

            table.insert(Tab.Sections,section)
            return section
        end

        table.insert(Window.Tabs,Tab)
        return Tab
    end

    return Window
end

return SlightlyOverdidIt
