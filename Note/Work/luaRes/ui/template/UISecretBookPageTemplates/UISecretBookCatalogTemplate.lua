local UISecretBookCatalogTemplate = {}

--region 局部变量

--endregion

--region 组件
function UISecretBookCatalogTemplate:GetQuestion_UILabel()
    if (self.mQuestionTitle == nil) then
        self.mQuestionTitle = self:Get("Par/GameObject/Title", "UILabel")
    end
    return self.mQuestionTitle
end

function UISecretBookCatalogTemplate:GetShowBtn_GameObject()
    if (self.mShowBtn == nil) then
        self.mShowBtn = self:Get("Par/GameObject/ShowBtn", "GameObject")
    end
    return self.mShowBtn
end

function UISecretBookCatalogTemplate:GetShowBtn_UISprite()
    if (self.mShowBtnUISprite == nil) then
        self.mShowBtnUISprite = self:Get("Par/GameObject/ShowBtn", "UISprite")
    end
    return self.mShowBtnUISprite
end

function UISecretBookCatalogTemplate:GetquesAndansGridContainer()
    if (self.mquesAndansGridContainer == nil) then
        self.mquesAndansGridContainer = self:Get("Par/Jump", "Top_UIGridContainer")
    end
    return self.mquesAndansGridContainer
end

function UISecretBookCatalogTemplate:GetquesAndansUITable()
    if (self.mquesAndansUITable == nil) then
        self.mquesAndansUITable = self:Get("", "UITable")
    end
    return self.mquesAndansUITable
end

function UISecretBookCatalogTemplate:GetSecretPageSubTypeDic()
    return CS.Cfg_SecretBookTableManager.Instance.SecretPageSubTypeDic
end

function UISecretBookCatalogTemplate:GetSecretSubTypeDic()
    return CS.Cfg_SecretBookTableManager.Instance.SecretSubTypeDic
end
--endregion

--region 初始化
function UISecretBookCatalogTemplate:Init(panel)
    self.panel = panel
    --self.index = 0
    self.resetShowBtn = nil
    self:BindUIEvents()
end

function UISecretBookCatalogTemplate:Show()

end
--endregion

--region 客户端事件
function UISecretBookCatalogTemplate:BindUIEvents()
    CS.UIEventListener.Get(self:GetShowBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetShowBtn_GameObject()).OnClickLuaDelegate = self.mShowBtnOnClick
end
--endregion

--region 刷新界面
function UISecretBookCatalogTemplate:RefreshUIPanel(info)
    if (info ~= nil) then
        self:GetQuestion_UILabel().text = info.typeName
    end
end

function UISecretBookCatalogTemplate:SetResetShowBtn(event)
    self.resetShowBtn = event
end

function UISecretBookCatalogTemplate:mShowBtnOnClick()
    if (self.panel:GetCatalogGridContainer_SpringPanel() ~= nil and self.panel:GetCatalogGridContainer_SpringPanel().enabled) then
        return
    end
    if (self:GetquesAndansGridContainer().MaxCount ~= 0) then
        self:GetquesAndansGridContainer().MaxCount = 0
        self:GetShowBtn_UISprite().flip = CS.UIBasicSprite.Flip.Nothing
        uiStaticParameter.SecretBookPageIndex = nil
    else
        local isFind, Info = UISecretBookCatalogTemplate:GetSecretSubTypeDic():TryGetValue(self:GetQuestion_UILabel().text)
        if (isFind) then
            if (self.resetShowBtn ~= nil) then
                self:resetShowBtn()
            end
            self:GetShowBtn_UISprite().flip = CS.UIBasicSprite.Flip.Vertically
            self:GetquesAndansGridContainer().MaxCount = Info.Count
            for i = 1, Info.Count do
                local go = self:GetquesAndansGridContainer().controlList[i - 1].gameObject
                ---@param tableData TABLE.CFG_SECRET_BOOK
                local info = Info[i - 1]
                CS.Utility_Lua.GetComponent(go.transform:Find("question"), "UILabel").text = info.subTypeName .. "  ·······························"
                local tran = go.transform:Find("pageJumpBtn")
                CS.UIEventListener.Get(CS.Utility_Lua.GetComponent(tran, "GameObject")).LuaEventTable = self
                CS.UIEventListener.Get(CS.Utility_Lua.GetComponent(tran, "GameObject")).OnClickLuaDelegate = function()
                    self.panel.JumpContentRefresh(info.pageNumber)
                end
            end
            uiStaticParameter.SecretBookPageTemplate = self
        end
    end
    self:GetquesAndansUITable().IsDealy = true
    self:GetquesAndansUITable():Reposition()
    self.panel:GetCatalogGridContainer_UITable().IsDealy = true
    self.panel:GetCatalogGridContainer_UITable():Reposition()
end

--endregion
function ondestroy()

end

return UISecretBookCatalogTemplate