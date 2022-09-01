---@class UIHuFuPanel:UIBase 虎符
local UIHuFuPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIHuFuPanel:GetCloseBtn_Go()
    if self.mCloseBtn_Go == nil then
        self.mCloseBtn_Go = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn_Go
end

---@return UILoopScrollViewPlus
function UIHuFuPanel:GetHuFuLoop_UILoopScrollViewPlus()
    if self.mHuFuLoop == nil then
        self.mHuFuLoop = self:GetCurComp("WidgetRoot/HuFu/Scroll View/LoopScrollViewPlus", "UILoopScrollViewPlus")
    end
    return self.mHuFuLoop
end

---@return UnityEngine.GameObject 空
function UIHuFuPanel:GetNullObj_GO()
    if self.mNullObj == nil then
        self.mNullObj = self:GetCurComp("WidgetRoot/HuFu/nullObj", "GameObject")
    end
    return self.mNullObj
end

---@return UnityEngine.GameObject Help
function UIHuFuPanel:GetHelpBtn_GO()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return self.mHelpBtn
end
--endregion

--region 初始化
function UIHuFuPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UIHuFuPanel:Show()
    self:InitHuFuShow()
end

function UIHuFuPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetHelpBtn_GO()).onClick = function()
        self:OnHelpBtnClicked()
    end
end

function UIHuFuPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshHuFuShow()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfficialInfoV2Message, function()
        self:RefreshCurrentStage()
        self:RefreshHuFuShow()
    end)
end
--endregion

--region 刷新虎符列表
function UIHuFuPanel:InitHuFuShow()
    self:RefreshCurrentStage()
    self:GetHuFuLoop_UILoopScrollViewPlus():Init(function(go, line)
        if line < self:GetCurrentStage() then
            local token = self:CacheTokenInfo(line + 1)
            local template = self:GetSingleHuFuTemplate(go)
            if template and token then
                template:Refresh(token)
                return true
            end
        end
        return false
    end, nil)
end

---刷新当前官阶
function UIHuFuPanel:RefreshCurrentStage()
    local posId = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo().officialPosistionId
    local posTbl = self:CachePositionInfo(posId)
    self:GetHuFuLoop_UILoopScrollViewPlus().gameObject:SetActive(posTbl ~= nil)
    self:GetNullObj_GO():SetActive(posTbl == nil)
    --self:get
    if posTbl == nil then
        self.mStage = 0
        return
    end
    self.mStage = posTbl:GetStage()
end

---获取官阶
function UIHuFuPanel:GetCurrentStage()
    return self.mStage
end

function UIHuFuPanel:RefreshHuFuShow()
    self:GetHuFuLoop_UILoopScrollViewPlus():RefreshCurrentPage()
end

---@return SingleHuFuTemplate 单个虎符模板
function UIHuFuPanel:GetSingleHuFuTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.SingleHuFuTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end
--endregion

--region 缓存数据
---@return TABLE.cfg_official_position 官位数据
function UIHuFuPanel:CachePositionInfo(posId)
    if posId == nil then
        return
    end
    if self.mPositionIdToInfo == nil then
        self.mPositionIdToInfo = {}
    end
    local info = self.mPositionIdToInfo[posId]
    if info == nil then
        info = clientTableManager.cfg_official_positionManager:TryGetValue(posId)
        self.mPositionIdToInfo[posId] = info
    end
    return info
end

---@return TABLE.cfg_official_emperor_token 虎符数据
function UIHuFuPanel:CacheTokenInfo(tokenId)
    if tokenId == nil then
        return
    end
    if self.mTokenIdToInfo == nil then
        self.mTokenIdToInfo = {}
    end
    local info = self.mTokenIdToInfo[tokenId]
    if info == nil then
        info = clientTableManager.cfg_official_emperor_tokenManager:TryGetValue(tokenId)
        self.mTokenIdToInfo[tokenId] = info
    end
    return info
end

---@return TABLE.cfg_items
function UIHuFuPanel:CacheItemInfo(itemId)
    if itemId == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        info = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

--region Help

function UIHuFuPanel:OnHelpBtnClicked()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(185)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

return UIHuFuPanel