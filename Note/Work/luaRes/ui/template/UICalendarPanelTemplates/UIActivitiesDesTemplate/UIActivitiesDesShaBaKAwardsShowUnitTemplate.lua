local UIActivitiesDesShaBaKAwardsShowUnitTemplate = {};

--region Components

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:GetAwardName_Text()
    if(self.mAwardName_Text == nil) then
        self.mAwardName_Text = self:Get("title","UILabel");
    end
    return self.mAwardName_Text;
end

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:GetAwardContent_Text()
    if(self.mAwardContent_Text == nil) then
        self.mAwardContent_Text = self:Get("dec","UILabel");
    end
    return self.mAwardContent_Text;
end

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:GetAwardsGridContainer()
    if(self.mAwardsGridContainer == nil) then
        self.mAwardsGridContainer = self:Get("grid","UIGridContainer");
    end
    return self.mAwardsGridContainer;
end

--endregion

--region Method

--region Public

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:UpdateUnit(rewardShowList)
    if(self.mAwardUnitDic == nil) then
        self.mAwardUnitDic = {};
    end
    if(rewardShowList.Count > 2) then
        self:GetAwardName_Text().text = rewardShowList[0];
        local type = tonumber(rewardShowList[1]);
        self:GetAwardsGridContainer().gameObject:SetActive(type == 2);
        self:GetAwardContent_Text().gameObject:SetActive(type == 1);
        if(type == 1) then
            self:GetAwardContent_Text().text = rewardShowList[2];
        elseif(type == 2) then
            local gridContainer = self:GetAwardsGridContainer();
            if(rewardShowList.Count > 2) then
                gridContainer.MaxCount = rewardShowList.Count - 2;
                local index = 0;
                for i = 2, rewardShowList.Count - 1 do
                    local strs = string.Split(rewardShowList[i], "_");
                    if(strs[1]) ~= nil and strs[2] ~= nil then
                        local itemId = tonumber(strs[1]);
                        local count = tonumber(strs[2]);
                        if(itemId ~= nil and count ~= nil) then
                            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                            if(isFind) then
                                local gobj = gridContainer.controlList[index];
                                if(self.mAwardUnitDic[gobj] == nil) then
                                    self.mAwardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                                end
                                self.mAwardUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, count);
                                CS.UIEventListener.Get(gobj).onClick = function()
                                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                                end;
                            end
                        end
                    end
                    index = index + 1;
                end
            end
        end
    end
end

--endregion

--region Private

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:InitEvents()

end

--endregion

--endregion

function UIActivitiesDesShaBaKAwardsShowUnitTemplate:Init()

end

return UIActivitiesDesShaBaKAwardsShowUnitTemplate;