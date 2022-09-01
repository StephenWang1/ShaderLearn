---@class UIRolePanel_EquipTemplateRepair:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateRepair = {}

setmetatable(UIRolePanel_EquipTemplateRepair, luaComponentTemplates.UIRolePanel_EquipTemplate)

local Utility = Utility

function UIRolePanel_EquipTemplateRepair:Init(panel)
    self:RunBaseFunction("Init", panel)
    ---@type table<number,UIRolePanel_GridTemplateRepair> 装备lid对应装备模板
    self.mLidToTemplateInfo = {}
    ---装备lid对应选中
    self.mLidToChoose = {}

    ---维修界面选中更改
    self.OnRepairChooseListChange = function(msgId, lid)
        self:RefreshGridChoose(lid)
    end

    ---刷新整个面板选中
    self.RepairGetRefreshChooseList = function(msgId, type)
        if type == luaEnumRepairType.Role then
            self:SendNewChooseList()
        end
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RepairChooseRoleGridChange, self.OnRepairChooseListChange)
    end
end

function UIRolePanel_EquipTemplateRepair:OnDestroy()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairGetRefreshChooseList, self.RepairGetRefreshChooseList)
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RepairChooseRoleGridChange, self.OnRepairChooseListChange)
    end
end

---为格子绑定模板并刷新
function UIRolePanel_EquipTemplateRepair:BindTemplate(equipIndex, grid)
    if self.gridTemplate then
        --绑定模板
        ---@type UIRolePanel_GridTemplateRepair
        local tbl = templatemanager.GetNewTemplate(grid, self.gridTemplate)
        --第一次刷新
        local info = self:GetEquipInfo(equipIndex)
        tbl:ShowEquip(info, equipIndex)
        tbl.equipIndex = equipIndex
        --存储数据
        self.mGridToTemplate[grid] = tbl
        self.mEquipIndexToTemplate[equipIndex] = tbl
        self.mEquipIndexToGrid[equipIndex] = grid
        if info then
            self.mLidToTemplateInfo[info.lid] = tbl
        end
        --绑定点击事件
        CS.UIEventListener.Get(grid).onClick = function()
            self:OnItemClicked(grid)
        end
    end
end

---发送新的选中列表
function UIRolePanel_EquipTemplateRepair:SendNewChooseList()
    self:SetItemChooseState()
    self:SendChooseList()
end

---设置维修道具选中状态
function UIRolePanel_EquipTemplateRepair:SetItemChooseState()
    self.mLidToChoose = {}
    if self.mEquipIndexToTemplate then
        for k, v in pairs(self.mEquipIndexToTemplate) do
            ---@type  UIRolePanel_GridTemplateRepair
            local template = v
            ---@type bagV2.BagItemInfo
            local bagItemInfo = template.bagItemInfo
            if bagItemInfo then
                local itemInfo = bagItemInfo.ItemTABLE
                if itemInfo then
                    local needChoose = bagItemInfo.currentLasting < itemInfo.maxLasting and itemInfo.repairCost and itemInfo.repairCost.list and itemInfo.repairCost.list.Count > 0 and itemInfo.repairCost.list[0].list
                    --屏蔽耐久度为-99999的装备
                    if (self:IsSpecialDurability(bagItemInfo)) then
                        needChoose = false
                    end
                    ---耐久不满需要选中
                    self.mLidToChoose[bagItemInfo.lid] = needChoose
                    template:ChooseItem(needChoose)
                end
            end
        end
    end
end

---发送当前选中列表
function UIRolePanel_EquipTemplateRepair:SendChooseList()
    local chooseList = {}
    --if self.isMainPlayer and CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.EquipInfo then
    --    local faceTemp = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(LuaEnumEquiptype.Face)
    --    if self.face ~= faceTemp and self.face ~= nil then
    --        self.face = faceTemp
    --        if self.face ~= nil and self.face.ItemTABLE then
    --            if self.face.currentLasting >= self.face.ItemTABLE.maxLasting then
    --                self.face = nil
    --            end
    --        end
    --    end
    --end
    --if self.face ~= nil and self.face.ItemTABLE ~= nil then
    --    table.insert(chooseList, self.face)
    --end
    if self.mLidToChoose ~= nil then
        for k, v in pairs(self.mLidToChoose) do
            if v and self.mLidToTemplateInfo ~= nil then
                ---@type UIRolePanel_GridTemplateRepair
                local template = self.mLidToTemplateInfo[k]
                ---屏蔽耐久度为-99999的装备
                if template and template.bagItemInfo and not self:IsSpecialDurability(template.bagItemInfo) then
                    table.insert(chooseList, template.bagItemInfo)
                end
            end
        end
    end
    luaEventManager.DoCallback(LuaCEvent.RepairChooseListChange, chooseList)
end

---获取所有当前选中列表
function UIRolePanel_EquipTemplateRepair:GetAllNeedRepairInfo()
    local list = nil
    if self.mEquipIndexToTemplate then
        list = {}
        for k, v in pairs(self.mEquipIndexToTemplate) do
            ---@type  UIRolePanel_GridTemplateRepair
            local template = v
            local bagItemInfo = template.bagItemInfo
            if bagItemInfo and self.mLidToChoose[bagItemInfo.lid] then
                table.insert(list, bagItemInfo)
            end
        end
    end
    return list
end

---刷新格子取消选中状态
function UIRolePanel_EquipTemplateRepair:RefreshGridChoose(lid)
    if self.face ~= nil and self.face.lid == lid then
        self.face = nil
        self:SendChooseList()
        return
    end
    if self.mLidToTemplateInfo[lid] then
        self.mLidToTemplateInfo[lid]:ChooseItem(false)
        self.mLidToChoose[lid] = false
        self:SendChooseList()
    end
end

---面巾装备点击事件
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIRolePanel_EquipTemplateRepair:OnFaceEquipClicked(bagItemInfo, go)
    if bagItemInfo then
        if self.face == bagItemInfo then
            ---@type bagV2.BagItemInfo
            self.face = nil
        else
            self.face = bagItemInfo
        end
        if bagItemInfo.ItemTABLE ~= nil and bagItemInfo.currentLasting >= bagItemInfo.ItemTABLE.maxLasting then
            Utility.ShowPopoTips(go, nil, 35)
            return
        end
        self:SendChooseList()
        return true
    end
end

---点击格子
function UIRolePanel_EquipTemplateRepair:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template then
        ---@type bagV2.BagItemInfo
        local bagItemInfo = template.bagItemInfo
        if bagItemInfo then
            local isChoose = self.mLidToChoose[bagItemInfo.lid]
            --耐久度可以维修
            local lastingEnough = bagItemInfo.currentLasting < bagItemInfo.ItemTABLE.maxLasting
            --耐久度为-99999的装备不允许维修
            if not lastingEnough or self:IsSpecialDurability(bagItemInfo) then
                Utility.ShowPopoTips(go, nil, 35)
                return
            end

            local itemInfo = bagItemInfo.ItemTABLE
            --有维修花费
            local hasCost = itemInfo.repairCost and itemInfo.repairCost.list and itemInfo.repairCost.list.Count > 0 and itemInfo.repairCost.list[0].list
            if not hasCost then
                Utility.ShowPopoTips(go, nil, 181)
                return
            end

            template:ChooseItem(not isChoose)
            self.mLidToChoose[bagItemInfo.lid] = not isChoose
            self:SendChooseList()
        end
    end
end

---刷新装备格子显示
function UIRolePanel_EquipTemplateRepair:RefreshGrid()
    if self.mEquipIndexToTemplate then
        for k, v in pairs(self.mEquipIndexToTemplate) do
            local info = self:GetEquipInfo(k)
            v:ShowEquip(info)
            v:SetChoose()
        end
    end
end

---特殊耐久度，不能维修
function UIRolePanel_EquipTemplateRepair:IsSpecialDurability(bagItemInfo)
    if (bagItemInfo ~= nil and bagItemInfo.currentLasting ~= nil and bagItemInfo.currentLasting == -99999) then
        return true
    end
    return false
end

return UIRolePanel_EquipTemplateRepair