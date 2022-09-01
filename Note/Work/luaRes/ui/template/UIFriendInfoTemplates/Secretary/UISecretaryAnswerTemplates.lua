local UISecretaryAnswerTemplates = {}

function UISecretaryAnswerTemplates:InitComponents()
    --秘书面板
    self.uichat = self:Get("chat", "GameObject")
    ---标题名称
    self.headline = self:Get("chat/headline", "Top_UILabel")
    ---变强攻略父节点
    self.cheats = self:Get("chat/cheats", "GameObject")
    ---变强攻略描述
    self.cheatsLabel = self:Get("chat/cheats/cheatsLabel", "Top_UILabel")
    ---变强攻略Icon
    self.cheatsIcon = self:Get("chat/cheats/icon", "Top_UISprite")
    ---导航栏描述
    self.bavigation = self:Get("chat/bavigation", "Top_UIGridContainer")
    ---内容描述
    self.details = self:Get("chat/details", "Top_UILabel")

    ---内容描述Grid
    self.Describe = self:Get("chat/Describe", "GameObject")
    ---内容描述Grid
    self.DescribeGrid = self:Get("chat/Describe/grid", "Top_UIGridContainer")
    ---内容描述
    self.detailsBoxCollider = self:Get("chat/details", "BoxCollider")
    ---背景
    self.Bg = self:Get("chat/Bg", "Top_UISprite")
    ---关键词列表
    self.keywordGrild = self:Get("chat/keywordGrild", "Top_UIGridContainer")

    self.widget = self:Get("widget", "GameObject")

end
function UISecretaryAnswerTemplates:InitOther()
    self.SecretaryDialogueData = nil
    self.topDis = 13
    self.distance = 0;
    self.isHavekeyword = false
    self.headlinePosition = self.headline.transform.localPosition
    self.bavigationPosition = self.bavigation.transform.localPosition
    self.detailsPosition = self.details.transform.localPosition
    self.keywordPosition = self.keywordGrild.transform.localPosition
    self.cheatsPosition = self.cheats.transform.localPosition
    self.widgetPosition = self.widget.transform.localPosition

    self.DescribePosition = self.Describe.transform.localPosition
    self.playerPosition = CS.UnityEngine.Vector3(480, 0, 0);
    self.SecretaryPosition = CS.UnityEngine.Vector3.zero;
    self.DescribeGridPosition = CS.UnityEngine.Vector3(0, 0, 0);

    CS.UIEventListener.Get(self.cheats.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.cheats.gameObject).OnClickLuaDelegate = self.OnClickIntensify
end

function UISecretaryAnswerTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

--CS.SecretaryDialogueData
function UISecretaryAnswerTemplates:RefreshUI(SecretaryDialogueData)
    if SecretaryDialogueData == nil then
        return
    end
    self.SecretaryDialogueData = SecretaryDialogueData
    local isMainPlayer = self.SecretaryDialogueData.IsMainPlayer
    self.uichat.gameObject:SetActive(not isMainPlayer)
    if not isMainPlayer then
        self:SetHeadline()
        self:SetBavigation()
    end

    self:SetDetails2()
    -- self.isNeedShowSpecialDetails = false
    -- local detailsList = self.SecretaryDialogueData.DetailsList
    -- if detailsList ~= nil or detailsList.Length > 1 then
    --     self.isNeedShowSpecialDetails = true
    -- end
    -- if self.isNeedShowSpecialDetails then
    --     self:SetDetails2()
    -- else
    --     self:SetDetails()
    -- end
    -- self:SetKeywordGrild()
    self:RefreShlocation()
    return self.distance

end
---设置标题
function UISecretaryAnswerTemplates:SetHeadline()
    if self.SecretaryDialogueData == nil then
        return
    end
    if self.SecretaryDialogueData.IsHaveTitle then
        self.headline.text = self.SecretaryDialogueData.TitleDes
        Utility.RequestCharactersInTexture(self.headline)
    end
    self.headline.gameObject:SetActive(self.SecretaryDialogueData.IsHaveTitle)
    self.cheats.gameObject:SetActive(self.SecretaryDialogueData.IsHaveTitle)

end

---导航栏描述
function UISecretaryAnswerTemplates:SetBavigation()
    if self.SecretaryDialogueData == nil then
        return
    end
    if self.SecretaryDialogueData.BavigationDesList == nil then
        return
    end
    self.bavigation.MaxCount = self.SecretaryDialogueData.BavigationDesList.Count
    local Selectsecond = ""
    local Selectthirdly = ""
    if self.SecretaryDialogueData.SelectTab ~= nil then
        Selectsecond = self.SecretaryDialogueData.SelectTab.secondTitle
        Selectthirdly = self.SecretaryDialogueData.SelectTab.title
    end
    local index = 0
    for i = 0, self.bavigation.MaxCount - 1 do
        local item = self.bavigation.controlList[i].gameObject
        local grid = CS.Utility_Lua.GetComponent(item.transform, "Top_UIGridContainer");
        if grid ~= nil then
            local infoList = self.SecretaryDialogueData.BavigationDesList[i]
            grid.MaxCount = infoList.Count
            for j = 0, grid.MaxCount - 1 do
                local item = grid.controlList[j].gameObject
                self.temp = templatemanager.GetNewTemplate(item, luaComponentTemplates.UISecretaryAnswerNavigationTemplates);
                self.temp:RefreshUI(infoList[j], Selectsecond, Selectthirdly, i, self.SecretaryDialogueData)
            end

        end
    end

end

---内容描述
function UISecretaryAnswerTemplates:SetDetails()
    if self.SecretaryDialogueData == nil then
        return
    end
    self.details.text = string.gsub(self.SecretaryDialogueData.Details, '\\n', '\n')
    Utility.RequestCharactersInTexture(self.details)
    local center = self.detailsBoxCollider.center
    local size = self.detailsBoxCollider.size
    center.y = -self.details.height / 2
    size.y = self.details.height
    self.detailsBoxCollider.center = center
    self.detailsBoxCollider.size = size
    local isopen = self.SecretaryDialogueData.IsBookPageNumberId
    self.cheats.gameObject:SetActive(isopen)
end

---内容描述
function UISecretaryAnswerTemplates:SetDetails2()
    if self.SecretaryDialogueData == nil then
        return
    end
    local detailsList = self.SecretaryDialogueData.DetailsList
    if detailsList == nil or detailsList.Length == 0 then
        return
    end

    self.DescribeGrid.MaxCount = detailsList.Length
    self.DescribeGridPosition = CS.UnityEngine.Vector3(0, 0, 0)
    local detailsListLength=detailsList.Length;
    for i = 0, detailsList.Length - 1 do
        local item = self.DescribeGrid.controlList[i].gameObject
        item.transform.localPosition = self.DescribeGridPosition
        local textGameObject = item.transform:Find("desText").gameObject
        local text = CS.Utility_Lua.GetComponent(textGameObject, "Top_UILabel")
        local textBox = CS.Utility_Lua.GetComponent(textGameObject, "BoxCollider")
        if text ~= nil then
            text.text = detailsList[i]
            Utility.RequestCharactersInTexture(text)
            local center = textBox.center
            local size = textBox.size
            center.y = -text.height / 2
            size.y = text.height
            textBox.center = center
            textBox.size = size
            self.DescribeGridPosition.y = self.DescribeGridPosition.y - text.height - 4
            if  detailsListLength==1 and text.height<30 then
                item.transform.localPosition= item.transform.localPosition-CS.UnityEngine.Vector3(0, 4, 0)
                self.DescribeGridPosition.y = self.DescribeGridPosition.y-5
            elseif detailsListLength-1==i and text.height<30 and not  self.SecretaryDialogueData.IsBookPageNumberId then
                self.DescribeGridPosition.y = self.DescribeGridPosition.y-6
            end
        end
    end
    local isopen = self.SecretaryDialogueData.IsBookPageNumberId
    self.cheats.gameObject:SetActive(isopen)
end

function UISecretaryAnswerTemplates:SetKeywordGrild()
    if self.SecretaryDialogueData == nil then
        return
    end
    local keyword = self.SecretaryDialogueData.KeywordList
    local Count = keyword.Count
    self.keywordGrild.MaxCount = Count
    if Count == 0 then
        return
    end
    self.isHavekeyword = true
    for i = 0, Count - 1 do
        local item = self.keywordGrild.controlList[i].gameObject
        local label = CS.Utility_Lua.GetComponent(item.transform:Find('Label'), "Top_UILabel");
        label.text = keyword[i].name
        Utility.RequestCharactersInTexture(label)
        CS.UIEventListener.Get(item.gameObject).onClick = function()
            CS.Cfg_SecretRelationwordsTableManager.Instance:CheckPrePushState(keyword[i].id);
        end
    end
end

function UISecretaryAnswerTemplates:RefreShlocation()
    self.distance = self.topDis
    if self.SecretaryDialogueData.IsHaveTitle then
        self.headlinePosition.y = self.distance
        self.headline.transform.localPosition = self.headlinePosition
        self.distance = self.distance - 31
    end

    if self.SecretaryDialogueData.IsHaveBavigationBar then
        self.distance = self.distance - 10
        self.bavigationPosition.y = self.distance
        self.bavigation.transform.localPosition = self.bavigationPosition
        self.distance = self.distance - self.bavigation.CellHeight * self.bavigation.MaxCount + 20
    end
    -- self.detailsPosition.y = self.distance
    -- self.details.transform.localPosition = self.detailsPosition
    -- if self.details.height <= 30 then
    --     self.distance = self.distance - 10
    -- end
    -- self.distance = self.distance - self.details.height
    self.DescribePosition.y = self.distance+2
    self.Describe.transform.localPosition = self.DescribePosition
    self.distance = self.distance + self.DescribeGridPosition.y

    if self.keywordGrild.MaxCount > 0 then
        self.distance = self.distance - 35
        self.keywordPosition.y = self.distance
        self.keywordGrild.transform.localPosition = self.keywordPosition
        local dis = self.keywordGrild.CellHeight
        if self.keywordGrild.MaxCount > self.keywordGrild.MaxPerLine then
            dis = dis * 2
        end
        self.distance = self.distance - dis + 30
    end
    if self.SecretaryDialogueData.IsBookPageNumberId then
        self.distance = self.distance - 14
        self.cheatsPosition.y = self.distance+2
        self.cheats.transform.localPosition = self.cheatsPosition
        self.distance = self.distance - self.cheatsLabel.height - 1
    end

    if self.distance < 0 then
        self.distance = self.distance * -1
    end
    self.distance = self.distance + 22
    if not self.SecretaryDialogueData.IsHaveTitle then
        self.distance = self.distance + 3
    end
    self.Bg.height = self.distance

    self.distance = self.distance - 20

    self.widgetPosition.y=-self.distance+20
    self.widget.transform.localPosition=self.widgetPosition
end

function UISecretaryAnswerTemplates:OnClickIntensify()
    if self.SecretaryDialogueData == nil then
        return
    end
    if self.SecretaryDialogueData.SelectTab == nil then
        return
    end
    uimanager:CreatePanel("UISecretBookPanel", nil, self.SecretaryDialogueData.SelectTab.bookKeyWord)
end

return UISecretaryAnswerTemplates