---@class 活跃度奖励宝箱
local UIDayToDayPanel_ActiveRewardBox = {}

--region 组件
---图标
function UIDayToDayPanel_ActiveRewardBox:GetIconSprite_UISprite()
    if self.mIconSprite_UISprite == nil then
        self.mIconSprite_UISprite = self:Get("box", "UISprite")
    end
    return self.mIconSprite_UISprite
end

---活跃度数值文字组件
function UIDayToDayPanel_ActiveRewardBox:GetBounsLabel_UILabel()
    if self.mBounsLabel_UILabel == nil then
        self.mBounsLabel_UILabel = self:Get("num", "UILabel")
    end
    return self.mBounsLabel_UILabel
end

---活跃度外框
function UIDayToDayPanel_ActiveRewardBox:GetFrame_Sprite()
    if self.mFrame_Sprite == nil then
        self.mFrame_Sprite = self:Get("frame", "UISprite")
    end
    return self.mFrame_Sprite
end

---活跃度箭头
function UIDayToDayPanel_ActiveRewardBox:GetArrow_Sprite()
    if self.mArrow_Sprite == nil then
        self.mArrow_Sprite = self:Get("arrow", "UISprite")
    end
    return self.mArrow_Sprite
end

---活跃度外发光
function UIDayToDayPanel_ActiveRewardBox:GetLight_Go()
    if self.mLight_Go == nil then
        self.mLight_Go = self:Get("light", "GameObject")
    end
    return self.mLight_Go
end

function UIDayToDayPanel_ActiveRewardBox:GetAlreadyGet_GameObject()
    if(self.mAlreadyGet_GameObject == nil) then
        self.mAlreadyGet_GameObject = self:Get("get","GameObject")
    end
    return self.mAlreadyGet_GameObject;
end

function UIDayToDayPanel_ActiveRewardBox:GetTweenFrame_UISprite()
    if self.mTweenFrame_UISprite == nil then
        self.mTweenFrame_UISprite = self:Get("frameTweenAlpha", "UISprite")
    end
    return self.mTweenFrame_UISprite
end

--function UIDayToDayPanel_ActiveRewardBox:GetFrame_TweenAlpha()
--    if self.mFrame_TweenAlpha == nil then
--        self.mFrame_TweenAlpha = self:Get("frameTweenAlpha", "TweenAlpha")
--    end
--    return self.mFrame_TweenAlpha
--end

---奖励个数数值文字组件
function UIDayToDayPanel_ActiveRewardBox:GetCountLabel_UILabel()
    if self.mCountLabel_UILabel == nil then
        self.mCountLabel_UILabel = self:Get("count", "UILabel")
    end
    return self.mCountLabel_UILabel
end

---自身的UIButton组件
function UIDayToDayPanel_ActiveRewardBox:GetUIButton_UIButton()
    if self.mUIButtonSelf_UIButton == nil then
        self.mUIButtonSelf_UIButton = self:Get("", "UIButton")
    end
    return self.mUIButtonSelf_UIButton
end

---自身的UIButtonScale组件
function UIDayToDayPanel_ActiveRewardBox:GetUIButtonScale_UIButtonScale()
    if self.mUIButtonScale_UIButtonScale == nil then
        self.mUIButtonScale_UIButtonScale = self:Get("", "UIButtonScale")
    end
    return self.mUIButtonScale_UIButtonScale
end
--endregion

---是否没领取
function UIDayToDayPanel_ActiveRewardBox:GetIsObtained()
    if self.rewardData ~= nil then
        local state = CS.CSScene.MainPlayerInfo.ActiveInfo:GetRewardState(self.rewardData.id);
        return not state;
    end
    return false;
end

--region 初始化
---设置数据
---@param rewardData TABLE.CFG_ACTIVE_REWARD
function UIDayToDayPanel_ActiveRewardBox:SetData(rewardData)
    self.rewardData = rewardData
    self.go.name = self.rewardData.id
    self:Refresh()
end

---设置位置
---@param minRelativePos Vector3 最小相对位置
---@param maxRelativePos Vector3 最大相对位置
function UIDayToDayPanel_ActiveRewardBox:SetPosition(minRelativePos, maxRelativePos)
    if self.rewardData then
        self.go.transform.localPosition = CS.UnityEngine.Vector3.Lerp(minRelativePos, maxRelativePos, self.rewardData.bonus / CS.Cfg_Active_RewardTableManager.Instance.MaxActiveNumber)
    end
end

---设置点击回调
---@param callback function
function UIDayToDayPanel_ActiveRewardBox:SetClickCallback(callback)
    self.mCallback = callback
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = UIDayToDayPanel_ActiveRewardBox.OnRewardBoxClicked
end
--endregion

--region 刷新数据
function UIDayToDayPanel_ActiveRewardBox:Refresh()
    if self.rewardData then
        self:GetBounsLabel_UILabel().text = tostring(self.rewardData.bonus)
        --奖励是否已被领取
        local state = CS.CSScene.MainPlayerInfo.ActiveInfo:GetRewardState(self.rewardData.id)
        --奖励是否可被领取
        self.isAbleToObtain = (state == false) and (CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber() >= self.rewardData.bonus)
        self:RefreshIcon(state and 1 or self.isAbleToObtain and 2 or 3)
        if self:GetUIButton_UIButton() then
            self:GetUIButton_UIButton().enabled = self.isAbleToObtain
        end
        if self:GetUIButtonScale_UIButtonScale() then
            self:GetUIButtonScale_UIButtonScale().enabled = self.isAbleToObtain
        end

        local spriteName = "";
        local count = 0
        local rewardList = CS.Cfg_Active_RewardTableManager.Instance:GetRewardList(self.rewardData.id);
        if(rewardList ~= nil and rewardList.Count > 0) then
            for i = 0, rewardList.Count - 1 do
                if(rewardList[i].Length >= 2) then
                    self.getItemId = rewardList[i][0];
                    count = rewardList[i][1];
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.getItemId);
                    if (isFind) then
                        spriteName = itemTable.icon;
                        self.itemInfo = itemTable
                    end
                    break;
                end
            end
        end

        self:GetIconSprite_UISprite().spriteName = spriteName;
        if self:GetCountLabel_UILabel() ~= nil then
            if(count == 1) then
                self:GetCountLabel_UILabel().text = ""
            else
                self:GetCountLabel_UILabel().text = count
            end
            if(self:GetCountLabel_UILabel().gameObject.activeSelf) then
                self:GetCountLabel_UILabel().gameObject:SetActive(count ~= 0)
            end
        end
        --self:GetIconSprite_UISprite().color = state and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    end
end
--endregion
---@param state number 1:已领取 2: 可领取 3:不可领取
function UIDayToDayPanel_ActiveRewardBox:RefreshIcon(state)
    self:GetLight_Go():SetActive(state == 2)
    self:GetIconSprite_UISprite().alpha = state == 1 and 0.3 or 1
    self:GetFrame_Sprite().spriteName = state == 3 and 'unrewardbg' or 'rewardbg'
    self:GetArrow_Sprite().spriteName = state == 3 and 'huoclosearrow' or 'huoopenarrow'
    self:GetBounsLabel_UILabel().effectStyle = state == 2 and 2 or 0
    self:GetBounsLabel_UILabel().color = state == 3 and LuaEnumUnityColorType.Grey or LuaEnumUnityColorType.White
    self:GetTweenFrame_UISprite().gameObject:SetActive(state == 2);
    self:GetAlreadyGet_GameObject():SetActive(state == 1);
    self:GetIconSprite_UISprite().gameObject:SetActive(state ~= 1);
    self:GetCountLabel_UILabel().gameObject:SetActive(state ~= 1);
    --self:PlayFrameTweenAlpha(state == 2);
end

function UIDayToDayPanel_ActiveRewardBox:PlayFrameTweenAlpha(isPlay)
    --if(not isPlay) then
    --    self:GetFrame_Sprite().spriteName = "rewardbg";
    --else
    --    self:GetFrame_Sprite().spriteName = "rewardlight";
    --end

    --if(self:GetFrame_TweenAlpha().enabled ~= isPlay) then
    --    self:GetFrame_TweenAlpha().enabled = isPlay;
    --    if(not isPlay) then
    --        self:GetTweenFrame_UISprite().alpha = 0.1;
    --    end
    --end
end

--region 点击事件
function UIDayToDayPanel_ActiveRewardBox:OnRewardBoxClicked()
    if self.mCallback then
        self.mCallback(self, self:GetIconSprite_UISprite())
    end
end
--endregion

return UIDayToDayPanel_ActiveRewardBox