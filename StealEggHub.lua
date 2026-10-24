-- STEAL AN EGG HUB | NEON EDITION
-- UI foundation only. No live-game automation or server actions are connected.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("StealEggHub")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(12,13,19), panel = Color3.fromRGB(19,21,30),
    card = Color3.fromRGB(25,28,39), raised = Color3.fromRGB(33,36,49),
    accent = Color3.fromRGB(0,235,180), text = Color3.fromRGB(241,243,250),
    muted = Color3.fromRGB(135,142,161), red = Color3.fromRGB(255,82,105),
    border = Color3.fromRGB(47,51,67)
}
local settings, stopped, buttons, pages = {}, false, {}, {}

local function new(class, props, parent)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end
local function round(o, r)
    new("UICorner", {CornerRadius=UDim.new(0,r or 9)}, o)
end
local function outline(o, color, transparency)
    new("UIStroke", {Color=color or C.border, Transparency=transparency or 0, Thickness=1}, o)
end
local function animate(o, duration, props)
    local t = TweenService:Create(o, TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    t:Play()
end

local gui = new("ScreenGui", {Name="StealEggHub", ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling}, playerGui)
local main = new("Frame", {
    Name="Main", Size=UDim2.fromOffset(760,500), Position=UDim2.new(.5,-380,.5,-250),
    BackgroundColor3=C.bg, BorderSizePixel=0, ClipsDescendants=true
}, gui)
round(main,15); outline(main,C.accent,.55)

local top = new("Frame", {Size=UDim2.new(1,0,0,60), BackgroundColor3=C.panel, BorderSizePixel=0}, main)
new("UIGradient", {Color=ColorSequence.new(C.panel,Color3.fromRGB(28,21,43))}, top)
local logo = new("Frame", {Position=UDim2.fromOffset(16,12),Size=UDim2.fromOffset(36,36),BackgroundColor3=C.accent},top)
round(logo,10)
new("TextLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text="S",TextColor3=C.bg,TextSize=23,Font=Enum.Font.GothamBlack},logo)
new("TextLabel",{Position=UDim2.fromOffset(62,10),Size=UDim2.fromOffset(250,24),BackgroundTransparency=1,Text="STEAL AN EGG",TextColor3=C.text,TextSize=17,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},top)
new("TextLabel",{Position=UDim2.fromOffset(63,33),Size=UDim2.fromOffset(240,16),BackgroundTransparency=1,Text="NEON HUB  /  UI BUILD",TextColor3=C.muted,TextSize=9,Font=Enum.Font.GothamMedium,TextXAlignment=Enum.TextXAlignment.Left},top)
local dot = new("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-115,.5,0),Size=UDim2.fromOffset(8,8),BackgroundColor3=C.accent},top); round(dot,9)
local status = new("TextLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-15,.5,0),Size=UDim2.fromOffset(90,20),BackgroundTransparency=1,Text="UI READY",TextColor3=C.accent,TextSize=10,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right},top)

local sidebar = new("Frame",{Position=UDim2.fromOffset(0,60),Size=UDim2.new(0,170,1,-60),BackgroundColor3=C.panel,BorderSizePixel=0},main)
new("Frame",{Position=UDim2.new(1,-1,0,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=C.border,BorderSizePixel=0},sidebar)
new("TextLabel",{Position=UDim2.fromOffset(16,14),Size=UDim2.new(1,-25,0,18),BackgroundTransparency=1,Text="WORKSPACE",TextColor3=C.muted,TextSize=10,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},sidebar)
local nav = new("Frame",{Position=UDim2.fromOffset(8,40),Size=UDim2.new(1,-16,0,270),BackgroundTransparency=1},sidebar)
new("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},nav)
local content = new("Frame",{Position=UDim2.fromOffset(170,60),Size=UDim2.new(1,-170,1,-60),BackgroundTransparency=1},main)
local title = new("TextLabel",{Position=UDim2.fromOffset(20,15),Size=UDim2.new(1,-40,0,28),BackgroundTransparency=1,Text="Main",TextColor3=C.text,TextSize=22,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},content)
local subtitle = new("TextLabel",{Position=UDim2.fromOffset(21,43),Size=UDim2.new(1,-42,0,18),BackgroundTransparency=1,Text="Your hub at a glance.",TextColor3=C.muted,TextSize=11,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},content)
local area = new("Frame",{Position=UDim2.fromOffset(14,73),Size=UDim2.new(1,-28,1,-85),BackgroundTransparency=1},content)

local function toast(msg)
    local t = new("TextLabel",{AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-12,1,-12),Size=UDim2.fromOffset(245,40),BackgroundColor3=C.raised,Text=msg,TextColor3=C.text,TextSize=11,Font=Enum.Font.GothamMedium,TextWrapped=true,ZIndex=10},main)
    round(t,9); outline(t,C.accent,.3)
    t.Position = t.Position + UDim2.fromOffset(0,10)
    animate(t,.18,{Position=UDim2.new(1,-12,1,-12)})
    task.delay(2,function()
        if t.Parent then animate(t,.18,{TextTransparency=1,BackgroundTransparency=1}); task.wait(.2); t:Destroy() end
    end)
end
local function page()
    local s = new("ScrollingFrame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.accent,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},area)
    new("UIListLayout",{Padding=UDim.new(0,9),SortOrder=Enum.SortOrder.LayoutOrder},s)
    new("UIPadding",{PaddingRight=UDim.new(0,4),PaddingBottom=UDim.new(0,8)},s)
    return s
end
local function section(parent, heading, desc)
    local f = new("Frame",{Size=UDim2.new(1,-2,0,desc and 66 or 43),BackgroundColor3=C.card,BorderSizePixel=0},parent)
    round(f,9); outline(f,C.border,.35)
    new("TextLabel",{Position=UDim2.fromOffset(12,7),Size=UDim2.new(1,-24,0,20),BackgroundTransparency=1,Text=heading,TextColor3=C.text,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},f)
    if desc then new("TextLabel",{Position=UDim2.fromOffset(12,29),Size=UDim2.new(1,-24,0,29),BackgroundTransparency=1,Text=desc,TextColor3=C.muted,TextSize=10,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},f) end
    return f
end
local function toggle(parent, name, desc, initial)
    local f = new("Frame",{Size=UDim2.new(1,-2,0,desc and 62 or 45),BackgroundColor3=C.card,BorderSizePixel=0},parent)
    round(f,9); outline(f,C.border,.5)
    new("TextLabel",{Position=UDim2.fromOffset(11,desc and 6 or 0),Size=UDim2.new(1,-70,0,20),BackgroundTransparency=1,Text=name,TextColor3=C.text,TextSize=11,Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left},f)
    if desc then new("TextLabel",{Position=UDim2.fromOffset(11,28),Size=UDim2.new(1,-76,0,26),BackgroundTransparency=1,Text=desc,TextColor3=C.muted,TextSize=9,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},f) end
    local track = new("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(38,21),BackgroundColor3=C.raised,Text="",AutoButtonColor=false},f); round(track,12)
    local knob = new("Frame",{Position=UDim2.fromOffset(3,3),Size=UDim2.fromOffset(15,15),BackgroundColor3=C.text},track); round(knob,9)
    settings[name] = initial == true
    local function paint(animated)
        local on = settings[name]
        local p = on and UDim2.new(1,-18,0,3) or UDim2.fromOffset(3,3)
        if animated then animate(knob,.13,{Position=p}); animate(track,.13,{BackgroundColor3=on and C.accent or C.raised})
        else knob.Position=p; track.BackgroundColor3=on and C.accent or C.raised end
    end
    paint(false)
    track.Activated:Connect(function()
        if stopped then toast("Hub stopped — resume first."); return end
        settings[name] = not settings[name]; paint(true)
        toast(name..(settings[name] and " enabled" or " disabled"))
    end)
end
local function slider(parent,name,min,max,initial)
    local f = new("Frame",{Size=UDim2.new(1,-2,0,62),BackgroundColor3=C.card,BorderSizePixel=0},parent)
    round(f,9); outline(f,C.border,.5)
    new("TextLabel",{Position=UDim2.fromOffset(11,7),Size=UDim2.new(1,-85,0,20),BackgroundTransparency=1,Text=name,TextColor3=C.text,TextSize=11,Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left},f)
    local val = new("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-11,0,7),Size=UDim2.fromOffset(60,20),BackgroundTransparency=1,Text=tostring(initial),TextColor3=C.accent,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right},f)
    local bar = new("Frame",{Position=UDim2.new(0,11,0,39),Size=UDim2.new(1,-22,0,5),BackgroundColor3=C.raised},f); round(bar,5)
    local fill = new("Frame",{Size=UDim2.new((initial-min)/(max-min),0,1,0),BackgroundColor3=C.accent},bar); round(fill,5)
    local hit = new("TextButton",{Position=UDim2.new(0,-4,0,-9),Size=UDim2.new(1,8,0,23),BackgroundTransparency=1,Text="",AutoButtonColor=false},bar)
    settings[name] = initial
    local function set(x)
        local a = math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        local v = math.floor(min+a*(max-min)+.5); settings[name]=v; val.Text=tostring(v)
        animate(fill,.05,{Size=UDim2.new(a,0,1,0)})
    end
    hit.Activated:Connect(function() if not stopped then set(UIS:GetMouseLocation().X) end end)
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then set(i.Position.X) end end)
end
local function action(parent, heading, desc, callback, danger)
    local b = new("TextButton",{Size=UDim2.new(1,-2,0,48),BackgroundColor3=danger and Color3.fromRGB(48,24,35) or C.card,BorderSizePixel=0,Text="",AutoButtonColor=false},parent)
    round(b,9); outline(b,danger and C.red or C.border,.35)
    new("TextLabel",{Position=UDim2.fromOffset(11,5),Size=UDim2.new(1,-22,0,19),BackgroundTransparency=1,Text=heading,TextColor3=danger and C.red or C.text,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},b)
    new("TextLabel",{Position=UDim2.fromOffset(11,25),Size=UDim2.new(1,-22,0,15),BackgroundTransparency=1,Text=desc,TextColor3=C.muted,TextSize=9,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},b)
    b.Activated:Connect(callback)
end

local tabData = {
    {"Main","⌂"},{"Eggs","◇"},{"Events","✦"},{"Pets","♧"},{"Player","➤"},{"Settings","⚙"}
}
local function build(name)
    local s = page(); pages[name]=s
    if name=="Main" then
        section(s,"Welcome back","Steal an Egg Hub • Neon Edition")
        section(s,"Session status","Interface loaded. Game actions are not connected.")
        toggle(s,"Notifications","Show hub status notifications.",true)
        toggle(s,"Compact UI","Preference only; layout resizing is not wired.",false)
        action(s,"PANIC STOP","Disable UI controls until resumed.",function()
            stopped=true; status.Text="STOPPED"; status.TextColor3=C.red; dot.BackgroundColor3=C.red; toast("Panic stop enabled.")
        end,true)
        action(s,"RESUME UI","Re-enable UI preferences.",function()
            stopped=false; status.Text="UI READY"; status.TextColor3=C.accent; dot.BackgroundColor3=C.accent; toast("UI controls resumed.")
        end)
    elseif name=="Eggs" then
        section(s,"Egg controls","Preferences only — auto-stealing is not connected.")
        toggle(s,"Auto Steal Eggs","Requires supported game integration.",false)
        toggle(s,"Rare Eggs Only","Rarity filter preference.",false)
        toggle(s,"Mythic Filter","Rarity filter preference.",false)
        toggle(s,"Legendary Filter","Rarity filter preference.",false)
        slider(s,"Egg Scan Range",10,500,100)
        section(s,"Integration status","No verified game interface is configured.")
    elseif name=="Events" then
        section(s,"Event center","Preferences for supported event features.")
        toggle(s,"Auto Event Farm","Not connected to game automation.",false)
        toggle(s,"Auto Treadmill","Not connected to treadmill mechanics.",false)
        toggle(s,"Event Notifications","UI preference for event alerts.",true)
        slider(s,"Event Scan Range",10,500,150)
    elseif name=="Pets" then
        section(s,"Pet manager","Inventory features require supported server integration.")
        toggle(s,"Pet Notifications","UI preference for pet messages.",true)
        toggle(s,"Rare Pet Filter","Filter preference for an inventory viewer.",false)
        toggle(s,"Show Inventory Panel","Live inventory is not loaded.",true)
        action(s,"Inventory Status","Check integration status.",function() toast("Live pet inventory is not connected.") end)
        action(s,"Duplication Status","No duplication request will be sent.",function() toast("Pet duplication is not implemented.") end)
    elseif name=="Player" then
        section(s,"Movement settings","Preferences only; no live character changes.")
        slider(s,"Speed Preference",16,100,16)
        toggle(s,"Fly Preference","Requires supported, authorized implementation.",false)
        toggle(s,"Anti-Ragdoll Preference","Not connected to game mechanics.",false)
        toggle(s,"Anti-Trap Preference","Not connected to game mechanics.",false)
        toggle(s,"Anti-Guard Preference","Not connected to game mechanics.",false)
        action(s,"Teleport Status","No teleport action is connected.",function() toast("Teleport integration is unavailable.") end)
    elseif name=="Settings" then
        section(s,"Interface settings","Adjust hub preferences.")
        toggle(s,"Accent Glow","Theme preference.",true)
        slider(s,"UI Scale",80,120,100)
        action(s,"Reset Preferences","Reset saved-in-memory UI preferences.",function()
            for k in pairs(settings) do settings[k]=false end
            toast("Preferences reset in memory.")
        end)
        section(s,"About","STEAL AN EGG HUB • NEON EDITION")
    end
end
local function select(name)
    title.Text=name
    subtitle.Text=({Main="Your hub at a glance.",Eggs="Egg selection and rarity preferences.",Events="Event and treadmill preferences.",Pets="Pet manager and inventory status.",Player="Movement and player preferences.",Settings="Interface and hub configuration."})[name] or ""
    for n,p in pairs(pages) do p.Visible=(n==name) end
    for n,b in pairs(buttons) do
        local chosen=n==name
        animate(b,.12,{BackgroundColor3=chosen and C.raised or C.panel})
        b.TextColor3=chosen and C.accent or C.muted
        local marker=b:FindFirstChild("Indicator")
        if marker then marker.BackgroundTransparency=chosen and 0 or 1 end
    end
end
for i,item in ipairs(tabData) do
    local name,glyph=item[1],item[2]
    local b=new("TextButton",{Name=name,Size=UDim2.new(1,0,0,38),BackgroundColor3=C.panel,BorderSizePixel=0,Text="   "..glyph.."     "..name,TextColor3=C.muted,TextSize=11,Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=i,AutoButtonColor=false},nav)
    round(b,8)
    local marker=new("Frame",{Name="Indicator",Position=UDim2.fromOffset(0,7),Size=UDim2.new(0,3,1,-14),BackgroundColor3=C.accent,BackgroundTransparency=1,BorderSizePixel=0},b); round(marker,4)
    buttons[name]=b; b.Activated:Connect(function() select(name) end)
end
for _,item in ipairs(tabData) do build(item[1]) end
select("Main")

-- Drag window using the top bar.
local dragging, dragStart, startPos
top.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dragging=true; dragStart=i.Position; startPos=main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dragStart
        main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)
local opener=new("TextButton",{Name="HubToggle",Position=UDim2.new(0,16,.5,-22),Size=UDim2.fromOffset(44,44),BackgroundColor3=C.panel,Text="S",TextColor3=C.accent,TextSize=20,Font=Enum.Font.GothamBlack,BorderSizePixel=0,AutoButtonColor=false},gui)
round(opener,12); outline(opener,C.accent,.3)
opener.Activated:Connect(function() main.Visible=not main.Visible end)
toast("Steal an Egg Hub UI loaded.")
