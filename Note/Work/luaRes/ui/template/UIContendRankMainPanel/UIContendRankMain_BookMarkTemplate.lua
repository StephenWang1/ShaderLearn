---@class UIContendRankMain_BookMarkTemplate:UIContendRank_BookMarkTemplate
local UIContendRankMain_BookMarkTemplate = {}

setmetatable(UIContendRankMain_BookMarkTemplate, luaComponentTemplates.UIContendRank_BookMarkTemplate)

function UIContendRankMain_BookMarkTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
end

---@param data table
---@field data.pageData RankPageInfo
---@field data.callBack function
function UIContendRankMain_BookMarkTemplate:SetTemplate(data)
    if data then
        ---@type RankPageInfo
        self.pageData = data.pageData
        self.goClickCallBack = data.callBack
        self:InitUI()
    end
end

function UIContendRankMain_BookMarkTemplate:InitUI()
    if self.pageData == nil then
        return
    end
    self.Label.text = self.pageData.str
    self.checkMarkLabel.text = self.pageData.str
    self.hot:SetActive(self.pageData.hotFlag == 1)
    self:SetRedPoint()
end

function UIContendRankMain_BookMarkTemplate:SetRedPoint()
    if self.redPoint ~= nil then
        self.redPoint:RemoveRedPointKey()
        if self.pageData.redEnum ~= nil then
            self.redPoint:AddRedPointKey(self.pageData.redEnum)
        end
    end
end

--刷新显示状态
function UIContendRankMain_BookMarkTemplate:RefreshToggleStatu(id)
    if self.pageData then
        local isOpen = id == self.pageData.id
        if self.checkmark.gameObject.activeSelf ~= isOpen then
            self.checkmark.gameObject:SetActive(isOpen)
        end

    end
end

return UIContendRankMain_BookMarkTemplate