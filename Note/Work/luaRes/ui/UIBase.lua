---@class UIBase
local UIBase = {}

UIBase.__index = UIBase
UIBase.__gc = uimanager.OnTableGCed

---@type table 运行基类时对每层基类的调用进行计数,以确定元表的调用次数
UIBase.__RunBaseCountDic = {}
---@type boolean 初始化时是否需要保持Active为true
UIBase.IsNeedActiveDuringInitialize = false
---@type string 界面名
UIBase._PanelName = nil
---@type UI界面状态 界面状态
UIBase._PanelState = LuaEnumUIState.NotYetInitialized;
---@type table 关联界面
UIBase._RelationPanels = {};
---@type boolean 界面是否在隐藏状态
UIBase.IsHiden = false
---@type UnityEngine.GameObject UI界面对应的根游戏物体
UIBase.go = nil
---@type boolean 界面是否正在初始化
UIBase.IsInitializing = true
---@type LuaEnumPanelOpenSourceType 界面打开来源类型
UIBase.mPanelOpenSourceType = nil

---界面层级类型
---@type UILayerType
UIBase.PanelLayerType = CS.UILayerType.WindowsPlane

UIBase.IsInitialLoad = false
---获取界面层级类型
---@return UILayerType
function UIBase:Get_PanelLayerType()
    return self.PanelLayerType
end

---是否需要播放开启音效
---@return boolean
function UIBase:IsNeedPlayOpenAudio()
    if self.PanelLayerType == CS.UILayerType.BasicPlane then
        return false
    end
    if self.IsInitialLoad then
        self.IsInitialLoad = false
        return false
    end
    return true
end

---是否需要播放关闭音效
---@return boolean
function UIBase:IsNeedPlayCloseAudio()
    if self.PanelLayerType == CS.UILayerType.BasicPlane then
        return false
    end
    return true
end

---获取面板的客户端消息Handler
---@return EventHandlerManager
function UIBase:GetClientEventHandler()
    if self == nil then
        return
    end
    if self.mClient == nil then
        self.mClient = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)--客户端事件
    end
    return self.mClient
end

---获取面板的服务器消息Handler
---@return EventHandlerManager
function UIBase:GetSocketEventHandler()
    if self == nil then
        return
    end
    if self.mSocket == nil then
        self.mSocket = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Socket)--服务器消息发送
    end
    return self.mSocket
end

---获取一个Lua事件管理器
---@return LuaEventHandler
function UIBase:GetLuaEventHandler()
    if self.mLuaEventHandler == nil then
        self.mLuaEventHandler = eventHandler.CreateNew()
        if self._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
            ---如果,本界面已经被销毁了,则将事件管理器的已释放标识置为true,以避免绑定了事件后发生事件没有事件进行解绑的情况
            self.mLuaEventHandler.mIsReleased = true
        end
    end
    return self.mLuaEventHandler
end

---释放Lua事件管理器
function UIBase:ReleaseLuaEventHandler()
    if self.mLuaEventHandler ~= nil then
        self.mLuaEventHandler:ReleaseAll()
        ---此处不销毁,是为了防止在界面被销毁后,依然有别的地方保留了该界面的引用,
        ---导致其调用GetLuaEventHandler方法时又创建了一个LuaEventHandler,从而导致绑定的事件没有解绑的问题出现
        ---此处mIsReleased置为true也是为了保证界面被销毁后不管是绑定还是移除事件都无效
        self.mLuaEventHandler.mIsReleased = true
    end
end

---释放面板的客户端消息Handler
---@return EventHandlerManager
function UIBase:ReleaseClientEventHandler()
    if self == nil then
        return
    end
    if self.mClient ~= nil then
        self.mClient:UnRegAll()
        self.mClient = nil
    end
end

---释放面板的服务器消息Handler
---@return EventHandlerManager
function UIBase:ReleaseSocketEventHandler()
    if self == nil then
        return
    end
    if self.mSocket ~= nil then
        self.mSocket:UnRegAll()
        self.mSocket = nil
    end
end

---获得界面上的UILinkCollector组件
---@return UILinkerCollector
function UIBase:GetUILinkCollector()
    if self.mUILinkCollector == nil then
        self.mUILinkCollector = CS.Utility_Lua.GetComponent(self.go, "UILinkerCollector")
    end
    return self.mUILinkCollector
end

---刷新界面的所有UILinker(调用的是默认延迟刷新)
function UIBase:RefreshLinks()
    if self:GetUILinkCollector() and CS.StaticUtility.IsNull(self:GetUILinkCollector()) == false then
        self:GetUILinkCollector():Refresh()
    end
end

---刷新界面的所有UILinker(调用的是立即刷新)
function UIBase:RefreshLinksImmediately()
    if self:GetUILinkCollector() and CS.StaticUtility.IsNull(self:GetUILinkCollector()) == false then
        self:GetUILinkCollector():RefreshImmediately()
    end
end

---获取组件
---@param trans UnityEngine.Transform 组件的Transform根节点
---@param path string 组件的相对路径
---@param type string 组建的C#类型
---@return UnityEngine.Component
function UIBase:GetComp(trans, path, type)
    if (trans == nil) then
        return nil
    end
    trans = trans:Find(path)
    if (trans == nil) then
        return nil;
    end
    if (type == 'GameObject') then
        return trans.gameObject
    elseif (type == 'Transform') then
        return trans
    end
    return CS.Utility_Lua.GetComponent(trans, type)
end

---获取组件
---@param path string 组件的相对路径
---@param type string 组建的C#类型
---@return UnityEngine.Component
function UIBase:GetCurComp(path, type)
    if self.go and CS.StaticUtility.IsNull(self.go) == false then
        return self:GetComp(self.go.transform, path, type)
    else
        return nil
    end
end

---UI界面初始化(待子类重写)
function UIBase:Init()
end

---UI界面显示(待子类重写)
function UIBase:Show()
end

---隐藏自己(SetActive(false),子类可重写)
function UIBase:HideSelf()
    if self._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
        return
    end
    self.go:SetActive(false)
end

---重新显示自己(SetActive(true),子类可重写)
function UIBase:ReShowSelf()
    if self._PanelState == LuaEnumUIState.IsGoingToBeDestroyed then
        return
    end
    self.go:SetActive(true)
end

---关联界面字典（有打开关闭逻辑相关和共存的界面）
function UIBase:AddRelationPanel(panelName)
    if (self._RelationPanels == nil) then
        self._RelationPanels = {};
    end
    self._RelationPanels[panelName] = panelName;
end

---获取关联面板
---@return table
function UIBase:GetRelationPanels()
    if (self._RelationPanels == nil) then
        self._RelationPanels = {};
    end
    return self._RelationPanels;
end

---在界面根节点上添加碰撞盒,并为其点击事件绑定关闭界面方法
function UIBase:AddCollider()
    local col = CS.Utility_Lua.GetComponent(self.go, 'BoxCollider')
    if (col == nil or CS.StaticUtility.IsNull(col)) then
        col = self.go:AddComponent(typeof(CS.UnityEngine.BoxCollider))
    end
    if (col ~= nil and CS.StaticUtility.IsNull(col) == false) then
        col.enabled = true
        col.center = CS.UnityEngine.Vector3(0, 0, 10)
        col.size = CS.UnityEngine.Vector3(2000, 2000, 0)
        CS.UIEventListener.Get(self.go).LuaEventTable = self
        CS.UIEventListener.Get(self.go).OnClickLuaDelegate = function(self, go)
            self:ClosePanel()
        end
    end
end

---移除碰撞盒,并移除点击事件绑定的方法
function UIBase:RemoveCollider()
    local col = CS.Utility_Lua.GetComponent(self.go, 'BoxCollider')
    if col ~= nil and CS.StaticUtility.IsNull(col) == false then
        col.enabled = false
    end
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = nil
end

---添加点击事件
---@param path string 点击的相对路径
---@param callback function 点击方法
---@param sound string 点击声音
function UIBase:AddClickEvent(path, callback, sound)
    if sound == nil or CS.System.String.IsNullOrEmpty(sound) then
        sound = "DefaultSound"
    end
    local click = CS.Utility_Lua.GetComponent(self.go.transform:Find(path), "UIButton")
    if click ~= nil then
        if callback == nil then
            return
        end
        local evt = CS.EventDelegate(callback)
        click.onClick:Add(evt)
    else
        if CS.CSDebug.developerConsoleVisible then
            CS.CSDebug.Log("button no find")
        end
    end
end

---获取面板深度
function UIBase:GetPanelDepth()
    local uiPanel = self:GetCurComp("", "UIPanel")
    if uiPanel ~= nil then
        return uiPanel.depth
    end
end

---关闭自身界面
function UIBase:ClosePanel()
    uimanager:ClosePanel(self._PanelName)
end

---界面释放事件
function UIBase:OnPanelReleased()

end

---被GC回收事件
function UIBase:OnDestruct()

end

---执行元表中的函数
---@param functionName string 元表中的函数名
function UIBase:RunBaseFunction(functionName, ...)
    if self ~= nil and functionName ~= nil then
        --调用函数时,在__RunBaseCountDic表中对传入的self对象的调用次数加一或初始化为一
        if Utility.IsContainsKey(UIBase.__RunBaseCountDic, self) == false then
            UIBase.__RunBaseCountDic[self] = {}
        end
        if Utility.IsContainsKey(UIBase.__RunBaseCountDic[self], functionName) == false then
            UIBase.__RunBaseCountDic[self][functionName] = 1
        else
            UIBase.__RunBaseCountDic[self][functionName] = UIBase.__RunBaseCountDic[self][functionName] + 1
        end
        --该函数中传入的self一般为面板模板自身
        local baseMetaTable = self
        --根据调用本函数的次数决定向上取多少次才能获取到上一级的元表,次数为1表示只需要取一次元表
        for i = 1, UIBase.__RunBaseCountDic[self][functionName] do
            if baseMetaTable ~= nil then
                baseMetaTable = getmetatable(baseMetaTable)
            else
                break
            end
        end
        --调用元表中的方法,并将返回值放入返回值表中
        local result
        if baseMetaTable ~= nil and baseMetaTable[functionName] ~= nil then
            if Utility.IsTruelyContainsKey(baseMetaTable, functionName) then
                --若元表本表中有该方法,则调用元表中的方法,并将返回值放入返回值表中
                result = { baseMetaTable[functionName](self, ...) }
            else
                --若元表本表中没有该方法,则再次递归本方法
                result = { self:RunBaseFunction(functionName, ...) }
            end
        end
        --将__RunBaseCountDic表中self对应的调用次数减一
        UIBase.__RunBaseCountDic[self][functionName] = UIBase.__RunBaseCountDic[self][functionName] - 1
        if UIBase.__RunBaseCountDic[self][functionName] == 0 then
            UIBase.__RunBaseCountDic[self][functionName] = nil
            if Utility.IsNullTable(UIBase.__RunBaseCountDic[self]) then
                UIBase.__RunBaseCountDic[self] = nil
            end
        end
        --将返回值表中的元素依次放入返回队列中
        if result ~= nil then
            return table.unpack(result)
        end
    end
end

--region 附件自适应
---获取当前面板背景图
function UIBase:GetBackGround_UISprite()

end

---附件自适应(默认情况下，适配节点是在面板的中心点，如果有偏差可以传入横向间距和纵向间距进行进行校正)
---如果需要用到改功能，对应面板下请重写GetBackGround_UISprite方法，用于获取面板的背景图
---该功能针对背景图进行适配
---@class AdjustAdaptionCustomData
---@field panel table 界面table
---@field adaptionType LuaEnumAdjustAdaptionType 自适应类型
---@field horizontalInterval number 横向间距
---@field verticalInterval number 纵向间距
---
---@param customData AdjustAdaptionCustomData
function UIBase:AdjustAdaption(customData)
    local panel = customData.panel
    if type(panel) ~= 'table' or CS.StaticUtility.IsNull(panel.go) == true or panel:GetBackGround_UISprite() == nil or self:GetBackGround_UISprite() == nil then
        return
    end
    ---附件相关参数
    local adjunctPanel_go = panel.go
    local adjunctPanelBackGroundSize = panel:GetBackGround_UISprite().localSize
    local adaptionType = ternary(customData.adaptionType == nil, LuaEnumAdjustAdaptionType.Right, customData.adaptionType)
    local horizontalInterval = ternary(customData.horizontalInterval == nil, 0, customData.horizontalInterval)
    local verticalInterval = ternary(customData.verticalInterval == nil, 0, customData.verticalInterval)
    ---主面板相关参数
    local PanelBackGroundSize = self:GetBackGround_UISprite().localSize
    ---偏移量计算
    local horizontalTotalInterval = adjunctPanelBackGroundSize.x * 0.5 + PanelBackGroundSize.x * 0.5
    local verticalTotalInterval = verticalInterval
    if adaptionType == LuaEnumAdjustAdaptionType.LeftDown or adaptionType == LuaEnumAdjustAdaptionType.LeftUp or adaptionType == LuaEnumAdjustAdaptionType.RightUp or adaptionType == LuaEnumAdjustAdaptionType.RightDown then
        verticalTotalInterval = math.abs(PanelBackGroundSize.y - adjunctPanelBackGroundSize.y) * 0.5
    end
    if adaptionType == LuaEnumAdjustAdaptionType.Left or adaptionType == LuaEnumAdjustAdaptionType.LeftDown or adaptionType == LuaEnumAdjustAdaptionType.LeftUp then
        horizontalTotalInterval = horizontalTotalInterval * -1
    end
    if adaptionType == LuaEnumAdjustAdaptionType.LeftUp or adaptionType == LuaEnumAdjustAdaptionType.RightUp then
        verticalTotalInterval = verticalTotalInterval * -1
    end
    ---偏移面板
    adjunctPanel_go.transform.position = self:GetBackGround_UISprite().transform.position
    local adjunctPanelLocalPosition = CS.UnityEngine.Vector3(adjunctPanel_go.transform.localPosition.x + horizontalTotalInterval + horizontalInterval, adjunctPanel_go.transform.localPosition.y + verticalTotalInterval + verticalInterval, adjunctPanel_go.transform.localPosition.z)
    adjunctPanel_go.transform.localPosition = adjunctPanelLocalPosition
end
--endregion

return UIBase