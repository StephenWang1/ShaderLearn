--- DateTime: 2021/05/08 14:09
--- Description 角色投保管理 调用示例 gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr()

---@class LuaInsureMgr
local LuaInsureMgr = {}

---@type table<LuaInsuranceBigTabType,table<LuaInsuranceSubTabType,LuaInsureItem[]>>全部装备可以投保的字典
LuaInsureMgr.AllInsuranceDic = nil
---@type LuaInsureItem[] 正在被保护的装备
LuaInsureMgr.BeingProtecteds = nil
---@type  roleV2.InsuredEquip[]
LuaInsureMgr.InsuredEquips = nil


--region Init

---初始化全部装备数据
function LuaInsureMgr:RefreshData()
    self:ResetData()
    self:RefreshBagData()
    self:RefreshRoleEquipData()
    self:InsuranceDicSort()
end

--endregion

--region public methods

---返回当前类型的所有可投保装备
---@param type LuaInsuranceBigTabType
---@param subType LuaInsuranceSubTabType
function LuaInsureMgr:GetInsuranceTypeEquipmentList(bigType, subType)
    if (self.AllInsuranceDic ~= nil and self.AllInsuranceDic[bigType] ~= nil and self.AllInsuranceDic[bigType][subType] ~= nil) then
        return self.AllInsuranceDic[bigType][subType]
    end
    return nil
end

---检查装备是否已经被保护
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaInsureMgr:CheckTheEquipmentHasBeenProtected(bagItemInfo)
    return false
end

---根据唯一ID检查装备是否已经被保护
---@param lidIDs number[]
---@return boolean
function LuaInsureMgr:CheckTheEquipmentHasBeenProtected_lid(lidID)
    --for i, v in pairs(self.AllInsuranceDic) do
    --    for k, equipList in pairs(v) do
    --        for i = 1, #equipList do
    --            if (equipList[i] ~= nil and equipList[i]:GetBagItemInfo() ~= nil and Utility.IsContainsValue(lidID, equipList[i]:GetBagItemInfo().lid)) then
    --                return true
    --            end
    --        end
    --    end
    --end
    return false
end

---获取投保文字说明
---@param bagItemInfo bagV2.BagItemInfo
function LuaInsureMgr:GetInsuredTextDescription()
    if (self.InsuredTextDes == nil) then
        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23111);
        if (isFind) then
            self.InsuredTextDes = globalTable.value
        end
    end
    return self.InsuredTextDes
end

---获取弃保文字说明
---@param bagItemInfo bagV2.BagItemInfo
function LuaInsureMgr:GetWaiveInsuredTextDescription()
    if (self.WaiveInsuredTextDes == nil) then
        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23112);
        if (isFind) then
            self.WaiveInsuredTextDes = globalTable.value
        end
    end
    return self.WaiveInsuredTextDes
end

---获取投保页签列表
---@return table
function LuaInsureMgr:GetInsuredTabList()
    if (self.InsuredTabList == nil) then
        self.InsuredTabList = {
            [1] = '投保',
            [2] = '弃保'
        }
    end
    return self.InsuredTabList
end

---刷新单个装备数据
---@param InsuredSucces roleV2.ResInsuredSucces
function LuaInsureMgr:RefreshEquipData(InsuredSucces)
    if (InsuredSucces == nil or InsuredSucces.isSuccess == false or InsuredSucces.theEquip == nil) then
        return
    end
    local bigTabType = InsuredSucces.abandonInsured + 1
    local subTabType = InsuredSucces.index == 0 and LuaInsuranceSubTabType.Bag or LuaInsuranceSubTabType.Role
    local isRemove = false
    for i, v in pairs(self.AllInsuranceDic) do
        if (isRemove) then
            break
        end
        for k, equipList in pairs(v) do
            if (isRemove) then
                break
            end
            for i = 1, #equipList do
                if (equipList[i] ~= nil and equipList[i]:GetBagItemInfo() ~= nil and equipList[i]:GetBagItemInfo().lid == InsuredSucces.theEquip.lid) then
                    table.remove(equipList, i)
                    isRemove = true
                    break
                end
            end
        end
    end
    ---投保或者弃保之后，大类型变为相反
    bigTabType = bigTabType == 1 and 2 or 1
    self:AddInsuranceData(bigTabType, subTabType, luaclass.LuaInsureItem:New(InsuredSucces.theEquip, InsuredSucces.theEquip.isInsured, InsuredSucces.index))
    self:InsuranceDicSort()
end

---显示投保提示框
function LuaInsureMgr:ShowInsurancePopup()
    CS.Utility.ShowRedTips("该装备已投保，请弃保后再来");
end

---是否已投保
---@param bagItemInfo bagV2.BagItemInfo
function LuaInsureMgr:IsInsurance(bagItemInfo)
    --if (bagItemInfo ~= nil and bagItemInfo.isInsured ~= 0) then
    --    return true
    --end
    return false
end
--endregion

--region private methods

---初始化背包装备数据
---@private
function LuaInsureMgr:RefreshBagData()
    ---@type LuaMainPlayerBagMgr
    local LuaMainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    ---@type table<lid,bagV2.BagItemInfo>
    local allItems = LuaMainPlayerBagMgr:GetAllBagItemData()

    local index = 0
    for i, v in pairs(allItems) do
        ---@type bagV2.BagItemInfo
        local item = v;
        ---@type TABLE.cfg_items
        local itemTbl = Utility.GetItemTblByBagItemInfo(item)
        ---可投保装备
        if itemTbl and itemTbl:GetInsure() ~= nil and itemTbl:GetInsure().list ~= nil then
            ---已投保,加入弃保列表
            if (self:IsInsurance(item)) then
                self:AddInsuranceData(LuaInsuranceBigTabType.WaiveInsurance, LuaInsuranceSubTabType.Bag, luaclass.LuaInsureItem:New(item, true, 0))
            else
                self:AddInsuranceData(LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Bag, luaclass.LuaInsureItem:New(item, false, 0))
            end
        end
        index = index + 1
        if (index % 10 == 0) then
            coroutine.yield(0)
        end
    end
end

---初始化人物装备数据
---@private
function LuaInsureMgr:RefreshRoleEquipData()
    if (self.InsuredEquips == nil) then
        return
    end
    local index = 0
    for i, v in pairs(self.InsuredEquips) do
        ---@type roleV2.InsuredEquip
        local item = v;
        if (item ~= nil and item.theEquip ~= nil) then
            ---已投保,加入弃保列表
            if (self:IsInsurance(item.theEquip)) then
                self:AddInsuranceData(LuaInsuranceBigTabType.WaiveInsurance, LuaInsuranceSubTabType.Role, luaclass.LuaInsureItem:New(item.theEquip, true, item.index))
            else
                self:AddInsuranceData(LuaInsuranceBigTabType.Insurance, LuaInsuranceSubTabType.Role, luaclass.LuaInsureItem:New(item.theEquip, false, item.index))
            end
        end

        index = index + 1
        if (index % 10 == 0) then
            coroutine.yield(0)
        end
    end
end

---@private
---初始化投保数据
---@param type LuaInsuranceBigTabType
---@param subType LuaInsuranceSubTabType
---@param data LuaInsureItem
function LuaInsureMgr:AddInsuranceData(type, subType, data)
    if (self.AllInsuranceDic == nil) then
        self.AllInsuranceDic = {}
    end
    if (self.AllInsuranceDic[type] == nil) then
        self.AllInsuranceDic[type] = {}
    end
    if (self.AllInsuranceDic[type][subType] == nil) then
        self.AllInsuranceDic[type][subType] = {}
    end
    table.insert(self.AllInsuranceDic[type][subType], data)
end

---@private
---装备列表排序字典
function LuaInsureMgr:InsuranceDicSort()
    if (self.AllInsuranceDic == nil) then
        return
    end
    for i, v in pairs(self.AllInsuranceDic) do
        for j, k in pairs(v) do
            self:InsuranceDicSortItem(v)
        end
    end
end

---@private
---装备列表排序集合
---@param InsuranceList LuaInsureItem[]
function LuaInsureMgr:InsuranceDicSortItem(InsuranceList)
    if (InsuranceList == nil) then
        return
    end
    for i, v in pairs(InsuranceList) do
        ---@param a LuaInsureItem
        ---@param b LuaInsureItem
        table.sort(v, function(a, b)
            if (a == nil or b == nil) then
                return false
            end
            --1、按装备部位排序
            if (a:GetBagItemInfo() ~= nil and b:GetBagItemInfo() ~= nil and a:GetBagItemInfo().index ~= b:GetBagItemInfo().index) then
                --递增
                return a:GetBagItemInfo().index > b:GetBagItemInfo().index
            end
            --2、同装备部位按item表排序字段（index）排序
            if (a:GetTblItem() ~= nil and b:GetTblItem() ~= nil and a:GetTblItem():GetIndex() ~= b:GetTblItem():GetIndex()) then
                --递增
                return a:GetTblItem():GetIndex() > b:GetTblItem():GetIndex()
            end
            --3、同排序字段（index）按itemid从大到小排序
            if (a:GetTblItem() ~= nil and b:GetTblItem() ~= nil) then
                --递减
                return a:GetTblItem():GetId() > b:GetTblItem():GetId()
            end
            return false
        end)
    end
end
--endregion

--region destroy
function LuaInsureMgr:ResetData()
    self.AllInsuranceDic = nil
end

--endregion

return LuaInsureMgr