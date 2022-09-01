---@class UIGoMapBtnUnit:luaobject
local UIGoMapBtnUnit = {};

UIGoMapBtnUnit.mMapId = 0;
UIGoMapBtnUnit.mFreshTime = 0;
UIGoMapBtnUnit.mDeliverId = 0;
UIGoMapBtnUnit.mType = 0;
UIGoMapBtnUnit.mParent = nil;
UIGoMapBtnUnit.dark = CS.UnityEngine.Color(135 / 225, 135 / 255, 135 / 255, 1)
UIGoMapBtnUnit.hei = CS.UnityEngine.Color(221 / 225, 230 / 255, 235 / 255, 1)

function UIGoMapBtnUnit:GetBtnGo_GameObject()
    return self.go;
end

function UIGoMapBtnUnit:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("backGround", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UIGoMapBtnUnit:GetMapName_Text()
    if (self.mMapName_Text == nil) then
        self.mMapName_Text = self:Get("lab_name", "UILabel");
    end
    return self.mMapName_Text;
end

function UIGoMapBtnUnit:Init()
    --luaDebug.LogError("UIGoMapBtnUnit Init")
    self:InitEvents();
end

function UIGoMapBtnUnit:InitEvents()
    CS.UIEventListener.Get(self:GetBtnGo_GameObject()).onClick = function(go)
        self:OnClickBtnGo(go);
    end;
end

---@param data table
---data.parent (UIGoMapBtnView 创建本单元的视图)
---data.freshTime (number 怪物刷新时间)
---data.mapId (地图id)
---data.deliverId (传送id)
---data.type (boss类型)
---data.bossVo
function UIGoMapBtnUnit:ShowWithData(data)
    self.mParent = data.parent;
    self.mFreshTime = data.freshTime;
    self.mMapId = data.mapId;
    self.mDeliverId = data.deliverId;
    self.mType = data.bossVo.type;
    self.mBossVo = data.bossVo;
    local mapNameStr = ''
    if (data.bossVo.type == LuaEnumBossType.FinalBoss) then
        local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(self.mMapId);
        if (isFind) then
            mapNameStr = mapTable.name
        end
    else
        local isFind
        isFind, self.tableValue = CS.Cfg_BossTableManager.Instance:TryGetValue(data.bossVo.id);
        if isFind then
            local nameArray = string.Split(self.tableValue.mapName, '#')
            if #nameArray > 0 then
                mapNameStr = (self.mFreshTime > 0 and #nameArray > 1) and nameArray[2] or nameArray[1]
                local length = CS.Utility_Lua.StringByteLength(mapNameStr)

                local isfind, size = CS.Cfg_GlobalTableManager.Instance.BossMapFontSizeDic:TryGetValue(length)
                if isfind then
                    self:GetMapName_Text().fontSize = size
                else
                    self:GetMapName_Text().fontSize = CS.Cfg_GlobalTableManager.Instance.BossMapNormalFontSize
                end
            end
        end
    end

    ---判断是否符合进入条件，更改色值
    if not self:IsMeetCondition() then
        local colorArray = LuaGlobalTableDeal.GetBossGoMapUnitColorTbl()
        if colorArray then
            mapNameStr = string.gsub(mapNameStr, colorArray[1], colorArray[2])
        end
    end

    self:GetMapName_Text().text = mapNameStr
    self:GetBackGround_UISprite().spriteName = self.mFreshTime > 0 and 'bo2' or 'bo1';
    --    self:GetMapName_Text().color = self.mFreshTime > 0 and self.dark or self.hei
end

function UIGoMapBtnUnit:OnClickBtnGo(go)
    if self.tableValue and self.tableValue.level and self.tableValue.level ~= 0 then
        local isMeet, conditionType = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionOfID(self.tableValue.level)
        if not isMeet then
            if conditionType == LuaEnumConditionKeyType.GreatePlayerLevel or conditionType == LuaEnumConditionKeyType.LessPlayerLevel then
                Utility.ShowPopoTips(go, nil, 256, 'UIBossPanel')
            elseif conditionType == LuaEnumConditionKeyType.GreatReincarnationLevel or conditionType == LuaEnumConditionKeyType.LessReincarnationLevel then
                Utility.ShowPopoTips(go, nil, 255, 'UIBossPanel')
            elseif conditionType == LuaEnumConditionKeyType.JoinStorage then
                ---未加入商会 弹窗 点击打开商会面板
                local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(107)
                if isFind then
                    local temp = {}
                    temp.Content = string.gsub(info.des, '\\n', '\n')
                    temp.CenterDescription = info.leftButton
                    temp.ID = 107
                    temp.CallBack = function(go)
                        uimanager:ClosePanel("UIPromptPanel")
                        uimanager:CreatePanel("UICommercePanel")
                    end
                    uimanager:CreatePanel("UIPromptPanel", nil, temp)
                end
            end
            return
        end
    end
    ---传送至比奇传送员,之后打开传送界面
    local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(self.mMapId, self.mDeliverId)
    if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
        res = CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            self:OnClickBtnGo(go)
        end)
        if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
            uimanager:ClosePanel("UIBossPanel");
        else
            return
        end
    end
    uimanager:ClosePanel("UIBossPanel");
end

function UIGoMapBtnUnit:OnDestruct()
    --luaDebug.Log("UIGoMapBtnUnit OnDestruct")
end

function UIGoMapBtnUnit:IsMeetCondition()
    if self.tableValue and self.tableValue.level and self.tableValue.level ~= 0 then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionOfID(self.tableValue.level)
    end
    return true
end

return UIGoMapBtnUnit;