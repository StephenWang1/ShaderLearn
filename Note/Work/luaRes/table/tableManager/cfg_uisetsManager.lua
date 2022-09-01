---@class cfg_uisetsManager:TableManager
local cfg_uisetsManager = {}

---@private
cfg_uisetsManager.LayerToInt = {
    ---预设无设置, 走代码
    None = -50,
    Back = -30,
    ---1.该层所摆放的游戏UI内容，包括按钮，信息，图片，活动图标等（除TIPS）以及相关的界面特效，都必须是玩家进入游戏中，不做任何操作，就可以看到UI信息
    BasicPlane = 0,
    ---2.该层所摆放的游戏UI内容，系统公告以及自动寻路，自动战斗，小飞鞋按钮等，玩家将角色托管给系统操作时，给予一些辅助性UI文字提示或者按钮以及各类气泡提示框
    AisstPlane = 50,
    ---3.该层摆放游戏内界面内容，主要是各个功能界面以及对应的二级，三级界面。该层内TIPS信息，界面特效出现较多，统一按照补充说明内第2条处理
    WindowsPlane = 200,
    ---4.该层摆放的是需要遮住其余Windows层界面, 且需要显示Tips层的界面
    TopWindowsPlane = 700,
    ---5.点击无法操作时的警示条
    TipsPlane = 800,
    ---6.提示的顶层, 该层的提示需要在其他提示上方, 但低于新手引导层
    TopTipsPlane = 950,
    ---7.该层所摆放的游戏UI为新手引导的UI，包括UI遮罩，指向标，提示UI呼吸框等等，只能是和新手引导有关的UI
    GuidePlane = 1000,
    ---8.该层所摆放的是，游戏中转换场景时所需要的UI美术资源和图片资源
    ChgsenPlane = 1800,
    ---9.该层只有在玩家客户端无法通信，断线时才会出现，弹窗信息/动画/UI提示
    ConnectPlane = 2000,
    ---10.登录界面所有UI信息
    TopPlane = 2100,
    ---11.点击反馈特效
    Hint = 2200,
}
cfg_uisetsManager.LayerToInt.__index = cfg_uisetsManager.LayerToInt

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_uisets
function cfg_uisetsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_uisets> 遍历方法
function cfg_uisetsManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_uisetsManager:PostProcess()
    for i, v in pairs(self.dic) do
        self:SetDepth(v)
    end
end

---@private
---@param uisets TABLE.cfg_uisets
function cfg_uisetsManager:SetDepth(uisets)
    if uisets.depth == nil then
        uisets.depth = {}
        uisets.depth.list = {}
    end
    local layerNameList = uisets:GetLayerNameList()
    if layerNameList ~= nil and layerNameList.list then
        for i = 1, #layerNameList.list do
            local layerName = layerNameList.list[i]
            if layerName ~= nil and layerName ~= "" and self.LayerToInt[layerName] ~= nil then
                table.insert(uisets.depth.list, self.LayerToInt[layerName])
            end
        end
    end
end

---是否在集合中
---@param id number
---@param panelName string
---@param layerTypeInt number UILayerType的int值
function cfg_uisetsManager:IsContainedInUISets(id, panelName, layerTypeInt)
    if id == nil then
        return false
    end
    local tbl = self:TryGetValue(id)
    if tbl then
        if tbl:GetPanelNameList() ~= nil and tbl:GetPanelNameList().list ~= nil then
            for i = 1, #tbl:GetPanelNameList().list do
                if tbl:GetPanelNameList().list[i] == panelName then
                    return true
                end
            end
        end
        if tbl:GetDepth() ~= nil and tbl:GetDepth().list ~= nil then
            for i = 1, #tbl:GetDepth().list do
                if tbl:GetDepth().list[i] == layerTypeInt then
                    return true
                end
            end
        end
    end
    return false
end

return cfg_uisetsManager