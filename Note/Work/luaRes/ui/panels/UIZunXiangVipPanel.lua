---@class UIZunXiangVipPanel:UIBase Vip尊享界面
local UIZunXiangVipPanel = {}

--region 数据
---@return table<UnityEngine.GameObject,UIItem>
function UIZunXiangVipPanel:GetItemTemplateList()
    if self.mItemTemplateList == nil then
        self.ItemTemplateList = {}
    end
    return self.ItemTemplateList
end
--endregion

--region 初始化
function UIZunXiangVipPanel:Init()
    self:InitComponent()
end

function UIZunXiangVipPanel:InitComponent()
    ---@type PictureLoader
    self.roleHead_PictureLoader = self:GetCurComp("WidgetRoot/view/MainView/Crystal/picture","PictureLoader")
    ---@type PictureLoader
    self.QRCode_PictureLoader = self:GetCurComp("WidgetRoot/view/MainView/Crystal/code","PictureLoader")
    ---@type UISprite
    self.title_UISprite = self:GetCurComp("WidgetRoot/view/MainView/Crystal/title","UISprite")
    ---@type UILabel
    self.Describe_UILabel = self:GetCurComp("WidgetRoot/view/MainView/Crystal/content","UILabel")
    ---@type UIGridContainer
    self.itemList_UIGridContainer = self:GetCurComp("WidgetRoot/view/MainView/Crystal/dropScroll/DropItem","UIGridContainer")
    ---@type UILabel
    self.hintText_UILabel = self:GetCurComp("WidgetRoot/view/MainView/Crystal/tips","UILabel")
end
--endregion

--region 刷新
function UIZunXiangVipPanel:Show()
    if self:AnalysisParams() == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshPanel()
end

---解析参数
---@return boolean
function UIZunXiangVipPanel:AnalysisParams()
    local zunXiangInfo = clientTableManager.cfg_vip_zunxiangManager:GetPlatformVipZunXiangInfo()
    if clientTableManager.cfg_vip_zunxiangManager:CanShowPlatformVipZunXiangPanel() == false then
        return false
    end
    self.zunXiangInfo = zunXiangInfo
    self.zunxiangRewardList = clientTableManager.cfg_vip_zunxiangManager:GetItemInfoList()
    return true
end

---刷新面板
function UIZunXiangVipPanel:RefreshPanel()
    luaclass.UIRefresh:RefreshWWWTexture(self.roleHead_PictureLoader,self.zunXiangInfo:GetPicture(),true)
    luaclass.UIRefresh:RefreshWWWTexture(self.QRCode_PictureLoader,self.zunXiangInfo:GetCode(),true)
    luaclass.UIRefresh:RefreshSprite(self.title_UISprite,self.zunXiangInfo:GetTitle(),nil,true)
    local content = string.gsub(self.zunXiangInfo:GetContent(), '\\n', '\n')
    luaclass.UIRefresh:RefreshLabel(self.Describe_UILabel,content)
    local hintText = string.gsub(self.zunXiangInfo:GetTips(), '\\n', '\n')
    luaclass.UIRefresh:RefreshLabel(self.hintText_UILabel,hintText)
    luaclass.UIRefresh:RefreshGridContainer(self.itemList_UIGridContainer,self.zunxiangRewardList,function(go,rewardInfo)
        local itemTemplate = self:GetItemTemplateList()[go]
        if itemTemplate == nil then
            itemTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
            self:GetItemTemplateList()[go] = itemTemplate
        end
        ---@type rewardInfo
        local curRewardInfo = rewardInfo
        itemTemplate:RefreshUIWithItemInfo(curRewardInfo.CSItemInfo,curRewardInfo.num)
        luaclass.UIRefresh:BindClickCallBack(itemTemplate.go,function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = curRewardInfo.CSItemInfo, showRight = false })
        end)
    end)
end
--endregion


return UIZunXiangVipPanel