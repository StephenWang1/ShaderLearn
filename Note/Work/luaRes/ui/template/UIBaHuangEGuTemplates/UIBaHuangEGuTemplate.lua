---@class UIBaHuangEGuTemplate :TemplateBase 副本传送单元模板
local UIBaHuangEGuTemplate = {}

--region 初始化

function UIBaHuangEGuTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end

function UIBaHuangEGuTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("TitleName", "Top_UILabel")
    ---@type Top_UILabel 限制
    self.conditionStr = self:Get("condition", "Top_UILabel")
    ---@type Top_UISprite 背景
    self.bg = self:Get("background", "Top_UISprite")
end

function UIBaHuangEGuTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go.gameObject).onClick = function(go)
        self:OnClickedSelf()
    end
end

--endregion

--region Show

---@param data
---@field data TABLE.CFG_DUPLICATE
function UIBaHuangEGuTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.data = data
    self:RefreshView(data)
end

--endregion

--region View

function UIBaHuangEGuTemplate:RefreshView(data)
    local canGo = self:CheckCanGo(data)
    local condition = self:GetCondition(data)
    self.name.text = canGo and "[c3f4ff]"..data.showName or luaEnumColorType.Gray .. data.showName
    self.bg.spriteName = canGo and "c3" or "c5"
    local color = canGo and luaEnumColorType.Green3 or luaEnumColorType.Red
    if #condition == 2 then
        self.conditionStr.text = (condition[1].success and luaEnumColorType.Green3..condition[1].txt or luaEnumColorType.Red..condition[1].txt).."[-] 或 "..(condition[2].success and luaEnumColorType.Green3..condition[2].txt or luaEnumColorType.Red..condition[2].txt)
    elseif #condition == 1 then
        self.conditionStr.text = condition[1].success and luaEnumColorType.Green3..condition[1].txt or luaEnumColorType.Red..condition[1].txt
    end
end

function UIBaHuangEGuTemplate:OnClickedSelf()
    local canGo = self:CheckCanGo(self.data)
    if canGo then
        uimanager:ClosePanel("UIBaHuangEGuPanel")
        Utility.TryTransfer(self.data.id)
    else
        Utility.TryShowFirstRechargePanel()
    end
end

--endregion

--region 进入条件

function UIBaHuangEGuTemplate:CheckCanGo(data)
    if data.condition == nil then
        return true
    end
    local condition = self:GetCondition(data)
    for i = 1, #condition do
        if condition[i].success == true then
            return true
        end
    end
    return false
end

--endregion

--region 获取条件

function UIBaHuangEGuTemplate:GetCondition(data)
    if data.condition == nil then
        return true
    end
    local condition = {}
    for i = 0, data.condition.list.Count - 1 do
        local isOpen = Utility.IsMainPlayerMatchCondition_LuaAndCS(data.condition.list[i].list[0])
        table.insert(condition, isOpen)
    end
    return condition
end

--endregion

--region ondestroy

function UIBaHuangEGuTemplate:onDestroy()

end

--endregion

return UIBaHuangEGuTemplate