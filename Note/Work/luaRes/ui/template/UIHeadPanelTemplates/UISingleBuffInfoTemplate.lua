---@class UISingleBuffInfoTemplate:TemplateBase 单个buff信息模板
local UISingleBuffInfoTemplate = {}

--region 初始化
function UISingleBuffInfoTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

function UISingleBuffInfoTemplate:InitComponent()
    ---@type UISprite
    self.icon_UISprite = self:Get("UIItem/icon", "UISprite")
    ---@type UILabel
    self.name_UILabel = self:Get("UIItem/name", "UILabel")
    ---@type UILabel
    self.txt_UILabel = self:Get("baseInfo/Center/Txt", "UILabel")
    ---@type UITable
    self.buffTable = self:Get("baseInfo/Center", "UITable")
    ---@type UILabel
    self.attribute_UILabel = self:Get("baseInfo/Center/attribute", "UILabel")
    ---@type UIToggle
    self.mOpenBuffBtn = self:Get("Open", "UIToggle")
    ---@type UISprite
    self.AutoSkill_bg = self:Get("Open/Sprite", "UISprite")
    self.AutoSkill_thumb = self:Get("Open/thumb", "GameObject")
end

function UISingleBuffInfoTemplate:BindEvents()
    CS.EventDelegate.Add(self.mOpenBuffBtn.onChange, function()
        self:OnOpenBuffBtnChange(self.mOpenBuffBtn.value)
    end)
end
--endregion

--region 刷新
---@param buffTbl TABLE.CFG_BUFF
---@param customBuffInfo CustomBuffInfo
function UISingleBuffInfoTemplate:RefreshSingleBuffInfo(buffTbl, customBuffInfo, rid)
    local isSameBuffer = self:IsSameBuffer(customBuffInfo.buffInfo.Info.bufferId)
    if self:AnalysisParams(buffTbl, customBuffInfo) == false then
        luaclass.UIRefresh:RefreshActive(self.go, false)
        return
    end
    self.lid = rid
    self:RefreshPanel(isSameBuffer ~= true)
end

---解析数据
---@param buffTbl TABLE.CFG_BUFF
---@param customBuffInfo CustomBuffInfo
---@return boolean 解析状态
function UISingleBuffInfoTemplate:AnalysisParams(buffTbl, customBuffInfo)
    if buffTbl == nil or customBuffInfo == nil or customBuffInfo.buffInfo == nil then
        return false
    end
    self.buffTbl = buffTbl
    self.buffSourceType = customBuffInfo.type
    self.customBuffInfo = customBuffInfo
    self.csBuffInfoItem = customBuffInfo.buffInfo
    self.serverBuffInfo = customBuffInfo.buffInfo.Info
    self.buffLid = self.serverBuffInfo.bufferId
    self.buffType = buffTbl.type
    self.buffConfigId = self.buffTbl.id
    if self.serverBuffInfo ~= nil then
        self.attributeList = Utility.CSListChangeTable(self.serverBuffInfo.addValue)
    end
    return true
end

---刷新buff
---@param needAutoAdujust boolean 是否自动矫正
function UISingleBuffInfoTemplate:RefreshPanel(needAutoAdujust)
    luaclass.UIRefresh:RefreshSprite(self.icon_UISprite, self.buffTbl.icon)
    luaclass.UIRefresh:RefreshLabel(self.name_UILabel, self.buffTbl.name)
    self:RefreshAttribute()
    self:RefreshTxtDes()
    self:RefreshOpenBtn()
    if needAutoAdujust == true then
        luaclass.UIRefresh:RefreshUITable(self.buffTable)
    end
end

---刷新文本描述
function UISingleBuffInfoTemplate:RefreshTxtDes()
    local buffDes = self.buffTbl.txt
    if CS.StaticUtility.IsNullOrEmpty(buffDes) == false then
        if self.buffSourceType == LuaEnumBuffSourceType.ServerBuff and self.buffType == LuaEnumBuffType.BloodStone then
            ---气血石
            buffDes = string.format(buffDes, tostring(self.serverBuffInfo.bufferValue), tostring(self.serverBuffInfo.bufferValue2))
        elseif self.buffType == LuaEnumBuffType.WristStrengthOrEnergy then
            if self.buffTbl.subType == 1 then
                ---腕力buff
                local curValue = self.serverBuffInfo.bufferValue / LuaGlobalTableDeal:GetWristStrengthScale()
                curValue = Utility.FloatRounding(curValue, 0)
                local maxValue = LuaGlobalTableDeal:GetWristStrengthMaxValue() / LuaGlobalTableDeal:GetWristStrengthScale()
                maxValue = Utility.FloatRounding(maxValue, 0)
                local strInfo = curValue == 0 and luaEnumColorType.Red .. tostring(curValue) .. '[-]/' .. tostring(maxValue)
                        or tostring(curValue) .. '/' .. tostring(maxValue)
                buffDes = string.format(buffDes, strInfo)
            elseif self.buffTbl.subType == 2 then
                ---精力buff
                local curValue = self.serverBuffInfo.bufferValue / LuaGlobalTableDeal:GetEnergyScale()
                curValue = Utility.FloatRounding(curValue, 0)
                local maxValue = LuaGlobalTableDeal:GetEnergyMaxValue() / LuaGlobalTableDeal:GetEnergyScale()
                maxValue = Utility.FloatRounding(maxValue, 0)
                local strInfo = curValue == 0 and luaEnumColorType.Red .. tostring(curValue) .. '[-]/' .. tostring(maxValue)
                        or tostring(curValue) .. '/' .. tostring(maxValue)
                buffDes = string.format(buffDes, strInfo)
            end
        elseif self.buffType == LuaEnumBuffType.AnimalBossHurtBuff then
            ---获取buff显示信息
            local buffValue, buffValueTwo = LuaGlobalTableDeal:GetMeetAnimalBossServantBuffShowInfo()
            buffDes = string.format(buffDes, tostring(buffValue), string.format("%0.0f", buffValueTwo) .. '%')
            luaclass.UIRefresh:RefreshSprite(self.icon_UISprite, self.buffTbl.icon .. '_' .. buffValue)
        elseif self.buffType == LuaEnumBuffType.ForShowOnly then
            if self.buffConfigId == 13009001 then
                ---联服封印塔伤害buff
                local percentage = luaclass.SealTowerDataInfo.towerAddDamagePercentage / 100
                --print("luaclass.SealTowerDataInfo.towerAddDamagePercentage", luaclass.SealTowerDataInfo.towerAddDamagePercentage)
                local num1, num2 = math.modf(percentage)
                percentage = num2 == 0 and num1 or percentage
                buffDes = string.format(buffDes, Utility.CombineStringQuickly(percentage, "%"))
            elseif self.buffConfigId == 13009002 then
                local num = self.serverBuffInfo.bufferValue
                --showingStr = string.format(buffTab.txt, string.format("%0.0f", num) .. '%')
                buffDes = string.format(buffDes, Utility.CombineStringQuickly(num, "%"))
            end
        elseif self.buffType == LuaEnumBuffType.BossShieldBuff then
            local shieldValue = self.serverBuffInfo.bufferValue
            if type(shieldValue) ~= 'number' or shieldValue < 0 then
                shieldValue = 0
            end
            buffDes = string.format(buffDes, tostring(shieldValue))
        elseif self.buffType == LuaEnumBuffType.Violent then
            ---狂暴buff显示，这样写是因为服务器不愿意消息里赋值
            local avatar = CS.CSScene.Sington:getAvatar(self.lid)
            local monsterId = 0
            if avatar and avatar.AvatarType == CS.EAvatarType.Monster and avatar.BaseInfo.monsterTable ~= nil then
                monsterId = avatar.BaseInfo.monsterTable.id
            end
            local luaMonsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
            if luaMonsterTbl ~= nil and luaMonsterTbl:GetRageHurtTips() ~= nil then
                local num = luaMonsterTbl:GetRageHurtTips() / 100
                local t1, t2 = math.modf(num)
                if t2 > 0 then
                    buffDes = string.format(buffDes, string.format("%0.0f", num) .. '%')
                else
                    buffDes = string.format(buffDes, tostring(t1) .. '%')
                end
            end
        elseif self.buffType == LuaEnumBuffType.FeiSheng then
            local maxNum = 0
            local buffValueStr
            if self.buffTbl.parameter ~= nil and self.buffTbl.parameter.list ~= nil and self.buffTbl.parameter.list.Count > 0 then
                maxNum = self.buffTbl.parameter.list[0]
            end
            buffValueStr = tostring(self.serverBuffInfo.bufferValue)
            if self.serverBuffInfo.bufferValue >= maxNum then
                buffValueStr = buffValueStr .. ' (Max)'
            end
            ---飞升buff
            buffDes = string.format(buffDes, buffValueStr)
        elseif self.buffType == LuaEnumBuffType.AutoPick then
            local state = Utility.IsPlayerAutoPickOpen()
            local show = state == 3 and "" or (state == 1 and "开启" or "关闭")
            buffDes = string.format(buffDes, show)
        elseif self.buffType == LuaEnumBuffType.AutoGather then
            ---自动挖掘
            buffDes = string.format(buffDes, CS.CSSceneExt.Sington.GatherController.LastAutoGatherTimes)
        end
    end
    buffDes = string.gsub(buffDes, '\\n', '\n')
    luaclass.UIRefresh:RefreshLabel(self.txt_UILabel, buffDes)
end

---刷新属性
function UISingleBuffInfoTemplate:RefreshAttribute()
    if type(self.attributeList) ~= 'table' or Utility.GetLuaTableCount(self.attributeList) <= 0 then
        luaclass.UIRefresh:RefreshActive(self.attribute_UILabel, false)
        return
    end
    local attributeDes = clientTableManager.cfg_attribute_showManager:GetAttributeDes(self.attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeDes) then
        luaclass.UIRefresh:RefreshActive(self.attribute_UILabel, false)
        return
    end
    luaclass.UIRefresh:RefreshLabel(self.attribute_UILabel, attributeDes)
    luaclass.UIRefresh:RefreshActive(self.attribute_UILabel, true)
end

---刷新buff开启按钮
function UISingleBuffInfoTemplate:RefreshOpenBtn()
    local panel = uimanager:GetPanel('UIBuffTipsPanel')
    self.mOpenBuffBtn.gameObject:SetActive(false)
    if (panel ~= nil and CS.CSScene.MainPlayerInfo.ID ~= panel.taregetLid) then
        self.mOpenBuffBtn.gameObject:SetActive(false)
    else
        local isAutoPick = self.buffType == LuaEnumBuffType.AutoPick
        if isAutoPick then
            local state = Utility.IsPlayerAutoPickOpen()
            local lasting = state ~= 3
            self.mOpenBuffBtn.gameObject:SetActive(lasting)
            local isChoose = state == 1
            if lasting and self.mOpenBuffBtn.value ~= isChoose then
                self.mOpenBuffBtn.value = isChoose
            end
        end
    end
end

---buff开启按钮改变
function UISingleBuffInfoTemplate:OnOpenBuffBtnChange(choose)
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if self.buffType == LuaEnumBuffType.AutoPick and mainPlayerInfo then
        CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.AutoPickUpByBuffer, choose and 1 or 2)
        self:RefreshTxtDes()
    end
    self.AutoSkill_bg.spriteName = choose and 'slbg2' or 'slbg'
    local posX = choose and -12 or -45
    self.AutoSkill_thumb.transform.localPosition = CS.UnityEngine.Vector3(posX, 10, 0)
end
--endregion

--region 查询
---是否石相同的buff
---@param lid number buffLid
---@return boolean
function UISingleBuffInfoTemplate:IsSameBuffer(lid)
    return self.buffLid == lid
end
--endregion

return UISingleBuffInfoTemplate