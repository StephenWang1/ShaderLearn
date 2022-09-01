--- 地宫挖宝数据
--- Created by Olivier.
--- DateTime: 2021/3/5 11:40
---
local LuaDigTreasureDataManager = {}


function LuaDigTreasureDataManager:Init()
    self.WarehouseDic = {}
    self.DigCount = 0
    self.NotNilCount = 0
    for i = 0, 11 do
        local tab  = {}
        for j = 1, 40 do
            table.insert(tab, { bagItemInfo = nil })
        end
        self.WarehouseDic[i] = tab
    end
end

function LuaDigTreasureDataManager:GetLingHunMissionData()
    if self.mLuaDigTreasureDataItem == nil then
        self.mLuaDigTreasureDataItem = luaclass.LuaDigTreasureDataItem:New()
    end
    return self.mLuaDigTreasureDataItem
end


function LuaDigTreasureDataManager:GetData()
    return self.WarehouseDic
end

function LuaDigTreasureDataManager.GetRevTab(tab)
    local revtab = {}
    for i, v in pairs(tab) do
        revtab[v] = true
    end
    return revtab
end

function LuaDigTreasureDataManager.Contains(tab,item)
    return LuaDigTreasureDataManager.GetRevTab(tab)[item]
end


function LuaDigTreasureDataManager:GetNetMes(msg)
    self.itemInfo = msg.itemInfo
    local mesCount = msg.itemInfo == nil and 0 or #msg.itemInfo
    local notNil = 0
    for i = 0, 11 do
        local tab = self.WarehouseDic[i]
        for j = 1, 40 do
            local TempIndex = i * 40 + j
            if mesCount ==  0 then
                tab[j].bagItemInfo = nil
            else
                if TempIndex <= mesCount then
                    notNil = notNil + 1
                    tab[j].bagItemInfo = msg.itemInfo[TempIndex]
                else
                    tab[j].bagItemInfo = nil
                end
            end
        end
        self.NotNilCount = notNil
        --print("第"..(i+1).."页数据count = "..notNil)
    end
    --print("挖宝仓库数量",#msg.itemInfo,msg.addItemLid)
    if msg.addItemLid ~= nil then
        for k = 1, #msg.addItemLid do
            if msg.addItemLid[k] ~= 0 then
                CS.CSAutoFightMgr.Instance.AutoPickUpByBuffer:FlyDigTreasureItem(tonumber(msg.addItemLid[k]));
            end
        end
    end
end

function LuaDigTreasureDataManager:SetDigCount(msg)
    --print("收到挖宝次数变动",msg.count)
    self.DigCount = msg.count
end

function LuaDigTreasureDataManager:IsShowDigPanel()
    local mapId = CS.CSScene.MainPlayerInfo.MapID
    if mapId == 130001 then
        return true
    end
    return false
end

function LuaDigTreasureDataManager:GetDigCount()
    return self.DigCount
end

function LuaDigTreasureDataManager:GetNotNilCount()
    return self.NotNilCount
end

function LuaDigTreasureDataManager:CheckRedPoint()
    if #self.itemInfo > 0 then
        return true
    end
    return false
end

---获取活动状态
function LuaDigTreasureDataManager:GetActive()
    if self.state == nil then
        return false
    end
    return self.state
end

---设置活动状态
function LuaDigTreasureDataManager:SetActive(state)
    self.state = state
    luaEventManager.DoCallback(LuaCEvent.GoldDigChange)
end


return LuaDigTreasureDataManager