---登录公告界面
local UIAgreementPanel = {}

--region 组件
---关闭按钮
function UIAgreementPanel.GetCloseButton_GameObject()
    if UIAgreementPanel.mCloseButton == nil then
        UIAgreementPanel.mCloseButton = UIAgreementPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIAgreementPanel.mCloseButton
end

---确认按钮
function UIAgreementPanel.GetKnowButton_GameObject()
    if UIAgreementPanel.mKnowButton == nil then
        UIAgreementPanel.mKnowButton = UIAgreementPanel:GetCurComp("WidgetRoot/events/btn_know", "GameObject")
    end
    return UIAgreementPanel.mKnowButton
end

---确认按钮UILabel
function UIAgreementPanel.GetKnowButton_UILabel()
    if UIAgreementPanel.mKnowButtonUILabel == nil then
        UIAgreementPanel.mKnowButtonUILabel = UIAgreementPanel:GetCurComp("WidgetRoot/events/btn_know/Label", "UILabel")
    end
    return UIAgreementPanel.mKnowButtonUILabel
end

---ViewRoot
function UIAgreementPanel.GetViewRoot()
    if UIAgreementPanel.mviewRoot == nil then
        UIAgreementPanel.mviewRoot = UIAgreementPanel:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return UIAgreementPanel.mviewRoot
end

function UIAgreementPanel.GetContent()
    if UIAgreementPanel.mContent == nil then
        UIAgreementPanel.mContent = UIAgreementPanel:GetCurComp("WidgetRoot/view/scrollview/content", "UILabel")
    end
    return UIAgreementPanel.mContent
end

function UIAgreementPanel.GetTitle()
    if UIAgreementPanel.mTitle == nil then
        UIAgreementPanel.mTitle = UIAgreementPanel:GetCurComp("WidgetRoot/window/title", "UILabel")
    end
    return UIAgreementPanel.mTitle
end

--endregion
--region 初始化
function UIAgreementPanel:Init()
    UIAgreementPanel.BindEvents()
    UIAgreementPanel.LoadNotice()
end

function UIAgreementPanel.BindEvents()
    CS.UIEventListener.Get(UIAgreementPanel.GetCloseButton_GameObject()).onClick = UIAgreementPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIAgreementPanel.GetKnowButton_GameObject()).onClick = UIAgreementPanel.OnCloseButtonClicked
end

function UIAgreementPanel:Show()
    local filePath = ''
    local fileName = 'Agreement.txt'
    if (isUnityEditor) then
        filePath = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath)
    else
        filePath = CS.CSStaticAssist.persistentDataPath
    end
    filePath = filePath .. "/" .. CS.CSResource.GetModelTypePath(CS.ResourceType.Picture) .. fileName;
    self:ReadFile(filePath)
end

function UIAgreementPanel:ReadFile(fileName)
    local f = io.open(fileName, 'r')

    if (f == nil) then
        CS.OnlineDebug.LogError("文件不存在，位置：" .. tostring(fileName))
    else
        local content = f:read('*all')
        UIAgreementPanel.GetContent().text = content
        f:close()
    end
end
--endregion
--region UI事件
---点击关闭按钮
function UIAgreementPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIAgreementPanel")
end
--endregion
--region 加载公告
function UIAgreementPanel.LoadNotice()

    local gameName = "热血之光"
    local gameDesc = Utility.GetGameName()
    if gameDesc ~= nil and gameDesc ~= "" then
        if UIAgreementPanel.GetContent() ~= nil then
            local des = string.gsub(UIAgreementPanel.GetContent().text, gameName, gameDesc)
            UIAgreementPanel.GetContent().text = des
        end

        if UIAgreementPanel.GetTitle() ~= nil then
            local TitleDes = string.gsub(UIAgreementPanel.GetTitle().text, gameName, gameDesc)
            UIAgreementPanel.GetTitle().text = TitleDes
        end
    end

    -- local notice_Prefix = CS.SDKConfig.notice_Prefix
    -- local gameName = "rxzg"
    -- if CS.SDKManager.PlatformData:GetPlatformData() ~= nil then
    --     gameName = CS.SDKManager.PlatformData:GetPlatformData().gameName
    -- end
    -- if UIAgreementPanel.NoticeEffect == nil then
    --     CS.CSResourceManager.Singleton:AddQueueCannotDelete(notice_Prefix .. gameName, CS.ResourceType.UIEffect, function(res)
    --         if res and res.MirrorObj and UIAgreementPanel.GetViewRoot() ~= nil then
    --             if CS.StaticUtility.IsNull(self.DailyEffect) then
    --                 local poolItem = res:GetUIPoolItem()
    --                 UIAgreementPanel.NoticeEffect = poolItem.go
    --                 local effectparent = UIAgreementPanel.GetViewRoot().transform
    --                 UIAgreementPanel.NoticeEffect.transform.parent = effectparent
    --                 UIAgreementPanel.NoticeEffect.transform.localScale = CS.UnityEngine.Vector3.one
    --                 UIAgreementPanel.NoticeEffect.gameObject:SetActive(true)
    --                 UIAgreementPanel.SetLabel( UIAgreementPanel.NoticeEffect.gameObject)
    --             end
    --         end
    --     end
    --     , CS.ResourceAssistType.ForceLoad)
    -- end
end

function UIAgreementPanel.SetLabel(obj)
    local LabelList = obj:GetComponentsInChildren(typeof(CS.UILabel))

    if LabelList == nil or UIAgreementPanel.GetKnowButton_UILabel() == nil then
        return
    end
    for i = 0, LabelList.Length - 1 do
        LabelList[i].trueTypeFont = UIAgreementPanel.GetKnowButton_UILabel().trueTypeFont
    end
end

--endregion
return UIAgreementPanel