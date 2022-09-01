---@class UIBossDuplicateTemplate :TemplateBase 副本传送单元模板
local UIBossDuplicateTemplate = {}

--region 初始化

function UIBossDuplicateTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end

function UIBossDuplicateTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("check/TitleName", "Top_UILabel")
    ---@type Top_UILabel 限制
    self.conditionStr = self:Get("condition", "Top_UILabel")
    ---@type Top_UISprite 背景
    self.bg = self:Get("check", "Top_UISprite")
end

function UIBossDuplicateTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go.gameObject).onClick = function(go)
        self:OnClickedSelf()
    end
end

--endregion

--region Show

---@param data
---@field data TABLE.CFG_DUPLICATE
function UIBossDuplicateTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.data = data
    self:RefreshView(data)
end

--endregion

--region View

function UIBossDuplicateTemplate:RefreshView(data)
    local condition = self:GetCondition(data)
    self.name.text = condition.success and "[c3f4ff]"..data.name or luaEnumColorType.Gray .. data.name
    self.bg.spriteName = condition.success and "c3" or "c5"
    if condition.txt ~= nil then
        self.conditionStr.text = condition.success and luaEnumColorType.Green3..condition.txt or luaEnumColorType.Red..condition.txt
    end
end

function UIBossDuplicateTemplate:OnClickedSelf()
    local canGo = self:GetCondition(self.data)
    if canGo.success == true then
        uimanager:ClosePanel("UIBossDuplicatePanel")
        networkRequest.ReqEnterDuplicate(self.data.id)
    else
        local str = "传送条件不足"
        Utility.ShowPopoTips(self.go.gameObject, str, 1)
    end
end

--endregion

--region 获取条件

function UIBossDuplicateTemplate:GetCondition(data)
    local isOpen = {}
    if data.condition == 0 or data.condition == nil then
        isOpen.success = true
        return isOpen
    end
    isOpen = Utility.IsMainPlayerMatchCondition_LuaAndCS(data.condition)
    return isOpen
end

--endregion

return UIBossDuplicateTemplate