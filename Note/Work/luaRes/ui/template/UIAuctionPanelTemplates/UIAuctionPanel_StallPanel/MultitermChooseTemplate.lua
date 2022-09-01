---多项选择模板
---@class MultitermChooseTemplate
local MultitermChooseTemplate = {}
--region 初始化
function MultitermChooseTemplate:Init()
    self:InitComponment()
    self:BindEvent()
end

function MultitermChooseTemplate:InitComponment()
    self.StallTitle_GameObject = self:Get("StallTitle", "GameObject")
    self.StallTitle_Label = self:Get("StallTitle/text", "UILabel")
    self.StallInfo_UIGridContainer = self:Get("StallInfo/ScrollView/Grid", "UIGridContainer")
    self.StallInfo_TweenPosition = self:Get("StallInfo", "TweenPosition")
    self.StallInfo_TweenAlpha = self:Get("StallInfo", "TweenAlpha")
    self.StallInfo_MultitermChoose = self:Get("StallInfo/ScrollView/Grid", "Top_MultitermChoose")
    --  self.StallTitle_Arrow = self:Get("StallTitle/arrow", "TweenRotation")
end

function MultitermChooseTemplate:BindEvent()
    CS.UIEventListener.Get(self.StallTitle_GameObject).onClick = function(go)
        if self.openTween and self.StallInfo_TweenPosition ~= nil and self.StallInfo_TweenAlpha ~= nil then
            self.stallInfoState = ternary(self.stallInfoState == nil, false, self.stallInfoState)
            self.stallInfoState = not self.stallInfoState
            self:ControlStallInfoOpen(self.stallInfoState)
        end
    end
end
--endregion

--region 刷新
function MultitermChooseTemplate:RefreshContent(commondata)
    self:RefreshParams(commondata)
    self:RefreshTable()
    self:RefreshTieleNameAndChangeTween(self.openTween, self.titleName)
end

function MultitermChooseTemplate:RefreshParams(commondata)
    self.showTable = ternary(commondata.showTable == nil, {}, commondata.showTable)
    if commondata.callBack ~= nil then
        self.callBack = commondata.callBack
    end
    self.openTween = ternary(commondata.openTween == nil, true, commondata.openTween)
    self.titleName = ternary(commondata.titleName == nil, "", commondata.titleName)
    self.stallInfoList = commondata.stallInfoList
end

function MultitermChooseTemplate:RefreshTable()
    ---btnid --》 按钮模板
    self.allChooseBtn = {}
    self.gameObjectAndBtnTemplateTable = {}
    if self.showTable ~= nil and CS.StaticUtility.IsNull(self.StallInfo_UIGridContainer) == false then
        self.StallInfo_UIGridContainer.MaxCount = #self.showTable
        local length = #self.showTable - 1
        for k = 0, length do
            local v = self.StallInfo_UIGridContainer.controlList[k]
            local stallInfo = nil
            if self.stallInfoList ~= nil then
                stallInfo = self.stallInfoList[k]
            end
            ---@type MultitermChooseBtnTemplate
            local btnTemplate = templatemanager.GetNewTemplate(v, luaComponentTemplates.MultitermChooseBtnTemplate, self)
            local customdata = {
                name = self.showTable[k + 1],
                stallInfo = stallInfo,
                btnId = k + 1,
            }
            table.insert(self.allChooseBtn, btnTemplate)
            self.gameObjectAndBtnTemplateTable[v] = btnTemplate
            btnTemplate:RefreshBtn(customdata)
        end
    end
    self.StallInfo_MultitermChoose.OnBtnClick = function(gameObject)
        self:RefreshTitleName(gameObject)
    end
end

---刷新标题内容
function MultitermChooseTemplate:RefreshTitleName(gameObject)
    if CS.CSScene.MainPlayerInfo.AuctionInfo:IsHaveBooth() == true and self.StallInfo_MultitermChoose.ChooseLock == true then
        Utility.ShowPopoTips(gameObject, nil, 224)
        return
    end
    if self.StallTitle_Label ~= nil and self.StallInfo_MultitermChoose ~= nil and self.StallInfo_MultitermChoose.BtnIdList ~= nil then
        local titleName = ""
        if self.StallInfo_MultitermChoose.BtnIdList.Count > 0 then
            local length = self.StallInfo_MultitermChoose.BtnIdList.Count - 1
            for k = 0, length do
                local v = self.StallInfo_MultitermChoose.BtnIdList[k]
                if self.allChooseBtn[v] ~= nil and self.allChooseBtn[v].name ~= nil then
                    titleName = titleName .. self.allChooseBtn[v].name
                end
            end
        end
        self.StallTitle_Label.text = titleName
    end

    local btnTemplate = nil
    if gameObject ~= nil then
        btnTemplate = self.gameObjectAndBtnTemplateTable[gameObject]
    end

    if self.callBack ~= nil and gameObject ~= nil then
        self:callBack(self:GetChooseList(),btnTemplate.stallInfo)
    end
end

--endregion

---region 功能
function MultitermChooseTemplate:ControlStallInfoOpen(state)
    if state == true then
        self.StallInfo_TweenPosition:PlayReverse()
        self.StallInfo_TweenAlpha:PlayReverse()
        self.StallTitle_Arrow:PlayReverse()
    elseif state == false then
        self.StallInfo_TweenPosition:PlayForward()
        self.StallInfo_TweenAlpha:PlayForward()
        self.StallTitle_Arrow:PlayForward()
    end
end

---设置多项选择
function MultitermChooseTemplate:SetChooseList(chooseTable)
    if self.StallInfo_MultitermChoose ~= nil and CS.StaticUtility.IsNull(self.StallInfo_MultitermChoose) == false then
        self.StallInfo_MultitermChoose:SetBtnState(chooseTable)
    end
end

---设置多项选择并刷新标题
function MultitermChooseTemplate:SetChooseListAndChangeTitleName(chooseTable)
    self:SetChooseList(chooseTable)
    self:RefreshTitleName()
end

---获取多项选择
function MultitermChooseTemplate:GetChooseList()
    if self.StallInfo_MultitermChoose ~= nil and CS.StaticUtility.IsNull(self.StallInfo_MultitermChoose) == false then
        return self.StallInfo_MultitermChoose.BtnIdList
    end
end

---设置标题名字
function MultitermChooseTemplate:SetTitleName(titleName)
    if self.StallTitle_Label ~= nil and titleName ~= nil and CS.StaticUtility.IsNull(self.StallTitle_Label) == false then
        self.StallTitle_Label.text = titleName
    end
end

---设置按钮列表显示状态
function MultitermChooseTemplate:SetBtnsState(state)
    if self.StallInfo_UIGridContainer ~= nil and CS.StaticUtility.IsNull(self.StallInfo_UIGridContainer) == false then
        self.StallInfo_UIGridContainer.gameObject:SetActive(state)
    end
end

---设置标题状态
function MultitermChooseTemplate:SetTitleState(state)
    if self.StallTitle_Label ~= nil and CS.StaticUtility.IsNull(self.StallTitle_Label) == false then
        self.StallTitle_Label.gameObject:SetActive(state)
    end
end

---刷新标题并控制tween的开关
function MultitermChooseTemplate:RefreshTieleNameAndChangeTween(openTween, titleName)
    --[[
    if openTween == nil or titleName == nil then
        return
    end
    self.openTween = openTween
    if self.openTween == false then
        self:ControlStallInfoOpen(self.openTween)
    end
    self.StallTitle_Arrow.gameObject:SetActive(self.openTween)
    --]]
    self:SetTitleName(titleName)
end

---endregion
return MultitermChooseTemplate