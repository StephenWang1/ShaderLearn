--- 地宫挖宝界面
--- Created by Olivier.
--- DateTime: 2021/3/8 10:44
---
---@class UIDiggingTreasurePanel:UIBase
local UIDiggingTreasurePanel = {}
UIDiggingTreasurePanel.ItemId = 8500001
UIDiggingTreasurePanel.ItemCost = 10
UIDiggingTreasurePanel.MaxCount = 480
UIDiggingTreasurePanel.ColorGreed = "[00ff00]"
UIDiggingTreasurePanel.ColorRed = "[ff0000]"


function UIDiggingTreasurePanel:Init()
    self:InitVariable()
    self:InitComponents()
    self:BindEvent()
end

function UIDiggingTreasurePanel:Show()
    local ItemCfg = clientTableManager.cfg_itemsManager:TryGetValue(UIDiggingTreasurePanel.ItemId)
    if ItemCfg ~= nil then
        self.Components.sp_itemIcon.spriteName = ItemCfg:GetIcon() 
    end
    self:RefreshCount()
    self:RefreshBtn()
    networkRequest.ReqOpenDigTreasureWareHouse()
end

function UIDiggingTreasurePanel:InitVariable()
    self.Components = {}
end

function UIDiggingTreasurePanel:InitComponents()
    self.Components.btn_warehouse = self:GetCurComp('WidgetRoot/diggingTreasure/ball', 'GameObject')
    self.Components.go_red = self:GetCurComp('WidgetRoot/diggingTreasure/redPoint', 'GameObject')
    self.Components.btn_dig = self:GetCurComp('WidgetRoot/diggingTreasure/dig/btn_dig', 'GameObject')
    self.Components.sp_btnDig = self:GetCurComp('WidgetRoot/diggingTreasure/dig/btn_dig/backGround', 'UISprite')
    self.Components.sp_itemIcon = self:GetCurComp('WidgetRoot/diggingTreasure/dig/cost/icon', 'UISprite')
    self.Components.lb_itemCount = self:GetCurComp('WidgetRoot/diggingTreasure/dig/cost/num', 'UILabel')
    self.Components.go_add = self:GetCurComp('WidgetRoot/diggingTreasure/dig/cost/add', 'GameObject')
    self.Components.go_red_label = self:GetCurComp('WidgetRoot/diggingTreasure/redPoint/EmptyGridCount', 'GameObject')

    self.Components.sp_btnDig_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2/btn_dig/backGround', 'UISprite')
    self.Components.lb_itemCount_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2/cost/num', 'UILabel')
    self.Components.go_add_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2/cost/add', 'GameObject')
    self.Components.btn_dig_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2/btn_dig', 'GameObject')
    self.Components.sp_Bg= self:GetCurComp('WidgetRoot/diggingTreasure/background', 'UISprite')
    self.Components.dig_gameObject = self:GetCurComp('WidgetRoot/diggingTreasure', 'GameObject')
    self.Components.dig_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2', 'GameObject')
    self.Components.sp_btnDig_Des_sec = self:GetCurComp('WidgetRoot/diggingTreasure/dig2/btn_dig/Label', 'UILabel')
end

function UIDiggingTreasurePanel:BindEvent()
    CS.UIEventListener.Get(self.Components.btn_warehouse).onClick = UIDiggingTreasurePanel.WarehouseBtnClick
    CS.UIEventListener.Get(self.Components.go_add).LuaEventTable = self
    CS.UIEventListener.Get(self.Components.go_add).OnClickLuaDelegate = self.AddBtnClick
    CS.UIEventListener.Get(self.Components.go_add_sec).onClick = function()
        self:AddSecBtnClick()
    end
    CS.UIEventListener.Get(self.Components.btn_dig).LuaEventTable = self
    CS.UIEventListener.Get(self.Components.btn_dig).OnClickLuaDelegate = self.OnClickDigBtn
    CS.UIEventListener.Get(self.Components.btn_dig_sec).OnClickLuaDelegate = self.OnClickSecDigBtn
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCount()
    end)
    self.OnCommonShowTips = function(id, data)
        self:OnRedPointShow()
        local dataCount = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetNotNilCount()
        self.Components.go_red_label:SetActive(dataCount >= UIDiggingTreasurePanel.MaxCount)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDigTreasureWareHouseMessage, self.OnCommonShowTips)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.GoldDigChange, function(id)
        self:RefreshBtn()
    end)
end

function  UIDiggingTreasurePanel.WarehouseBtnClick()
    uimanager:CreatePanel("UIDigWarehousePanel")
end

function  UIDiggingTreasurePanel:AddBtnClick()
    Utility.ShowItemGetWay(UIDiggingTreasurePanel.ItemId, self.Components.go_add, LuaEnumWayGetPanelArrowDirType.Left)
end

---黄金矿搞获取点击事件
function UIDiggingTreasurePanel:AddSecBtnClick()
    Utility.ShowItemGetWay(tonumber(self.globalTbl[1]), self.Components.go_add_sec, LuaEnumWayGetPanelArrowDirType.Left)
end

---黄金矿搞使用
function UIDiggingTreasurePanel:OnClickSecDigBtn()
    local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(tonumber(UIDiggingTreasurePanel.globalTbl[1]))
    if playerHas >= tonumber(UIDiggingTreasurePanel.globalTbl[2]) then
        CS.CSAutoFightMgr.Instance:Toggle(false)
        --关闭自动寻路
        CS.CSPathFinderManager.Instance:Reset(true, true)
        --清除当前任务
        CS.CSMissionManager.Instance:ClearCurrentTask()
        --清除并关闭目标选择系统
        CS.CSTargetGetWayManager.Instanece:Clear()
        networkRequest.ReqDigTreasure(1)
    else
        Utility.ShowItemGetWay(tonumber(UIDiggingTreasurePanel.globalTbl[1]), UIDiggingTreasurePanel.Components.go_add_sec, LuaEnumWayGetPanelArrowDirType.Left)
    end
end

function  UIDiggingTreasurePanel:OnClickDigBtn()
    local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(UIDiggingTreasurePanel.ItemId)
    if playerHas > 9 then
        CS.CSAutoFightMgr.Instance:Toggle(false)
        --关闭自动寻路
        CS.CSPathFinderManager.Instance:Reset(true, true)
        --清除当前任务
        CS.CSMissionManager.Instance:ClearCurrentTask()
        --清除并关闭目标选择系统
        CS.CSTargetGetWayManager.Instanece:Clear()
        networkRequest.ReqDigTreasure()
    else
        Utility.ShowItemGetWay(UIDiggingTreasurePanel.ItemId, self.Components.go_add, LuaEnumWayGetPanelArrowDirType.Left)
    end
end

function UIDiggingTreasurePanel:RefreshCount()
    local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(UIDiggingTreasurePanel.ItemId)
    local str = playerHas >= UIDiggingTreasurePanel.ItemCost and UIDiggingTreasurePanel.ColorGreed or UIDiggingTreasurePanel.ColorRed
    self.Components.lb_itemCount.text = str..playerHas..("[-]/")..UIDiggingTreasurePanel.ItemCost
    self.Components.sp_btnDig.spriteName = playerHas >= UIDiggingTreasurePanel.ItemCost and "anniu12" or "anniu13"

    local globalData = self:GetGlobalTable(23062)
    if globalData == nil then
        return
    end
    local globalTbl = string.Split(globalData, "#")
    local platerHas_sec = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(tonumber(globalTbl[1]))
    if platerHas_sec == nil or globalTbl[2] == nil then
        return
    end
    self.globalTbl = globalTbl
    local str_sec = platerHas_sec >= tonumber(globalTbl[2]) and UIDiggingTreasurePanel.ColorGreed or UIDiggingTreasurePanel.ColorRed
    self.Components.lb_itemCount_sec.text = str_sec..platerHas_sec.."[-]/"..globalTbl[2]
    self.Components.sp_btnDig_sec.spriteName = platerHas_sec >= tonumber(globalTbl[2]) and "anniu12" or "anniu14"
    self.Components.sp_btnDig_Des_sec.text = "挖宝10次"
end

---根据活动状态显示不同按钮组件
function UIDiggingTreasurePanel:RefreshBtn()
    local isShow = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetActive()
    if isShow == true then
        self.Components.sp_Bg.width = 380
        self.Components.dig_sec:SetActive(true)
        local v3 = CS.UnityEngine.Vector3.zero
        v3.x = -15
        v3.y = -155
        self.Components.dig_gameObject.transform.localPosition = v3
    else
        self.Components.sp_Bg.width = 240
        self.Components.dig_sec:SetActive(false)
        local v3 = CS.UnityEngine.Vector3.zero
        v3.x = 55
        v3.y = -155
        self.Components.dig_gameObject.transform.localPosition = v3
    end
end

function UIDiggingTreasurePanel:OnRedPointShow()
    local isShow = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():CheckRedPoint()
    self.Components.go_red:SetActive(isShow)
    self.Components.go_red_label:SetActive(false)

end

function UIDiggingTreasurePanel:OnDestroy()
    
end

---读取global
function UIDiggingTreasurePanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    return Lua_GlobalTABLE.value
end

return UIDiggingTreasurePanel