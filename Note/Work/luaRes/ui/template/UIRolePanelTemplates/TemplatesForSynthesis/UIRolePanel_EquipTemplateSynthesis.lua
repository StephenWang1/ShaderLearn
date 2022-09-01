---@class UIRolePanel_EquipTemplateSynthesis:UIRolePanel_EquipTemplate
local UIRolePanel_EquipTemplateSynthesis = {};

setmetatable(UIRolePanel_EquipTemplateSynthesis, luaComponentTemplates.UIRolePanel_EquipTemplate)

UIRolePanel_EquipTemplateSynthesis.mCurrentChooseItem = nil

---@return bagV2.BagItemInfo
function UIRolePanel_EquipTemplateSynthesis:GetCurSynthesisBagItem()
    local synthesisPanel = uimanager:GetPanel("UISynthesisPanel");
    if (synthesisPanel ~= nil) then
        local mainBagItemInfo = synthesisPanel:GetSynthesisViewTemplate():GetSynthesisMainBagItemInfo();
        if(synthesisPanel:GetSynthesisViewTemplate().mLastSelectBagItem ~= nil) then
            mainBagItemInfo = synthesisPanel:GetSynthesisViewTemplate().mLastSelectBagItem;
        end
        if (mainBagItemInfo ~= nil) then
            return mainBagItemInfo;
        end
    end
    return nil;
end

---帧更新事件
function UIRolePanel_EquipTemplateSynthesis:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            if (self.mPressTarget ~= nil) then
                local template = self.mGridToTemplate[self.mPressTarget]
                self:ShowItemInfo(template, false);
                self.mPressTarget = nil;
            end
            return ;
        end
    end
end

---重写角装备格子按下事件
function UIRolePanel_EquipTemplateSynthesis:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.mTimer = 0;
    if (state) then
        self.mIsLongPress = true;
        self.mPressTarget = go;
    else
        self.mIsLongPress = false;
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateSynthesis:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateSynthesis
    local template = self.mGridToTemplate[go];

    if (template.mIsChoose) then
        self:ShowItemInfo(template, false);
    else
        local hasError = false;
        local tipsInfo = {};
        if (template.itemInfo ~= nil) then
            if(template.hasSignetOrElementSynthesis == false) then
                tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 329
                tipsInfo[LuaEnumTipConfigType.Describe] = "此物品无法合成"
                hasError = true;
            end
            if (not hasError) then
                self:RunBaseFunction("OnItemClicked", go);
            else
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
            end
        end
    end
    self:UpdateGrid();
end

---重写选中角色格子事件
function UIRolePanel_EquipTemplateSynthesis:SetItemChoose(equipIndex)
    self:UpdateGrid();
end

---隐藏当前选中物品
function UIRolePanel_EquipTemplateSynthesis:HideCurrentChooseItem()
    --if UIRolePanel_EquipTemplateSynthesis.mCurrentChooseItem ~= nil then
    --    self:SetItemShowChoose(false, UIRolePanel_EquipTemplateSynthesis.mCurrentChooseItem)
    --    UIRolePanel_EquipTemplateSynthesis.mCurrentChooseItem = nil
    --end
    self:UpdateGrid();
end

function UIRolePanel_EquipTemplateSynthesis:UpdateGrid()
    self:RefreshGrid();
    for k, v in pairs(self.mGridToTemplate) do
        self:SetItemShowChoose(false, v.go);
        if (v.bagItemInfo ~= nil) then
            if (self:GetCurSynthesisBagItem() ~= nil and v.bagItemInfo.lid == self:GetCurSynthesisBagItem().lid) then
                self:SetItemShowChoose(true, v.go);
            end
        end
    end

    --if (self.mCoroutineUpdateGrid ~= nil) then
    --    StopCoroutine(self.mCoroutineUpdateGrid);
    --    self.mCoroutineUpdateGrid = nil;
    --end
    --self.mCoroutineUpdateGrid = StartCoroutine(self.CDelayUpdateGrid, self);
end

--function UIRolePanel_EquipTemplateSynthesis:CDelayUpdateGrid()
--    coroutine.yield(0);
--    self:RefreshGrid();
--    for k, v in pairs(self.mGridToTemplate) do
--        self:SetItemShowChoose(false, v.go);
--        if (v.bagItemInfo ~= nil) then
--            if (self:GetCurSynthesisBagItem() ~= nil and v.bagItemInfo.lid == self:GetCurSynthesisBagItem().lid) then
--                self:SetItemShowChoose(true, v.go);
--            end
--        end
--    end
--end

---设置某格子选中显示
function UIRolePanel_EquipTemplateSynthesis:SetItemShowChoose(isShow, go)
    local template = self.mGridToTemplate[go]
    if template and template.ChooseItem then
        template:ChooseItem(isShow)
    end

    if (isShow) then
        --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(template.itemInfo.id)
        --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(template.itemInfo.id)
        --if (CS.StaticUtility.IsNull(template:RedPoint()) == false) then
        --    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
        --end
        self.mCurrentChooseTemplate = template
    end
end

function UIRolePanel_EquipTemplateSynthesis:OnEnable()
    self:RunBaseFunction("OnEnable");
    self.CallOnResSynthesisMessage = function()
        self:UpdateGrid();
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage)
    end

    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResBagChangeMessage, self.CallOnResSynthesisMessage);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
    self:UpdateGrid();
end

function UIRolePanel_EquipTemplateSynthesis:OnDisable()
    self:RunBaseFunction("OnDisable");
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, self.CallOnResSynthesisMessage);
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage)
    end
end

function UIRolePanel_EquipTemplateSynthesis:OnDestroy()
    self:RunBaseFunction("OnDestroy");
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSynthesisMessage, self.CallOnResSynthesisMessage)
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, self.CallOnResSynthesisMessage);
    if (self.mCoroutineUpdateGrid ~= nil) then
        StopCoroutine(self.mCoroutineUpdateGrid);
        self.mCoroutineUpdateGrid = nil;
    end
end

return UIRolePanel_EquipTemplateSynthesis;