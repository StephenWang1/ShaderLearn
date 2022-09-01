---@class UIEffectPanel:UIBase
local UIEffectPanel = {};

---@type UIEffectPanel
local this = nil;

UIEffectPanel.mEffectDic = nil;

UIEffectPanel.mFlyItemIconPool = nil;

--region Components

function UIEffectPanel:GetEffectNode_Transform()
    if (this.mEffectNode_Transform == nil) then
        this.mEffectNode_Transform = this:GetCurComp("WidgetRoot/effectNode", "Transform");
    end
    return this.mEffectNode_Transform;
end

function UIEffectPanel:GetFlyItemIcon_UISprite()
    if (this.mFlyItemIcon_UISprite == nil) then
        this.mFlyItemIcon_UISprite = this:GetCurComp("WidgetRoot/itemIconFly", "UISprite");
    end
    return this.mFlyItemIcon_UISprite;
end

function UIEffectPanel:GetFlyItemPoolTemplate_GameObject()
    if (this.mFlyItemPoolTemplate_GameObject == nil) then
        this.mFlyItemPoolTemplate_GameObject = this:GetCurComp("WidgetRoot/itemIconFly", "GameObject");
    end
    return this.mFlyItemPoolTemplate_GameObject;
end

function UIEffectPanel:GetPoolParent_Transform()
    if (this.mPoolParent_Transform == nil) then
        this.mPoolParent_Transform = this:GetCurComp("WidgetRoot/iconPool", "Transform");
    end
    return this.mPoolParent_Transform;
end

---技能拖拽公用ICON
function UIEffectPanel:GetDragSkillIcon_UISprite()
    if (this.mDragSkillIcon_UISprite == nil) then
        this.mDragSkillIcon_UISprite = this:GetCurComp("WidgetRoot/dragSkillIcon", "UISprite");
    end
    return this.mDragSkillIcon_UISprite;
end

--endregion

--region Method

--region Public

function UIEffectPanel:GetLocalPosition(wordPosition)
    return this:GetEffectNode_Transform():InverseTransformPoint(wordPosition);
end

function UIEffectPanel:CloseEffect(effectId)
    if (this.mEffectDic ~= nil and this.mEffectDic[effectId] ~= nil) then
        CS.UnityEngine.GameObject.Destroy(this.mEffectDic[effectId]);
        this.mEffectDic[effectId] = nil;
    end
end

---播放普通特效
function UIEffectPanel:PlayEffect(effectId, scale, wordPosition, callBack)
    if (scale == nil) then
        scale = 1;
    end

    if (this.mEffectDic == nil) then
        this.mEffectDic = {};
    end
    if (this.mEffectDic[effectId] == nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                res.IsCanBeDelete = false
                this.mEffectDic[effectId] = res:GetObjInst();
                if this.mEffectDic[effectId] ~= nil then
                    this.mEffectDic[effectId].transform.parent = this:GetEffectNode_Transform();
                    this.mEffectDic[effectId].transform.localPosition = this:GetLocalPosition(wordPosition);
                    this.mEffectDic[effectId].transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale);
                end
                if (callBack ~= nil) then
                    callBack(this.mEffectDic[effectId]);
                end
            end
        end, CS.ResourceAssistType.UI);
    else
        this.mEffectDic[effectId].transform.parent = this:GetEffectNode_Transform();
        this.mEffectDic[effectId].transform.localPosition = this:GetLocalPosition(wordPosition);
        this.mEffectDic[effectId].transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale);
        this.mEffectDic[effectId]:SetActive(false);
        this.mEffectDic[effectId]:SetActive(true);
        if (callBack ~= nil) then
            callBack(this.mEffectDic[effectId]);
        end
    end
end

---飞动物品Icon
function UIEffectPanel:PlayFlyItemIcon(itemId, from, to, endCallBack)
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    local gobj = this:PopPoolFlyItem();
    local sprite = CS.Utility_Lua.GetComponent(gobj, "UISprite");
    local tweenPosition = CS.Utility_Lua.GetComponent(gobj, "TweenPosition");
    local tweenScale = CS.Utility_Lua.GetComponent(gobj, "TweenScale");
    if (sprite ~= nil) then
        if (isFind) then
            sprite.spriteName = itemTable.icon;
        end
    end

    local fromLocalPosition = this:GetLocalPosition(from);
    local toLocalPosition = this:GetLocalPosition(to);
    if (tweenPosition ~= nil) then
        tweenPosition.from = fromLocalPosition;
        tweenPosition.to = toLocalPosition;
        tweenPosition:SetOnFinished(function()
            this:PushPoolFlyItem(gobj);
            if (endCallBack ~= nil) then
                endCallBack();
            end
        end);
        tweenPosition:PlayTween();
    else
        this:PushPoolFlyItem(gobj);
    end

    if (tweenScale ~= nil) then
        tweenScale:PlayTween();
    end
end

--endregion

--region Private

function UIEffectPanel:PopPoolFlyItem()
    if (this.mFlyItemIconPool == nil) then
        this.mFlyItemIconPool = {};
    end
    if (#this.mFlyItemIconPool > 0) then
        local poolItem = this.mFlyItemIconPool[1];
        table.remove(this.mFlyItemIconPool, 1);
        poolItem:SetActive(true);
        return poolItem;
    end

    local gobj = CS.UnityEngine.GameObject.Instantiate(this:GetFlyItemPoolTemplate_GameObject(), this:GetPoolParent_Transform());
    gobj:SetActive(false);
    table.insert(this.mFlyItemIconPool, gobj);
    return this:PopPoolFlyItem();
end

function UIEffectPanel:PushPoolFlyItem(gobj)
    if (not CS.StaticUtility.IsNull(gobj)) then
        gobj:SetActive(false);
        gobj.transform.localScale = CS.UnityEngine.Vector3.one;
        table.insert(this.mFlyItemIconPool, gobj);
    end
end

function UIEffectPanel:GetFlyItemToPosition(itemId)
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    local targetPosition = CS.UnityEngine.Vector3.zero;
    local mainChatPanel = uimanager:GetPanel("UIMainChatPanel");
    if (mainChatPanel ~= nil) then
        targetPosition = mainChatPanel.btn_bag.transform.position;
    end
    if (isFind) then
        if (itemTable.type == Utility.EnumToInt(CS.EItem_Type.Box)) then
            if (itemTable.subType == 1) then
                local roleHeadPanel = uimanager:GetPanel("UIRoleHeadPanel");
                if (roleHeadPanel ~= nil) then
                    targetPosition = roleHeadPanel:GetRoleIcon_UISprite().gameObject.transform.position;
                end
            elseif (itemTable.subType == 2) then
                local servantHeadPanel = uimanager:GetPanel("UIServantHeadPanel");
                if (servantHeadPanel ~= nil) then
                    targetPosition = servantHeadPanel:GetServant1Icon_GameObject().transform.position;
                end
            elseif (itemTable.subType == 3) then
                local navigationPanel = uimanager:GetPanel("UINavigationPanel");
                if (navigationPanel ~= nil) then
                    targetPosition = navigationPanel:GetNavViewTemplate():GetBtnOpen_GameObject().transform.position;
                end
            end
        end
    end
    return targetPosition;
end

function UIEffectPanel:InitEvents()
    this.CallEffectFlyItemIcon = function(msgId, msgData)
        if (msgData ~= nil and msgData.itemId ~= nil and msgData.from ~= nil) then
            if (msgData.to == nil) then
                msgData.to = this:GetFlyItemToPosition(msgData.itemId);
            end
            this:PlayFlyItemIcon(msgData.itemId, msgData.from, msgData.to, msgData.callBack);
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Effect_FlyItemIcon, this.CallEffectFlyItemIcon)

    this.CallPlayEffect = function(msgId, msgData)
        if (msgData ~= nil and msgData.effectId ~= nil) then
            local effectId = msgData.effectId;
            local scale = msgData.scale == nil and 1 or msgData.scale;
            local wordPosition = msgData.wordPosition == nil and CS.UnityEngine.Vector3.zero or msgData.wordPosition;
            local callBack = msgData.callBack;
            this:PlayEffect(effectId, scale, wordPosition, callBack);
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Effect_PlayEffect, this.CallPlayEffect)
end
--endregion

--endregion

function UIEffectPanel:Init()
    this = self;
    this:InitEvents();
end

return UIEffectPanel;