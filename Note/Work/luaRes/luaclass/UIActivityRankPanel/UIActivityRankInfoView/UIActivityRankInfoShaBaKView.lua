local UIActivityRankInfoShaBaKView = {};

UIActivityRankInfoShaBaKView.mUIItemDic = nil;

setmetatable(UIActivityRankInfoShaBaKView, luaclass.UIActivityRankInfoViewBase)

--设置行会信息
function UIActivityRankInfoShaBaKView:SetUnionInfo(data)
    if(data ~= nil) then
        self.uninname.text = data.settleInfo.unionName
    end
end

--刷新详细子类型数据
function UIActivityRankInfoShaBaKView:SetInfoValueUnit(lebel, index, data)
    if CS.CSScene.MainPlayerInfo == nil or data == nil then
        return ''
    end
    local allShaBaKValue = CS.CSScene.MainPlayerInfo.DuplicateV2:GetAllShaBaKValue();
    if allShaBaKValue == nil then
        return ''
    end
    if index == 0 then
        local tatio = allShaBaKValue.allKillCount == 0 and 0 or data.settleInfo.killCount / allShaBaKValue.allKillCount * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.killCount .. '(' .. tatio .. '%)'
    elseif index == 1 then
        local tatio = allShaBaKValue.allDamage == 0 and 0 or data.settleInfo.damage / allShaBaKValue.allDamage * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.damage .. '(' .. tatio .. '%)'
    elseif index == 2 then
        local tatio = allShaBaKValue.allHurt == 0 and 0 or data.settleInfo.hurt / allShaBaKValue.allHurt * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.hurt .. '(' .. tatio .. '%)'
    elseif index == 3 then
        local tatio = allShaBaKValue.allCure == 0 and 0 or data.settleInfo.cure / allShaBaKValue.allCure * 100
        tatio = string.format('%.1f', tatio)
        lebel.text = data.settleInfo.cure .. '(' .. tatio .. '%)'
    end
end

---是否显示战勋列表
function UIActivityRankInfoShaBaKView:IsShowZhanSun()
    return true
end

function UIActivityRankInfoShaBaKView:RefreshOther(data)
    if(self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end
    if(data ~= nil and data.settleInfo ~= nil) then
        if(data.settleInfo.loseItems.Count > 0) then
            self.zhansunGridContainer.MaxCount = data.settleInfo.loseItems.Count;
            for i = 0, data.settleInfo.loseItems.Count - 1 do
                local gobj = self.zhansunGridContainer.controlList[i];
                if(self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local itemId = data.settleInfo.loseItems[i];
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                if(isFind) then
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable);
                else
                    self.mUIItemDic[gobj]:ResetUI();
                end
                CS.UIEventListener.Get(gobj).onClick = function()
                    if(isFind) then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false })
                    end
                end
            end
        else
            self:ResetLoseContainer();
        end
    else
        self:ResetLoseContainer();
    end
end

function UIActivityRankInfoShaBaKView:ResetLoseContainer()
    self.zhansunGridContainer.MaxCount = 3;
    for i = 0, self.zhansunGridContainer.MaxCount - 1 do
        local gobj = self.zhansunGridContainer.controlList[i];
        if(self.mUIItemDic[gobj] == nil) then
            self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
        end
        self.mUIItemDic[gobj]:ResetUI();
    end
end

---重写bg自适应
function UIActivityRankInfoShaBaKView:AdaptiveOfItemCount()

end

return UIActivityRankInfoShaBaKView;