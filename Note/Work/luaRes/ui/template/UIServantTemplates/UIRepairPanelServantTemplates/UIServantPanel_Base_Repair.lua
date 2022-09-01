---灵兽装备面板（维修状态下）
---@class UIServantPanel_Base_Repair:UIServantPanel_Base
local UIServantPanel_Base_Repair = {}
setmetatable(UIServantPanel_Base_Repair, luaComponentTemplates.UIServantPanel_Base)

local Utility = Utility

function UIServantPanel_Base_Repair:Init(panel)
    self:RunBaseFunction("Init", panel)
    ---@type number 当前设置耐久度
    self.mLasting = nil
    ---lid对应选中状态
    ---@type table<number,boolean>
    self.lidToChooseInfo = nil

    ---lid对应格子模板
    ---@type table<number,UIServantEquipGridTemplate>
    self.lidToTemplate = {}

    ---lid对应装备当前耐久度信息 耐久度改变时候刷新选中状态
    self.lidToCurrentLasting = {}

    self.ServantPanel:ShowOtherButton(false)
    self:GetAllBtn_GameObject():SetActive(false)
    self:GetEquipHelp_GameObject():SetActive(false)
    self:BindLastingMessage()
end

---绑定耐久度消息
function UIServantPanel_Base_Repair:BindLastingMessage()
    ---刷新整个面板选中
    self.RepairGetRefreshChooseList = function(msgId, type)
        if type == luaEnumRepairType.Servant then
            self:SendNewChooseList()
        end
    end
    self.OnRepairPanelChooseItemChangeFunc = function(msgId, lid)
        self:OnItemQuitChoose(lid)
    end
    if self.ServantPanel then
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)
        self.ServantPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseServantGridChange, self.OnRepairPanelChooseItemChangeFunc)
    end

end

function UIServantPanel_Base_Repair:OnDestroy()
    if self.ServantPanel then
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)
        self.ServantPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairChooseServantGridChange, self.OnRepairPanelChooseItemChangeFunc)
    end
end

function UIServantPanel_Base_Repair:SetAllButtonShow(isShow)
end

function UIServantPanel_Base_Repair:OnClickEquip(go)
    local template = self.mGridToTemplate[go]
    if template then
        local bagItemInfo = template.BagItemInfo
        if bagItemInfo and bagItemInfo.ItemTABLE then
            local canChoose = bagItemInfo.ItemTABLE.maxLasting and bagItemInfo.ItemTABLE.maxLasting ~= 0 and bagItemInfo.currentLasting < bagItemInfo.ItemTABLE.maxLasting
            if canChoose then
                self.lidToChooseInfo[bagItemInfo.lid] = not self.lidToChooseInfo[bagItemInfo.lid]
                template:SetItemRepairChoose(self.lidToChooseInfo[bagItemInfo.lid])
                self:SendServantChooseItemChangeMessage()
            else
                Utility.ShowPopoTips(go, nil, 144)
            end
        end
    end
end

---灵兽切换刷新选中
function UIServantPanel_Base_Repair:RefreshServant(servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    self.lidToTemplate = {}
    self:RunBaseFunction("RefreshServant", servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    --   self:RefreshItemChoose()
    self.ServantPanel:GetBtnShowAttribute():SetActive(false)
end

---刷新单个装备格子
---@param equipInfo Dictionary 灵兽装备字典
---@param index int 装备位置
---@param temp UIServantEquipGridTemplate 灵兽装备格子模板
---@param grid GameObject 格子Obj
---@param servantType int  灵兽类型
function UIServantPanel_Base_Repair:RefreshGridTemp(temp, index, equipInfo, grid, servantType)
    if (equipInfo == nil) or grid:IsNull() then
        return
    end
    --红点
    local redPoint = grid.transform:Find("RedPoint").gameObject
    redPoint:SetActive(false)
    --加号
    local add = grid.transform:Find("add").gameObject
    add:SetActive(false)
    --灵兽信息
    local info = self.ServantPanel:GetServantInfo()
    --刷新装备信息
    CS.UIEventListener.Get(grid).LuaEventTable = self
    self.mGridToTemplate[grid] = temp
    local res, dicInfo = equipInfo:TryGetValue(index)
    if res then
        --该位置有装备
        self.lidToTemplate[dicInfo.lid] = temp
        temp:RefreshEquip(dicInfo, LuaEnumServantEquipShowColorType.Normal)
        CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickEquip
        if self.lidToChooseInfo then
            temp:SetItemRepairChoose(self.lidToChooseInfo[dicInfo.lid])
        end
    else
        --该位置没有装备
        temp:ResetEquip()
        temp:SetItemRepairChoose(false)
    end
end

---刷新Item选中状态
function UIServantPanel_Base_Repair:RefreshItemChoose()
    if self.lidToChooseInfo == nil then
        self.lidToChooseInfo = {}
    end

    local equipInfo = self.ServantPanel:GetServantInfo().ServantEquip
    for k, v in pairs(equipInfo) do
        local bagItemInfo = v
        local isChoose = bagItemInfo.ItemTABLE.maxLasting and bagItemInfo.ItemTABLE.maxLasting ~= 0 and bagItemInfo.currentLasting < bagItemInfo.ItemTABLE.maxLasting
        self.lidToChooseInfo[bagItemInfo.lid] = isChoose
        local template = self.lidToTemplate[bagItemInfo.lid]
        if template then
            template:SetItemRepairChoose(isChoose)
        end
        self.lidToCurrentLasting[bagItemInfo.lid] = bagItemInfo.currentLasting

    end
    self:SendServantChooseItemChangeMessage()
end

---发送选中列表
function UIServantPanel_Base_Repair:SendServantChooseItemChangeMessage()
    local repairList = self:GetAllNeedRepairServantInfo()
    luaEventManager.DoCallback(LuaCEvent.RepairChooseListChange, repairList)
end

---获取所有需要维修道具列表
function UIServantPanel_Base_Repair:GetAllNeedRepairServantInfo()
    local repairList = {}
    local equipInfo = self.ServantPanel:GetServantInfo().ServantEquip
    if self.lidToChooseInfo and equipInfo then
        for k, v in pairs(equipInfo) do
            if self.lidToChooseInfo[v.lid] then
                table.insert(repairList, v)
            end
        end
    end
    return repairList
end

--region 客户端消息

---取消lid的选中
function UIServantPanel_Base_Repair:OnItemQuitChoose(lid)
    self.lidToChooseInfo[lid] = false
    local template = self.lidToTemplate[lid]
    if template then
        template:SetItemRepairChoose(false)
    end
    self:SendServantChooseItemChangeMessage()
end
--endregion

---刷新选中
function UIServantPanel_Base_Repair:SendNewChooseList()
    self:RefreshItemChoose()
end

return UIServantPanel_Base_Repair