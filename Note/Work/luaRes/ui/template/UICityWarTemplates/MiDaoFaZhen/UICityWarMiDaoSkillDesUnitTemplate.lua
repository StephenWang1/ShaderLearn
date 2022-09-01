local UICityWarMiDaoSkillDesUnitTemplate = {};

--region Components

function UICityWarMiDaoSkillDesUnitTemplate:GetPlayerNum_Text()
    if(self.mPlayerNum_Text == nil) then
        self.mPlayerNum_Text = self:Get("number","UILabel");
    end
    return self.mPlayerNum_Text;
end

function UICityWarMiDaoSkillDesUnitTemplate:GetSkillDes_Text()
    if(self.mSkillDes_Text == nil) then
        self.mSkillDes_Text = self:Get("benefits","UILabel");
    end
    return self.mSkillDes_Text;
end

--endregion

--region Method

--region Public

function UICityWarMiDaoSkillDesUnitTemplate:UpdateUnit(configList)
    if(configList ~= nil) then
        if(configList.Count >= 3) then
            local playerNum = configList[0];
            local costNum = configList[1];
            local damageNum = configList[2];

            self:GetPlayerNum_Text().text = playerNum.."人";
            self:GetSkillDes_Text().text = luaEnumColorType.Gray.."对皇宫内所有人造成"..luaEnumColorType.White..math.floor(damageNum/100).."%[-]血量伤害[-]";
        end
    end
end

--endregion

--region Private

--endregion

--endregion

function UICityWarMiDaoSkillDesUnitTemplate:Init()

end

function UICityWarMiDaoSkillDesUnitTemplate:Show()

end

return UICityWarMiDaoSkillDesUnitTemplate;