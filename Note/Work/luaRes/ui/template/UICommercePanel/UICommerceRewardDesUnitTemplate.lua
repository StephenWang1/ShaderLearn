local UICommerceRewardDesUnitTemplate = {};

--region Components

function UICommerceRewardDesUnitTemplate:GetDes_Text()
    if(self.mDes_Text == nil) then
        self.mDes_Text = self:Get("rewardLabel","UILabel");
    end
    return self.mDes_Text;
end

--endregion

--region Method

--region Public

function UICommerceRewardDesUnitTemplate:UpdateUnit(des, itemId, itemCount)
    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    if(isFindItem) then
        self:GetDes_Text().text = des..luaEnumColorType.SimpleYellow..itemCount.."[-]"..itemTable.name;
    end
end

function UICommerceRewardDesUnitTemplate:UpdateDes(des)
    self:GetDes_Text().text = des;
end

--endregion

--endregion

function UICommerceRewardDesUnitTemplate:Init()

end

return UICommerceRewardDesUnitTemplate;