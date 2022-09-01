---@class UIMilitaryRankTitleFlairPanel : UIBase
local UIMilitaryRankTitleFlairPanel = {}

-- 天赋丹物品id
UIMilitaryRankTitleFlairPanel.TalentItemId = 5000765
-- 重置天赋丹id
UIMilitaryRankTitleFlairPanel.ResetBindTalentItemId = 6500001


--region 初始化

function UIMilitaryRankTitleFlairPanel:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIEvents()
    self:BindNetMessage()
end

--- 初始化组件
function UIMilitaryRankTitleFlairPanel:InitComponents()
    ---@type UILoopScrollViewPlus
    UIMilitaryRankTitleFlairPanel.grid = self:GetCurComp("WidgetRoot/view/ScrollView/Gird", "UILoopScrollViewPlus")

    ---@type UnityEngine.GameObject 关闭按钮
    UIMilitaryRankTitleFlairPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 取消按钮
    UIMilitaryRankTitleFlairPanel.btn_cancel = self:GetCurComp("WidgetRoot/events/btn_no", "GameObject")
    ---@type UnityEngine.GameObject 确定按钮（保存）
    UIMilitaryRankTitleFlairPanel.btn_yes = self:GetCurComp("WidgetRoot/events/btn_yes", "GameObject")
    ---@type UnityEngine.GameObject 重置按钮
    UIMilitaryRankTitleFlairPanel.btn_reset = self:GetCurComp("WidgetRoot/events/btn_return", "GameObject")
    ---@type UnityEngine.GameObject 可分配点数的加号
    UIMilitaryRankTitleFlairPanel.btn_add_attribute = self:GetCurComp("WidgetRoot/view/attributeNum/add", "GameObject")
    ---@type UILabel 可分配点数
    UIMilitaryRankTitleFlairPanel.attr_point = self:GetCurComp("WidgetRoot/view/attributeNum/inputcount/Label", "UILabel")
    ---@type UnityEngine.GameObject
    UIMilitaryRankTitleFlairPanel.returnItemObj = self:GetCurComp("WidgetRoot/view/returnItem", "GameObject")
    ---@type UISprite 重置需要的物品的图标
    UIMilitaryRankTitleFlairPanel.needItem_icon = self:GetCurComp("WidgetRoot/view/returnItem/icon", "UISprite")
    ---@type UILabel 重置需要的物品数量
    UIMilitaryRankTitleFlairPanel.needItem_num = self:GetCurComp("WidgetRoot/view/returnItem/num", "UILabel")
    ---@type UnityEngine.GameObject 重置需要的物品的获取途径按钮
    UIMilitaryRankTitleFlairPanel.btn_needItem_add = self:GetCurComp("WidgetRoot/view/returnItem/add", "GameObject")
    ---@type UILabel 可用天赋丹数
    UIMilitaryRankTitleFlairPanel.attributeItemNum = self:GetCurComp("WidgetRoot/view/attributeItemNum", "UILabel")
end

--- 初始化参数
function UIMilitaryRankTitleFlairPanel:InitParameters()
    self.isInitLoopPlus = false
    self.resetNeedItem = nil
    self.resetNeedItemCount = nil
    self.AttributeTemoDic = nil
    self.talentShowStrFormat = '[dde6eb]可用天赋丹[-]  %s'
end

-- 获取天赋数据
function UIMilitaryRankTitleFlairPanel:GetData()
    -- 服务器数据返回的天赋数据
    UIMilitaryRankTitleFlairPanel.talentData = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentData()
    -- 临时分配的天赋数据
    UIMilitaryRankTitleFlairPanel.talentTempData = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentTempData()
    self.RemainPoint = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetRemainPointData()
end

function UIMilitaryRankTitleFlairPanel:BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(self.CloseBtn).onClick = function()
        self:OnClickCloseBtn()
    end
    ---点击取消按钮
    CS.UIEventListener.Get(self.btn_cancel).onClick = function()
        self:OnClickCancelBtn()
    end
    ---点击确定按钮（保存）
    CS.UIEventListener.Get(self.btn_yes).onClick = function()
        self:OnClickSaveBtn()
    end
    ---点击重置按钮
    CS.UIEventListener.Get(self.btn_reset).onClick = function()
        self:OnClickResetBtn()
    end
    ---点击可分配点数的加号按钮
    CS.UIEventListener.Get(self.btn_add_attribute).onClick = function()
        self:OnClickAddAttributeBtn()
    end

    ---重置需要物品的获取方式
    CS.UIEventListener.Get(self.btn_needItem_add).onClick = function()
        self:OnClickResetNeedItemGetWaysBtn()
    end

    CS.UIEventListener.Get(self.needItem_icon.gameObject).onClick = function()
        self:OnClickResetNeedItemIcon()
    end

end

function UIMilitaryRankTitleFlairPanel:BindNetMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTitleTianfuMessage, UIMilitaryRankTitleFlairPanel.OnResTitleTianfuMessageCallBack)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIMilitaryRankTitleFlairPanel.OnBagCoinChangedCallBack)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshFengHaoRemainPoint, UIMilitaryRankTitleFlairPanel.RefreshFengHaoRemainPoint)
end

--endregion

---@param msgId LuaEnumNetDef
---@param msgData roleV2.ResTitleTianfu
function UIMilitaryRankTitleFlairPanel.OnResTitleTianfuMessageCallBack(msgId, msgData)
    UIMilitaryRankTitleFlairPanel:RefreshPanel()
end

function UIMilitaryRankTitleFlairPanel.OnBagCoinChangedCallBack()
    UIMilitaryRankTitleFlairPanel:RefreshNeedItem()
    UIMilitaryRankTitleFlairPanel:RefreshTalentDanTxt()
end

function UIMilitaryRankTitleFlairPanel.RefreshFengHaoRemainPoint(id,data)
    local data = 0
    for i = 1, #UIMilitaryRankTitleFlairPanel.talentTempData do
        data = data + UIMilitaryRankTitleFlairPanel.talentTempData[i]
    end
    local remainPoint = UIMilitaryRankTitleFlairPanel.talentData[7] - data
    remainPoint = remainPoint < 0 and 0 or remainPoint
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetRemainPointData(remainPoint)
    UIMilitaryRankTitleFlairPanel.RemainPoint = remainPoint
    UIMilitaryRankTitleFlairPanel:RefreshAttrPoint(remainPoint)
    UIMilitaryRankTitleFlairPanel:RefreshBtnActive()
end

--region 函数监听

---点击关闭按钮
---@private
function UIMilitaryRankTitleFlairPanel:OnClickCloseBtn()
    uimanager:ClosePanel("UIMilitaryRankTitleFlairPanel")
end

---点击取消按钮
---@private
function UIMilitaryRankTitleFlairPanel:OnClickCancelBtn()
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():ResetTalentTempData()
    self:RefreshPanel()
end

---点击确定按钮（保存）
---@private
function UIMilitaryRankTitleFlairPanel:OnClickSaveBtn()
    -- 请求保存后，重置临时分配点数据
    networkRequest.ReqSaveTitleTianfu(UIMilitaryRankTitleFlairPanel.talentTempData[1], UIMilitaryRankTitleFlairPanel.talentTempData[2], UIMilitaryRankTitleFlairPanel.talentTempData[3], UIMilitaryRankTitleFlairPanel.talentTempData[4], UIMilitaryRankTitleFlairPanel.talentTempData[5], UIMilitaryRankTitleFlairPanel.talentTempData[6])
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():ResetTalentTempData()
    UIMilitaryRankTitleFlairPanel:GetData()
    self:RefreshAttrPoint(UIMilitaryRankTitleFlairPanel.talentData[7])
    self:RefreshAttributeGridView()
end

-- 数值变化时，重新计算剩余可分配点数，刷新显示
function UIMilitaryRankTitleFlairPanel.OnNumberChanged()
    -- 数值变化前的剩余点数
    local data = 0
    for i = 1, #UIMilitaryRankTitleFlairPanel.talentTempData do
        data = data + UIMilitaryRankTitleFlairPanel.talentTempData[i]
    end
    local remainPoint = UIMilitaryRankTitleFlairPanel.talentData[7] - data
    remainPoint = remainPoint < 0 and 0 or remainPoint
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetRemainPointData(remainPoint)
    UIMilitaryRankTitleFlairPanel.RemainPoint = remainPoint
    UIMilitaryRankTitleFlairPanel:RefreshAttrPoint(remainPoint)
    UIMilitaryRankTitleFlairPanel:RefreshBtnActive()
    UIMilitaryRankTitleFlairPanel:RefreshAttributeGridView()
end

---点击重置按钮
---@private
function UIMilitaryRankTitleFlairPanel:OnClickResetBtn()

    -- 重置需要的物品数量大于背包已有数量 提示
    local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.resetNeedItem)
    curCount = curCount + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.ResetBindTalentItemId)
    if (self.resetNeedItemCount > curCount) then
        local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(474)
        if res then
            Utility.ShowPopoTips(self.btn_reset, info.content, 474)
        end
        return
    end

    -- 页面显示数据重置，请求重置
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():ResetTalentTempData()
    self:RefreshAttrPoint(UIMilitaryRankTitleFlairPanel.talentData[7])
    networkRequest.ReqResetTitleTianfu()
end

---点击可分配点数的加号按钮
---@private
function UIMilitaryRankTitleFlairPanel:OnClickAddAttributeBtn()
    -- 定死展示封号天赋丹的获取途径
    Utility.ShowItemGetWay(self.TalentItemId, self.btn_add_attribute, LuaEnumWayGetPanelArrowDirType.Left);
end

-- 重置需要物品的获取方式
function UIMilitaryRankTitleFlairPanel:OnClickResetNeedItemGetWaysBtn()
    if (self.resetNeedItem ~= nil) then
        Utility.ShowItemGetWay(self.resetNeedItem, self.btn_needItem_add, LuaEnumWayGetPanelArrowDirType.Down)
    end
end

function UIMilitaryRankTitleFlairPanel:OnClickResetNeedItemIcon()
    if self.resetNeedItem == nil then
        return
    end

    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.resetNeedItem)
    if isFind then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false })
    end
end

--endregion

--region UI

function UIMilitaryRankTitleFlairPanel:Show(customData)
    self:RefreshPanel()
end

function UIMilitaryRankTitleFlairPanel:RefreshPanel()
    self:GetData()
    self:RefreshAttributeGridView()
    self:RefreshBtnActive()
    self:RefreshAttrPoint(gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetRemainPointData())
    self:RefreshNeedItem()
    self:RefreshTalentDanTxt()
end

function UIMilitaryRankTitleFlairPanel:RefreshAttributeGridView()
    if (self.AttributeTemoDic == nil) then
        self.AttributeTemoDic = {}
    end
    if not self.isInitLoopPlus then
        self.isInitLoopPlus = true
        self.grid:Init(function(go, line)
            return self:TempCallBack(go, line)
        end, nil)
    else
        self.grid:RefreshCurrentPage()
    end
end

function UIMilitaryRankTitleFlairPanel:TempCallBack(go, line)
    local index = line + 1
    if line < 6 then
        ---显示6条
        local temp = self.AttributeTemoDic[go]
        if (temp == nil) then
            temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMilitaryRankTitleFlairTemplate, UIMilitaryRankTitleFlairPanel.OnNumberChanged)
            self.AttributeTemoDic[go] = temp
        end

        temp:RefreshUI(index, UIMilitaryRankTitleFlairPanel.talentData, UIMilitaryRankTitleFlairPanel.talentTempData[index])
        return true
    else
        return false
    end
end

-- 控制按钮的显隐
function UIMilitaryRankTitleFlairPanel:RefreshBtnActive()
    -- 剩余点和总点一样显示重置按钮 
    local result = self.RemainPoint == self.talentData[7]
    self.btn_reset:SetActive(result)
    self.returnItemObj:SetActive(result)
    self.btn_yes:SetActive(not  result)
    self.btn_cancel:SetActive(not  result)
    --if (self.RemainPoint == self.talentData[7]) then
    --    self.btn_reset:SetActive(true)
    --    self.returnItemObj:SetActive(true)
    --    self.btn_yes:SetActive(false)
    --    self.btn_cancel:SetActive(false)
    --else
    --    self.btn_reset:SetActive(false)
    --    self.returnItemObj:SetActive(false)
    --    self.btn_yes:SetActive(true)
    --    self.btn_cancel:SetActive(true)
    --end
end

-- 刷新显示可分配点数
-- @param num 点数
function UIMilitaryRankTitleFlairPanel:RefreshAttrPoint(num)
    self.attr_point.color = self.RemainPoint ~= self.talentData[7] and CS.UnityEngine.Color.green or CS.UnityEngine.Color.white
    self.attr_point.text = Utility.GetIntPart(num)
end

--刷新重置需要的物品
function UIMilitaryRankTitleFlairPanel:RefreshNeedItem()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22874)
    if not isFind then
        return
    end
    local infoArray = string.Split(info.value, '#')

    local id = infoArray[1]
    local needCount = tonumber(infoArray[2])
    self.resetNeedItem = tonumber(id)
    self.resetNeedItemCount = needCount

    local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.resetNeedItem)
    curCount = curCount + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.ResetBindTalentItemId)
    isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.resetNeedItem)
    if isFind then
        self.needItem_icon.spriteName = info.icon
        self.needItem_num.text = (curCount < self.resetNeedItemCount and luaEnumColorType.Red or luaEnumColorType.Green3) .. curCount .. "[-]/" .. self.resetNeedItemCount
    end

end

---刷新可用天赋丹次数
function UIMilitaryRankTitleFlairPanel:RefreshTalentDanTxt()
    local num = 0
    if gameMgr:GetPlayerDataMgr() and gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo() then
        num = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetRemainTalentDan()
    end
    local color = num == 0 and luaEnumColorType.Red or luaEnumColorType.Green3
    self.attributeItemNum.text = string.format(self.talentShowStrFormat, color .. tostring(num) .. '[-]')
end

--endregion

return UIMilitaryRankTitleFlairPanel