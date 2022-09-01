---@class UIGhostShipTemplate :TemplateBase 副本传送单元模板
local UIGhostShipTemplate = {}

--region 初始化

function UIGhostShipTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end

function UIGhostShipTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.name = self:Get("TitleName", "Top_UILabel")
    ---@type Top_UILabel 限制
    self.conditionStr = self:Get("condition", "Top_UILabel")
    ---@type Top_UISprite 背景
    self.bg = self:Get("background", "Top_UISprite")
end

function UIGhostShipTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go.gameObject).onClick = function(go)
        self:OnClickedSelf()
    end
end

--endregion

--region Show

---@param data
---@field data TABLE.CFG_DUPLICATE
function UIGhostShipTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.data = data
    self:RefreshView(data)
end

--endregion

--region View

function UIGhostShipTemplate:RefreshView(data)
    local canGo = self:CheckCanGo()
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

function UIGhostShipTemplate:OnClickedSelf()
    local canGo = self:CheckCanGo()
    if canGo then
        if self:GetUnionState() then
            if self:GetReinState() then
                uimanager:ClosePanel("UIGhostShipPanel")
                Utility.TryTransfer(self.data.id)
            end
        end
    else
        local str = "幽灵船尚未入港"
        Utility.ShowPopoTips(self.go.gameObject, str, 1)
    end
end

--endregion

--region 进入条件

function UIGhostShipTemplate:CheckCanGo()
    local state = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetState()
    return state
end

function UIGhostShipTemplate:GetUnionState()
    if CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0 then
        local str = "请先加入一个行会"
        Utility.ShowPopoTips(self.go.gameObject, str, 1)
        return false
    else
        return true
    end
end

function UIGhostShipTemplate:GetReinState()
    local condition = self:GetCondition(self.data)
    if condition[1].success == false then
        local str = "转生等级不足"
        Utility.ShowPopoTips(self.go.gameObject, str, 1)
        return false
    else
        return true
    end
end


--endregion

--region 获取条件

function UIGhostShipTemplate:GetCondition(data)
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


return UIGhostShipTemplate