---@class UISLequip_LevelTemplate :TemplateBase 副本传送单元模板
local UISLequip_LevelTemplate = {}

--region 初始化

function UISLequip_LevelTemplate:Init()
    self:InitComponents()
end

function UISLequip_LevelTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("curLevelAttribute/AttributeName", "Top_UILabel")
    ---@type Top_UILabel 名称
    self.curAttr = self:Get("curLevelAttribute/AttributeValue", "Top_UILabel")
    ---@type Top_UILabel 名称
    self.NextAttr = self:Get("nextLevelAttribute/AttributeValue", "Top_UILabel")
    ---@type UnityEngine.GameObject 名称
    self.Max = self:Get("nextLevelAttribute/levelmax", "GameObject")
end

--endregion

--region Show

---@param data
function UISLequip_LevelTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self:RefreshView(data)
end

--endregion

--region View

function UISLequip_LevelTemplate:RefreshView(data)
    self.name.text  = data.name
    self.curAttr.text = data.addStr
    if data.nextStr ~= nil then
        self.NextAttr.text = data.nextStr
        self.Max:SetActive(false)
        self.NextAttr.gameObject:SetActive(true)
    else
        self.Max:SetActive(true)
        self.NextAttr.gameObject:SetActive(false)
    end
end

--endregion

--region 获取table


--endregion

--region ondestroy

function UISLequip_LevelTemplate:onDestroy()

end

--endregion

return UISLequip_LevelTemplate