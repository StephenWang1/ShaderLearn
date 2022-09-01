---@class UIRolePanel_SLSuitPanelTemplate 人物面板的神力装备栏面板的模板类
local UIRolePanel_SLSuitPanelTemplate = {}

---装备列表的数据(PS:为了方便查看其他玩家使用,这个的装备数据不应该去直接获取主角,而是从面板传入)
---@type LuaPlayerEquipmentListData
UIRolePanel_SLSuitPanelTemplate.PlayerEquipmentListData = nil
UIRolePanel_SLSuitPanelTemplate.Type = nil

---@type UIRolePanel_SLEquipGridTemp
UIRolePanel_SLSuitPanelTemplate.EquipGridDic = nil

---@type boolean 是否是第一次重置位置
UIRolePanel_SLSuitPanelTemplate.IsFirstResetFinish = nil

function UIRolePanel_SLSuitPanelTemplate:Init(panel)
    if panel ~= nil then
        self.panel = panel
    end
    self:InitComponent()
    self:BindEvent()
end

function UIRolePanel_SLSuitPanelTemplate:BindEvent()
    if self.panel ~= nil then
        self.panel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BingJianChoose, function(id, bagItemInfo)
            self:RefreshGridChoose(bagItemInfo)
        end)
    end
end

function UIRolePanel_SLSuitPanelTemplate:InitComponent()
    self.EquipGridDic = {}

    self.lamp = self:Get("equips/Left/lamp", "GameObject")
    self.weapon = self:Get("equips/Left/weap", "GameObject")
    self.clothes = self:Get("equips/Left/clothes", "GameObject")
    self.BraceletL = self:Get("equips/Left/BraceletL", "GameObject")
    self.ringL = self:Get("equips/Left/ringL", "GameObject")
    self.Helmet = self:Get("equips/Right/Helmet", "GameObject")
    self.Necklace = self:Get("equips/Right/Necklace", "GameObject")
    self.medal = self:Get("equips/Right/medal", "GameObject")
    self.BraceletR = self:Get("equips/Right/BraceletR", "GameObject")
    self.ringR = self:Get("equips/Right/ringR", "GameObject")

    self.LeftUITable = self:Get("equips/Left", "Top_UITable")
    self.RightUITable = self:Get("equips/Right", "Top_UITable")

    self:BindTemplate(LuaEquipmentItemType.POS_SL_FABAO, self.lamp)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_WEAPON, self.weapon)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_CLOTHES, self.clothes)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_LEFT_HAND, self.BraceletL)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_LEFT_RING, self.ringL)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_HEAD, self.Helmet)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_NECKLACE, self.Necklace)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_MEDAL, self.medal)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_RIGHT_HAND, self.BraceletR)
    self:BindTemplate(LuaEquipmentItemType.POS_SL_RIGHT_RING, self.ringR)
end


---index=6为写死代码 如果装备类型是6的话在装备栏中不需要显示所有的装备
function UIRolePanel_SLSuitPanelTemplate:SetEquipIndex(index)
    self.lamp:SetActive(index ~= 6)
    self.weapon:SetActive(index ~= 6)
    self.clothes:SetActive(index ~= 6)
    self.BraceletL:SetActive(index ~= 6)
    self.Helmet:SetActive(index ~= 6)
    self.Necklace:SetActive(index ~= 6)
    self.medal:SetActive(index ~= 6)
    self.BraceletR:SetActive(index ~= 6)
    self.ringR:SetActive(index ~= 6)
    self.ringL:SetActive(index ~= 6)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23104)
    if Lua_GlobalTABLE.value == nil then
        return
    end
    local obj = string.Split(Lua_GlobalTABLE.value,"#")
    for i = 1, #obj do
        self[obj[i]]:SetActive(true)
    end
    if index ~= 6 then
        uimanager:ClosePanel("UISLequipLevelPanel")
    else
        local equipInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLBingJianByGlobalOrder()
        if equipInfo then
            uimanager:CreatePanel("UISLequipLevelPanel", nil, 1, equipInfo)
            CS.CSListUpdateMgr.Add(150, nil, function()
                luaEventManager.DoCallback(LuaCEvent.BingJianChoose, equipInfo)
            end)
        end
    end
end


---更新装备列表数据
---@param listData LuaPlayerEquipmentListData 装备列表数据
function UIRolePanel_SLSuitPanelTemplate:UpdateDate(listData, panel)
    if (listData ~= nil) then
        self.PlayerEquipmentListData = listData
    end

    if (self.PlayerEquipmentListData == nil) then
        return
    end

    self:SetEquipIndex(self.PlayerEquipmentListData.EquipmentListType)

    if (self.Type ~= self.PlayerEquipmentListData.EquipmentListType) then
        self.IsFirstResetFinish = nil
    end
    self.Type = self.PlayerEquipmentListData.EquipmentListType
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_FABAO);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_WEAPON);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_CLOTHES);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_LEFT_HAND);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_LEFT_RING);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_HEAD);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_NECKLACE);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_MEDAL);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_RIGHT_HAND);
    self:UpdateItemData(LuaEquipmentItemType.POS_SL_RIGHT_RING);

    --if (self.LeftUITable ~= nil) then
    --    if (self.IsFirstResetFinish ~= nil) then
    --        self.LeftUITable.IsDealy = true
    --    end
    --    self.LeftUITable:Reposition()
    --end
    --if (self.RightUITable ~= nil) then
    --    if (self.IsFirstResetFinish ~= nil) then
    --        self.RightUITable.IsDealy = true
    --    end
    --    self.RightUITable:Reposition()
    --end
    self.IsFirstResetFinish = true
end

---为格子绑定模板并刷新
function UIRolePanel_SLSuitPanelTemplate:BindTemplate(equipIndex, grid)
    --绑定模板
    local tbl = templatemanager.GetNewTemplate(grid, self:GetGridTemp())
    ----存储数据
    self.EquipGridDic[equipIndex] = tbl
end

---移除格子的数据
function UIRolePanel_SLSuitPanelTemplate:CancelBind(equipIndex, grid)
    ----移除数据
    if self.EquipGridDic[equipIndex] ~= nil then
        self.EquipGridDic[equipIndex] = nil
    end
end

function UIRolePanel_SLSuitPanelTemplate:CallGridRed()
    for i, v in pairs(self.EquipGridDic) do
        ---@type UIRolePanel_SLEquipGridTemp
        local UIRolePanel_SLEquipGridTemp = v
        UIRolePanel_SLEquipGridTemp:CallRedPoint()
    end
end

---@return UIRolePanel_SLEquipGridTemp
function UIRolePanel_SLSuitPanelTemplate:GetGridTemp()
    return luaComponentTemplates.UIRolePanel_SLEquipGridTemp
end

---设置背包数据,  为了在查看其他玩家面板的时候通用,主角打开的时候 传入正常的主角背包,其他玩家的时候,传入nil就好了
---@param data LuaMainPlayerBagMgr
function UIRolePanel_SLSuitPanelTemplate:SetBagMgrData(data)
    self.PlayerBagMgr = data
end

---得到背包数据
function UIRolePanel_SLSuitPanelTemplate:GetBagMgrData()
    return self.PlayerBagMgr
end

function UIRolePanel_SLSuitPanelTemplate:UpdateItemData(equipBasicIndex)
    local equipIndex = 100000 + 1000 * self.Type + equipBasicIndex
    ---@type UIRolePanel_GridTemplateSynthesis
    local temp = self.EquipGridDic[equipBasicIndex]
    if (temp == nil) then
        return ;
    end
    temp:SetBagMgrData(self:GetBagMgrData())
    --第一次刷新
    local info = self:GetEquipDataItem(equipIndex)
    if (info ~= nil) then
        temp:ShowEquip(info.BagItemInfo, equipIndex)
    else
        temp:ShowEquip(nil, equipIndex)
    end
    temp.equipIndex = equipIndex
    temp.subType = equipBasicIndex
end

---获取显示装备信息
---@param equipIndex XLua.Cast.Int32 装备位indexReqPutOnTheEquipMessage
---@return LuaEquipDataItem
function UIRolePanel_SLSuitPanelTemplate:GetEquipDataItem(equipIndex)
    if (self.PlayerEquipmentListData.EquipmentDic == nil) then
        return nil
    end
    return self.PlayerEquipmentListData.EquipmentDic[equipIndex]
end

---刷新选中格子
function UIRolePanel_SLSuitPanelTemplate:RefreshGridChoose(bagItemInfo)
    if bagItemInfo == nil then
        for k, v in pairs(self.EquipGridDic) do
            v:SetItemChoose(false)
        end
        return
    end
    for k, v in pairs(self.EquipGridDic) do
        v:SetItemChoose(v.equipIndex == bagItemInfo.index)
    end
end

return UIRolePanel_SLSuitPanelTemplate;