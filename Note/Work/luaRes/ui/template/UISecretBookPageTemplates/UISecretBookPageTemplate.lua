local UISecretBookpageTemplate = {}

--region 组件
function UISecretBookpageTemplate:GetTitleFirstColor()
    if (self.mTitleFirstColor == nil) then
        self.mTitleFirstColor = CS.UnityEngine.Color(79 / 255, 54 / 255, 42 / 255, 1)
    end
    return self.mTitleFirstColor
end

function UISecretBookpageTemplate:GetTitleSecondColor()
    if (self.mTitleSecondColor == nil) then
        self.mTitleSecondColor = CS.UnityEngine.Color(75 / 255, 58 / 255, 34 / 255, 1)
    end
    return self.mTitleSecondColor
end

function UISecretBookpageTemplate:GetTitleNormalColor()
    if (self.mTitleNormalColor == nil) then
        self.mTitleNormalColor = CS.UnityEngine.Color(133 / 255, 106 / 255, 77 / 255, 1)
    end
    return self.mTitleNormalColor
end

function UISecretBookpageTemplate:GetTitleMiddlePos()
    if (self.mTitleMiddlePos == nil) then
        self.mTitleMiddlePos = CS.UnityEngine.Vector3(-312, 237, 0)
    end
    return self.mTitleMiddlePos
end

function UISecretBookpageTemplate:GetTitleNormalPos()
    if (self.mTitleNormalPos == nil) then
        self.mTitleNormalPos = CS.UnityEngine.Vector3(-464, 237, 0)
    end
    return self.mTitleNormalPos
end

function UISecretBookpageTemplate:GetLeftTitleNormalPos()
    if (self.mTitleNormalPos == nil) then
        self.mTitleNormalPos = CS.UnityEngine.Vector3(-440, 237, 0)
    end
    return self.mTitleNormalPos
end

function UISecretBookpageTemplate:GetFirstPageContentPos()
    if (self.mFirstPageContentPos == nil) then
        self.mFirstPageContentPos = CS.UnityEngine.Vector3(15, -4, 0)
    end
    return self.mFirstPageContentPos
end

function UISecretBookpageTemplate:GetNormalPageContentPos()
    if (self.mNormalPageContentPos == nil) then
        self.mNormalPageContentPos = CS.UnityEngine.Vector3(0, -4, 0)
    end
    return self.mNormalPageContentPos
end

function UISecretBookpageTemplate:GetGridContainer_GridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("introduce/GridContainer", "UIGridContainer")
    end
    return self.mGridContainer
end

function UISecretBookpageTemplate:GetGridUITable_UITable()
    if (self.mGridUITable == nil) then
        self.mGridUITable = self:Get("introduce/GridContainer", "UITable")
    end
    return self.mGridUITable
end

function UISecretBookpageTemplate:GetCatalogGridContainer_GridContainer()
    if (self.mCatalogGridContainer == nil) then
        self.mCatalogGridContainer = self:Get("introduce/ScollView/CatalogGridContainer", "UIGridContainer")
    end
    return self.mCatalogGridContainer
end

function UISecretBookpageTemplate:GetCatalogGridContainer_UITable()
    if (self.mCatalogUITable == nil) then
        self.mCatalogUITable = self:Get("introduce/ScollView/CatalogGridContainer", "UITable")
    end
    return self.mCatalogUITable
end

function UISecretBookpageTemplate:GetSecretBookDic()
    if (self.mSecretBookDic == nil) then
        self.mSecretBookDic = CS.Cfg_SecretBookTableManager.Instance.SecretBookDic
    end
    return self.mSecretBookDic
end

function UISecretBookpageTemplate:GetSecretPageSubTypeDic()
    if (self.mSecretPageSubTypeDic == nil) then
        self.mSecretPageSubTypeDic = CS.Cfg_SecretBookTableManager.Instance.SecretPageSubTypeDic
    end
    return self.mSecretPageSubTypeDic
end

function UISecretBookpageTemplate:GetSecretBookFirtstTypeList()
    if (self.mSecretBookFirtstTypeDic == nil) then
        self.mSecretBookFirtstTypeDic = CS.Cfg_SecretBookTableManager.Instance.SecretBookPageList
    end
    return self.mSecretBookFirtstTypeDic
end

--endregion

--region 初始化
function UISecretBookpageTemplate:Init(panel)
    self.panel = panel
    self.SecretBookContentTemplates = {}
    self.SecretBookPageContentTemplates = {}
    self:InitComponents()
end

function UISecretBookpageTemplate:InitComponents()
    self.Title = self:Get("window/title", "UILabel")
    self.page_UILabel = self:Get("window/page", "UILabel")
    self.cutline = self:Get("window/cutline", "GameObject")
    self.pageNums = 1
    self.jumppageNums = 0
end

function UISecretBookpageTemplate:BindUIEvents()

end
--endregion

--region 客户端事件
function UISecretBookpageTemplate:JumpBtnOnClickEvent()

end
--endregion

--region 刷新界面
function UISecretBookpageTemplate:RefreshUIPanel(ani)
    self.page_UILabel.text = self.pageNums
    self.Title.text = self:GetTitleContent(self.pageNums)
    if (ani) then
        self:RefreshSecretBookContent()
    end
end

function UISecretBookpageTemplate:GetTitleContent(page)
    local isfind, info = self:GetSecretBookDic():TryGetValue(page)
    if (isfind) then
        if (not CS.System.String.IsNullOrEmpty(info[0].subTypeName)) then
            return tostring(info[0].typeName) .. " - " .. tostring(info[0].subTypeName)
        end
        return info[0].typeName
    end
    return "目录"
end

function UISecretBookpageTemplate:RefreshSecretBookContent()
    local isfind, info = self:GetSecretBookDic():TryGetValue(self.pageNums)
    if (isfind) then
        self.Title.fontSize = 18
        self.Title.color = self:GetTitleNormalColor()
        self:GetGridContainer_GridContainer().MaxCount = info.Count

        for i = 1, info.Count do
            local go = self:GetGridContainer_GridContainer().controlList[i - 1].gameObject
            if (self.SecretBookContentTemplates[go] == nil) then
                self.SecretBookContentTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISecretBookContentTemplate)
            end
            self.SecretBookContentTemplates[go].pageNums = self.pageNums
            self.SecretBookContentTemplates[go]:RefreshUIPanel(info[i - 1])
        end
        self:GetGridUITable_UITable().IsDealy = true
        self:GetGridUITable_UITable():Reposition()
        if (self.SetFirstPageCor == nil) then
            self.SetFirstPageCor = StartCoroutine(self.IEnumSetFirstPagePos, self)
        else
            StopCoroutine(self.SetFirstPageCor)
            self.SetFirstPageCor = StartCoroutine(self.IEnumSetFirstPagePos, self)
        end
        return
    else
        self:GetGridContainer_GridContainer().MaxCount = 0
        self:GetGridUITable_UITable().IsDealy = true
        self:GetGridUITable_UITable():Reposition()
    end

    if (self.pageNums == 1) then
        self.Title.fontSize = 18
        self.Title.color = self:GetTitleFirstColor()
        if (self:GetCatalogGridContainer_GridContainer().MaxCount == 0) then
            self:GetCatalogGridContainer_GridContainer().MaxCount = self:GetSecretBookFirtstTypeList().Count - 1
            for i = 1, self:GetSecretBookFirtstTypeList().Count - 1 do
                local go = self:GetCatalogGridContainer_GridContainer().controlList[i - 1].gameObject
                if (self.SecretBookPageContentTemplates[go] == nil) then
                    self.SecretBookPageContentTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISecretBookCatalogTemplate, self.panel)
                end
                self.SecretBookPageContentTemplates[go]:RefreshUIPanel(self:GetSecretBookFirtstTypeList()[i])
                self.SecretBookPageContentTemplates[go]:SetResetShowBtn(self.ResetCatalogBtn)
                go.name = tostring(i)
            end

            if (uiStaticParameter.SecretBookPageTemplate ~= nil) then
                uiStaticParameter.SecretBookPageIndex:mShowBtnOnClick()
            else
                if (self:GetCatalogGridContainer_GridContainer().controlList.Count >= 1) then
                    local go = self:GetCatalogGridContainer_GridContainer().controlList[0].gameObject
                    self.SecretBookPageContentTemplates[go]:mShowBtnOnClick()
                end
            end
            self:GetCatalogGridContainer_UITable().IsDealy = true
            self:GetCatalogGridContainer_UITable():Reposition()
        end
    end
end

function UISecretBookpageTemplate:ResetCatalogBtn()
    if (uiStaticParameter.SecretBookPageTemplate ~= nil) then
        uiStaticParameter.SecretBookPageTemplate:GetShowBtn_UISprite().flip = CS.UIBasicSprite.Flip.Nothing
        uiStaticParameter.SecretBookPageTemplate:GetquesAndansGridContainer().MaxCount = 0
    end
end

function UISecretBookpageTemplate:IEnumSetFirstPagePos()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.001));
    if (self.pageNums == 2 and self:GetGridContainer_GridContainer().controlList.Count >= 1) then
        self.Title.fontSize = 22
        self.Title.color = self:GetTitleSecondColor()
        self:GetGridContainer_GridContainer().controlList[0].gameObject.transform.localPosition = self:GetFirstPageContentPos()
        self.Title.transform.localPosition = self:GetTitleMiddlePos()
    else
        self:GetGridContainer_GridContainer().controlList[0].gameObject.transform.localPosition = self:GetNormalPageContentPos()
        local num1, num2 = math.modf(self.pageNums / 2)
        if (num2 == 0) then
            self.Title.transform.localPosition = self:GetTitleNormalPos()
        else
            self.Title.transform.localPosition = self:GetLeftTitleNormalPos()
        end
    end
    for k, v in pairs(self.SecretBookContentTemplates) do
        v:GetQuesRoot_UITable():Reposition()
    end
    StopCoroutine(self.SetFirstPageCor)
    self.SetFirstPageCor = nil
end
--endregion
function UISecretBookpageTemplate:OnDestroy()
    StopCoroutine(self.SetFirstPageCor)
    self.SetFirstPageCor = nil
end

return UISecretBookpageTemplate