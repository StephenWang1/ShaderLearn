local UIRefreshTemplate = {}
---控制显示
---@param obj UnityEngine.GameObject
function UIRefreshTemplate:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
---@param obj Top_UISprite
---@param spriteName string
function UIRefreshTemplate:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
---@param obj Top_UILabel
---@param text string
---@param color UnityEngine.Color
function UIRefreshTemplate:RefreshLabel(obj, text, color)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UILabel)) then
            obj.text = text
            if color ~= nil and CS.StaticUtility.IsNull(color) == false then
                obj.color = color
            end
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
                if color ~= nil and CS.Utility_Lua.IsTypeEqual(color:GetType(), typeof(CS.UnityEngine.Color)) then
                    obj.color = color
                end
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---刷新尺寸
---@param obj UnityEngine.GameObject
---@param vector2 UnityEngine.Vector2
function UIRefreshTemplate:RefreshSize(obj, vector2)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UIWidget)) then
            obj:SetDimensions(vector2.x, vector2.y)
        else
            local curUIWidget = self:GetCurComp(obj, "", "UIWidget")
            if curUIWidget ~= nil then
                curUIWidget:SetDimensions(vector2.x, vector2.y)
            end
        end
    end
end

---刷新列表
---@param obj Top_UIGridContainer
---@param table table 列表
---@param action function 刷新方法
function UIRefreshTemplate:RefreshGridContainer(obj, table, action)
    if CS.StaticUtility.IsNull(obj) == true or table == nil or type(table) ~= 'table' or action == nil then
        return
    end
    local gridContainer = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UIGridContainer)) == false then
        gridContainer = self:GetCurComp(obj, "", "Top_UIGridContainer")
    end
    if CS.StaticUtility.IsNull(gridContainer) == false then
        gridContainer.MaxCount = #table
        local length = gridContainer.MaxCount
        for k = 0, length - 1 do
            local grid = gridContainer.controlList[k]
            local info = table[k + 1]
            action(grid, info)
        end
    end
end

---刷新列表（uiScrollViewPlus）
---@param obj UILoopScrollViewPlus
---@param table table 列表
---@param singleGridRefreshFunc function<UnityEngine.GameObject,number,table[i]> 刷新方法<go,line,对应table内的数据>
---@param topLineRefresh function<number> 顶部刷新方法<line>
---@param refreshNum number 刷新数量
function UIRefreshTemplate:RefreshLoopScrollViewPlus(obj, table, singleGridRefreshFunc, topLineRefresh, refreshNum)
    if CS.StaticUtility.IsNull(obj) == true or table == nil or type(table) ~= 'table' or singleGridRefreshFunc == nil then
        return
    end
    local loopScrollViewPlus = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UILoopScrollViewPlus)) == false then
        loopScrollViewPlus = self:GetCurComp(obj, "", "UILoopScrollViewPlus")
    end
    if CS.StaticUtility.IsNull(loopScrollViewPlus) == false then
        loopScrollViewPlus:Init(function(go, line)
            ---从1开始
            local curLine = line + 1
            if refreshNum ~= nil and curLine > refreshNum then
                return false
            end
            if curLine > #table then
                return false
            end
            local info = table[curLine]
            singleGridRefreshFunc(go, curLine, info)
            return true
        end, function(line)
            if topLineRefresh ~= nil then
                topLineRefresh(line)
            end
        end)
    end
end

---刷新当前显示的列表
---@param obj UILoopScrollViewPlus
function UIRefreshTemplate:RefreshLoopScrollViewPlusCurPage(obj)
    if CS.StaticUtility.IsNull(obj) == true then
        return
    end
    local loopScrollViewPlus = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UILoopScrollViewPlus)) == false then
        loopScrollViewPlus = self:GetCurComp(obj, "", "UILoopScrollViewPlus")
    end
    if CS.StaticUtility.IsNull(loopScrollViewPlus) == false then
        loopScrollViewPlus:RefreshCurrentPage()
    end
end

---绑定点击事件
---@param obj UnityEngine.GameObject
---@param action function
function UIRefreshTemplate:BindClickCallBack(obj, action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end

---启动刷新
---@param action function
function UIRefreshTemplate:RefreshUpdate(action)
    self:RemoveUpdate()
    if action == nil then
        return
    end
    self.initListUpdate = CS.CSListUpdateMgr.Add(200, nil, action, true)
end

---移除刷新
function UIRefreshTemplate:RemoveUpdate()
    if self.initListUpdate ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.initListUpdate)
        self.initListUpdate = nil
    end
end

---手动调用自适应
---@param obj UIWidget
function UIRefreshTemplate:UpdateAnchors(obj)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UIWidget)) then
            obj:UpdateAnchors()
        else
            local curUIWidget = self:GetCurComp(obj, "", "UIWidget")
            if curUIWidget ~= nil then
                curUIWidget:UpdateAnchors()
            end
        end
    end
end

function UIRefreshTemplate:onDestroy()
    self:RemoveUpdate()
end
return UIRefreshTemplate