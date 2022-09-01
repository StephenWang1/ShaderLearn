---行会活动的活动描述,可以作为通用的活动描述界面
---@class UIUnionActivitiesDesPanel:UIBase
local UIUnionActivitiesDesPanel = {}

---关闭按钮
---@return UnityEngine.GameObject
function UIUnionActivitiesDesPanel:GetCloseButton()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/Btn_Close", "GameObject")
    end
    return self.mCloseButton
end

---标题文本组件
---@return UILabel
function UIUnionActivitiesDesPanel:GetTitleLabel()
    if self.mTitleLabel == nil then
        self.mTitleLabel = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/title", "UILabel")
    end
    return self.mTitleLabel
end

---获取背景图组件
---@return UISprite
function UIUnionActivitiesDesPanel:GetBgTexture()
    if self.mBgTexture == nil then
        self.mBgTexture = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/texture", "UISprite")
    end
    return self.mBgTexture
end

---获取格子容器
---@return UIGridContainer
function UIUnionActivitiesDesPanel:GetGrids()
    if self.mGrids == nil then
        self.mGrids = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/ScrollView/Grid", "UIGridContainer")
    end
    return self.mGrids
end

---获取格子的排序组件
---@return UITable
function UIUnionActivitiesDesPanel:GetGridsTable()
    if self.mGridsTable == nil then
        self.mGridsTable = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/ScrollView/Grid", "UITable")
    end
    return self.mGridsTable
end

---查看详情按钮
---@return UnityEngine.GameObject
function UIUnionActivitiesDesPanel:GetLastBtnGO()
    if self.mLastBtnGO == nil then
        self.mLastBtnGO = self:GetCurComp("WidgetRoot/ActivitiesDesPanel/events/LastBtn", "GameObject")
    end
    return self.mLastBtnGO
end

function UIUnionActivitiesDesPanel:Init()
    self:BindUIEvents()
end

function UIUnionActivitiesDesPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButton()).onClick = function()
        self:ClosePanel()
    end
end

---@param data {title:string, description:string, textureName:string, buttonClickCallBack:fun(go:UnityEngine.GameObject):boolean}
function UIUnionActivitiesDesPanel:Show(data)
    if data == nil or data.description == nil then
        self:ClosePanel()
        return
    end
    ---处理标题
    self:GetTitleLabel().text = data.title == nil and "" or data.title
    ---处理背景图
    self:GetBgTexture().spriteName = data.textureName == nil and "" or data.textureName
    ---处理文本内容
    local analyzeData = self:AnalyzeString(data.description)
    self:GetGrids().MaxCount = #analyzeData
    for i = 1, #analyzeData do
        ---@type UnityEngine.GameObject
        local go = self:GetGrids().controlList[i - 1]
        local des = analyzeData[i]
        if go ~= nil and des ~= nil then
            ---@type UILabel
            local titleLabel = self:GetComp(go.transform, 'Label1', 'UILabel')
            ---@type UIGridContainer
            local descs = self:GetComp(go.transform, 'Desc', 'UIGridContainer')
            titleLabel.text = des.title
            descs.MaxCount = #des.subDescriptions
            for j = 1, #des.subDescriptions do
                ---@type ActivitySubDescription
                local subDes = des.subDescriptions[j]
                ---@type UnityEngine.GameObject
                local subGo = descs.controlList[j - 1]
                ---@type UILabel
                local subTitleLabel = self:GetComp(subGo.transform, 'title', 'UILabel')
                ---@type UILabel
                local subContentLabel = self:GetComp(subGo.transform, 'dec', 'UILabel')
                ---@type UnityEngine.GameObject
                local subSignGo = self:GetComp(subGo.transform, 'sign', 'GameObject')
                local posX = 0
                if subDes.isShowSign then
                    subSignGo:SetActive(true)
                    posX = posX + 20
                else
                    subSignGo:SetActive(false)
                end
                if subDes.subTitle == nil then
                    subTitleLabel.gameObject:SetActive(false)
                else
                    subTitleLabel.gameObject:SetActive(true)
                    subTitleLabel.text = subDes.subTitle
                    local subTitleLabelPos = subTitleLabel.transform.localPosition
                    subTitleLabelPos.x = posX
                    subTitleLabel.transform.localPosition = subTitleLabelPos
                    subTitleLabel:MakePixelPerfect()
                    posX = posX + subTitleLabel.width + 10
                end
                local subContentLabelPos = subContentLabel.transform.localPosition
                subContentLabelPos.x = posX
                subContentLabel.transform.localPosition = subContentLabelPos
                subContentLabel.text = subDes.content
            end
        end
    end
    self:GetGridsTable().enabled = true
    ---处理按钮
    if data.buttonClickCallBack == nil then
        self:GetLastBtnGO():SetActive(false)
        self.mButtonCallBack = nil
        CS.UIEventListener.Get(self:GetLastBtnGO()).onClick = nil
    else
        self:GetLastBtnGO():SetActive(true)
        self.mButtonCallBack = data.buttonClickCallBack
        CS.UIEventListener.Get(self:GetLastBtnGO()).onClick = function(go)
            self:OnButtonClicked(go)
        end
    end
end

---活动描述
---@public
---@class ActivityDescription
---@field title string
---@field subDescriptions table<number, ActivitySubDescription>

---活动子描述
---@public
---@class ActivitySubDescription
---@field isShowSign boolean
---@field subTitle string|nil
---@field content string

---@param description string
---@return table<number, ActivityDescription>
function UIUnionActivitiesDesPanel:AnalyzeString(description)
    if description == nil then
        return {}
    end
    ---@type table<number, ActivityDescription>
    local list = {}
    local desStrArray1 = string.Split(description, '&', true)
    local pattern = "(?<=\\<)[^\\>]+"
    for i = 1, #desStrArray1 do
        local desStr1 = desStrArray1[i]
        local desStrArray2 = string.Split(desStr1, '#', true)
        if #desStrArray2 > 1 then
            ---@type ActivityDescription
            local tblTemp = {}
            ---只处理有两个以上的,凑够标题和内容
            tblTemp.title = desStrArray2[1]
            tblTemp.subDescriptions = {}
            ---@type System.Text.RegularExpressions.MatchCollection
            local matchCollections = CS.System.Text.RegularExpressions.Regex.Matches(desStr1, pattern)
            if matchCollections ~= nil and matchCollections.Count > 0 then
                ---有匹配项
                for j = 1, matchCollections.Count do
                    ---@type System.Text.RegularExpressions.Match
                    local match = matchCollections[j - 1]
                    local desStrArray3 = string.Split(match.Value, '#')
                    if #desStrArray3 > 1 then
                        ---@type ActivitySubDescription
                        local tblTemp2 = {}
                        tblTemp2.isShowSign = true
                        tblTemp2.subTitle = desStrArray3[1]
                        tblTemp2.content = string.gsub(desStrArray3[2], '\\n', '\n')
                        table.insert(tblTemp.subDescriptions, tblTemp2)
                    end
                end
            else
                ---无匹配项
                local contentStr = string.gsub(desStrArray2[2], '\\n', '\n')
                ---@type ActivitySubDescription
                local tblTemp2 = {}
                tblTemp2.isShowSign = false
                tblTemp2.subTitle = nil
                tblTemp2.content = contentStr
                table.insert(tblTemp.subDescriptions, tblTemp2)
            end
            table.insert(list, tblTemp)
        end
    end
    return list
end

---按钮点击事件
---@private
function UIUnionActivitiesDesPanel:OnButtonClicked(go)
    if self.mButtonCallBack ~= nil then
        if self.mButtonCallBack(go) then
            self:ClosePanel()
        end
    end
end

return UIUnionActivitiesDesPanel