---@class UIActivityRankUnitShaBaKFeature:UIActivityRankUnitFeatureBase
local UIActivityRankUnitShaBaKFeature = {};
setmetatable(UIActivityRankUnitShaBaKFeature, luaclass.UIActivityRankUnitFeatureBase)

function UIActivityRankUnitShaBaKFeature:SetUnitView()
    self:RunBaseFunction("SetUnitView")
    local target = self.tbl;
    if target then
        if target:GetFirstValue() ~= nil and not CS.StaticUtility.IsNull(target:GetFirstValue()) then
            target:GetFirstValue().text = target.settleInfo.killCount;
        end

        if target:GetSecondValue() ~= nil and not CS.StaticUtility.IsNull(target:GetSecondValue()) then
            target:GetSecondValue().text = Utility.GetNumStr(target.settleInfo.damage);
        end

        if target:GetThirdValue() ~= nil and not CS.StaticUtility.IsNull(target:GetThirdValue()) then
            target:GetThirdValue().text = Utility.GetNumStr(target.settleInfo.hurt);
        end

        if target:GetFourthValue() ~= nil and not CS.StaticUtility.IsNull(target:GetFourthValue()) then
            target:GetFourthValue().text = Utility.GetNumStr(target.settleInfo.cure);
        end

        if target:GetBattleDamageGrid() ~= nil and not CS.StaticUtility.IsNull(target:GetBattleDamageGrid()) then
            self:UpdateLoseItem(target:GetBattleDamageGrid(), target.settleInfo.loseItems);
        end

        if target:GetBattleDamageBtn() ~= nil and not CS.StaticUtility.IsNull(target:GetBattleDamageBtn()) then
            CS.UIEventListener.Get(target:GetBattleDamageBtn()).onClick = function()
                uimanager:CreatePanel("UICityWarDieDropItemPanel", nil, { itemIdList = target.settleInfo.loseItems })
            end
        end
    end
end

function UIActivityRankUnitShaBaKFeature:SetUnitComponentPos()
    self:RunBaseFunction("SetUnitComponentPos")
    local target = self.tbl;
    if target then
        if target:GetFirstValue() ~= nil and not CS.StaticUtility.IsNull(target:GetFirstValue()) then
            target:GetFirstValue().gameObject:SetActive(true);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.KillPlayer)
            local originPos = target:GetFirstValue().transform.localPosition
            target:GetFirstValue().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end

        if target:GetSecondValue() ~= nil and not CS.StaticUtility.IsNull(target:GetSecondValue()) then
            target:GetSecondValue().gameObject:SetActive(true);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.OutputHurt)
            local originPos = target:GetSecondValue().transform.localPosition
            target:GetSecondValue().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end

        if target:GetThirdValue() ~= nil and not CS.StaticUtility.IsNull(target:GetThirdValue()) then
            target:GetThirdValue().gameObject:SetActive(true);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.TakeDamage)
            local originPos = target:GetThirdValue().transform.localPosition
            target:GetThirdValue().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end

        if target:GetFourthValue() ~= nil and not CS.StaticUtility.IsNull(target:GetFourthValue()) then
            target:GetFourthValue().gameObject:SetActive(true);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.Cure)
            local originPos = target:GetFourthValue().transform.localPosition
            target:GetFourthValue().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end

        if target:GetBattleDamageGrid() ~= nil and not CS.StaticUtility.IsNull(target:GetBattleDamageGrid()) then
            target:GetBattleDamageGrid().gameObject:SetActive(target.settleInfo.loseItems.Count > 0);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.BsttlrDamage)
            local originPos = target:GetBattleDamageGrid().transform.localPosition
            target:GetBattleDamageGrid().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end

        if target:GetBattleDamageBtn() ~= nil and not CS.StaticUtility.IsNull(target:GetBattleDamageBtn()) then
            target:GetBattleDamageBtn().gameObject:SetActive(target.settleInfo.loseItems.Count > 0);
            local posX = self:GetComponentPosx(LuaEnumActivityRankComponentType.BsttlrDamageBtn)
            local originPos = target:GetBattleDamageBtn().transform.localPosition
            target:GetBattleDamageBtn().transform.localPosition = { x = posX, y = originPos.y, z = 0 }
        end
    end
end

function UIActivityRankUnitShaBaKFeature:RefreshIntegral()
    local target = self.tbl;
    if (target ~= nil) then
        local score = target.settleInfo.integral;
        local scoreStr = tostring(math.floor(score));
        if (score > math.floor(score)) then
            local tempScore = math.floor(score * 10) / 10;
            scoreStr = string.format('%.1f', tempScore);
        end
        if target:GetMvpNum() ~= nil and not CS.StaticUtility.IsNull(target:GetMvpNum().gameObject) then
            target:GetMvpNum().text = scoreStr;
        end
    end
end

function UIActivityRankUnitShaBaKFeature:UpdateLoseItem(gridContainer, loseItemList)
    if (gridContainer ~= nil and not CS.StaticUtility.IsNull(gridContainer)) then
        if (loseItemList ~= nil and loseItemList.Count > 0) then
            --gridContainer.MaxCount = loseItemList.Count;
            --for i = 0, loseItemList.Count - 1 do
            --    local iconSprite = CS.Utility_Lua.GetComponent(gridContainer.controlList[i], "UISprite");
            --    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(loseItemList[i]);
            --    if (isFind) then
            --        iconSprite = itemTable.icon;
            --    end
            --end
            gridContainer.MaxCount = 1;
            local gobj = gridContainer.controlList[0]
            --local iconSprite = CS.Utility_Lua.GetComponent(gobj, "UISprite");
            self.mLoseItemUIItem = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(loseItemList[0]);
            if (isFind) then
                --iconSprite = itemTable.icon;
                self.mLoseItemUIItem:RefreshUIWithItemInfo(itemTable, 1);
                CS.UIEventListener.Get(gobj).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false });
                end
            end
        else
            gridContainer.MaxCount = 0;
        end
    end
end

--重写刷新点赞
function UIActivityRankUnitShaBaKFeature:RefreshLike()

    local target = self.tbl;

    local stateCode = CS.CSScene.MainPlayerInfo.DuplicateV2:GetShaBaKRankState()

    if target:GetLikeNum() ~= nil and not CS.StaticUtility.IsNull(target:GetLikeNum()) then
        --活动中不显示点赞
        if stateCode == 0 or not target.settleInfo:IsLiked() then
            target:GetLikeNum().text = ''
        else
            local count = target.settleInfo.likeRoleList.Count
            target:GetLikeNum().text = count <= 0 and "" or tostring(count);
        end
    end
    if target:GetLikeSprite() ~= nil and not CS.StaticUtility.IsNull(target:GetLikeSprite()) then
        target:GetLikeSprite().gameObject:SetActive(stateCode ~= 0);
        --活动中不显示点赞
        if stateCode == 0 then
            target:GetLikeSprite().spriteName = LuaEnumActivityLikeType.HidePraise
        else
            target:GetLikeSprite().spriteName = self:GetLikeSprite(target.settleInfo)
        end
    end
end

--重写获得点赞图标
function UIActivityRankUnitShaBaKFeature:GetLikeSprite(settleInfo)
    if settleInfo == nil then
        return ''
    else
        if CS.CSScene.MainPlayerInfo.DuplicateV2:IsShaBaKLikeEachOther(settleInfo.rid) then
            --互赞 两个大拇指
            return LuaEnumActivityLikeType.MutualPraise
        elseif settleInfo:IsLiked() then
            --有赞 或者 往期回顾 发暗大拇指
            return LuaEnumActivityLikeType.NormalPraise
        else
            -- 未被赞 发光大拇指
            return LuaEnumActivityLikeType.HightPraise
        end
    end
end

function UIActivityRankUnitShaBaKFeature:RefreshTitle()
    local target = self.tbl;

    if target == nil or target.settleInfo == nil then
        return
    end
    if target:GetMvpSprite() == nil or CS.StaticUtility.IsNull(target:GetMvpSprite()) then
        return
    end
    local stateCode = CS.CSScene.MainPlayerInfo.DuplicateV2:GetShaBaKRankState()
    ---是否处于活动中
    local isInActivity = stateCode == 0 and uiStaticParameter.mIsCurrentShaBaK;
    target:GetMvpBgSprite().spriteName = self:GetMvpBgSprite(target.isLeft, target.settleInfo.isMvp and not isInActivity)
    --target.Mvp.gameObject:SetActive(true);
    if (target.settleInfo.isMvp and not isInActivity) then
        local isFind, name = CS.Cfg_GlobalTableManager.Instance.rankTitleIconNameDic:TryGetValue(self:GetTitleType(target.settleInfo.mvpType));
        if isFind then
            target:GetMvpSprite().spriteName = name
            target:GetMvpTween():PlayReverse()
        else
            target:GetMvpSprite().spriteName = ""
            --target.Mvp.gameObject:SetActive(false);
            target:GetMvpTween():PlayForward()
        end
    else
        target:GetMvpSprite().spriteName = ""
        --target.Mvp.gameObject:SetActive(false);
        target:GetMvpTween():PlayForward()
    end
    --target.Mvp:MakePixelPerfect();
end

function UIActivityRankUnitShaBaKFeature:GetTitleType(mvpType)
    if mvpType == 0 then
        --MVP
        return 1
    elseif mvpType == 3 then
        --最强护卫
        return 5
    elseif mvpType == 1 then
        --最多斩杀
        return 3;
    elseif mvpType == 5 then
        --最多战损
        return 8
    elseif mvpType == 2 then
        --最高伤害
        return 6
    elseif mvpType == 4 then
        --最多治疗
        return 7
    end
    return 0;
end

--重写点击点赞图标
function UIActivityRankUnitShaBaKFeature:OnLikeBtnClick()
    local target = self.tbl;
    if target == nil or target.settleInfo == nil then
        return
    end
    networkRequest.ReqLike(101, target.settleInfo.rid, uiStaticParameter.CurShaBaKRankIndex);
end

--重写点击详情按钮回调
function UIActivityRankUnitShaBaKFeature:OnDetailsBtnClick()
    --uimanager:CreatePanel("UIActivityShabakeInformationPanel", nil, { settleInfo = self.tbl.settleInfo, rankId = LuaEnuActivityRankID.ShaBaK })

    if self.tbl.settleInfo ~= nil then
        --CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(self.activityInfoClass.rid, LuaEnumOtherPlayerBtnType.ROLE,LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
        -- uimanager:ClosePanel("UIActivityInformationPanel")
        if (self.tbl.settleInfo.roleId == CS.CSScene.MainPlayerInfo.ID) then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Equip);
        else
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = self.tbl.settleInfo.roleId,
                roleName = self.tbl.settleInfo.name,
                roleSex = self.tbl.settleInfo.sex,
            })
        end
        uimanager:ClosePanel("UIActivityInformationPanel");
    end
end

return UIActivityRankUnitShaBaKFeature;