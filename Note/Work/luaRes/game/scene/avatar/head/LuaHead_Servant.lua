---@class LuaHead_Servant:LuaHead_Avatar 灵兽头顶
local LuaHead_Servant = {}
setmetatable(LuaHead_Servant, luaclass.LuaHead_Avatar)

--region overrid

function LuaHead_Servant:InitData()
    self:RunBaseFunction('InitData')
    ---灵兽标记文本颜色
    self.practiceColor = LuaEnumUnityColorType.Green
end

---@protected
function LuaHead_Servant:InitView()
    self:RunBaseFunction('InitView')
    --self:SetPracticeLabelState()
end

function LuaHead_Servant:SortHead()
    self:RunBaseFunction('SortHead')
    local offSet = self.curOffsetPos
    local targetY = offSet.y
    if self:IsShowPracticeLabel() then
        if self.mPractiveLabel ~= nil and not CS.StaticUtility.IsNull(self.mPractiveLabel.gameObject) then
            targetY = targetY + 30
            self:PractiveLabel().transform.localPosition = CS.UnityEngine.Vector3(offSet.x, targetY, offSet.z)
        end
    end
end

--endregion

--region 灵兽修炼标记 (仅做样本)

---@type CSLabel 灵兽修炼标记文本组件
function LuaHead_Servant:PractiveLabel()
    if self.mPractiveLabel == nil then
        self.mPractiveLabel = self:CreatPracticeLabel()
    end
    return self.mPractiveLabel
end

---设置灵兽修炼标记状态
function LuaHead_Servant:SetPracticeLabelState()
    if not self:IsShowPracticeLabel() and self.mPractiveLabel == nil then
        return
    end
    if self:GetCSAvatar() ~= nil and self:PractiveLabel() ~= nil then
        self:PractiveLabel().gameObject:SetActive(self:IsShowPracticeLabel())
        if self:IsShowPracticeLabel() then
            self:SortHead()
        end
    end
end

---创建一个灵兽修炼标记
---@return CSLabel
function LuaHead_Servant:CreatPracticeLabel()
    if self:GetParentRoot() == nil then
        return nil
    end

    local obj = CS.UnityEngine.GameObject('practiceLabel')
    obj.transform:SetParent(self:GetParentRoot())
    obj.transform.localRotation = CS.UnityEngine.Quaternion.identity
    obj.transform.localScale = CS.UnityEngine.Vector3.one
    obj.transform.localPosition = CS.UnityEngine.Vector3.one

    local label = obj:AddComponent(typeof(CS.CSLabel))
    label.font = CS.CSGameManager.Instance:GetStaticObj("msyh")
    label.color = self.practiceColor
    label.mIsoutLine = true
    label.mOutColor = LuaEnumUnityColorType.OutLineBlack
    label.text = "正在修炼"
    return label
end

---清理灵兽修炼标记状态
function LuaHead_Servant:ClearPracticeLabel()
    if self.mPractiveLabel ~= nil then
        CS.UnityEngine.Object.Destroy(self.mPractiveLabel.gameObject)
        self.mPractiveLabel = nil
    end
    self.practiceColor = nil
end

--endregion

--region switchController

---是否显示灵兽标记
function LuaHead_Servant:IsShowPracticeLabel()
    if self:GetCSAvatar() ~= nil then
        return self:GetCSAvatar().ServantAvaterType == CS.EServantAvaterType.Cultivate
    end
    return false
end

--endregion

function LuaHead_Servant:Destroy()
    self:RunBaseFunction('Destroy')
    self:ClearPracticeLabel()
end

return LuaHead_Servant