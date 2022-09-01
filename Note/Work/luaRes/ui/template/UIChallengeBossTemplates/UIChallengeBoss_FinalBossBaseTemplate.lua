---@class UIChallengeBoss_FinalBossBaseTemplate:UIChallengeBossBaseTemplates 终极boss基础模板
local UIChallengeBoss_FinalBossBaseTemplate = {}

setmetatable(UIChallengeBoss_FinalBossBaseTemplate, luaComponentTemplates.UIChallengeBossBaseTemplates)

--region 初始化
function UIChallengeBoss_FinalBossBaseTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---地图信息按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---地图名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---地图怪物数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---掉落道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "UIGridContainer")
    ---@type UIGridSpriteTiled bg平铺替换
    self.dropItemTiled = self:Get("dropScroll/DropItem", "UIGridSpriteTiled")
    ---UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---@type UISprite
    self.BlackModel_UISprite = self:Get("BlackModel", "Top_UISprite")
    ---@type UILabel
    self.BossRoomNum_UILabel = self:Get("RoomNum", "UILabel")
    ---@type UISprite 按钮背景图
    self.backGround_UISprite = self:Get("btn_go/backGround", "UISprite")
    ---@type Top_UISlider 怪物数量进度条
    self.bossNum_Slider = self:Get("Slider", "Top_UISlider")
    ---@type Top_UILabel 怪物进度条文本
    self.bossNumSlider_UIlabel = self:Get("Slider/Num", "UILabel")
end

function UIChallengeBoss_FinalBossBaseTemplate:InitOther()
    self:RunBaseFunction("InitOther")
    CS.UIEventListener.Get(self.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = self.OnClickBossInfoBtn
end

---点击怪物信息按钮
function UIChallengeBoss_FinalBossBaseTemplate:OnClickBossInfoBtn(go)
    if self.bossTable == nil then
        return
    end
    self:ClickOperation(self.bossTable, go)
end

--region  数据初始化
---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBoss_FinalBossBaseTemplate:InitData(data)
    if data == nil then
        return
    end
    ---@type table<number,bossV2.FieldBossInfo> boss信息服务器原生数据
    self.fieldBossInfoList = data
    ---@type bossV2.FieldBossInfo boss信息服务器单个数据
    self.fieldBossInfo = nil
    ---@type TABLE.cfg_boss boss表
    self.bossTable = nil
    ---@type TABLE.cfg_monsters 怪物表
    self.monsterTable = nil
    ---@type table<number,bossTemp.MapBtnInfo> boss表列表
    self.mapBtnInfoList = {}
    for i, v in pairs(data) do
        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(v.bossId)
        if self.fieldBossInfo == nil then
            self.fieldBossInfo = v
            self.bossTable = bossInfo
            if bossInfo ~= nil then
                local id = tonumber(bossInfo:GetConfId())
                if self.bossSubType ~= nil and self.bossSubType == LuaEnumFinalBossType.MythBoss and self.fieldBossInfo ~= nil then
                    id = self.fieldBossInfo.configId
                end
                self.monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(id)
            end
        end
        ---@class bossTemp.MapBtnInfo
        local mapBtnInfo = {
            ---@type TABLE.cfg_boss
            Info = bossInfo,
            ---@type number
            number = v.count
        }
        table.insert(self.mapBtnInfoList, mapBtnInfo)
    end
end
--endregion
--endregion

--region 刷新
---@param data table<number,bossV2.FieldBossInfo>
---@alias commonData {bossSubtype LuaEnumFinalBossType}
function UIChallengeBoss_FinalBossBaseTemplate:RefreshUI(data, ClipShader, commonData)
    self:AnalysisParams(commonData)
    self:ResetUI()
    self:InitData(data)
    if self.bossSubType == LuaEnumFinalBossType.MythBoss then
        self:MythBossRefresh(data, ClipShader)
    else
        self:AncientBossRefresh(data, ClipShader)
    end
    self:RefreshMapGrid()
    self:BaseRefresh()
end

---解析数据
---@alias commonData {bossSubtype LuaEnumFinalBossType,bossSubtype boolean}
function UIChallengeBoss_FinalBossBaseTemplate:AnalysisParams(commonData)
    self.bossSubType = commonData.bossSubtype
    self.activeState = commonData.activeState
end

---重置不必要显示的UI
function UIChallengeBoss_FinalBossBaseTemplate:ResetUI()
    luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite, false)
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel, false)
    luaclass.UIRefresh:RefreshActive(self.bossNum_Slider, false)
end

--region 基础刷新
---基础通用刷新
function UIChallengeBoss_FinalBossBaseTemplate:BaseRefresh()
    self:SetItemGrid(self.bossTable)
end

---设置掉落道具展示
function UIChallengeBoss_FinalBossBaseTemplate:SetItemGrid()
    if self.bossTable == nil then
        return
    end
    local monsterID = self.bossTable:GetConfId()
    if self.bossUnLock == true then
        monsterID = self.monsterTable.id
    end
    local dropList
    if clientTableManager.cfg_monstersManager ~= nil and clientTableManager.cfg_monstersManager.GetDropShowList ~= nil then
        dropList = clientTableManager.cfg_monstersManager:GetDropShowList(monsterID)
    end
    if dropList then
        self.dropItemGrid.MaxCount = #dropList
        if self.dropItemTiled~=nil then
            self.dropItemTiled.MaxCount = #dropList
        end
        for i = 1, #dropList do
            if dropList[i]:GetItemId() ~= nil then
                local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(dropList[i]:GetItemId())
                local go = self.dropItemGrid.controlList[i - 1]
                if infobool then
                    --local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                    local temp = self:GetItemTemplate(go)
                    temp:RefreshUIWithItemInfo(iteminfo, 1)
                    --temp:RefreshOtherUI({ tag = dropList[i]:GetTag() })
                    CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                        if temp.ItemInfo ~= nil then
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                        end
                    end
                end
            end
        end
    end
    self.UIScrollView:ResetPosition()
end

---@return UIChallengeBossFinalBossItem
function UIChallengeBoss_FinalBossBaseTemplate:GetItemTemplate(go)
    if self.mItemGoToItemTemplates == nil then
        self.mItemGoToItemTemplates = {}
    end
    local itemTemplate = self.mItemGoToItemTemplates[go]
    if itemTemplate == nil then
        itemTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIChallengeBossFinalBossItem)
        self.mItemGoToItemTemplates[go] = itemTemplate
    end
    return itemTemplate
end

---设置怪物信息按钮
function UIChallengeBoss_FinalBossBaseTemplate:SetBossInfoBtn()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local mapNameList = _fSplit(self.bossTable:GetMapName(), "#")
    local bossNum = self.fieldBossInfo.count
    local mainPlayerCanMeet = self:IsMeetCondition(self.bossTable)
    local name = ""
    local numberColor = ""
    local spriteName = ""
    if bossNum > 0 and mainPlayerCanMeet == true then
        ---有存活且可进入
        numberColor = "[00ff00]"
        spriteName = "bo1"
        name = tostring(mapNameList[1])
    elseif bossNum > 0 and mainPlayerCanMeet == false then
        ---有存货且不可进
        numberColor = "[00ff00]"
        spriteName = "bo1"
        name = tostring(mapNameList[3])
    elseif bossNum <= 0 then
        ---没有存活
        numberColor = "[878787]"
        spriteName = "bo2"
        name = tostring(mapNameList[2])
    end
    self.lab_name.text = name
    self.lab_num.text = ""
    if self.fieldBossInfo.type ~= LuaEnumFinalBossType.MythBoss then
        self.lab_num.text = numberColor .. self.fieldBossInfo.count .. "只"
    end
    self.backGround_UISprite.spriteName = spriteName
end
--endregion

--region 远古boss刷新
---远古boss刷新
function UIChallengeBoss_FinalBossBaseTemplate:AncientBossRefresh(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    luaclass.UIRefresh:RefreshActive(self.ModelRoot, true)
    self:RefreshKillProgress()
    self:SetBossInfoBtn()
end

---刷新击杀进度
function UIChallengeBoss_FinalBossBaseTemplate:RefreshKillProgress()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local monsterID = self.bossTable:GetConfId()
    if monsterID == nil or type(monsterID) ~= 'number' then
        return
    end
    local ancientBossTableInfoIsFind, ancientBossTableInfo = CS.Cfg_AncientBossTableManager.Instance:TryGetValue(monsterID)
    if ancientBossTableInfo == nil then
        return
    end
    local totalKillNum = ancientBossTableInfo.num
    if totalKillNum == nil or type(totalKillNum) ~= 'number' then
        return
    end
    --local progressValue = self.fieldBossInfo.killCount / totalKillNum
    --local progressTextDes = luaEnumColorType.Green .. tostring(self.fieldBossInfo.killCount) .. "/" .. tostring(totalKillNum)
    --luaclass.UIRefresh:RefreshActive(self.bossNum_Slider,true)
    --luaclass.UIRefresh:SetSliderProgress(self.bossNum_Slider,progressValue)
    --luaclass.UIRefresh:RefreshLabel(self.bossNumSlider_UIlabel,progressTextDes)
end
--endregion

--region 神级boss刷新
function UIChallengeBoss_FinalBossBaseTemplate:MythBossRefresh(data, ClipShader)
    self.OptimizeClipShaderScript = ClipShader
    self:InitMythBossData(data)
    self:RefreshModel(self.bossTable, self.monsterTable, self.ModelRoot)
    self:RefreshName(self.monsterTable)
    self:RefreshBossRoomNum()
    self:SetGodBossBtn()
end

---数据初始化
---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBoss_FinalBossBaseTemplate:InitMythBossData(data)
    ---@type boolean boss是否解锁
    self.bossUnLock = false
    self.bossRoomNum = 0
    self.bossBackGroundSpriteName = ""
    if self.fieldBossInfo ~= nil then
        self.bossUnLock = self.activeState and self:IsShieldMonsterId(self.monsterTable:GetId()) == false
        self.bossRoomNum = self.fieldBossInfo.peopleCount
    end
    if self.bossTable ~= nil then
        self.bossBackGroundSpriteName = self.bossTable:GetParameter()
    end
end

---是否是需要屏蔽的monsterId
---@param monsterId number 怪物id
---@return boolean 是否需要屏蔽
function UIChallengeBoss_FinalBossBaseTemplate:IsShieldMonsterId(monsterId)
    if monsterId == nil then
        return true
    end
    return monsterId < 10
end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_FinalBossBaseTemplate:RefreshModel(bossTable, monsterTable, RootGO)
    if bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    if self.bossUnLock == true and monsterTable ~= nil then
        self:ShowShenBossModel(bossTable, monsterTable, RootGO)
        luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite, false)
        luaclass.UIRefresh:RefreshActive(self.ModelRoot, true)
    else
        ---如果当前boss未解锁，则显示剪影
        luaclass.UIRefresh:RefreshSprite(self.BlackModel_UISprite, self.bossBackGroundSpriteName)
        luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite, true)
        luaclass.UIRefresh:RefreshActive(self.ModelRoot, false)
    end
end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_FinalBossBaseTemplate:ShowShenBossModel(bossTable, monsterTable, RootGO)
    if bossTable == nil or monsterTable == nil then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    --self.ObservationModel:ClearModel()
    self.ObservationModel.DefalutShaderType = 1
    self.ObservationModel:SetShowMotion(CS.CSMotion.Stand)
    self.ObservationModel:SetBindRenderQueue()
    self.ObservationModel:SetDragRoot(RootGO)
    local Scale = monsterTable:GetScale() * bossTable:GetModelScale() / 10000
    ---设置旋转
    self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    self.ObservationModel:ResetCurScale()
    ---设置缩放
    self.ObservationModel:SetScaleSizeforRatio(Scale)
    ---设置位置
    self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(bossTable:GetOffsetX(), bossTable:GetOffsetY(), 1500))

    ---创建模型
    self.ObservationModel:CreateModel(monsterTable:GetModel(), tonumber(monsterTable:GetHeadModel()), tonumber(monsterTable:GetWeapModel()), CS.EAvatarType.Monster, RootGO.transform, function()
        if self.OptimizeClipShaderScript ~= nil and self.ObservationModel ~= nil then
            self.OptimizeClipShaderScript:AddRenderList(self.ObservationModel.ModelRoot, true, false, true);
        end
    end)


end

---显示boss模型信息
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_FinalBossBaseTemplate:RefreshName(monsterTable)
    if self.bossTable == nil then
        return
    end
    if self.bossUnLock == true and monsterTable ~= nil then
        self:ShowShenBossModelInfo(monsterTable)
    else
        if self.bossTable ~= nil then
            self.name.text = self.bossTable:GetName()
        end
    end
end

function UIChallengeBoss_FinalBossBaseTemplate:ShowShenBossModelInfo(monsterTable)
    if monsterTable == nil then
        return
    end
    local nameColor = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTable:GetType()))
    self.name.text = nameColor .. monsterTable:GetName()
end

---刷新密室房间人数
function UIChallengeBoss_FinalBossBaseTemplate:RefreshBossRoomNum()
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel, false)
    if self.bossTable == nil or self.fieldBossInfo == nil or self.bossRoomNum == nil or self.bossRoomNum < 0 or self.bossUnLock == false then
        return
    end
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel, true)
    luaclass.UIRefresh:RefreshLabel(self.BossRoomNum_UILabel, "[878787]密室人数    [-][dde6eb]" .. tostring(self.bossRoomNum))
end

---刷新神级boss按钮状态
function UIChallengeBoss_FinalBossBaseTemplate:SetGodBossBtn()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local mapNameList = _fSplit(self.bossTable:GetMapName(), "#")
    local bossNum = self.fieldBossInfo.count
    local mainPlayerCanEnterRoom = luaclass.FinalBossDataInfo:GetMythBossDataInfo():CheckMainPlayerCanEnterMap(self.bossTable:GetMapId())
    local name = ""
    local numberColor = ""
    local spriteName = ""
    if bossNum > 0 then
        numberColor = luaEnumColorType.Green
        spriteName = "bo1"
        name = tostring(mapNameList[1])
    else
        numberColor = luaEnumColorType.Gray
        spriteName = "bo2"
        name = tostring(mapNameList[2])
    end
    --if mainPlayerCanEnterRoom and bossNum > 0 then
    --    numberColor = luaEnumColorType.Green
    --    spriteName="bo1"
    --    name = tostring(mapNameList[1])
    --elseif mainPlayerCanEnterRoom and bossNum <= 0 then
    --    numberColor = luaEnumColorType.Red
    --    spriteName="bo1"
    --    name = tostring(mapNameList[1])
    --elseif mainPlayerCanEnterRoom == false then
    --    numberColor = luaEnumColorType.Gray
    --    spriteName="bo2"
    --    name = tostring(mapNameList[2])
    --end
    self.lab_name.text = name
    self.lab_num.text = ""
    if self.bossSubType ~= LuaEnumFinalBossType.MythBoss or self.bossUnLock == true then
        self.lab_num.text = numberColor .. self.fieldBossInfo.count .. "只"
    end
    self.backGround_UISprite.spriteName = spriteName
end
--endregion

--region 刷新前往地图列表
---设置地图格子位置
function UIChallengeBoss_FinalBossBaseTemplate:SetMapGridPosition()
    if CS.StaticUtility.IsNull(self:GetSelectMap_UIScrollView()) or CS.StaticUtility.IsNull(self:GetSelectMap_UIPanel()) then
        return
    end
    self:GetSelectMap_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(0, -166, 0)
    self:GetSpringPanel().target = CS.UnityEngine.Vector3(0, -166, 0)
    --if #self.mapBtnInfoList >= 4 then
    --    self:GetSelectMap_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(0, -166+20, 0)
    --    self:GetSpringPanel().target = CS.UnityEngine.Vector3(0, -166+20, 0)
    --
    --else
    --    self:GetSelectMap_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(0, -166+20 - (4 - #self.mapBtnInfoList) * 53, 0)
    --    self:GetSpringPanel().target = CS.UnityEngine.Vector3(0, -166+20 - (4 - #self.mapBtnInfoList) * 53, 0)
    --end
    --self:GetSelectMap_UIPanel().clipOffset = CS.UnityEngine.Vector2(0, 0);

    self:GetSelectMap_UIScrollView():SetSoftnessValue(true, 3)
end
--endregion
--endregion

function UIChallengeBoss_FinalBossBaseTemplate:RefreshBossLevel()
    if self.monsterTable ~= nil then
        if type(self.monsterTable:GetLevel()) == 'number' and self.monsterTable:GetLevel() > 0 then
            luaclass.UIRefresh:RefreshLabel(self:GetLevel_UILabel(), tostring(self.monsterTable:GetLevel()) .. "级")
        end
    end
end

return UIChallengeBoss_FinalBossBaseTemplate