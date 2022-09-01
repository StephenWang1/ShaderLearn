local UISecretBookPanel = {}

--region 局部变量
UISecretBookPanel.LeftPageTem = {}
UISecretBookPanel.RightPageTem = {}
UISecretBookPanel.SecretBookPageGOTable = {}
UISecretBookPanel.LeftPagePosX = 0
UISecretBookPanel.RightPagePosX = 930
UISecretBookPanel.LastPagePos = -1
UISecretBookPanel.CurPageIndex = 0
--endregion

UISecretBookPanel.IsNeedActiveDuringInitialize = true

--region 组件
function UISecretBookPanel.GetCloseBtn_GameObject()
    if (UISecretBookPanel.mCloseBtn == nil) then
        UISecretBookPanel.mCloseBtn = UISecretBookPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UISecretBookPanel.mCloseBtn
end

function UISecretBookPanel.GetLeftJumpBtn_GameObject()
    if (UISecretBookPanel.mLeftJumpBtnGo == nil) then
        UISecretBookPanel.mLeftJumpBtnGo = UISecretBookPanel:GetCurComp("WidgetRoot/Left/window/JumpBtn", "GameObject")
    end
    return UISecretBookPanel.mLeftJumpBtnGo
end

function UISecretBookPanel.GetRightJumpBtn_GameObject()
    if (UISecretBookPanel.mRightJumpBtnGo == nil) then
        UISecretBookPanel.mRightJumpBtnGo = UISecretBookPanel:GetCurComp("WidgetRoot/Right/window/JumpBtn", "GameObject")
    end
    return UISecretBookPanel.mRightJumpBtnGo
end

function UISecretBookPanel.GetLeftRoot_GameObject()
    if (UISecretBookPanel.mLeftRoot == nil) then
        UISecretBookPanel.mLeftRoot = UISecretBookPanel:GetCurComp("WidgetRoot/Left", "GameObject")
    end
    return UISecretBookPanel.mLeftRoot
end

function UISecretBookPanel.GetRightRoot_GameObject()
    if (UISecretBookPanel.mRightRoot == nil) then
        UISecretBookPanel.mRightRoot = UISecretBookPanel:GetCurComp("WidgetRoot/Right", "GameObject")
    end
    return UISecretBookPanel.mRightRoot
end

---@type UIGridContainer
function UISecretBookPanel.GetPageGridContainer_GridContainer()
    if (UISecretBookPanel.mPageGridContainer == nil) then
        UISecretBookPanel.mPageGridContainer = UISecretBookPanel:GetCurComp("WidgetRoot/PageToggleArea/PageGridContainer", "UIGridContainer")
    end
    return UISecretBookPanel.mPageGridContainer
end

function UISecretBookPanel.GetSecretPageContentList()
    if (UISecretBookPanel.mSecretBookFirtstTypeDic == nil) then
        UISecretBookPanel.mSecretBookFirtstTypeDic = CS.Cfg_SecretBookTableManager.Instance.SecretBookPageList
    end
    return UISecretBookPanel.mSecretBookFirtstTypeDic
end

function UISecretBookPanel:GetLeftCatalogGo_Go()
    if (self.mCatalogUITableLeftGo == nil) then
        self.mCatalogUITableLeftGo = self:GetCurComp("WidgetRoot/Left/introduce", "GameObject")
    end
    return self.mCatalogUITableLeftGo
end

function UISecretBookPanel:GetRightCatalogGo_Go()
    if (self.mCatalogUITableRightGo == nil) then
        self.mCatalogUITableRightGo = self:GetCurComp("WidgetRoot/Right/introduce", "GameObject")
    end
    return self.mCatalogUITableRightGo
end

function UISecretBookPanel:GetCatalogGridContainer_SpringPanel()
    if (self.mCatalogSpringPanel == nil) then
        self.mCatalogSpringPanel = self:GetCurComp("WidgetRoot/Left/introduce/ScollView", "SpringPanel")
    end
    return self.mCatalogSpringPanel
end

function UISecretBookPanel:GetCatalogGridContainer_UITable()
    if (self.mCatalogUITable == nil) then
        self.mCatalogUITable = self:GetCurComp("WidgetRoot/Left/introduce/ScollView/CatalogGridContainer", "UITable")
    end
    return self.mCatalogUITable
end

function UISecretBookPanel:GetLeftTurnPageEffect_UIEffectLoad()
    if (self.mLeftPageUIEffectLoad == nil) then
        self.mLeftPageUIEffectLoad = self:GetCurComp("WidgetRoot/Left/window/BG", "CSUIEffectLoad")
    end
    return self.mLeftPageUIEffectLoad
end

function UISecretBookPanel:GetLeftTurnPageEffect_Sprite()
    if (self.mLeftPageEffectSprite == nil) then
        self.mLeftPageEffectSprite = self:GetCurComp("WidgetRoot/Left/window/BG", "Top_UISprite")
    end
    return self.mLeftPageEffectSprite
end

function UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation()
    if (self.mLeftPageEffect == nil) then
        self.mLeftPageEffect = self:GetCurComp("WidgetRoot/Left/window/BG", "Top_UISpriteAnimation")
    end
    return self.mLeftPageEffect
end

function UISecretBookPanel:GetRightTurnPageEffect_UIEffectLoad()
    if (self.mRightPageUIEffectLoad == nil) then
        self.mRightPageUIEffectLoad = self:GetCurComp("WidgetRoot/Right/window/BG", "CSUIEffectLoad")
    end
    return self.mRightPageUIEffectLoad
end

function UISecretBookPanel:GetRightTurnPageEffect_Sprite()
    if (self.mRightPageEffectSprite == nil) then
        self.mRightPageEffectSprite = self:GetCurComp("WidgetRoot/Right/window/BG", "Top_UISprite")
    end
    return self.mRightPageEffectSprite
end

function UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation()
    if (self.mRightPageEffect == nil) then
        self.mRightPageEffect = self:GetCurComp("WidgetRoot/Right/window/BG", "Top_UISpriteAnimation")
    end
    return self.mRightPageEffect
end
--endregion

--region 初始化
function UISecretBookPanel:Init()
    UISecretBookPanel:BindMessage()
    UISecretBookPanel:BindUIEvents()
    UISecretBookPanel:InitPanel()
    UISecretBookPanel:InitData()
end

function update()
    --if (self:GetCatalogGridContainer_SpringPanel() ~= nil) then
    --    print(self:GetCatalogGridContainer_SpringPanel().enable)
    --end
end

function UISecretBookPanel:Show(keyword)

    if (not CS.System.String.IsNullOrEmpty(keyword)) then
        if (UISecretBookPanel.LeftPageTem ~= nil) then
            UISecretBookPanel.LeftPageTem.pageNums = CS.Cfg_SecretBookTableManager.Instance:GetPageByKeyWord(keyword)
        end
    end
    UISecretBookPanel.JumpContentRefresh(UISecretBookPanel.LeftPageTem.pageNums)
end

function UISecretBookPanel:BindMessage()

end

function UISecretBookPanel:BindUIEvents()
    CS.UIEventListener.Get(UISecretBookPanel.GetCloseBtn_GameObject()).onClick = UISecretBookPanel.mCloseBtnOnClick
    CS.UIEventListener.Get(UISecretBookPanel.GetLeftJumpBtn_GameObject()).onClick = UISecretBookPanel.mLeftJumpBtnOnClick
    CS.UIEventListener.Get(UISecretBookPanel.GetRightJumpBtn_GameObject()).onClick = UISecretBookPanel.mRightJumpBtnOnClick
end

function UISecretBookPanel:InitData()
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        UISecretBookPanel.LeftPageTem.pageNums = 1
    end
    if (UISecretBookPanel.RightPageTem ~= nil) then
        UISecretBookPanel.RightPageTem.pageNums = 2
    end
    UISecretBookPanel:InitPage()
end

function UISecretBookPanel:InitPanel()
    UISecretBookPanel.LeftPageTem = templatemanager.GetNewTemplate(UISecretBookPanel.GetLeftRoot_GameObject(), luaComponentTemplates.UISecretBookPageTemplate, UISecretBookPanel)
    UISecretBookPanel.RightPageTem = templatemanager.GetNewTemplate(UISecretBookPanel.GetRightRoot_GameObject(), luaComponentTemplates.UISecretBookPageTemplate, UISecretBookPanel)
    UISecretBookPanel.SetLoadCallBack()
end
--endregion

--region 客户端事件
function UISecretBookPanel.SetLoadCallBack()
    UISecretBookPanel:GetLeftTurnPageEffect_UIEffectLoad().onLoadFinish = function()
        UISecretBookPanel:GetLeftTurnPageEffect_Sprite().gameObject:SetActive(false)
        UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation().ReversePlay = true
    end
    UISecretBookPanel:GetRightTurnPageEffect_UIEffectLoad().onLoadFinish = function()
        UISecretBookPanel:GetRightTurnPageEffect_Sprite().gameObject:SetActive(false)
    end
end

function UISecretBookPanel.mCloseBtnOnClick()
    uimanager:ClosePanel("UISecretBookPanel")
end

function UISecretBookPanel.mLeftJumpBtnOnClick()
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        if (UISecretBookPanel.LeftPageTem.pageNums == 1) then
            return
        end
        UISecretBookPanel.LeftPageTem.pageNums = UISecretBookPanel.LeftPageTem.pageNums - 2
    end
    if (UISecretBookPanel.RightPageTem ~= nil) then
        UISecretBookPanel.RightPageTem.pageNums = UISecretBookPanel.RightPageTem.pageNums - 2
    end
    UISecretBookPanel:RefreshUIPanel(false)
    UISecretBookPanel.HideContnet()

    UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation():ResetToEnding()
    UISecretBookPanel:GetLeftTurnPageEffect_Sprite().spriteName = "turnpage11"
    UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation().gameObject:SetActive(true)
    UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation():Play()
    UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation().OnFinish = function()
        UISecretBookPanel:GetLeftTurnPageEffect_SpriteAnimation().gameObject:SetActive(false)
        UISecretBookPanel.ReShowContent()
    end
end

function UISecretBookPanel.mRightJumpBtnOnClick()
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        if (UISecretBookPanel.LeftPageTem.pageNums + 2 > CS.Cfg_SecretBookTableManager.Instance.SecretBookDic.Count + 1) then
            return
        end
        UISecretBookPanel.LeftPageTem.pageNums = UISecretBookPanel.LeftPageTem.pageNums + 2
    end
    if (UISecretBookPanel.RightPageTem ~= nil) then
        UISecretBookPanel.RightPageTem.pageNums = UISecretBookPanel.RightPageTem.pageNums + 2
    end
    UISecretBookPanel:RefreshUIPanel(false)
    UISecretBookPanel.HideContnet()

    UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation().gameObject:SetActive(true)
    UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation().OnFinish = function()
        UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation().gameObject:SetActive(false)
        UISecretBookPanel.ReShowContent()
    end
    UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation():ResetToBeginning()
    UISecretBookPanel:GetRightTurnPageEffect_SpriteAnimation():Play()
end
--endregion
function UISecretBookPanel.HideContnet()
    UISecretBookPanel.LeftPageTem.Title.gameObject:SetActive(false)
    UISecretBookPanel.RightPageTem.Title.gameObject:SetActive(false)
    UISecretBookPanel.LeftPageTem.cutline.gameObject:SetActive(false)
    UISecretBookPanel.RightPageTem.cutline.gameObject:SetActive(false)
    UISecretBookPanel.LeftPageTem:GetGridContainer_GridContainer().gameObject:SetActive(false)
    UISecretBookPanel.RightPageTem:GetGridContainer_GridContainer().gameObject:SetActive(false)
    UISecretBookPanel.LeftPageTem:GetCatalogGridContainer_GridContainer().gameObject:SetActive(false)
end

function UISecretBookPanel.ReShowContent()
    UISecretBookPanel.LeftPageTem.Title.gameObject:SetActive(true)
    UISecretBookPanel.RightPageTem.Title.gameObject:SetActive(true)
    UISecretBookPanel.LeftPageTem.cutline.gameObject:SetActive(true)
    UISecretBookPanel.RightPageTem.cutline.gameObject:SetActive(true)
    if (UISecretBookPanel.LeftPageTem.pageNums == 1) then
        UISecretBookPanel.LeftPageTem:GetCatalogGridContainer_GridContainer().gameObject:SetActive(true)
    else
        UISecretBookPanel.LeftPageTem:GetGridContainer_GridContainer().gameObject:SetActive(true)
    end

    UISecretBookPanel.LeftPageTem:RefreshSecretBookContent()
    UISecretBookPanel.LeftPageTem:GetGridUITable_UITable().IsDealy = true
    UISecretBookPanel.LeftPageTem:GetGridUITable_UITable():Reposition()
    --UISecretBookPanel.LeftPageTem:GetCatalogGridContainer_UITable():Reposition()

    UISecretBookPanel.RightPageTem:GetGridContainer_GridContainer().gameObject:SetActive(true)
    UISecretBookPanel.RightPageTem:RefreshSecretBookContent()
    UISecretBookPanel.RightPageTem:GetGridUITable_UITable().IsDealy = true
    UISecretBookPanel.RightPageTem:GetGridUITable_UITable():Reposition()

end

--region 刷新UI
function UISecretBookPanel:RefreshUIPanel(ani)
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        if (UISecretBookPanel.LeftPageTem.pageNums == 1) then
            UISecretBookPanel.GetLeftJumpBtn_GameObject():SetActive(false)
        else
            UISecretBookPanel.GetLeftJumpBtn_GameObject():SetActive(true)
        end
        UISecretBookPanel.LeftPageTem:RefreshUIPanel(ani)
    end
    if (UISecretBookPanel.RightPageTem ~= nil) then
        if (UISecretBookPanel.RightPageTem.pageNums == CS.Cfg_SecretBookTableManager.Instance.SecretBookDic.Count + 1) then
            UISecretBookPanel.GetRightJumpBtn_GameObject():SetActive(false)
        else
            UISecretBookPanel.GetRightJumpBtn_GameObject():SetActive(true)
        end
        UISecretBookPanel.RightPageTem:RefreshUIPanel(ani)
    end
    UISecretBookPanel.RefreshPagePos()

end

function UISecretBookPanel:InitPage()
    local count = UISecretBookPanel.GetSecretPageContentList().Count
    UISecretBookPanel.GetPageGridContainer_GridContainer().MaxCount = count
    for i = 0, count - 1 do
        local num = i
        local go = UISecretBookPanel.GetPageGridContainer_GridContainer().controlList[i].gameObject
        CS.Utility_Lua.GetComponent(go.transform:Find('pagetoggle/backgroud/Label'), "UILabel").text = UISecretBookPanel.GetSecretPageContentList()[i].typeName
        CS.Utility_Lua.GetComponent(go.transform:Find('pagetoggle/checkMark/Label'), "UILabel").text = UISecretBookPanel.GetSecretPageContentList()[i].typeName
        CS.UIEventListener.Get(go).onClick = function(go)
            local info = UISecretBookPanel.GetSecretPageContentList()[num]
            if (num ~= UISecretBookPanel.CurPageIndex) then
                UISecretBookPanel.CurPageIndex = num
                UISecretBookPanel.JumpContentRefresh(info.PageNumber)
            end
        end
    end
    UISecretBookPanel.RefreshPagePos()
end

function UISecretBookPanel.RefreshPagePos()
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        local num = CS.Cfg_SecretBookTableManager.Instance:GetFirstTypeByPage(UISecretBookPanel.LeftPageTem.pageNums)
        if (UISecretBookPanel.LastPagePos == num) then
            return
        end
        UISecretBookPanel.LastPagePos = num
        if (num == 0) then
            local go = UISecretBookPanel.GetPageGridContainer_GridContainer().controlList[0]
            UISecretBookPanel.CurPageIndex = num
            local checksprite = CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/checkMark"), "UISprite")
            checksprite.flip = CS.UIBasicSprite.Flip.Horizontally
            checksprite.gameObject:SetActive(true)
            CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/backgroud"), "UISprite").flip = CS.UIBasicSprite.Flip.Horizontally
            go.transform.localPosition = CS.UnityEngine.Vector3(UISecretBookPanel.LeftPagePosX, go.transform.localPosition.y, 0)
            for i = 1, UISecretBookPanel.GetPageGridContainer_GridContainer().MaxCount - 1 do
                local go = UISecretBookPanel.GetPageGridContainer_GridContainer().controlList[i]
                local checksprite = CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/checkMark"), "UISprite")
                checksprite.flip = CS.UIBasicSprite.Flip.Nothing
                checksprite.gameObject:SetActive(false)
                CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/backgroud"), "UISprite").flip = CS.UIBasicSprite.Flip.Nothing
                go.transform.localPosition = CS.UnityEngine.Vector3(UISecretBookPanel.RightPagePosX, go.transform.localPosition.y, 0)
            end
            return
        end
        for i = 0, num do
            UISecretBookPanel.CurPageIndex = i
            local go = UISecretBookPanel.GetPageGridContainer_GridContainer().controlList[i]
            go.transform.localPosition = CS.UnityEngine.Vector3(UISecretBookPanel.LeftPagePosX, go.transform.localPosition.y, 0)
            local checksprite = CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/checkMark"), "UISprite")
            checksprite.flip = CS.UIBasicSprite.Flip.Horizontally
            if (i == num) then
                checksprite.gameObject:SetActive(true)
            else
                checksprite.gameObject:SetActive(false)
            end
            CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/backgroud"), "UISprite").flip = CS.UIBasicSprite.Flip.Horizontally
        end
        for i = num + 1, UISecretBookPanel.GetPageGridContainer_GridContainer().MaxCount - 1 do
            local go = UISecretBookPanel.GetPageGridContainer_GridContainer().controlList[i]
            go.transform.localPosition = CS.UnityEngine.Vector3(UISecretBookPanel.RightPagePosX, go.transform.localPosition.y, 0)
            local checksprite = CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/checkMark"), "UISprite")
            checksprite.flip = CS.UIBasicSprite.Flip.Nothing
            checksprite.gameObject:SetActive(false)
            CS.Utility_Lua.GetComponent(go.transform:Find("pagetoggle/backgroud"), "UISprite").flip = CS.UIBasicSprite.Flip.Nothing
        end
    end
end

function UISecretBookPanel.JumpContentRefresh(page)
    local catalogpage = 1
    local num1, num2 = math.modf(page / 2)
    if (num2 == 0) then
        catalogpage = page - 1
    else
        catalogpage = page
    end
    if (UISecretBookPanel.LeftPageTem ~= nil) then
        UISecretBookPanel.LeftPageTem.pageNums = catalogpage
    end
    if (UISecretBookPanel.RightPageTem ~= nil) then
        UISecretBookPanel.RightPageTem.pageNums = catalogpage + 1
    end
    UISecretBookPanel:RefreshUIPanel(true)
    UISecretBookPanel.HideContnet()
    UISecretBookPanel.ReShowContent()
end
--endregion

function ondestroy()
    uiStaticParameter.SecretBookPageTemplate = nil
    uiStaticParameter.SecretBookPageIndex = nil
end

return UISecretBookPanel