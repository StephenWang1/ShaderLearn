---多项选择单个按钮模板
---@class MultitermChooseBtnTemplate
local MultitermChooseBtnTemplate = {}
function MultitermChooseBtnTemplate:Init(MultitermChooseTemplate)
    self.MultitermChooseTemplate = MultitermChooseTemplate
    self:InitComponent()
end

function MultitermChooseBtnTemplate:InitComponent()
    self.name_UILabel = self:Get("Label", "UILabel")
    self.choosePoint = self:Get("check/Label", "UILabel")
end

function MultitermChooseBtnTemplate:RefreshBtn(customData)
    if customData.name ~= nil then
        self.name = customData.name
        self.name_UILabel.text = customData.name
        self.choosePoint.text = customData.name
    end
    if customData.btnId ~= nil then
        self.btnId = customData.btnId
    end
    self.stallInfo = customData.stallInfo
    self.callBack = customData.callBack
end

return MultitermChooseBtnTemplate