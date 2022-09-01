---藏品界面
---@class UICollectionPanel:UIBase
local UICollectionPanel = {}

--region 组件
---左侧主部件
---@return UnityEngine.GameObject
function UICollectionPanel:GetLeftMainWndPartGo()
    if self.mLeftMainPartGo == nil then
        self.mLeftMainPartGo = self:GetCurComp("WidgetRoot/window/window/left_main", "GameObject")
    end
    return self.mLeftMainPartGo
end

---右侧主部件
---@return UnityEngine.GameObject
function UICollectionPanel:GetRightMainWndPartGo()
    if self.mRightMainPartGo == nil then
        self.mRightMainPartGo = self:GetCurComp("WidgetRoot/window/window/all_main", "GameObject")
    end
    return self.mRightMainPartGo
end

---左侧切换按钮
---@return UnityEngine.GameObject
function UICollectionPanel:GetLeftMainSwitchBtnGo()
    if self.mLeftMainSwitchBtnGo == nil then
        self.mLeftMainSwitchBtnGo = self:GetCurComp("WidgetRoot/window/window/left_main/arrow", "GameObject")
    end
    return self.mLeftMainSwitchBtnGo
end

---右侧切换按钮
---@return UnityEngine.GameObject
function UICollectionPanel:GetRightMainSwitchBtnGo()
    if self.mRightMainSwitchBtnGo == nil then
        self.mRightMainSwitchBtnGo = self:GetCurComp("WidgetRoot/window/window/all_main/arrow", "GameObject")
    end
    return self.mRightMainSwitchBtnGo
end

---左主界面的关闭按钮
---@return UnityEngine.GameObject
function UICollectionPanel:GetLeftMainCloseBtnGo()
    if self.mLeftMainCloseBtnGo == nil then
        self.mLeftMainCloseBtnGo = self:GetCurComp("WidgetRoot/window/window/left_main/events/btn_close", "GameObject")
    end
    return self.mLeftMainCloseBtnGo
end

---右主界面的关闭按钮
---@return UnityEngine.GameObject
function UICollectionPanel:GetRightMainCloseBtnGo()
    if self.mRightMainCloseBtnGo == nil then
        self.mRightMainCloseBtnGo = self:GetCurComp("WidgetRoot/window/window/all_main/events2/btn_close", "GameObject")
    end
    return self.mRightMainCloseBtnGo
end

---右侧属性部分
---@return UnityEngine.GameObject
function UICollectionPanel:GetRightAttrPartGo()
    if self.mRightAttrPartGo == nil then
        self.mRightAttrPartGo = self:GetCurComp("WidgetRoot/right", "GameObject")
    end
    return self.mRightAttrPartGo
end

---帮助按钮
---@return UnityEngine.GameObject
function UICollectionPanel:GetHelpBtnGo()
    if self.mHelpBtnGo == nil then
        self.mHelpBtnGo = self:GetCurComp("WidgetRoot/left/helpBtn", "GameObject")
    end
    return self.mHelpBtnGo
end

---图集字典根节点
---@return UnityEngine.GameObject
function UICollectionPanel:GetAtlasDicGo()
    if self.mAtlasDicGo == nil then
        self.mAtlasDicGo = self:GetCurComp("StaticRoot/atlasDic", "GameObject")
    end
    return self.mAtlasDicGo
end

---藏品页右侧部分
---@return UnityEngine.GameObject
function UICollectionPanel:GetRightPartGo()
    if self.mRightPartGo == nil then
        self.mRightPartGo = self:GetCurComp("WidgetRoot/right", "GameObject")
    end
    return self.mRightPartGo
end

---获取右侧部分
---@return UICollectionRightPart
function UICollectionPanel:GetRightPart()
    return self.mRightPart
end

---升级特效
---@return UnityEngine.GameObject
function UICollectionPanel:GetLevelUpEffect()
    if self.mLevelUpEffect == nil then
        self.mLevelUpEffect = self:GetCurComp("WidgetRoot/left/updataEffect", "GameObject")
    end
    return self.mLevelUpEffect
end

---藏品列表
---@return UnityEngine.GameObject
function UICollectionPanel:GetCollectionList_GameObject()
    if self.mCollectionList_GameObject == nil then
        self.mCollectionList_GameObject = self:GetCurComp("WidgetRoot/left/items", "GameObject")
    end
    return self.mCollectionList_GameObject
end

---等级限制内容
---@return Top_UILabel
function UICollectionPanel:GetLevelLimit_UILabel()
    if self.mLevelLimit_UILabel == nil then
        self.mLevelLimit_UILabel = self:GetCurComp("WidgetRoot/left/needlevel", "Top_UILabel")
    end
    return self.mLevelLimit_UILabel
end

---等级限制内容
---@return Top_UISprite
function UICollectionPanel:GetLevelLimit_UISprite()
    if self.mLevelLimit_UISprite == nil then
        self.mLevelLimit_UISprite = self:GetCurComp("WidgetRoot/left/needlevel/lb_level", "Top_UISprite")
    end
    return self.mLevelLimit_UISprite
end
--endregion

--region 属性
---获取图集
---@param atlasName string
---@return UIAtlas
function UICollectionPanel:GetUIAtlas(atlasName)
    if self.mAtlasDic == nil then
        return nil
    end
    return self.mAtlasDic[atlasName]
end

---获取所展示的藏品信息
---@return LuaCollectionInfo
function UICollectionPanel:GetCollectionInfo()
    return gameMgr:GetPlayerDataMgr():GetCollectionInfo()
end
--endregion

--region 初始化
---@private
function UICollectionPanel:Init()
    self:InitializeAtlasDic()
    self:BindUIEvents()
    self:BindClientEvents()
    ---如果创建时发现背包界面已经创建了,则更改为藏品背包
    ---@type UIBagPanel
    local bagPanel = uimanager:GetPanel("UIBagPanel")
    if bagPanel ~= nil then
        uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Collection)
    end
    self.mRightPart = templatemanager.GetNewTemplate(self:GetRightPartGo(), luaComponentTemplates.UICollectionRightPart, self, self:GetCollectionInfo(), Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
end

---初始化图集字典
---@private
function UICollectionPanel:InitializeAtlasDic()
    self:GetAtlasDicGo():SetActive(false)
    local spriteArray = self:GetAtlasDicGo():GetComponentsInChildren(typeof(CS.UISprite), true)
    self.mAtlasDic = {}
    if spriteArray ~= nil then
        for i = 1, spriteArray.Length do
            ---@type UISprite
            local spriteTemp = spriteArray[i - 1]
            if spriteTemp.atlas ~= nil then
                self.mAtlasDic[spriteTemp.atlas.Name] = spriteTemp.atlas
            end
        end
    end
end

---绑定UI事件
---@private
function UICollectionPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetLeftMainCloseBtnGo()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetRightMainCloseBtnGo()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetLeftMainSwitchBtnGo()).onClick = function()
        self:SwitchPanelState(true)
        ---如果切换到扩展藏品界面,则尝试收起背包界面
        ---@type UIBagPanel
        local bagPanel = uimanager:GetPanel("UIBagPanel")
        if bagPanel ~= nil and bagPanel:GetBagMainController():IsExpandBagPanel() then
            self.mIsBagChangedBySelf = true
            bagPanel:OnExpandButtonClicked()
            self.mIsBagChangedBySelf = false
        end
    end
    CS.UIEventListener.Get(self:GetRightMainSwitchBtnGo()).onClick = function()
        self:SwitchPanelState(false)
    end
    CS.UIEventListener.Get(self:GetHelpBtnGo()).onClick = function()
        self:OnHelpBtnClicked()
    end
end

---绑定客户端事件
---@private
function UICollectionPanel:BindClientEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CollectionInfoUpdate, function()
        self:RefreshUI()
        self:GetRightPart():RefreshUI()
        self:TriggleLevelUpEffect()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, function()
        ---主界面背包按钮点击事件
        self:OnMainChatPanelBagBtnClicked()
    end)
    ---背包箭头点击时,如果切换到了扩展背包,则收起藏品界面
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_ArrowBtnClicked, function()
        if self.mIsBagChangedBySelf then
            return
        end
        ---@type UIBagPanel
        local bagPanel = uimanager:GetPanel("UIBagPanel")
        if bagPanel ~= nil and bagPanel:GetBagMainController() ~= nil and bagPanel:GetBagMainController():IsExpandBagPanel() then
            self:SwitchPanelState(false)
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay,function()
        self:CollectionOpenStatePanelChange()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateReincarnation,function()
        self:CollectionOpenStatePanelChange()
    end)
end

---@alias UICollectionPanelCustomData {isShowAll:boolean|nil}
---@param customData UICollectionPanelCustomData
function UICollectionPanel:Show(customData)
    local isShowAll
    if customData then
        isShowAll = customData.isShowAll
    else
        isShowAll = false
    end
    self.mLevelCache = nil
    self:CollectionOpenStatePanelChange()
    self:GetLevelUpEffect():SetActive(false)
    self:TriggleLevelUpEffect()
    self:SwitchPanelState(isShowAll)
    self:RefreshUI()
    self:GetRightPart():RefreshUI()
    if self:GetCollectionInfo():IsCanLevelUp() then
        self:SwitchPanelState(true)
    end
end
--endregion

--region 状态切换
---切换界面状态
---@param isShowAll boolean|nil 是否切换到完整界面状态
function UICollectionPanel:SwitchPanelState(isShowAll)
    if isShowAll == nil then
        isShowAll = self.mIsShowAll ~= true
    else
        isShowAll = isShowAll == true
    end
    if self.mIsShowAll == isShowAll then
        return
    end
    self.mIsShowAll = isShowAll
    if self.mIsShowAll then
        self:GetLeftMainWndPartGo():SetActive(false)
        self:GetRightMainWndPartGo():SetActive(true)
        self:GetRightAttrPartGo():SetActive(true)
    else
        self:GetLeftMainWndPartGo():SetActive(true)
        self:GetRightMainWndPartGo():SetActive(false)
        self:GetRightAttrPartGo():SetActive(false)
    end
    self:RefreshLinks()
end

---切换到页
---@param pageIndex number 切换到的目标页
---@param withAnimation boolean|nil 是否平滑动画过渡过去
function UICollectionPanel:SwitchToPage(pageIndex, withAnimation)
    if self:GetCollectionItemsController() ~= nil then
        self:GetCollectionItemsController():SwitchToPage(pageIndex, withAnimation)
    end
end

---主界面背包按钮点击事件,以打开藏品背包
---@private
function UICollectionPanel:OnMainChatPanelBagBtnClicked()
    uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Collection)
end
--endregion

--region 帮助按钮
---帮助按钮点击事件
---@private
function UICollectionPanel:OnHelpBtnClicked()
    ---显示帮助按钮窗口
    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(189)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, desInfo)
    end
end
--endregion

--region 特效播放
function UICollectionPanel:TriggleLevelUpEffect()
    if self.mLevelCache == nil then
        self.mLevelCache = self:GetCollectionInfo():GetCabinetLevel()
        return
    end
    local currentLevel = self:GetCollectionInfo():GetCabinetLevel()
    if self.mLevelCache < currentLevel then
        self.mLevelCache = currentLevel
        self:GetLevelUpEffect():SetActive(false)
        self:GetLevelUpEffect():SetActive(true)
    end
end
--endregion

--region 逐帧刷新
function update()
    local time = CS.UnityEngine.Time.time
    UICollectionPanel:OnUpdate(time)
end

function UICollectionPanel:OnUpdate(time)
    if self:GetCollectionItemsController() and self:CollectionIsOpen() == true then
        self:GetCollectionItemsController():OnUpdate(time)
    end
end
--endregion

--region 收藏物品格子
---@return UICollectionItemsController
function UICollectionPanel:GetCollectionItemsController()
    if self.mCollectionItemsController == nil then
        local go = self:GetCollectionList_GameObject()
        self.mCollectionItemsController = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionItemsController, self, self:GetCollectionInfo())
    end
    return self.mCollectionItemsController
end
--endregion

--region 刷新UI
---刷新UI
---@public
function UICollectionPanel:RefreshUI()
    self:GetCollectionItemsController():RefreshUI()
end
--endregion

--region 藏品开启状态
---藏品是否开启
---@return boolean
function UICollectionPanel:CollectionIsOpen()
    local isOpen = LuaGlobalTableDeal:MainPlayerIsOpenCollection()
    return isOpen
end

---藏品开启状态界面切换
function UICollectionPanel:CollectionOpenStatePanelChange()
    local isOpen,popoStr,spriteName,spriteNameDes = LuaGlobalTableDeal:MainPlayerIsOpenCollection()
    luaclass.UIRefresh:RefreshActive(self:GetCollectionList_GameObject(),isOpen)
    luaclass.UIRefresh:RefreshActive(self:GetLevelLimit_UILabel(),not isOpen)
    luaclass.UIRefresh:RefreshActive(self:GetLeftMainSwitchBtnGo(), isOpen)
    luaclass.UIRefresh:RefreshLabel(self:GetLevelLimit_UILabel(),spriteNameDes)
    luaclass.UIRefresh:RefreshSprite(self:GetLevelLimit_UISprite(),spriteName)
end
--endregion

function ondestroy()
    ---@type UIBagPanel
    local bagPanel = uimanager:GetPanel("UIBagPanel")
    if bagPanel ~= nil and (bagPanel:GetBagType() == LuaEnumBagType.Collection or bagPanel:GetBagType() == LuaEnumBagType.CollectionRecycle) then
        uimanager:ClosePanel("UIBagPanel")
    end
end

return UICollectionPanel