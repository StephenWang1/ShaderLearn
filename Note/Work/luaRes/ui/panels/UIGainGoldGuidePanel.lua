---@class UIGainGoldGuidePanel:UIBase 打金指南
local UIGainGoldGuidePanel = {}

local CheckNullFunction = CS.StaticUtility.IsNull

---每行长度
UIGainGoldGuidePanel.mMaxLengthPerLine = 802
---每个item长度
UIGainGoldGuidePanel.mMaxLengthPerItem = 80
---用于替换道具的空格
UIGainGoldGuidePanel.mReplaceSpace = "                    "
--UIGainGoldGuidePanel.mReplaceSpace = ""

---@return CSMainPlayerInfo
function UIGainGoldGuidePanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return number 主角职业
function UIGainGoldGuidePanel:GetMainPlayerCareer()
    if self.mMainPlayerCareer == nil then
        self.mMainPlayerCareer = 0
        if self:GetMainPlayerInfo() then
            self.mMainPlayerCareer = Utility.EnumToInt(self:GetMainPlayerInfo().Career)
        end
    end
    return self.mMainPlayerCareer
end

---@return number 主角职业
function UIGainGoldGuidePanel:GetMainPlayerSex()
    if self.mMainPlayerSex == nil then
        self.mMainPlayerSex = 0
        if self:GetMainPlayerInfo() then
            self.mMainPlayerSex = Utility.EnumToInt(self:GetMainPlayerInfo().Sex)
        end
    end
    return self.mMainPlayerSex
end

--region 组件
---@return UnityEngine.GameObject
function UIGainGoldGuidePanel:GetCloseBtn_GO()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UIGridContainer
function UIGainGoldGuidePanel:GetBookMark_Grid()
    if self.mBookGrid == nil then
        self.mBookGrid = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "UIGridContainer")
    end
    return self.mBookGrid
end

---@return UILabel
function UIGainGoldGuidePanel:GetMainText_UILabel()
    if self.mMainText == nil then
        self.mMainText = self:GetCurComp("WidgetRoot/view/scroll/mainLabel", "UILabel")
    end
    return self.mMainText
end

---@return UIGridContainer
function UIGainGoldGuidePanel:GetTitleGrid_UIGridContainer()
    if self.mTitleGrid == nil then
        self.mTitleGrid = self:GetCurComp("WidgetRoot/view/scroll/gridTitle", "UIGridContainer")
    end
    return self.mTitleGrid
end

---@return UIGridContainer
function UIGainGoldGuidePanel:GetItemGrid_UIGridContainer()
    if self.mItemGrid == nil then
        self.mItemGrid = self:GetCurComp("WidgetRoot/view/scroll/reward", "UIGridContainer")
    end
    return self.mItemGrid
end

---@return UIScrollView
function UIGainGoldGuidePanel:GetScroll()
    if self.mScroll == nil then
        self.mScroll = self:GetCurComp("WidgetRoot/view/scroll", "UIScrollView")
    end
    return self.mScroll
end
--endregion

--region 初始化
function UIGainGoldGuidePanel:Init()
    self:BindEvents()
    local allShow = clientTableManager.cfg_guidebookManager:GetAllData()
    self:InitBookMark(allShow)
end

function UIGainGoldGuidePanel:Show()
    self:ChooseFistBookMark()
end

function UIGainGoldGuidePanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GO()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region 初始化页签
---@param allShow table<number,TABLE.cfg_guidebook>
function UIGainGoldGuidePanel:InitBookMark(allShow)
    if allShow == nil or #allShow <= 0 then
        return
    end
    ---@type table<TABLE.cfg_guidebook> 从上倒下的按钮列表
    self.mBookMarkList = {}
    self.mBookMarkType = {}
    self.mBookMarkTypeToGo = {}
    self:GetBookMark_Grid().MaxCount = #allShow
    for i = 0, self:GetBookMark_Grid().controlList.Count - 1 do
        local singleData = allShow[i + 1]
        local bookMarkId = singleData:GetId()
        local go = self:GetBookMark_Grid().controlList[i]
        local template = self:GetBookMarkTemplate(go)
        if template then
            template:SetLbInfo(singleData:GetMarkName())
        end
        CS.UIEventListener.Get(go).onClick = function()
            self:OnBookMarkClicked(bookMarkId)
        end
        table.insert(self.mBookMarkList,singleData)
        self.mBookMarkType[bookMarkId] = singleData
        self.mBookMarkTypeToGo[bookMarkId] = go
    end
end

---页签点击
function UIGainGoldGuidePanel:OnBookMarkClicked(bookMarkId)
    local data = self.mBookMarkType[bookMarkId]
    self:ShowDayToDayPanel(bookMarkId == 1)
    self:ShowVipZunXiangPanel(bookMarkId == 8)
    self:RefreshShowInfo(data)
end

---显示日活界面
function UIGainGoldGuidePanel:ShowDayToDayPanel(isShow)
    if self.mDayToDayPanel == nil then
        if isShow then
            uimanager:CreatePanel("UIDayToDayPanel", function(panel)
                self.mDayToDayPanel = panel
            end)
        end
    else
        if isShow then
            uimanager:ReShowPanel(self.mDayToDayPanel)
        else
            uimanager:HidePanel(self.mDayToDayPanel)
        end
    end
end

---vip尊享界面
function UIGainGoldGuidePanel:ShowVipZunXiangPanel(isShow)
    if self.mVipZunXiangPanel == nil then
        if isShow then
            uimanager:CreatePanel("UIZunXiangVipPanel", function(panel)
                self.mVipZunXiangPanel = panel
            end)
        end
    else
        if isShow then
            uimanager:ReShowPanel(self.mVipZunXiangPanel)
        else
            uimanager:HidePanel(self.mVipZunXiangPanel)
        end
    end
end

function UIGainGoldGuidePanel:ChooseFistBookMark()
    if self.mBookMarkList ~= nil then
        ---@type TABLE.cfg_guidebook
        local firstValue = Utility.GetTableFirstValue(self.mBookMarkList)
        self:ChooseBookMarkByBookMarkId(firstValue:GetId())
    end
end

---外部调用选中页签
---public
---@param eventId number 对应 cfg_special_activity eventId
function UIGainGoldGuidePanel:ChooseBookMarkByBookMarkId(eventId)
    if eventId == nil then
        return
    end
    if self.mBookMarkTypeToGo then
        local go = self.mBookMarkTypeToGo[eventId]
        local template = self:GetBookMarkTemplate(go)
        if template then
            template:ChooseItem(true)
        end
    end
    self:OnBookMarkClicked(eventId)
end
---@return UICommonBookMarkTemplate
---protected 页签模板
function UIGainGoldGuidePanel:GetBookMarkTemplate(go)
    if CheckNullFunction(go) then
        return
    end
    if self.mGoToBookMarkTemplate == nil then
        self.mGoToBookMarkTemplate = {}
    end
    local template = self.mGoToBookMarkTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICommonBookMarkTemplate)
        self.mGoToBookMarkTemplate[go] = template
    end
    return template
end
--endregion

--region 刷新内容
---@param data TABLE.cfg_guidebook
function UIGainGoldGuidePanel:RefreshShowInfo(data)
    if data == nil then
        return
    end
    local dis = (data:GetLineSpace() == nil or data:GetLineSpace() == 0) and 16 or data:GetLineSpace()
    self:GetMainText_UILabel().spacingY = dis
    local mainShow = string.gsub(data:GetText(), '\\n', '\n')
    mainShow = string.gsub(mainShow, '{0}', self.mReplaceSpace)
    self:GetMainText_UILabel().text = mainShow
    self:RefreshAllItem(data)
    self:RefreshTitle(data)
    self:GetScroll():ResetPosition()
end

---@class GuidItemInfo
---@field itemId number
---@field effectId number
---@field posX number
---@field posY number

---@param data TABLE.cfg_guidebook 刷新道具
function UIGainGoldGuidePanel:RefreshAllItem(data)
    if data == nil then
        self:ShowAllItem()
        return
    end
    ---@type table<number,GuidItemInfo>
    local showData = {}
    local allData = data:GetIcon()
    local strs = string.Split(allData, '&')
    for i = 1, #strs do
        local singleItemInfo = string.Split(strs[i], '#')
        self:TryAddShowItem(showData, singleItemInfo)
    end
    --local allPos = self:GetItemPos(data)
    self:ShowAllItem(showData)
end

---@return number 字符大小
function UIGainGoldGuidePanel:GetFontSize()
    return self:GetMainText_UILabel().fontSize
end

---@return table<number> 每个道具的位置
---@param data TABLE.cfg_guidebook 刷新道具
function UIGainGoldGuidePanel:GetItemPos(data)
    local posTbl = {}
    if data == nil then
        return posTbl
    end
    ---获得总共有多少段
    local strs = string.Split(data:GetText(), '\\n')
    local CurrentLine = 0
    for i = 1, #strs do
        local singleSegment = strs[i]
        local allCut = self:GetSingleSegmentStr(singleSegment)
        if #allCut > 0 then
            local totalLen = 0
            for j = 1, #allCut do
                local cut = allCut[j]
                local length = self:GetShowStrToWordNum(cut) * self:GetFontSize()
                if length == 0 then
                    length = 1
                end
                totalLen = totalLen + length
                local currentLine = math.ceil(totalLen / self.mMaxLengthPerLine)
                local lineY = currentLine + CurrentLine - 1
                local des = (data:GetLineSpace() == nil or data:GetLineSpace() == 0) and math.ceil(self.mMaxLengthPerItem / 2) or data:GetLineSpace()
                local PosY = -1 * lineY * (self:GetFontSize() + des)
                local PosX = totalLen - self.mMaxLengthPerLine * (currentLine - 1)
                local pos = {}
                pos.x = PosX
                pos.y = PosY
                table.insert(posTbl, pos)
                totalLen = totalLen + self.mMaxLengthPerItem
            end
            local line = math.ceil(totalLen / self.mMaxLengthPerLine)
            CurrentLine = CurrentLine + line
        else
            local segLen = self:GetStringLength(singleSegment)
            local length = math.ceil(segLen / 3) * self:GetFontSize()
            local line = math.ceil(length / self.mMaxLengthPerLine)
            CurrentLine = CurrentLine + line
        end
    end
    return posTbl
end

function UIGainGoldGuidePanel:GetSingleSegmentStr(singleSegment)
    local allStr = {}
    self:GetSingleStr(singleSegment, allStr)
    return allStr
end

function UIGainGoldGuidePanel:GetSingleStr(singleSegment, tbl)
    if singleSegment == nil or #singleSegment <= 0 or tbl == nil then
        return
    end
    local startIndex, endIndex = string.find(singleSegment, "{0}")
    if startIndex and endIndex then
        local str = string.sub(singleSegment, 1, startIndex - 1)
        local allWithOutColorStr = {}
        self:AddStrWithOutColor(str, allWithOutColorStr)
        local withoutColor = ""
        for i = 1, #allWithOutColorStr do
            withoutColor = withoutColor .. allWithOutColorStr[i]
        end
        table.insert(tbl, withoutColor)
        local nextStr = string.sub(singleSegment, endIndex + 1, -1)
        if nextStr then
            self:GetSingleStr(nextStr, tbl)
        end
    end
end

---将去除字色的文本添加到table中
---@param strs string
function UIGainGoldGuidePanel:AddStrWithOutColor(strs, patStr)
    if strs == nil or #strs <= 0 or patStr == nil then
        return
    end
    local startIndex, endIndex = string.find(strs, "%[")
    if startIndex and endIndex then
        local startIndex1, endIndex1 = string.find(strs, "%]")
        if startIndex1 and endIndex1 then
            local dis = startIndex1 - startIndex + 1
            if dis == 8 or dis == 3 then
                local currentStr = string.sub(strs, 1, startIndex - 1)
                if currentStr and currentStr ~= "" then
                    table.insert(patStr, currentStr)
                end
                local nextStr = string.sub(strs, endIndex1 + 1, -1)
                if nextStr then
                    self:AddStrWithOutColor(nextStr, patStr)
                    return
                end
            else
                local currentStr = string.sub(strs, 1, endIndex1)
                if currentStr and currentStr ~= "" then
                    table.insert(patStr, currentStr)
                end
                local nextStr = string.sub(strs, endIndex1 + 1, -1)
                if nextStr then
                    self:AddStrWithOutColor(nextStr, patStr)
                    return
                end
            end
        end
    end
    table.insert(patStr, strs)
    --table.insert(tbl, str)
end

function UIGainGoldGuidePanel:GetStringLength(str)
    if str == nil or type(str) ~= "string" or #str <= 0 then
        return 0
    end
    ---字符的个数
    local length = 0
    local i = 1
    while true do
        local cutByte = string.byte(str, i)
        local byteCount = 1
        if cutByte > 239 then
            byteCount = 4--4字节字符
        elseif cutByte > 223 then
            byteCount = 3--汉字
        elseif cutByte > 128 then
            byteCount = 2
        else
            byteCount = 1
        end

        i = i + byteCount

        length = length + 1
        if i > #str then
            break
        end
    end
    return length
end

---字符字母等转换成中文文本的个数
function UIGainGoldGuidePanel:GetShowStrToWordNum(str)
    if str == nil or type(str) ~= "string" or #str <= 0 then
        return 0
    end
    ---字符的个数
    local length = 0
    local i = 1
    local addLen = 0
    while true do
        local cutByte = string.byte(str, i)
        local byteCount = 1
        if cutByte > 239 then
            byteCount = 4--4字节字符
            addLen = 1
        elseif cutByte > 223 then
            byteCount = 3--汉字
            addLen = 1
        elseif cutByte > 128 then
            byteCount = 2--双字节字符
            addLen = 1
        else
            byteCount = 1-- 单字节字符
            local char = string.sub(str, i, i + byteCount - 1)
            if char == " " then
                addLen = 0.2
            else
                addLen = 0.5
            end
        end
        i = i + byteCount
        length = length + addLen
        if i > #str then
            break
        end
    end
    return length
end

---添加需要显示的item
function UIGainGoldGuidePanel:TryAddShowItem(tbl, singleItemInfo)
    if singleItemInfo and #singleItemInfo >= 6 then
        local itemId = tonumber(singleItemInfo[1])
        local career = tonumber(singleItemInfo[2])
        local sex = tonumber(singleItemInfo[3])
        local effectId = tonumber(singleItemInfo[4])
        local posX = tonumber(singleItemInfo[5])
        local posY = tonumber(singleItemInfo[6])
        if itemId == nil or effectId == nil then
            return
        end

        if career ~= 0 and career ~= self:GetMainPlayerCareer() then
            return
        end
        if sex ~= 0 and sex ~= self:GetMainPlayerSex() then
            return
        end
        ---@type GuidItemInfo
        local guidInfo = {}
        guidInfo.itemId = itemId
        guidInfo.effectId = effectId
        guidInfo.posX = posX
        guidInfo.posY = posY
        table.insert(tbl, guidInfo)
    end
end

---刷新所有icon
---@param itemList table<number,GuidItemInfo>
---@param allPos table<number>
function UIGainGoldGuidePanel:ShowAllItem(itemList)
    if itemList == nil or #itemList <= 0 then
        self:GetItemGrid_UIGridContainer().MaxCount = 0
        return
    end
    self:GetItemGrid_UIGridContainer().gameObject:SetActive(#itemList > 0)
    self:GetItemGrid_UIGridContainer().MaxCount = #itemList
    for i = 0, self:GetItemGrid_UIGridContainer().controlList.Count - 1 do
        local itemGo = self:GetItemGrid_UIGridContainer().controlList[i]
        ---@type UISprite
        local icon = CS.Utility_Lua.Get(itemGo.transform, "icon", "UISprite")
        ---@type CSUIEffectLoad
        local effect = CS.Utility_Lua.Get(itemGo.transform, "frame", "CSUIEffectLoad")
        local singleInfo = itemList[i + 1]
        -- effect.effectId = singleInfo.effectId
        effect.gameObject:SetActive(singleInfo.effectId ~= 0)
        if singleInfo.effectId ~= 0 then
            effect:ChangeEffect(singleInfo.effectId)
        end
        local res, csItem = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(singleInfo.itemId)
        if res then
            icon.spriteName = csItem.icon
            CS.UIEventListener.Get(icon.gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csItem })
            end
        end
        local goPos = itemGo.transform.localPosition
        goPos.x = singleInfo.posX
        goPos.y = singleInfo.posY
        itemGo.transform.localPosition = goPos
    end
end
--endregion

--region 刷新标题
---@param data TABLE.cfg_guidebook
function UIGainGoldGuidePanel:RefreshTitle(data)
    local title = data:GetMainTitle()
    local hasData = title and title ~= ""
    self:GetTitleGrid_UIGridContainer().gameObject:SetActive(hasData)
    self:GetTitleGrid_UIGridContainer().MaxCount = 1
    local go = self:GetTitleGrid_UIGridContainer().controlList[0]
    --据策划说，这里只会有一个标题，但是保险起见，先留个container
    local lb = CS.Utility_Lua.GetComponent(go.transform, "UILabel")
    lb.text = title
end
--endregion

function ondestroy()
    if UIGainGoldGuidePanel.mDayToDayPanel then
        uimanager:ClosePanel(UIGainGoldGuidePanel.mDayToDayPanel)
    end
    if UIGainGoldGuidePanel.mVipZunXiangPanel then
        uimanager:ClosePanel(UIGainGoldGuidePanel.mVipZunXiangPanel)
    end
end

return UIGainGoldGuidePanel