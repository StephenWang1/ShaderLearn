---@class UISystemOpenPanel_BookMarkTemplate:UIBookMarkBaseTempate 系统预告页签
local UISystemOpenPanel_BookMarkTemplate = {}

setmetatable(UISystemOpenPanel_BookMarkTemplate, luaComponentTemplates.UIBookMarkBaseTempate)

---@param data.pageData  systemPreviewInfo  当前页签信息
---@param data.callBack  function 点击回调
function UISystemOpenPanel_BookMarkTemplate:SetTemplate(data)
    if data and data.pageInfo then
        self.pageData = data.pageInfo
        ---@type TABLE.cfg_system_preview
        self.tblInfo = data.pageInfo.systemTblData
        self.goClickCallBack = data.callBack
        self:InitUI()
    end
end

function UISystemOpenPanel_BookMarkTemplate:InitUI()
    if self.tblInfo ~= nil then
        self.Label.text = self.tblInfo:GetName()
        self.checkMarkLabel.text = self.tblInfo:GetName()
        self.icon.spriteName = self.tblInfo:GetIconName()
        self.checkMarkIcon.spriteName = self.tblInfo:GetIconName()
    end
end

function UISystemOpenPanel_BookMarkTemplate:OnTemplatBtnClick(go)
    if self.goClickCallBack ~= nil then
        self.goClickCallBack(self)
    end
end

return UISystemOpenPanel_BookMarkTemplate