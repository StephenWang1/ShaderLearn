---@class UISuitAttributeDivineSuitPanel:UIBase 神力套装属性
local UISuitAttributeDivineSuitPanel = {}

local IsNull = CS.StaticUtility.IsNull

--region 数据获取
---@return LuaPlayerBloodSuitEquipMgr
function UISuitAttributeDivineSuitPanel:GetDataManager()
    if self.mMainData == nil then
        if self.playerType == 1 then
            self.mMainData = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
        elseif self.playerType == 2 then
            self.mMainData = luaclass.LuaPlayerBloodSuitEquipMgr:New()
            local RoleToOtherInfo = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo
            for i, item in pairs(RoleToOtherInfo.equipList) do
                self.mMainData:RefreShBloodSuitDic(item, item.index)
            end
        end
    end
    return self.mMainData
end
--endregion

--region 组件
---@return UILoopScrollViewPlus
function UISuitAttributeDivineSuitPanel:GetShowLoop()
    if self.mLoopGo == nil then
        self.mLoopGo = self:GetCurComp("WidgetRoot/view/Scroll View/scrollContent", "UILoopScrollViewPlus")
    end
    return self.mLoopGo
end

---@return UIPanel
function UISuitAttributeDivineSuitPanel:GetAttributeScrollView_UIPanel()
    if self.mScrollViewUIPanel == nil then
        self.mScrollViewUIPanel = self:GetCurComp("WidgetRoot/view/Scroll View", "UIPanel")
    end
    return self.mScrollViewUIPanel
end

---@return UISprite
function UISuitAttributeDivineSuitPanel:GetBg_UISprite()
    if self.mBgSp == nil then
        self.mBgSp = self:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return self.mBgSp
end
--endregion

--region 初始化
function UISuitAttributeDivineSuitPanel:Init()
    self:BindEvents()
end

---@param type LuaEquipBloodSuitType 选中套装类型
---@param isMainPlayer number 玩家类型 是否是主角
function UISuitAttributeDivineSuitPanel:Show(type, isMainPlayer)
    if type and isMainPlayer then
        self.type = type
        self.isMainPlayer = isMainPlayer
        self:RefreshShowData()
    end
end

function UISuitAttributeDivineSuitPanel:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region 刷新面板

---@class DivineSuitData
---@field type number 标题1/内容2
---@field info string 文本
---@field sort number 排序用

function UISuitAttributeDivineSuitPanel:RefreshShowData()
    ---@type BloodSuitLevelData
    local showTable = {}
    self:AddTotalSuitData(showTable)
    self:AddAttributeData(showTable)
    self:GetShowLoop():Init(function(go, line)
        if line < #showTable then
            local data = showTable[line + 1]
            if data then
                self:RefreshSingleLine(go, data)
            end
            return true
        else
            return false
        end
    end, nil)
    self:SuitPanel(#showTable)
end

---@param data BloodSuitLevelData
function UISuitAttributeDivineSuitPanel:RefreshSingleLine(go, data)
    ---@type UILabel
    local title = CS.Utility_Lua.Get(go.transform, "title", "UILabel")
    ---@type UILabel
    local attr = CS.Utility_Lua.Get(go.transform, "AttrName", "UILabel")
    if IsNull(title) or IsNull(attr) then
        return
    end
    local isTitle = data.type == 1
    local isInfo = data.type == 2
    local titleColor = "[73ddf7]"
    title.text = isTitle and titleColor .. data.info or ""
    attr.text = isInfo and data.info or ""
end

---获取当前类型所有装备数据
function UISuitAttributeDivineSuitPanel:GetEquipList()
    if self.isMainPlayer then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(self.type)
    else

    end
end

---@return TABLE.cfg_divinesuit  取任意一件已装备 神力装备 获取数据
function UISuitAttributeDivineSuitPanel:GetSingleEquipSuitData()
    if self.mEquipData == nil then
        local allEquipList = self:GetEquipList()
        if self.isMainPlayer then
            local list = allEquipList.EquipmentDic
            for k, v in pairs(list) do
                ---@type LuaEquipDataItem
                local equipItem = v
                local bagItemInfo = equipItem.BagItemInfo
                if bagItemInfo then
                    self.mEquipData = Utility.GetDivineSuitTblByBagItemInfo(bagItemInfo)
                end
            end
        else

        end
    end
    return self.mEquipData
end

---@param type  LuaEquipmentItemType 装备位
---@return boolean 玩家身上是否有对应装备
function UISuitAttributeDivineSuitPanel:HasTypeEquip(type)
    if self.isMainPlayer then
        local equipData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(self.type, type)
        if equipData then
            return equipData.BagItemInfo ~= nil
        end
    else

    end
    return false
end

---添加总属性
function UISuitAttributeDivineSuitPanel:AddTotalSuitData(allTbl)
    --region 套装部件
    local tblSuitData = self:GetSingleEquipSuitData()
    if tblSuitData == nil then
        return
    end
    ---@type  DivineSuitData
    local data = {}
    data.type = 1
    data.info = "[73ddf7]" .. tblSuitData:GetSuitName()
    table.insert(allTbl, data)
    local attrValue = ""
    for i = 1, #uiStaticParameter.mDivineSuitType do
        ---@type  LuaEquipmentItemType
        local type = uiStaticParameter.mDivineSuitType[i]
        local name = uiStaticParameter.mDivineSuitName[type]
        local full = self:HasTypeEquip(type)
        local color = full and luaEnumColorType.Green or luaEnumColorType.Gray
        attrValue = color .. attrValue .. name .. "[-]"
        if i % 5 == 0 then
            ---@type  DivineSuitData
            local data = {}
            data.type = 2
            data.info = attrValue
            table.insert(allTbl, data)
            attrValue = ""
        else
            attrValue = attrValue .. "   "
        end
    end
    --endregion
end

---添加套装属性
function UISuitAttributeDivineSuitPanel:AddAttributeData(allTbl)
    ---@type  BloodSuitLevelData
    local data = {}
    data.type = 1
    data.info = "[73ddf7]套装属性"
    table.insert(allTbl, data)
    local equipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(self.type)
    local allAttribute = equipmentListData:GetAdditionDataList()
    if allAttribute then
        for i = 1, #allAttribute do
            ---@type LuaEquipSuitAdditionItem
            local attribute = allAttribute[i]
            if attribute then
                local color = attribute.IsActivate and luaEnumColorType.Green or luaEnumColorType.Gray
                local des = attribute.DivineSuitAttribute:GetDes()

                if des == nil or des == "" then
                    des = attribute.DivineSuitAttribute:GetSkilldes()
                end
                local leftNum = attribute.ActivateData[1]
                local rightNum = attribute.ActivateLimitCount
                local currentCount = leftNum > rightNum and rightNum or leftNum
                local num = currentCount .. "/" .. attribute.ActivateLimitCount .. "  "
                local attrValue = color .. num .. des
                ---@type  BloodSuitLevelData
                local data = {}
                data.type = 2
                data.info = attrValue
                table.insert(allTbl, data)
            end
        end
    end
end
--endregion

--region 界面适配
function UISuitAttributeDivineSuitPanel:SuitPanel(num)
    if num == nil then
        return
    end
    local height = 0
    local length = self:GetShowLoop().CellLeghth
    if length then
        height = height + length
    end
    local des = self:GetShowLoop().gapDis
    if des then
        height = height + des
    end
    local gap = 40
    local totalHeight = num * height + gap
    local sizeHeight = self:GetAttributeScrollView_UIPanel():GetViewSize().y
    local pos = self:GetAttributeScrollView_UIPanel().gameObject.transform.localPosition
    local PosY = -(sizeHeight - totalHeight + gap) / 2
    pos.y = totalHeight < sizeHeight and PosY or 0
    self:GetAttributeScrollView_UIPanel().gameObject.transform.localPosition = pos
    self:GetBg_UISprite().height = totalHeight < sizeHeight and totalHeight or sizeHeight + gap
end
--endregion

--region 数据缓存
---@return TABLE.cfg_divinesuit
function UISuitAttributeDivineSuitPanel:CacheDivineSuitData(divineId)
    if self.mLevelToDivineData == nil then
        self.mLevelToDivineData = {}
    end
    local data = self.mLevelToDivineData[divineId]
    if data == nil then
        data = clientTableManager.cfg_divinesuitManager:TryGetValue(divineId)
        self.mLevelToDivineData[divineId] = data
    end
    return data
end

---@return CSMainPlayerInfo
function UISuitAttributeDivineSuitPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

--endregion

return UISuitAttributeDivineSuitPanel