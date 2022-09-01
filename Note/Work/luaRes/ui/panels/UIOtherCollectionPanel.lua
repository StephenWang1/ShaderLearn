---其他玩家的藏品数据
---@class UIOtherCollectionPanel:UIBase
local UIOtherCollectionPanel = {}

---帮助按钮
---@return UnityEngine.GameObject
function UIOtherCollectionPanel:GetHelpBtnGo()
    if self.mHelpBtnGo == nil then
        self.mHelpBtnGo = self:GetCurComp("WidgetRoot/left/helpBtn", "GameObject")
    end
    return self.mHelpBtnGo
end

---图集字典根节点
---@return UnityEngine.GameObject
function UIOtherCollectionPanel:GetAtlasDicGo()
    if self.mAtlasDicGo == nil then
        self.mAtlasDicGo = self:GetCurComp("StaticRoot/atlasDic", "GameObject")
    end
    return self.mAtlasDicGo
end

---获取图集
---@param atlasName string
---@return UIAtlas
function UIOtherCollectionPanel:GetUIAtlas(atlasName)
    if self.mAtlasDic == nil then
        return nil
    end
    return self.mAtlasDic[atlasName]
end

function UIOtherCollectionPanel:GetCollectionInfo()
    return self.mCollectionInfo
end

---@return UICollectionItemsController
function UIOtherCollectionPanel:GetCollectionItemsController()
    if self.mCollectionItemsController == nil then
        local go = self:GetCurComp("WidgetRoot/left/items", "GameObject")
        self.mCollectionItemsController = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionItemsController_OtherPlayer, self, self:GetCollectionInfo())
    end
    return self.mCollectionItemsController
end

function UIOtherCollectionPanel:GetCloseButtonGo()
    if self.mCloseButtonGo == nil then
        self.mCloseButtonGo = self:GetCurComp("WidgetRoot/window/window/left_main/events/btn_close", "GameObject")
    end
    return self.mCloseButtonGo
end

function UIOtherCollectionPanel:Init()
    self:InitializeAtlasDic()
    CS.UIEventListener.Get(self:GetCloseButtonGo()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetHelpBtnGo()).onClick = function()
        self:OnHelpBtnClicked()
    end
end

---初始化图集字典
---@private
function UIOtherCollectionPanel:InitializeAtlasDic()
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

function UIOtherCollectionPanel:Show()
    self.mCollectionInfo = gameMgr:GetOtherPlayerDataMgr():GetCollectionInfo()
    if self.mCollectionInfo == nil then
        self:ClosePanel()
        return
    end
    self:RefreshUI()
end

function update()
    local time = CS.UnityEngine.Time.time
    UIOtherCollectionPanel:OnUpdate(time)
end

function UIOtherCollectionPanel:OnUpdate(time)
    if self:GetCollectionItemsController() then
        self:GetCollectionItemsController():OnUpdate(time)
    end
end

---帮助按钮点击事件
---@private
function UIOtherCollectionPanel:OnHelpBtnClicked()
    ---显示帮助按钮窗口
    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(189)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, desInfo)
    end
end

---切换到页
---@param pageIndex number 切换到的目标页
---@param withAnimation boolean|nil 是否平滑动画过渡过去
function UIOtherCollectionPanel:SwitchToPage(pageIndex, withAnimation)
    if self:GetCollectionItemsController() ~= nil then
        self:GetCollectionItemsController():SwitchToPage(pageIndex, withAnimation)
    end
end

---刷新UI
---@public
function UIOtherCollectionPanel:RefreshUI()
    self:GetCollectionItemsController():RefreshUI()
end

return UIOtherCollectionPanel