--[[
    📌 Anti-debug & whitelist protection script
    ⚠️ ใช้งานสำหรับการป้องกันการแฮกและ UI ตรวจจับ
--]]

-- 📁 ปิดเสียง log ต่าง ๆ
local function disableConsoleOutput()
    local fake = function() return "Secret" end
    local toHook = {"rconsoleprint", "rconsolewarn", "rconsoleinfo", "rconsoleerr", "rconsolelog"}
    for _, name in ipairs(toHook) do
        local original = getfenv()[name]
        if original then
            --while true do end
            print("Fuck U CrackerMan")
            hookfunction(original, fake)
        end
    end
end
-- "print", "warn", 
-- 🛡️ ป้องกันฟังก์ชันสำคัญจากการโดนแฮก
local function secureFunctions()
    local fake = function() return "Blocked" end
    local targets = {"hookfunction", "hookfunc", "replaceclosure", "getrawmetatable", "setreadonly"}
    for _, name in ipairs(targets) do
        local fn = getfenv()[name] or _G[name]
        if fn then
            --while true do end
            print("Fuck U CrackerMan2")
            hookfunction(fn, fake)
        end
    end
end

-- 🧼 ล้าง GUI ที่ไม่ได้รับอนุญาต
--[[local function cleanUnauthorizedGUIs()
    local forbiddenNames = {"DevConsole", "dark dex", "dex", "Spy", "RemoteSpy", "spyu"}
    for _, gui in ipairs(game:GetDescendants()) do
        if gui:IsA("ScreenGui") or gui:IsA("TextLabel") then
            for _, keyword in ipairs(forbiddenNames) do
                if string.lower(gui.Name):find(string.lower(keyword)) or string.lower(gui.Text or ""):find(string.lower(keyword)) then
                    gui:Destroy()
                    print("Fuck U CrackerMan3")
                    --while true do end
                end
            end
        end
    end
end]]--

-- 🚫 ตรวจจับ UI ที่พยายามดักข้อมูล
local function detectSpyingUI()
    for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:lower():find("spyu") then
            --while true do end
            error("Spy UI detected.")
            print("Fuck U CrackerMan4")
        end
    end
end

-- 📦 ส่งข้อมูล whitelist ตรวจสอบกับเซิร์ฟเวอร์
local function whitelistCheck()
    local http = game:GetService("HttpService")
    local player = game.Players.LocalPlayer
    local key, discordid, hwid = "YourKeyHere", "YourDiscordID", "YourHWID"

    local data = http:JSONEncode({
        Key = key,
        DiscordID = discordid,
        HWID = hwid
    })

    local url = "http://127.0.0.1:3000/checkwhitelist"
    local success, response = pcall(function()
        return http:PostAsync(url, data, Enum.HttpContentType.ApplicationJson)
    end)

    if not success or not response or string.lower(response) ~= "whitelisted" then
        print("Fuck U CrackerMan5")
        --game.Players.LocalPlayer:Kick("❌ You are not whitelisted.")
    end
end

-- 🔐 รันฟังก์ชันทั้งหมด
pcall(disableConsoleOutput)
pcall(secureFunctions)
--pcall(cleanUnauthorizedGUIs)
pcall(detectSpyingUI)
pcall(whitelistCheck)


local repo = 'https://raw.githubusercontent.com/skylysoft/UiLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'LinoriaLib.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'x2Sky_zxc Project',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}


local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Main')
local Right = Tabs.Main:AddRightGroupbox('Teleport')
local Player = Tabs.Main:AddRightGroupbox('Player')

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Esp All Ore',
    Default = false,
    Tooltip = 'Esp All Ore',

    Callback = function(v)
        EspOre = v
    end
})

LeftGroupBox:AddButton({
    Text = 'Reset Bomb',
    Func = function()
        ResetBomb()
    end,
    DoubleClick = false,
    Tooltip = 'Reset Ur Cooldown Bomb'
})

LeftGroupBox:AddButton({
    Text = 'Save Pos1',
    Func = function()
        _G.Pos1 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Cave'
})

LeftGroupBox:AddButton({
    Text = 'Save Pos2',
    Func = function()
        _G.Pos2 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Cave'
})

LeftGroupBox:AddButton({
    Text = 'Tp To Old Pos1',
    Func = function()
        BypassTP(_G.Pos1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Old Position 1'
})

LeftGroupBox:AddButton({
    Text = 'Tp To Old Pos2',
    Func = function()
        BypassTP(_G.Pos2)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Old Position 2'
})

Right:AddButton({
    Text = 'Tp To Cave',
    Func = function()
        BypassTP(Cave)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Cave'
})

Right:AddButton({
    Text = 'Tp To Home',
    Func = function()
        local myPlot = GetHome()

        if myPlot then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myPlot:GetPivot().Position)
        end
    end,
    DoubleClick = false,
    Tooltip = 'Teleport To Ur Home'
})

Right:AddButton({
    Text = 'Rejoin',
    Func = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end,
    DoubleClick = false,
    Tooltip = 'Rejoin'
})

Right:AddButton({
    Text = 'Hop Server',
    Func = function()
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/skylysoft/API/main/Hop%20Server.lua")()

        module:Teleport(game.PlaceId)
    end,
    DoubleClick = false,
    Tooltip = 'Hop Server'
})

Right:AddButton({
    Text = 'Hop Lower Server',
    Func = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"

        local _place = game.PlaceId
        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
        end

        local Server, Next; repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
        until Server

        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
    end,
    DoubleClick = false,
    Tooltip = 'Hop Lower Server'
})


Player:AddSlider('MySlider', {
    Text = 'WalkSpeed',
    Default = 100,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        walkSpeed = v
    end
})

GetSubPrefix=function(a)
	local a=tostring(a):gsub(" ","");
	local bX="";
	if#a==2 then 
		local Yp=string.sub(a,#a,#a+1);
		bX=Yp=="1"and"st"or Yp=="2"and"nd"or Yp=="3"and"rd"or"th";
	end;
	return bX;
end;

local h="%A, %B";local t=os.date(" %d",os.time());
local l=", %Y.";
h=os.date(h,os.time())..t..GetSubPrefix(t)..os.date(l,os.time());

Library:SetWatermarkVisibility(true)

Library:SetWatermark("x2Sky_zxc Project | " .. tostring(h));

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Delete', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
