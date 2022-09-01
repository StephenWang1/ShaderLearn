---@class UISLequip_ClassTemplate :TemplateBase 副本传送单元模板
local UISLequip_ClassTemplate = {}

--region 初始化

function UISLequip_ClassTemplate:Init()
    self:InitComponents()
end

function UISLequip_ClassTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("curLevelAttribute/AttributeName", "Top_UILabel")
end

--endregion

--region Show

---@param data
---@field data TABLE.CFG_DUPLICATE
function UISLequip_ClassTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self:RefreshView(data)
end

--endregion

--region View

function UISLequip_ClassTemplate:RefreshView(data)
    local des = string.Split(data, "#")
    self.name.text  = des[1] .. "[00ff00]" .. des[2]
end

--endregion

--region 获取table


--endregion

--region ondestroy

function UISLequip_ClassTemplate:onDestroy()

end

--endregion

return UISLequip_ClassTemplate