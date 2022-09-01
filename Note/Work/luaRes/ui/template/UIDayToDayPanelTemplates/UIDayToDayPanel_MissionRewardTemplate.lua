local UIDayToDayPanel_MissionRewardTemplate = {};

UIDayToDayPanel_MissionRewardTemplate.mMission = nil;

function UIDayToDayPanel_MissionRewardTemplate:GetItemIcon_UISprite()
    if(self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:Get("icon","UISprite");
    end
    return self.mItemIcon_UISprite;
end

function UIDayToDayPanel_MissionRewardTemplate:GetItemValue_Text()
    if(self.mItemValue_Text == nil) then
        self.mItemValue_Text = self:Get("value", "UILabel");
    end
    return self.mItemValue_Text;
end

function UIDayToDayPanel_MissionRewardTemplate:GetRewardDes_Text()
    if(self.mRewardDes_Text == nil) then
        self.mRewardDes_Text = self:Get("rewardText", "UILabel");
    end
    return self.mRewardDes_Text;
end

--region Method

--region Public

function UIDayToDayPanel_MissionRewardTemplate:UpdateUnit(itemId, count)
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    if(isFind) then
        self.mItemTable = itemTable;
        self:GetItemValue_Text().text = count;
        self:GetItemIcon_UISprite().alpha = 1;
        self:GetItemIcon_UISprite().spriteName = itemTable.icon;
        self:GetRewardDes_Text().text = "活跃度";
        self:GetItemValue_Text().transform.localPosition = CS.UnityEngine.Vector3(self.mValueTextOriginPosition.x - 5 , self.mValueTextOriginPosition.y, self.mValueTextOriginPosition.z);
    end
end

function UIDayToDayPanel_MissionRewardTemplate:UpdateOther(showStr)
    self:GetItemIcon_UISprite().alpha = 0.01;
    self:GetItemValue_Text().text = showStr;
    self:GetRewardDes_Text().text = "次数";
    local pos = self:GetItemIcon_UISprite().transform.localPosition;
    self:GetItemValue_Text().transform.localPosition = CS.UnityEngine.Vector3(pos.x - 5 , pos.y, pos.z);
end

--endregion

--region Private

function UIDayToDayPanel_MissionRewardTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetItemIcon_UISprite().gameObject).onClick = function()
        if(self.mItemTable ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.mItemTable})
        end
    end
end

--endregion

--endregion

function UIDayToDayPanel_MissionRewardTemplate:Init()
    self:InitEvents();
    self.mValueTextOriginPosition = self:GetItemValue_Text().transform.localPosition;
end

return UIDayToDayPanel_MissionRewardTemplate;