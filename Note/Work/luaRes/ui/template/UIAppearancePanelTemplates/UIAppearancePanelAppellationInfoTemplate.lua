---@class UIAppearancePanelAppellationInfoTemplate
local UIAppearancePanelAppellationInfoTemplate = {}

--region 初始化

function UIAppearancePanelAppellationInfoTemplate:Init()
    self:InitComponents()
end

function UIAppearancePanelAppellationInfoTemplate:InitComponents()
    ---@type Top_UILabel 标题
    self.CallName = self:Get("CallName", "Top_UILabel")
    ---@type Top_UILabel 内容
    self.CallDes = self:Get("CallDes", "Top_UILabel")
end


--endregion

--region UI
---{
---@field  data      table
---@param data.id    number  id
---@param data.param table
---@param data.text string
---}
function UIAppearancePanelAppellationInfoTemplate:SetTemplate(data)
    local isFind, info = CS.Cfg_AppellationTableManager.Instance.dic:TryGetValue(data.id)
    self.CallName.gameObject:SetActive(isFind)
    self.CallDes.gameObject:SetActive(isFind)
    if isFind then
        --self.CallName.text = info.name
        self.CallName.text = data.text
        local str = ''
        if info.type == LuaEnumAppellation.Union then
            local unionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo
            if unionInfo then
                str = unionInfo.unionName
            end
        elseif info.type == LuaEnumAppellation.Marrige then
            local loverInfo = CS.CSScene.MainPlayerInfo.MarryInfo.LoverInfo
            if loverInfo ~= nil then
                str = loverInfo.name
            end
        end
        self.CallDes.text = string.format(string.gsub(info.des, '\\n', '\n'), str)
    end
end

--endregion

return UIAppearancePanelAppellationInfoTemplate