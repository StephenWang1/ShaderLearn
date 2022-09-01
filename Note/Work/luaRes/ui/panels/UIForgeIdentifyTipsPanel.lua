---@class UIForgeIdentifyTipsPanel:UIBase 切割详情
local UIForgeIdentifyTipsPanel = {}

--region 组件
---@return UnityEngine.GameObject
function UIForgeIdentifyTipsPanel:GetGridContainer()
    if (self.mGetGridContainer == nil) then
        self.mGetGridContainer = self:GetCurComp("WidgetRoot/view/Describe/grid", "Top_UIGridContainer");
    end
    return self.mGetGridContainer
end

---@return UISprite
function UIForgeIdentifyTipsPanel:GetBackground()
    if (self.mGetBackground == nil) then
        self.mGetBackground = self:GetCurComp("WidgetRoot/window/background", "UISprite");
    end
    return self.mGetBackground
end
--endregion

--region 初始化
function UIForgeIdentifyTipsPanel:Init()
    self:AddCollider()
end

function UIForgeIdentifyTipsPanel:Show(itemId)
    if itemId then
        self:GridShow(itemId)
    else
        uimanager:ClosePanel(self)
    end
end
--endregion

--region 界面显示
function UIForgeIdentifyTipsPanel:GridShow(itemId)
    self:GetGridContainer().MaxCount = 1
    local attrList = self:GetItemInfo(itemId)
    local desText = self:GetGlobalTable(22997)
    local go = self:GetGridContainer().controlList[0]
    local des = self:GetComp(go.transform,"desText",'UILabel')
    local destName = string.CSFormat(desText.value, attrList[1], attrList[2], attrList[3], attrList[4], attrList[5], attrList[6], attrList[7], attrList[8], attrList[9], attrList[10])
    local name = string.gsub(destName,'\\n', '\n')
    des.text = name
    self:GetBackground().height = self:GetBackground().height + des.height - 70
end
--endregion

--region 获取装备属性
function UIForgeIdentifyTipsPanel:GetItemInfo(itemId)
    local itemInfo = self:GetJianDingTable(itemId)
    local tempList = {}
    table.insert(tempList,itemInfo:GetAttribute1().list[1])
    table.insert(tempList,itemInfo:GetAttribute1().list[2])
    table.insert(tempList,itemInfo:GetAttribute2().list[1])
    table.insert(tempList,itemInfo:GetAttribute2().list[2])
    table.insert(tempList,itemInfo:GetAttribute3().list[1])
    table.insert(tempList,itemInfo:GetAttribute3().list[2])
    table.insert(tempList,itemInfo:GetAttribute4().list[1])
    table.insert(tempList,itemInfo:GetAttribute4().list[2])
    table.insert(tempList,itemInfo:GetAttribute5().list[1])
    table.insert(tempList,itemInfo:GetAttribute5().list[2])
    return tempList
end
--endregion

--region 获取table
function UIForgeIdentifyTipsPanel:GetGlobalTable(id)
    if id ~= nil then
        local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
        return Lua_GlobalTABLE
    end
end

function UIForgeIdentifyTipsPanel:GetJianDingTable(itemId)
    local Lua_jianDingCost = clientTableManager.cfg_jiandingManager:TryGetValue(itemId)
    return Lua_jianDingCost
end
--endregion

return UIForgeIdentifyTipsPanel