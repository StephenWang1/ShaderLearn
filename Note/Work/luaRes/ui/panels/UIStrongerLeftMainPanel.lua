--- @class UIStrongerLeftMainPanel:UIBase
local UIStrongerLeftMainPanel = {}

--region 初始化

function UIStrongerLeftMainPanel:Init()
    self:InitComponents()
    UIStrongerLeftMainPanel.InitParameters()
    UIStrongerLeftMainPanel.BindUIEvents()
    UIStrongerLeftMainPanel.BindNetMessage()
    UIStrongerLeftMainPanel.BindRedPoint()
end

function UIStrongerLeftMainPanel:Show()
    UIStrongerLeftMainPanel.RefreshUI()
end

--- 初始化变量
function UIStrongerLeftMainPanel.InitParameters()
    UIStrongerLeftMainPanel.isShow = false
    UIStrongerLeftMainPanel.curInfo = nil
    UIStrongerLeftMainPanel.curShowState = true
end

--- 初始化组件
function UIStrongerLeftMainPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIStrongerLeftMainPanel.mainGo = self:GetCurComp("WidgetRoot/main", "GameObject")
    ---@type UnityEngine.GameObject
    UIStrongerLeftMainPanel.mainPackGo = self:GetCurComp("WidgetRoot/main/btn_lvPacks", "GameObject")
    ---@type UnityEngine.GameObject
    UIStrongerLeftMainPanel.bgGo = self:GetCurComp("WidgetRoot/main/bg", "GameObject")
    ---@type Top_UISprite icon
    UIStrongerLeftMainPanel.icon = self:GetCurComp("WidgetRoot/main/btn_lvPacks/spr_static", "Top_UISprite")
    ---@type Top_UILabel 标题
    UIStrongerLeftMainPanel.topTitle = self:GetCurComp("WidgetRoot/main/topTitle", "Top_UILabel")
    ---@type Top_UILabel 描述
    UIStrongerLeftMainPanel.des = self:GetCurComp("WidgetRoot/main/taskeAmount", "Top_UILabel")
    ---@type UnityEngine.GameObject
    UIStrongerLeftMainPanel.mEffectGo = self:GetCurComp("WidgetRoot/main/btn_lvPacks/effectParent", "GameObject")
    ---@type UIRedPoint
    UIStrongerLeftMainPanel.mEffectRedPoint = self:GetCurComp("WidgetRoot/main/btn_lvPacks/effectParent", "UIRedPoint")
end

function UIStrongerLeftMainPanel.BindUIEvents()
    CS.UIEventListener.Get(UIStrongerLeftMainPanel.mainPackGo).onClick = UIStrongerLeftMainPanel.OnClickMainPackGoCallBack
end

function UIStrongerLeftMainPanel.BindNetMessage()
    UIStrongerLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleSystemPreviewMessage, UIStrongerLeftMainPanel.onResSystemPreviewCallBack)
    UIStrongerLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.SystemOpenReminderMessage, UIStrongerLeftMainPanel.onResSystemOpenChangedCallBack)
    --UIStrongerLeftMainPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIStrongerLeftMainPanel.onMapChangeCallBack);
end

function UIStrongerLeftMainPanel.BindRedPoint()
    local systemPreview = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("SystemPreview");
    UIStrongerLeftMainPanel.mEffectRedPoint:AddRedPointKey(systemPreview)
end

--endregion

--region 函数监听
function UIStrongerLeftMainPanel.OnClickMainPackGoCallBack()
    uimanager:CreatePanel("UISystemOpenMainPanel", nil)
end
--endregion

--region 网络消息处理

---系统开启回调
function UIStrongerLeftMainPanel.onResSystemOpenChangedCallBack()
    if UIStrongerLeftMainPanel.curType == LuaEnumSystemPageType.System then
        return
    end
    UIStrongerLeftMainPanel.RefreshUI()
end

---系统预告刷新回调
function UIStrongerLeftMainPanel.onResSystemPreviewCallBack()
    if UIStrongerLeftMainPanel.curType == LuaEnumSystemPageType.Stronge then
        return
    end
    UIStrongerLeftMainPanel.RefreshUI()
end

---地图切换回调
function UIStrongerLeftMainPanel.onMapChangeCallBack()
    UIStrongerLeftMainPanel.RefreshUI()
end

--endregion

--region UI

function UIStrongerLeftMainPanel.RefreshUI()
    if UIStrongerLeftMainPanel.RefreshShowState() then
        UIStrongerLeftMainPanel.RefreshPackView()
    end
end

function UIStrongerLeftMainPanel.RefreshShowState()
    local isShow = UIStrongerLeftMainPanel.IsNeedShowInMainPanel()
    if isShow == UIStrongerLeftMainPanel.curShowState then
        return isShow
    end
    UIStrongerLeftMainPanel.curShowState = isShow
    if isShow then
        if UIStrongerLeftMainPanel.mainGo and not CS.StaticUtility.IsNull(UIStrongerLeftMainPanel.mainGo) then
            UIStrongerLeftMainPanel.mainGo:SetActive(true)
        end
        UIStrongerLeftMainPanel:ReShowSelf()
        return true
    else
        if UIStrongerLeftMainPanel.mainGo and not CS.StaticUtility.IsNull(UIStrongerLeftMainPanel.mainGo) then
            UIStrongerLeftMainPanel.mainGo:SetActive(false)
        end
        return false
    end

end

function UIStrongerLeftMainPanel.RefreshPackView()
    local info = UIStrongerLeftMainPanel.GetViewInfo()
    if info == nil then
        return
    end
    UIStrongerLeftMainPanel.curType = info.type
    UIStrongerLeftMainPanel.des.text = info.des
    UIStrongerLeftMainPanel.icon.spriteName = info.icon
    UIStrongerLeftMainPanel.topTitle.text = info.title
    if UIStrongerLeftMainPanel.bgGo and not CS.StaticUtility.IsNull(UIStrongerLeftMainPanel.bgGo) then
        UIStrongerLeftMainPanel.bgGo:SetActive(info.type ~= LuaEnumSystemPageType.Stronge)
    end
end

--endregion

--region otherFunction

function UIStrongerLeftMainPanel.GetViewInfo()
    local info = {}
    ---@type table<number,systemPreviewInfo>
    local systemTbl = gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr():GetSystemPerviewTbl()
    if #systemTbl > 0 then
        info.icon = systemTbl[1].systemTblData:GetIconName()
        info.title = systemTbl[1].systemTblData:GetTips()
        ---可在此处添加 奖励状态判断显示文本
        info.des = systemTbl[1].systemTblData:GetOpenTips()
        info.type = LuaEnumSystemPageType.System

    else
        info.icon = "Strengthen_icon"
        info.title = ""
        info.des = ""
        info.type = LuaEnumSystemPageType.Stronge
    end

    return info
end

---是否需要显示在主界面
---@private
---@return boolean
function UIStrongerLeftMainPanel.IsNeedShowInMainPanel()
    if gameMgr:GetPlayerDataMgr() == nil then
        return false
    end
    --if UIStrongerLeftMainPanel.IsNeedShowByCurMapId() then
    local systemTbl = gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr():GetSystemPerviewTbl()
    if #systemTbl == 0 and not Utility.CheckSystemOpenState(84) then
        return false
    end
    --end
    return true
end

---当前地图是否满足显示
function UIStrongerLeftMainPanel.IsNeedShowByCurMapId()
    local currentMainPlayerMapID = CS.CSScene.getMapID()
    if currentMainPlayerMapID == nil or currentMainPlayerMapID == 0 then
        ---未出在地图中,则不能显示
        return false
    end
    local duplicate = CS.Cfg_GlobalTableManager.CfgInstance:GetListTypeIntListJingHao(22526)
    if (duplicate ~= nil and duplicate.Count > 0) then
        for i = 0, duplicate.Count - 1 do
            local isget, activitb = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicate[i])
            if (isget) then
                if (activitb.groupID == currentMainPlayerMapID) then
                    if (CS.StaticUtility.IsNull(UIStrongerLeftMainPanel.mainGo) == false) then
                        UIStrongerLeftMainPanel.mainGo.transform.localPosition = CS.UnityEngine.Vector3(0, 30, 0)
                    end
                    return true
                end
            end
        end
    end
    ---@type TABLE.CFG_MAP
    local currentMapTbl
    ___, currentMapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(currentMainPlayerMapID)
    if currentMapTbl == nil then
        ---未加载到地图数据,不能显示
        return false
    end
    if currentMapTbl.duplicate == 1 then
        ---在副本中,不能显示
        return false
    end
    if (CS.StaticUtility.IsNull(UIStrongerLeftMainPanel.mainGo) == false) then
        UIStrongerLeftMainPanel.mainGo.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    end
    return true
end

--endregion


return UIStrongerLeftMainPanel