---@class UIBuffTipsPanel
local UIBuffTipsPanel = {}

--region 局部变量
---@type UIBuffInfoTemplate
UIBuffTipsPanel.buffInfoTemplat = nil
UIBuffTipsPanel.RefreshTimeIenumerator = nil
UIBuffTipsPanel.showPlayerType = -1
UIBuffTipsPanel.taregetLid = 0
--endregion

--region 初始化

function UIBuffTipsPanel:Init()
    self:InitComponents()
    self:AddCollider()
    UIBuffTipsPanel.BindUIEvents()
    UIBuffTipsPanel.BindNetMessage()
end

function UIBuffTipsPanel:Show(targetLid)
    UIBuffTipsPanel.taregetLid = targetLid
end

--- 初始化组件
function UIBuffTipsPanel:InitComponents()
    ---@type UnityEngine.GameObject 模板父物体
    UIBuffTipsPanel.mainpart = self:GetCurComp("WidgetRoot/mainpart", "GameObject")
    ---@type UnityEngine.GameObject
    UIBuffTipsPanel.box = self:GetCurComp("WidgetRoot/mainpart/box", "GameObject")
end

function UIBuffTipsPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIBuffTipsPanel.box).onClick = function()
        uimanager:ClosePanel('UIBuffTipsPanel')
    end
end

function UIBuffTipsPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听

--endregion


--region 网络消息处理

--endregion

--region UI

---@param allBuffDic table<number,CustomBuffInfo>
function UIBuffTipsPanel.ShowBuff(allBuffDic, index)
    UIBuffTipsPanel.InitTipsPos(index)
    if UIBuffTipsPanel.buffInfoTemplat == nil then
        UIBuffTipsPanel.buffInfoTemplat = templatemanager.GetNewTemplate(UIBuffTipsPanel.mainpart, luaComponentTemplates.UIHeadPanel_BuffInfo)
    end
    if allBuffDic ~= nil and #allBuffDic ~= 0 then
        UIBuffTipsPanel.buffInfoTemplat:Show(allBuffDic, UIBuffTipsPanel.taregetLid)
    end
end

--endregion

--region otherFunction


function UIBuffTipsPanel.StartRefreshTime()
    UIBuffTipsPanel.RefreshTime()
end

function UIBuffTipsPanel.StopRefreshTime()
    if UIBuffTipsPanel.RefreshTimeIenumerator ~= nil then
        StopCoroutine(UIBuffTipsPanel.RefreshTimeIenumerator)
        UIBuffTipsPanel.RefreshTimeIenumerator = nil
    end
end

function UIBuffTipsPanel.RefreshTime()
    if UIBuffTipsPanel.RefreshTimeIenumerator ~= nil then
        StopCoroutine(UIBuffTipsPanel.RefreshTimeIenumerator)
    end
    UIBuffTipsPanel.RefreshTimeIenumerator = StartCoroutine(function()
        while true do
            if UIBuffTipsPanel.buffInfoTemplat == nil then
                StopCoroutine(UIBuffTipsPanel.RefreshTimeIenumerator)
            else
                UIBuffTipsPanel.buffInfoTemplat:RefreshTime()
            end
            coroutine.yield(0.5)
        end
    end)
end

function UIBuffTipsPanel.InitTipsPos(index)
    UIBuffTipsPanel.showPlayerType = index
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20343)
    if not isFind then
        return
    end
    local str = info.value
    local vector3List = string.Split(str, '&')
    if vector3List[index] == nil then
        return
    end
    local vector3List = string.Split(vector3List[index], '#')
    local x = tonumber(vector3List[1]) - 1000
    local y = tonumber(vector3List[2]) - 1000
    if UIBuffTipsPanel.mainpart ~= nil then
        UIBuffTipsPanel.mainpart.transform.localPosition = CS.UnityEngine.Vector3(x, y, 0)
    end
end
--endregion

--region ondestroy

function ondestroy()
    if UIBuffTipsPanel.RefreshTimeIenumerator ~= nil then
        StopCoroutine(UIBuffTipsPanel.RefreshTimeIenumerator)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIBuffTipsPanel