---@class UIRolePanel_GridTemplateStrength:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateStrength = {}
setmetatable(UIRolePanel_GridTemplateStrength, luaComponentTemplates.UIRolePanel_GridTemplateBase)

function UIRolePanel_GridTemplateStrength:Init()
    self:RunBaseFunction("Init")
    self.mBindRedPoint = false
end

function UIRolePanel_GridTemplateStrength:ShowEquip(bagItemInfo, equipIndex)
    self:RunBaseFunction("ShowEquip", bagItemInfo, equipIndex)
    if bagItemInfo then
        self.bagItemInfo = bagItemInfo
        if self.mBindRedPoint then
            local key = "Strength_" .. bagItemInfo.index
            local StrengthKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
            CS.CSUIRedPointManager.GetInstance():CallRedPoint(StrengthKey);
        else
            self:BindSelfRedPoint()
            self.mBindRedPoint = true
        end
    end
end

---角色默认的刷新方法
function UIRolePanel_GridTemplateStrength:RefreshGrid(bagItemInfo)
    self:RunBaseFunction("RefreshGrid", bagItemInfo)

end

function UIRolePanel_GridTemplateStrength:GetCurrentBagItemInfo()
    return self.bagItemInfo
end

function UIRolePanel_GridTemplateStrength:BindSelfRedPoint()
    if self:GetCurrentBagItemInfo() then
        local key = "Strength_" .. self:GetCurrentBagItemInfo().index
        local StrengthKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
        self.CallIsShowStrengthRedPoint = function()
            local isShow = gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():IsItemNeedRedPoint(self:GetCurrentBagItemInfo())
            return isShow
        end
        self:ClearRedPointFunc()
        self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunctionByInt(StrengthKey, self.CallIsShowStrengthRedPoint);
        if (self:RedPoint() ~= nil and StrengthKey ~= nil) then
            self:RedPoint():AddRedPointKey(StrengthKey)
        end
    end
end

---清除红点
function UIRolePanel_GridTemplateStrength:ClearRedPointFunc()
    if self:RedPoint() ~= nil then
        self:RedPoint():RemoveRedPointKey();
    end
    if self.CallIsShowStrengthRedPoint then
        local key = "Strength_" .. self:GetCurrentBagItemInfo().index
        local StrengthKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
        self:GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(StrengthKey)
    end
end

---@return CSUIRedPointManager
function UIRolePanel_GridTemplateStrength:GetCSUIRedPointManager()
    return CS.CSUIRedPointManager:GetInstance();
end

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateStrength:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateStrength:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end

---重写刷新选中框（取消刷新）
function UIRolePanel_GridTemplateStrength:HideChoose()
end
--endregion

return UIRolePanel_GridTemplateStrength