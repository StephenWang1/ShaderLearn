---@class UIGuildBossInspirePanel 鼓舞界面
local UIGuildBossInspirePanel = {}

--region 组件的获取

---得到关闭界面按钮
function UIGuildBossInspirePanel:GetBtnClose()
    if (self.mGetBtnClose == nil) then
        self.mGetBtnClose = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mGetBtnClose
end

---得到个人鼓舞按钮
function UIGuildBossInspirePanel:GetBtnInspirePerson()
    if (self.mGetBtnInspirePerson == nil) then
        self.mGetBtnInspirePerson = self:GetCurComp("WidgetRoot/view/left/Btn", "GameObject")
    end
    return self.mGetBtnInspirePerson
end

---个人加成的数值
function UIGuildBossInspirePanel:GetInspirePersonAdditionLabel()
    if (self.mGetInspirePersonAdditionLabel == nil) then
        self.mGetInspirePersonAdditionLabel = self:GetCurComp("WidgetRoot/view/left/inspireNum", "Top_UILabel")
    end
    return self.mGetInspirePersonAdditionLabel
end

---个人鼓舞的剩余次数
function UIGuildBossInspirePanel:GetInspirePersonLastCountLabel()
    if (self.mGetInspirePersonLastCountLabel == nil) then
        self.mGetInspirePersonLastCountLabel = self:GetCurComp("WidgetRoot/view/left/num", "Top_UILabel")
    end
    return self.mGetInspirePersonLastCountLabel
end

---个人鼓舞的花费Icon
function UIGuildBossInspirePanel:GetInspirePersonCostIcon()
    if (self.mGetInspirePersonCostIcon == nil) then
        self.mGetInspirePersonCostIcon = self:GetCurComp("WidgetRoot/view/left/Cost/icon", "Top_UISprite")
    end
    return self.mGetInspirePersonCostIcon
end

---个人鼓舞的花费数量
function UIGuildBossInspirePanel:GetInspirePersonCostCount()
    if (self.mGetInspirePersonCostCount == nil) then
        self.mGetInspirePersonCostCount = self:GetCurComp("WidgetRoot/view/left/Cost/count", "Top_UILabel")
    end
    return self.mGetInspirePersonCostCount
end

---个人鼓舞的BuffAddition
function UIGuildBossInspirePanel:GetInspirePersonInspireNumLabel()
    if (self.mGetInspirePersonInspireNumLabel == nil) then
        self.mGetInspirePersonInspireNumLabel = self:GetCurComp("WidgetRoot/view/left/inspireNum", "Top_UILabel")
    end
    return self.mGetInspirePersonInspireNumLabel
end

---得到公会鼓舞按钮
function UIGuildBossInspirePanel:GetBtnInspireUnion()
    if (self.mGetBtnInspireUnion == nil) then
        self.mGetBtnInspireUnion = self:GetCurComp("WidgetRoot/view/right/Btn2", "GameObject")
    end
    return self.mGetBtnInspireUnion
end

---公会加成的数值
function UIGuildBossInspirePanel:GetInspireUnionAdditionLabel()
    if (self.mGetInspireUnionAdditionLabel == nil) then
        self.mGetInspireUnionAdditionLabel = self:GetCurComp("WidgetRoot/view/right/inspireNum", "Top_UILabel")
    end
    return self.mGetInspireUnionAdditionLabel
end

---公会鼓舞的剩余次数
function UIGuildBossInspirePanel:GetInspireUnionLastCountLabel()
    if (self.mGetInspireUnionLastCountLabel == nil) then
        self.mGetInspireUnionLastCountLabel = self:GetCurComp("WidgetRoot/view/right/num2", "Top_UILabel")
    end
    return self.mGetInspireUnionLastCountLabel
end

---公会鼓舞的花费Icon
function UIGuildBossInspirePanel:GetInspireUnionCostIcon()
    if (self.mGetInspireUnionCostIcon == nil) then
        self.mGetInspireUnionCostIcon = self:GetCurComp("WidgetRoot/view/right/Cost2/icon", "Top_UISprite")
    end
    return self.mGetInspireUnionCostIcon
end

---公会鼓舞的花费数量
function UIGuildBossInspirePanel:GetInspireUnionCostCount()
    if (self.mGetInspireUnionCostCount == nil) then
        self.mGetInspireUnionCostCount = self:GetCurComp("WidgetRoot/view/right/Cost2/count", "Top_UILabel")
    end
    return self.mGetInspireUnionCostCount
end

---公会鼓舞的BuffAddition
function UIGuildBossInspirePanel:GetInspireUnionInspireNumLabel()
    if (self.mGetInspireUnionInspireNumLabel == nil) then
        self.mGetInspireUnionInspireNumLabel = self:GetCurComp("WidgetRoot/view/right/inspireNum", "Top_UILabel")
    end
    return self.mGetInspireUnionInspireNumLabel
end
--endregion

---@type number
UIGuildBossInspirePanel.remainUnionNum = 0

---@type number
UIGuildBossInspirePanel.remainPersonalNum = 0

---@type table<number> buff的ID列表
UIGuildBossInspirePanel.PersonBuffList = {}

---@type table<number> buff的ID列表
UIGuildBossInspirePanel.UnionBuffList = {}

function UIGuildBossInspirePanel:Init()
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.UnionInspireDiamondNotEnough
    self:InitData()
    self:InitUI()
    self:BindEvent()
    self:BindMessage()

    networkRequest.ReqUnionBossBuffInfo()
end

function UIGuildBossInspirePanel:InitData()

    local isfind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22761)
    if (isfind) then
        local strs = string.Split(tbl.value, '#')
        for i, v in pairs(strs) do
            table.insert(self.PersonBuffList, v)
        end
    end

    isfind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22762)
    if (isfind) then
        local strs = string.Split(tbl.value, '#')
        for i, v in pairs(strs) do
            table.insert(self.UnionBuffList, v)
        end
    end
end

function UIGuildBossInspirePanel:InitUI()
    self:InitLeft()
    self:InitRight()
end

---@type boolean 个人鼓舞金币是否足够
local isItEnoughLeft = true
---@type boolean 行会鼓舞金币是否足够
local isItEnoughRight = true
---@type number 行会鼓舞左边消耗金币ID
local ContLeftID = 0
---@type number 行会鼓舞右边消耗金币ID
local ContRightID = 0

function UIGuildBossInspirePanel:InitLeft()
    ---@type TABLE.CFG_GLOBAL
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22763)
    local InspirePersionCost = tbl.value
    local strs = string.Split(InspirePersionCost, '#')
    ContLeftID = tonumber(strs[1])
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(ContLeftID)
    local costCount = tonumber(strs[2])
    self:GetInspirePersonCostCount().text = tostring(costCount)
    if (itemTbl ~= nil) then
        self:GetInspirePersonCostIcon().spriteName = itemTbl:GetIcon()
    end
    local curCoinCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(ContLeftID)
    if (itemTbl ~= nil and itemTbl:GetType() == luaEnumItemType.Coin and costCount > curCoinCount) then
        isItEnoughLeft = false
    end
end

function UIGuildBossInspirePanel:InitRight()
    ---@type TABLE.CFG_GLOBAL
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22764)
    local InspireUnionCost = tbl.value
    local strs = string.Split(InspireUnionCost, '#')
    ContRightID = tonumber(strs[1])
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(ContRightID)
    local costCount = tonumber(strs[2])
    self:GetInspireUnionCostCount().text = tostring(costCount)
    if (itemTbl ~= nil) then
        self:GetInspireUnionCostIcon().spriteName = itemTbl:GetIcon()
    end
    local curCoinCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(ContRightID)
    if (itemTbl ~= nil and itemTbl:GetType() == luaEnumItemType.Coin and costCount > curCoinCount) then
        isItEnoughRight = false
    end
end

function UIGuildBossInspirePanel:BindEvent()
    --关闭界面
    CS.UIEventListener.Get(self:GetBtnClose()).onClick = function()
        uimanager:ClosePanel("UIGuildBossInspirePanel")
    end

    --个人鼓舞按钮点击
    CS.UIEventListener.Get(self:GetBtnInspirePerson()).onClick = function(go)
        if (not isItEnoughLeft) then
            if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(ContLeftID)) then
                Utility.TryShowFirstRechargePanel()
            else
                Utility.ShowItemGetWay(ContLeftID, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0));
            end
            return
        end
        networkRequest.ReqUnionBossAddBuff(1)
    end

    --公会鼓舞按钮点击
    CS.UIEventListener.Get(self:GetBtnInspireUnion()).onClick = function(go)
        if (not isItEnoughRight) then
            if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(ContRightID)) then
                Utility.TryShowFirstRechargePanel()
            else
                Utility.ShowItemGetWay(ContRightID, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0));
            end
            return
        end
        networkRequest.ReqUnionBossAddBuff(2)
    end
end

function UIGuildBossInspirePanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionBossBuffInfoMessage, function(id, tblData)
        self:UpdateInfo(tblData)
    end)
end

---@param tblData unionV2.UnionBossBuffInfo
function UIGuildBossInspirePanel:UpdateInfo(tblData)
    self.remainUnionNum = tblData.remainUnionNum
    self.remainPersonalNum = tblData.remainPersonalNum

    self:GetInspirePersonLastCountLabel().text = "剩余次数 : " .. tostring(tblData.remainPersonalNum)
    self:GetInspireUnionLastCountLabel().text = "剩余次数 : " .. tostring(tblData.remainUnionNum)

    local personBuffIndex = tblData.personalNum + 1
    local unionBuffIndex = tblData.unionNum + 1

    --personBuffIndex = personBuffIndex > #self.PersonBuffList and #self.PersonBuffList or personBuffIndex;
    --unionBuffIndex = unionBuffIndex > #self.UnionBuffList and #self.UnionBuffList or unionBuffIndex;
    ---现在统一只用各自的BUFF1
    personBuffIndex = 1
    unionBuffIndex = 1

    if (#self.PersonBuffList > 0) then
        local buffId = self.PersonBuffList[personBuffIndex]
        local isfind, tbl = CS.Cfg_BuffTableManager.Instance:TryGetValue(tostring(buffId))
        if (isfind) then
            self:GetInspirePersonInspireNumLabel().text = "+" .. tostring(tbl.atkPer) .. "%"
        end
    end

    if (#self.UnionBuffList > 0) then
        local buffId = self.UnionBuffList[unionBuffIndex]

        local isfind, tbl = CS.Cfg_BuffTableManager.Instance:TryGetValue(tostring(buffId))
        if (isfind) then
            self:GetInspireUnionInspireNumLabel().text = "+" .. tostring(tbl.atkPer) .. "%"
        end
    end

end

return UIGuildBossInspirePanel