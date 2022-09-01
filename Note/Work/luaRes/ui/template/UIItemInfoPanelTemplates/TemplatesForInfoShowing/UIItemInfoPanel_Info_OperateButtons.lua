---@type 物品信息界面信息
local UIItemInfoPanel_Info_OperateButtons = {}

setmetatable(UIItemInfoPanel_Info_OperateButtons, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---CD时间文本
function UIItemInfoPanel_Info_OperateButtons:GetCDTimeLabel_UILabel()
    if self.mCDTimeLabel_UILabel == nil then
        self.mCDTimeLabel_UILabel = self:Get("LimitTime", "UILabel")
    end
    return self.mCDTimeLabel_UILabel
end

---CD事件倒计时
---@return UICountdownLabel
function UIItemInfoPanel_Info_OperateButtons:GetCDTimeCountDown()
    if self.mCDTimeCountDown == nil then
        self.mCDTimeCountDown = self:Get("LimitTime", "UICountdownLabel")
    end
    return self.mCDTimeCountDown
end

---右按钮
---@type UnityEngine.GameObject
function UIItemInfoPanel_Info_OperateButtons:GetRightButton_GameObject()
    if self.mRightButtonGO == nil then
        self.mRightButtonGO = self:Get("RightBtn", "GameObject")
    end
    return self.mRightButtonGO
end

---展示按钮
function UIItemInfoPanel_Info_OperateButtons:GetShowBtn_GameObject()
    if self.mShowBtn_GameObject == nil then
        self.mShowBtn_GameObject = self:Get("ShowBtn", "GameObject")
    end
    return self.mShowBtn_GameObject
end

---右上角按钮列表
function UIItemInfoPanel_Info_OperateButtons:GetRightBtnList_GameObject()
    if self.mRightBtnList_GameObject == nil then
        local uiItemInfoPanel = uimanager:GetPanel("UIItemInfoPanel")
        local uiPetInfoPanel = uimanager:GetPanel("UIPetInfoPanel")
        if uiItemInfoPanel ~= nil then
            self.mRightBtnList_GameObject = uiItemInfoPanel.go.transform:Find("WidgetRoot/mainpart/content/rightup").gameObject
        elseif uiPetInfoPanel ~= nil then
            self.mRightBtnList_GameObject = uiPetInfoPanel.go.transform:Find("WidgetRoot/mainpart/content/rightup").gameObject
        end
    end
    return self.mRightBtnList_GameObject
end

---右下角按钮列表
function UIItemInfoPanel_Info_OperateButtons:GetRightDownBtnList_GameObject()
    if self.mRightDownBtnList_GameObjectt == nil then
        local uiItemInfoPanel = uimanager:GetPanel("UIItemInfoPanel")
        local uiPetInfoPanel = uimanager:GetPanel("UIPetInfoPanel")
        if uiItemInfoPanel ~= nil then
            self.mRightDownBtnList_GameObjectt = uiItemInfoPanel.go.transform:Find("WidgetRoot/mainpart/content/rightdown").gameObject
        elseif uiPetInfoPanel ~= nil then
            self.mRightDownBtnList_GameObjectt = uiPetInfoPanel.go.transform:Find("WidgetRoot/mainpart/content/rightdown").gameObject
        end
    end
    return self.mRightDownBtnList_GameObjectt
end
--endregion

--region 刷新面板组件信息
---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_OperateButtons:RefreshWithInfo(commonData)
    ---策划要求取消所有获取途径按钮（则修改获取途径的根源）
    self:GetRightButton_GameObject():SetActive(false)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo

    --self.mBagItemInfo = bagItemInfo
    --self.mItemInfo = itemInfo
    --self:RefreshCDTime(bagItemInfo, itemInfo)
    ----没有获取途径时隐藏此按钮
    --local res, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mItemInfo.id)
    --if res and itemInfo then
    --    self:GetRightButton_GameObject():SetActive(self:OpenGainBtn(itemInfo) and itemInfo.wayGet ~= nil)
    --end
    --
    ----获取途径
    --if self:GetRightButton_GameObject() and CS.StaticUtility.IsNull(self:GetRightButton_GameObject()) == false then
    --    CS.UIEventListener.Get(self:GetRightButton_GameObject()).onClick = function()
    --        self:OnButtonClicked_GainOperate()
    --    end
    --end
    --
    ----展示按钮
    --if self:GetShowBtn_GameObject() and CS.StaticUtility.IsNull(self:GetShowBtn_GameObject()) == false then
    --    if CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(itemInfo.subType) ~= nil then
    --        if CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(itemInfo.subType).itemId == itemInfo.id then
    --            self:GetShowBtn_GameObject():SetActive(false)
    --        end
    --    end
    --    if itemInfo.sex ~= LuaEnumSex.Common then
    --        if Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) ~= itemInfo.sex then
    --            self:GetShowBtn_GameObject():SetActive(false)
    --        end
    --    end
    --    if itemInfo.career ~= LuaEnumCareer.Common then
    --        if Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) ~= itemInfo.career then
    --            self:GetShowBtn_GameObject():SetActive(false)
    --        end
    --    end
    --    if not Utility.IntToBool(itemInfo.isModelPreview) then
    --        self:GetShowBtn_GameObject():SetActive(false)
    --    end
    --    CS.UIEventListener.Get(self:GetShowBtn_GameObject()).onClick = function()
    --        uimanager:CreatePanel("UIShowEquipPanel", nil, bagItemInfo, itemInfo)
    --    end
    --end
end
--endregion

---刷新CD时间(该位置还有属性,如聚灵珠的经验值)
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS 背包物品表信息
function UIItemInfoPanel_Info_OperateButtons:RefreshCDTime(bagItemInfo, itemInfo)
    if self:GetCDTimeLabel_UILabel() and CS.StaticUtility.IsNull(self:GetCDTimeLabel_UILabel()) == false then
        local str = ""
        local needLine = false
        --限时道具
        if bagItemInfo and bagItemInfo.timeSpecified and bagItemInfo.time > 0 then
            if needLine then
                str = str .. "\r\n"
            end
            self:GetCDTimeCountDown():StartCountDown(500, 3, bagItemInfo.time, str .. "剩余 ", "[-]", nil, nil)
            self:GetCDTimeLabel_UILabel().gameObject:SetActive(true)
            return
        end
        self:GetCDTimeLabel_UILabel().text = str
    end
end

--region 按钮点击回调
---"获取"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_OperateButtons:OnButtonClicked_GainOperate(go)
    if self.mItemInfo ~= nil then
        if self:GetRightBtnList_GameObject().activeSelf then
            self:GetRightBtnList_GameObject():SetActive(false)
            self:GetRightDownBtnList_GameObject():SetActive(true)
        else
            self:GetRightBtnList_GameObject():SetActive(true)
            self:GetRightDownBtnList_GameObject():SetActive(false)
        end
    end
    --if self.mItemInfo.openPanelSpecified then
    --    local res, panelParams = CS.Cfg_ItemsTableManager.Instance.OpenPanel:TryGetValue(self.mItemInfo.id)
    --    if res and panelParams then
    --        for i = 0, panelParams.Count - 1 do
    --            if panelParams[i].operateID == LuaEnumItemOperateType.Gain then
    --                if panelParams[i].openParams.Count == 0 then
    --                    if self.gainList == nil then
    --                        self.gainList = uimanager:CreatePanel(panelParams[i].panelName, function(panel)
    --                            self.gainList = panel
    --                            self:GetRightBtnList_GameObject():SetActive(false)
    --                        end, self.mItemInfo, self:GetRightButton_GameObject(), CS.UnityEngine.Vector3(-36, 252, 0), CS.UnityEngine.Vector3.one)
    --                    else
    --                        if self.gainList.go.activeSelf then
    --                            self.gainList.go.gameObject:SetActive(false)
    --                            self:GetRightBtnList_GameObject():SetActive(true)
    --                        else
    --                            self.gainList.go.gameObject:SetActive(true)
    --                            self:GetRightBtnList_GameObject():SetActive(false)
    --                        end
    --                    end
    --                else
    --                    local tbl = {}
    --                    for j = 0, panelParams[i].openParams.Count - 1 do
    --                        table.insert(tbl, panelParams[i].openParams[j])
    --                    end
    --                    if self.gainList == nil then
    --                        uimanager:CreatePanel(panelParams[i].panelName, function(panel)
    --                            self.gainList = panel
    --                            self:GetRightBtnList_GameObject():SetActive(false)
    --                        end, table.unpack(tbl), self:GetRightButton_GameObject(), CS.UnityEngine.Vector3(-36, 252, 0))
    --                    else
    --                        if self.gainList.go.activeSelf then
    --                            self.gainList.go.gameObject:SetActive(false)
    --                            self:GetRightBtnList_GameObject():SetActive(true)
    --                        else
    --                            self.gainList.go.gameObject:SetActive(true)
    --                            self:GetRightBtnList_GameObject():SetActive(false)
    --                        end
    --                    end
    --                end
    --            end
    --        end
    --    end
    --end
end

function UIItemInfoPanel_Info_OperateButtons:OpenGainBtn(itmeInfo)
    local leftOperate = itmeInfo.leftOperate
    local rightOperate = itmeInfo.rightOperate
    if itmeInfo then
        if leftOperate then
            for i = 0, leftOperate.list.Count - 1 do
                if leftOperate.list[i] == LuaEnumItemOperateType.Gain then
                    return true
                end
            end
        end
        if rightOperate then
            for j = 0, rightOperate.list.Count - 1 do
                if rightOperate.list[j] == LuaEnumItemOperateType.Gain then
                    return true
                end
            end
        end
    end
    return false
end
--endregion

return UIItemInfoPanel_Info_OperateButtons