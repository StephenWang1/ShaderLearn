---@class UISLequip_InfoTemplate :TemplateBase 副本传送单元模板
local UISLequip_InfoTemplate = {}

--region 初始化

function UISLequip_InfoTemplate:Init()
    self:InitComponents()
end

function UISLequip_InfoTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("AttrName", "Top_UILabel")
    ---@type Top_UILabel 名称
    self.curAttr = self:Get("AttrValue/AttrValue", "Top_UILabel")
    ---@type Top_UILabel 名称
    self.nextAttr = self:Get("", "Top_UILabel")
end

--endregion

--region Show

---@param data
function UISLequip_InfoTemplate:SetTemplate(data, hasName)
    if data == nil then
        return
    end
    self:RefreshView(data, hasName)
end

--endregion

--region View

function UISLequip_InfoTemplate:RefreshView(data, hasName)
    if hasName then
        self.name.text  = data.name
        self.curAttr.text = data.addStr
    else
        self.nextAttr.text = "[878787]" .. data.nextStr
    end

end

--endregion

--region 获取table


--endregion

--region ondestroy

function UISLequip_InfoTemplate:onDestroy()

end

--endregion

return UISLequip_InfoTemplate