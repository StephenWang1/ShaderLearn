---专精技能面板
local UIProficientPanel = {}

UIProficientPanel.ProficientItemTempList = nil

function UIProficientPanel:GetBtnClose()
    if (self.mGetBtnClose == nil) then
        self.mGetBtnClose = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mGetBtnClose;
end

function UIProficientPanel:GetProficientSkillGridContainer()
    if (self.mGetProficientSkillGridContainer == nil) then
        self.mGetProficientSkillGridContainer = self:GetCurComp("WidgetRoot/UISkillInfoPanel/UISkillColumn/Scroll View/skills", "Top_UIGridContainer")
    end
    return self.mGetProficientSkillGridContainer;
end

function UIProficientPanel:Init()
    self:BindEvent()
    self:BindMessage()
end

---绑定界面点击事件
function UIProficientPanel:BindEvent()
    CS.UIEventListener.Get(self:GetBtnClose().gameObject).onClick = function()
        self:OnClickClose()
    end
end

---绑定客户端事件以及服务器消息事件
function UIProficientPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function(id, tbl)
        ---设置xp能量
        self:OnResBagChangeMessage(tbl)
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipProficientInfoMessage, function(id, tbl)
        ---@param ProficientItemTemp UIProficientItemTemplate
        for i, ProficientItemTemp in pairs(self.ProficientItemTempList) do
            ---@type LuaProficientItem
            local data = gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():GetProficientDataByType(ProficientItemTemp.ProficientItem.type)
            ProficientItemTemp:UpdateData(data)
        end
    end)
end

function UIProficientPanel:Show()
    self:InitData()
end

function UIProficientPanel:InitData()
    self:InitProficientGridContainer()
end

---@param tbl bagV2.ResBagChange
function UIProficientPanel:OnResBagChangeMessage(tbl)
    if (self.ProficientItemTempList == nil) then
        return ;
    end
    ---之后再优化,可以再这里先进行个数的数据处理,后续就不用处理了
    --if(tbl.itemList ~= nil) then
    --    ---@param bagItemInfo bagV2.BagItemInfo
    --    for i, bagItemInfo in pairs(tbl.itemList) do
    --
    --    end
    --end

    ---@param ProficientItemTemp UIProficientItemTemplate
    for i, ProficientItemTemp in pairs(self.ProficientItemTempList) do
        ProficientItemTemp:UpdateCostMaterialCount()
    end
end

---初始化专精列表
function UIProficientPanel:InitProficientGridContainer()
    if (self:GetProficientSkillGridContainer() == nil) then
        return ;
    end
    ---@type table<number, LuaProficientItem>
    local list = self:GetUIShowProficientList()
    local maxCount = Utility.GetTableCount(list)

    self:GetProficientSkillGridContainer().MaxCount = maxCount
    if (self.ProficientItemTempList == nil) then
        self.ProficientItemTempList = {}
    end
    local index = 0
    ---@param item LuaProficientItem
    for i, item in pairs(list) do
        local obj = self:GetProficientSkillGridContainer().controlList[index];

        if (self.ProficientItemTempList[obj] == nil) then
            self.ProficientItemTempList[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.UIProficientPanel_ProficientItemTemplate)
        end
        ---@type UIProficientItemTemplate
        local temp = self.ProficientItemTempList[obj]
        temp:UpdateData(item, index)

        index = index + 1
    end
end

---得到UI上面显示的UI列表
---@return table<number, LuaProficientItem>
function UIProficientPanel:GetUIShowProficientList()
    ---@type table<number, LuaProficientItem>
    local default = gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():GetProficientList()
    local list = {}
    ---@param v LuaProficientItem
    for i, v in pairs(default) do
        if self:IsShowProficUnit(v) then
            table.insert(list, v)
        end
        --[[        if (v.needCheckRoleEquip == nil) then

                else
                    ---需要检测装备位的专精先临时隐藏掉
                    ---@type LuaEquipDataItem
                    --local LuaEquipDataItem = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(0):GetEquipItem(v.needCheckRoleEquip)
                    --if(LuaEquipDataItem ~= nil and LuaEquipDataItem.BagItemInfo~= nil) then
                    --    table.insert(list, v)
                    --end
                end]]
    end
    ---这里之后需要获取到已经升级的数据,然后进行替换
    return list
end

---更新专精信息
function UIProficientPanel:UpdateProficientInfo(data)

end

--region 判断专精是否显示

---判断材料工具
---@type LuaMaterialData
function UIProficientPanel:CheckMaterialTool()
    if self.mCheckMaterialTool == nil then
        self.mCheckMaterialTool = luaclass.LuaMaterialData:New()
    end
    return self.mCheckMaterialTool
end

---根据专精信息是否显示专精单元
---@param data LuaProficientItem
---@return boolean
function UIProficientPanel:IsShowProficUnit(data)
    ---是否需要去人物身上查找装备位
    if data.needCheckRoleEquip == nil then
        return true
    end

    ---特殊装备专精（灯座、宝饰等）修改为获得过材料后才显示对应条目
    if data.level > 0 then
        return true
    end
    if data.nextTbl == nil then
        return false
    end
    local itemCostList = data.nextTbl:GetCost()
    if (itemCostList ~= nil and itemCostList.list ~= nil) then
        ---@param v table<number, table<number>>
        for i, v in pairs(itemCostList.list) do
            if v.list ~= nil and #v.list > 0 then
                local materialItemId = v.list[1]
                ---更新材料信息缓存
                self:CheckMaterialTool():GenerateData(materialItemId)
                ---获得材料数量
                local count = self:CheckMaterialTool():GetMaterialCount(LuaItemSavePos.Bag, true)
                if count > 0 then
                    return true
                end
            end
        end
    end
    return false
end

--endregion

function UIProficientPanel:OnClickClose()
    uimanager:ClosePanel("UIProficientPanel")
end

function ondestroy()
    uimanager:ClosePanel("UIProficientDetailsPanel")
end

return UIProficientPanel