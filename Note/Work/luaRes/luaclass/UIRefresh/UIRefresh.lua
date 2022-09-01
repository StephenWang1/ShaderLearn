---@class UIRefresh 静态UI刷新功能类
local UIRefresh = {}
---控制显示
---@param obj UnityEngine.GameObject
function UIRefresh:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
---@param obj Top_UISprite
---@param spriteName string
---@param color UnityEngine.Color
---@param showOriginSpriteSize boolean
function UIRefresh:RefreshSprite(obj, spriteName,color,showOriginSpriteSize)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
            if color ~= nil then
                obj.color = color
            end
            if showOriginSpriteSize == true then
                obj:MakePixelPerfect()
            end
        else
            ---@type UISprite
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
                if color ~= nil then
                    curSprite.color = color
                end
                if showOriginSpriteSize == true then
                    curSprite:MakePixelPerfect()
                end
            end
        end
    end
end

---设置Label
---@param obj Top_UILabel
---@param text string
---@param color UnityEngine.Color
---@param spacingX number 文本横向间距
---@param spacingX number 文本纵向间距
function UIRefresh:RefreshLabel(obj, text, color,spacingX,spacingY)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if not CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UILabel)) then
            obj = self:GetCurComp(obj, "", "UILabel")
        end
        if obj ~= nil then
            if CS.StaticUtility.IsNullOrEmpty(text) == false then
                obj.text = text
            else
                obj.text = ""
            end
            if color ~= nil then
                obj.color = color
            end
            if spacingX ~= nil then
                obj.spacingX = spacingX
            end
            if spacingY ~= nil then
                obj.spacingY = spacingY
            end
        end
    end
end


---刷新Effect
---@param obj CSUIEffectLoad
---@param effectName string
---@param loadEffectFinish function
function UIRefresh:RefreshEffect(obj,effectName,loadEffectFinish)
    if CS.StaticUtility.IsNull(obj) == true or CS.StaticUtility.IsNullOrEmpty(effectName) then
        return
    end
    local uiEffectLoad = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.CSUIEffectLoad)) == false then
        uiEffectLoad = self:GetCurComp(obj, "", "CSUIEffectLoad")
    end
    if CS.StaticUtility.IsNull(uiEffectLoad) == false then
        uiEffectLoad:ChangeEffectAndFinishCallBack(effectName,loadEffectFinish)
    end
end

---重置列表位置
---@param obj UIScrollView
function UIRefresh:UIScrollviewReposition(obj)
    if CS.StaticUtility.IsNull(obj) == true then
        return
    end
    local uiScrollView = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UIScrollView)) == false then
        uiScrollView = self:GetCurComp(obj, "", "UIScrollView")
    end
    if CS.StaticUtility.IsNull(uiScrollView) == false then
        uiScrollView:ResetPosition()
    end
end

---刷新UITable
---@param obj Top_UITable
function UIRefresh:RefreshUITable(obj)
    if CS.StaticUtility.IsNull(obj) == true then
        return
    end
    local uiTable = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UITable)) == false then
        uiTable = self:GetCurComp(obj, "", "UITable")
    end
    if CS.StaticUtility.IsNull(uiTable) == false then
        uiTable:Reposition()
    end
end

---播放Tween
---@param obj UITweener
---@param frontPlay boolean
function UIRefresh:PlayTween(obj,frontPlay)
    if CS.StaticUtility.IsNull(obj) == true then
        return
    end
    local uiTweener = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UITweener)) == false then
        uiTweener = self:GetCurComp(obj, "", "UITweener")
    end
    if CS.StaticUtility.IsNull(uiTweener) == false then
        uiTweener:Play(frontPlay)
    end
end

---刷新尺寸
---@param obj UnityEngine.GameObject
---@param vector2 UnityEngine.Vector2
function UIRefresh:RefreshSize(obj, vector2)
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
---@param orderLyRefresh boolean 是否有序刷新（有序刷新从1开始有序刷新）
function UIRefresh:RefreshGridContainer(obj, table, action,orderLyRefresh)
    if CS.StaticUtility.IsNull(obj) == true or table == nil or type(table) ~= 'table' or action == nil then
        return
    end
    local gridContainer = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UIGridContainer)) == false then
        gridContainer = self:GetCurComp(obj, "", "Top_UIGridContainer")
    end
    if CS.StaticUtility.IsNull(gridContainer) == false then
        gridContainer.MaxCount = Utility.GetLuaTableCount(table)
        if orderLyRefresh == true then
            for k = 0,gridContainer.MaxCount - 1 do
                local grid = gridContainer.controlList[k]
                local info = table[k + 1]
                action(grid, info)
            end
        else
            local index = 0
            for k,v in pairs(table) do
                local grid = gridContainer.controlList[index]
                local info = v
                action(grid, info)
                index = index + 1
            end
        end
    end
end

---刷新列表（uiScrollViewPlus）
---@param obj UILoopScrollViewPlus
---@param table table 列表
---@param singleGridRefreshFunc function<UnityEngine.GameObject,number,table[i]> 刷新方法<go,line,对应table内的数据>
---@param topLineRefresh function<number> 顶部刷新方法<line>
---@param refreshNum number 刷新数量
function UIRefresh:RefreshLoopScrollViewPlus(obj, table, singleGridRefreshFunc, topLineRefresh, refreshNum)
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
function UIRefresh:RefreshLoopScrollViewPlusCurPage(obj)
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
function UIRefresh:BindClickCallBack(obj, action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end

---绑定Toggle点击事件
---@param obj UIToggle
---@param action function
---@param groupId number
---@param startActive boolean
function UIRefresh:BindToggle(obj,action,groupId,startActive)
    if CS.StaticUtility.IsNull(obj) == true then
        return
    end
    local uiToggle = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.UIToggle)) == false then
        uiToggle = self:GetCurComp(obj, "", "UIToggle")
    end
    if CS.StaticUtility.IsNull(uiToggle) == false then
        if type(groupId) == 'number' then
            uiToggle.group = groupId
        end
        if type(startActive) == 'boolean' then
            uiToggle.startsActive = startActive
        end
        CS.EventDelegate.Add(uiToggle.onChange, function()
            if action ~= nil then
                action(uiToggle.value)
            end
        end)
    end
end


---手动调用自适应
---@param obj UIWidget
function UIRefresh:UpdateAnchors(obj)
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

---设置slider进度
---@param go UISlider
---@param progress number 浮点
function UIRefresh:SetSliderProgress(go,progress)
    if CS.StaticUtility.IsNull(go) == true or type(progress) ~= 'number' then
        return
    end
    local uiSlider = go
    if CS.Utility_Lua.IsTypeEqual(go:GetType(), typeof(CS.UISlider)) == false then
        uiSlider = self:GetCurComp(go, "", "UISlider")
    end
    if CS.StaticUtility.IsNull(uiSlider) == false then
        uiSlider.sliderValue = progress
    end
end

---根据路径获取模板的物体下组件或Transform,GameObject
---@protected
---@param go UnityEngine.GameObject 父节点
---@param path string 相对路径
---@param typeStr string 组件类型字符串
function UIRefresh:GetCurComp(go, path, typeStr)
    if CS.StaticUtility.IsNull(go) or path == nil or typeStr == nil then
        return nil
    end
    return CS.Utility_Lua.Get(go.transform, path, typeStr)
end

---绑定红点
---@param go UIRedPoint
---@param key string
function UIRefresh:AddRedPointKey(go,key)
    if CS.StaticUtility.IsNull(go) == true or CS.StaticUtility.IsNullOrEmpty(key) == true then
        return
    end
    local uiRedPoint = go
    if CS.Utility_Lua.IsTypeEqual(go:GetType(), typeof(CS.UIRedPoint)) == false then
        uiRedPoint = self:GetCurComp(go, "", "UIRedPoint")
    end
    if CS.StaticUtility.IsNull(uiRedPoint) == false then
        key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
        uiRedPoint:AddRedPointKey(key)
    end
end

---设置网络加载图片
---@param go PictureLoader
---@param url string
---@param useOriginSize boolean 是否显示原始图片尺寸
function UIRefresh:RefreshWWWTexture(go, url, useOriginSize)
    if CS.StaticUtility.IsNull(go) == true or type(url) ~= 'string' then
        return
    end
    local pictureLoader = go
    if CS.Utility_Lua.IsTypeEqual(go:GetType(), typeof(CS.PictureLoader)) == false then
        pictureLoader = self:GetCurComp(go, "", "PictureLoader")
    end
    local curUseOriginSize = useOriginSize
    if curUseOriginSize == nil then
        curUseOriginSize = false
    end
    if CS.StaticUtility.IsNull(pictureLoader) == false then
        CS.CSListUpdateMgr.Add(200, nil, function()
            pictureLoader:LoadWWWSprite(url,curUseOriginSize)
        end)
    end
end

return UIRefresh