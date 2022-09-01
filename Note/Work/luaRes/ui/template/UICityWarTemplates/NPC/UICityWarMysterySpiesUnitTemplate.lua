local UICityWarMysterySpiesUnitTemplate = {};

UICityWarMysterySpiesUnitTemplate.mPlayerData = nil;

--region Method

function UICityWarMysterySpiesUnitTemplate:GetBtnTrack_GameObject()
    if(self.mBtnTrack_GameObject == nil) then
        self.mBtnTrack_GameObject = self:Get("btn_track","GameObject")
    end
    return self.mBtnTrack_GameObject;
end

function UICityWarMysterySpiesUnitTemplate:GetPlayerName_UILabel()
    if(self.mPlayerName_UILabel == nil) then
        self.mPlayerName_UILabel = self:Get("Name","UILabel");
    end
    return self.mPlayerName_UILabel;
end

function UICityWarMysterySpiesUnitTemplate:GetTitleName_UILabel()
    if(self.mTitleName_UILabel == nil) then
        self.mTitleName_UILabel = self:Get("Title","UILabel");
    end
    return self.mTitleName_UILabel;
end

function UICityWarMysterySpiesUnitTemplate:GetPlayerIcon_UISprite()
    if(self.mPlayerIcon_UISprite == nil) then
        self.mPlayerIcon_UISprite = self:Get("headicon","UISprite");
    end
    return self.mPlayerIcon_UISprite;
end

--endregion

--region Method

--region Public

function UICityWarMysterySpiesUnitTemplate:UpdateUnit(playerData)
    self.mPlayerData = playerData;
    self:UpdateUI();
end

function UICityWarMysterySpiesUnitTemplate:UpdateUI()
    if(self.mPlayerData ~= nil) then
        self:GetPlayerIcon_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(self.mPlayerData.sex, self.mPlayerData.career);
        local unionPosName = uiStaticParameter.PosStringList[self.mPlayerData.unionPos];
        unionPosName = unionPosName == nil and "" or unionPosName;
        self:GetTitleName_UILabel().text = unionPosName;
        self:GetPlayerName_UILabel().text = self.mPlayerData.name;
    end
end

--endregion

--region Private

function UICityWarMysterySpiesUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnTrack_GameObject()).onClick = function()
        if(self.mPlayerData ~= nil) then
            networkRequest.ReqBrokerQuery(self.mPlayerData.roleId);
            uimanager:ClosePanel("UICityWarMysterySpiesPanel");
        end
    end;
end

--endregion

--endregion

function UICityWarMysterySpiesUnitTemplate:Init()
    self:InitEvents();
end

--function UICityWarMysterySpiesUnitTemplate:OnDestroy()
--
--end

return UICityWarMysterySpiesUnitTemplate;