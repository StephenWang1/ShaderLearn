---@class UIRolePanel_GridTemplateSynthesis:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateSynthesis = {};
setmetatable(UIRolePanel_GridTemplateSynthesis, luaComponentTemplates.UIRolePanel_GridTemplateBase)

UIRolePanel_GridTemplateSynthesis.mIsChoose = false;

UIRolePanel_GridTemplateSynthesis.mLuaRedPointKeyCache = nil;

---@return bagV2.BagItemInfo
function UIRolePanel_GridTemplateSynthesis:GetCurSynthesisBagItem()
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

function UIRolePanel_GridTemplateSynthesis:RedPoint()
    if self.red == nil then
        self.red = self:Get('background/Red', 'Top_UIRedPoint')
    end
    return self.red
end

--region 重写

---重写加号显示
function UIRolePanel_GridTemplateSynthesis:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateSynthesis:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateSynthesis:RefreshIconInfo()
    self:SetItemChoose(false)

    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if (self.bagItemInfo ~= nil) then
            if (self.itemInfo ~= nil) then
                self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            end
            self:UpdateIsCanSynthesis(self.bagItemInfo)
            --local canSynthesis = CS.Cfg_SynthesisTableManager.Instance:CanSynthesis(self.itemInfo.id);
            self:GetIcon_UISprite().color = self.hasSignetOrElementSynthesis and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
        self:GetIcon_UISprite().gameObject:SetActive(true)
    end
end

UIRolePanel_GridTemplateSynthesis.hasSignetOrElementSynthesis = nil

---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_GridTemplateSynthesis:UpdateIsCanSynthesis(bagItemInfo)
    ---先根据选中的物品拿到合成配方
    local synthesisTbl = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisByItemId(bagItemInfo.itemId);

    if(synthesisTbl == nil ) then
        ---这个点击的格子上面是否存在能合成的印记/元素
        self.hasSignetOrElementSynthesis = false;

        if(bagItemInfo ~= nil) then
            local equipIndex = bagItemInfo.index;
            local isFind1, signetInfo = CS.CSScene.MainPlayerInfo.SignetV2.ImprintInfoDic:TryGetValue(equipIndex)
            local isFind2, elementInfo = CS.CSScene.MainPlayerInfo.ElementInfo.Elements:TryGetValue(equipIndex);
            if(isFind1) then
                if(clientTableManager.cfg_synthesisManager:IsCanSynthesis(signetInfo.id)) then
                    self.hasSignetOrElementSynthesis = true;
                end
            end

            if(isFind2) then
                if(clientTableManager.cfg_synthesisManager:IsCanSynthesis(elementInfo.id)) then
                    self.hasSignetOrElementSynthesis = true;
                end
            end
        end
    else
        self.hasSignetOrElementSynthesis = true
    end
end

---重写隐藏其他界面调用Icon
function UIRolePanel_GridTemplateSynthesis:SetOtherIcon()
    --元素
    if self:GetElementAdd_UISprite().gameObject and CS.StaticUtility.IsNull(self:GetElementAdd_UISprite().gameObject) == false then
        self:GetElementAdd_UISprite().gameObject:SetActive(false)
    end
    --特效
    if self:GetEffect_GameObject() and CS.StaticUtility.IsNull(self:GetEffect_GameObject()) then
        self:GetEffect_GameObject():SetActive(false)
    end
    --印记
    if self:GetYinJi_GameObject() and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self:GetYinJi_GameObject():SetActive(false)
    end
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite().gameObject) == false then
        self:GetOverlayIcon2_UISprite().spriteName = ""
    end
    --维修
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(false)
    end
end

---重写选中特效
function UIRolePanel_GridTemplateSynthesis:ChooseItem(isShow)
    self.mIsChoose = isShow;
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
    end
end

function UIRolePanel_GridTemplateSynthesis:GetRedPointKey(index)
    if index == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return CS.RedPointKey.Synthesis_HasWeaponSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return CS.RedPointKey.Synthesis_HasClothesSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return CS.RedPointKey.Synthesis_HasLeftBraceletSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return CS.RedPointKey.Synthesis_HasLeftRingSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return CS.RedPointKey.Synthesis_HasBeltSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return CS.RedPointKey.Synthesis_HasShoesSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return CS.RedPointKey.Synthesis_HasRightRingSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return CS.RedPointKey.Synthesis_HasRightBraceletSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return CS.RedPointKey.Synthesis_HasNecklaceSynthesis;
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return CS.RedPointKey.Synthesis_HasHelmetSynthesis;
    end
    return CS.RedPointKey.NON;
end

---印记与元素的lua红点key
function UIRolePanel_GridTemplateSynthesis:GetLuaRedPointKey(index)
    self.mLuaRedPointKeyCache = {};
    local elementKey = gameMgr:GetLuaRedPointManager():GetSynthesisEquipElementRedPointKey(index);
    local signetKey = gameMgr:GetLuaRedPointManager():GetSynthesisEquipSignetRedPointKey(index);
    table.insert(self.mLuaRedPointKeyCache,elementKey);
    table.insert(self.mLuaRedPointKeyCache,signetKey);
    return self.mLuaRedPointKeyCache
end

function UIRolePanel_GridTemplateSynthesis:OnEnable()
    self:RunBaseFunction("OnEnable");
    if (self:RedPoint() ~= nil) then
        self:RedPoint():RemoveRedPointKey();
        --self:RedPoint():AddRedPointKey(self:GetRedPointKey(self.equipIndex));

        local luaKeys = self:GetLuaRedPointKey(self.equipIndex);
        if(luaKeys ~= nil) then
            for k,v in pairs(luaKeys) do
                self:RedPoint():AddRedPointKey(v);
            end
        end
    end
end

function UIRolePanel_GridTemplateSynthesis:OnDisable()
    self:RunBaseFunction("OnDisable");
    if (self:RedPoint() ~= nil) then
        self:RedPoint():RemoveRedPointKey();
    end
end

return UIRolePanel_GridTemplateSynthesis;