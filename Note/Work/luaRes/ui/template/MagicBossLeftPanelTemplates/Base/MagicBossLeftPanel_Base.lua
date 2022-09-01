local MagicBossLeftPanel_Base = {}

setmetatable(MagicBossLeftPanel_Base, luaComponentTemplates.UIRefreshTemplate)

---没有倒计时的时间默认文本格式
MagicBossLeftPanel_Base.DefaultTimeText = "击杀时限%s分钟"
---有倒计时的时间文本格式
MagicBossLeftPanel_Base.RemainTimeText = "%02.0f秒后血量回满"

--region 组件
---背景UIWidget
function MagicBossLeftPanel_Base:GetBG_UIWidget()
    if CS.StaticUtility.IsNull(self.BG_UIWidget) then
        self.BG_UIWidget = self:Get("window/bg", "UIWidget")
    end
    return self.BG_UIWidget
end

---标题label
function MagicBossLeftPanel_Base:GetTitle_UILabel()
    if CS.StaticUtility.IsNull(self.title_UILabel) then
        self.title_UILabel = self:Get("view/lb_name", "UILabel")
    end
    return self.title_UILabel
end

---时间label
function MagicBossLeftPanel_Base:GetTime_UILabel()
    if CS.StaticUtility.IsNull(self.time_UILabel) then
        self.time_UILabel = self:Get("view/Time", "UILabel")
    end
    return self.time_UILabel
end

---击杀数量label
function MagicBossLeftPanel_Base:GetKillNum_UILabel()
    if CS.StaticUtility.IsNull(self.killNum_UILabel) then
        self.killNum_UILabel = self:Get("view/Killnum", "UILabel")
    end
    return self.killNum_UILabel
end

---协助次数label
function MagicBossLeftPanel_Base:GetHelpNum_UILabel()
    if CS.StaticUtility.IsNull(self.helpNum_UILabel) then
        self.helpNum_UILabel = self:Get("view/helpnum", "UILabel")
    end
    return self.helpNum_UILabel
end

---条件描述内容label
function MagicBossLeftPanel_Base:GetConditionDes_UILabel()
    if CS.StaticUtility.IsNull(self.conditionDes_UILabel) then
        self.conditionDes_UILabel = self:Get("view/lb_des", "UILabel")
    end
    return self.conditionDes_UILabel
end

---中间按钮
function MagicBossLeftPanel_Base:GetCenterBtn_GameObject()
    if CS.StaticUtility.IsNull(self.centerBtn_GameObject) then
        self.centerBtn_GameObject = self:Get("events/btn_center", "GameObject")
    end
    return self.centerBtn_GameObject
end

---中间按钮图片
function MagicBossLeftPanel_Base:GetCenterBtn_Sprite()
    if CS.StaticUtility.IsNull(self.centerBtn_Sprite) then
        self.centerBtn_Sprite = self:Get("events/btn_center", "Top_UISprite")
    end
    return self.centerBtn_Sprite
end

---下部分父节点
function MagicBossLeftPanel_Base:GetDown_GameObject()
    if CS.StaticUtility.IsNull(self.down_GameObject) then
        self.down_GameObject = self:Get("view/down", "GameObject")
    end
    return self.down_GameObject
end

---协助奖励
function MagicBossLeftPanel_Base:GetReward_GameObject()
    if CS.StaticUtility.IsNull(self.reward_GameObject) then
        self.reward_GameObject = self:Get("view/down/HelpReward", "GameObject")
    end
    return self.reward_GameObject
end

---协助奖励列表
function MagicBossLeftPanel_Base:GetReward_GridContainer()
    if CS.StaticUtility.IsNull(self.reward_GridContainer) then
        self.reward_GridContainer = self:Get("view/down/HelpReward/Awards", "Top_UIGridContainer")
    end
    return self.reward_GridContainer
end

---协助奖励领取按钮
function MagicBossLeftPanel_Base:GetGetRewardBtn_GameObject()
    if CS.StaticUtility.IsNull(self.getRewardBtn_GameObject) then
        self.getRewardBtn_GameObject = self:Get("view/down/HelpReward/btn_get", "GameObject")
    end
    return self.getRewardBtn_GameObject
end

---击杀奖励
function MagicBossLeftPanel_Base:GetKillReward_GameObject()
    if CS.StaticUtility.IsNull(self.killReward_GameObject) then
        self.killReward_GameObject = self:Get("view/down/KillReward", "GameObject")
    end
    return self.killReward_GameObject
end

---击杀奖励列表
function MagicBossLeftPanel_Base:GetKillReward_GridContainer()
    if CS.StaticUtility.IsNull(self.killReward_GridContainer) then
        self.killReward_GridContainer = self:Get("view/down/KillReward/Awards", "Top_UIGridContainer")
    end
    return self.killReward_GridContainer
end

---击杀奖励领取按钮
function MagicBossLeftPanel_Base:GetGetKillRewardBtn_GameObject()
    if CS.StaticUtility.IsNull(self.getKillRewardBtn_GameObject) then
        self.getKillRewardBtn_GameObject = self:Get("view/down/KillReward/btn_get", "GameObject")
    end
    return self.getKillRewardBtn_GameObject
end

---击杀次数增加按钮
function MagicBossLeftPanel_Base:GetKillNumAddBtn_GameObject()
    if CS.StaticUtility.IsNull(self.killNumAddBtn_GameObject) then
        self.killNumAddBtn_GameObject = self:Get("view/add", "GameObject")
    end
    return self.killNumAddBtn_GameObject
end

---击杀次数增加按钮tween
function MagicBossLeftPanel_Base:GetKillNumAddBtn_UITweenAlpha()
    if CS.StaticUtility.IsNull(self.killNumAddBtn_UITweenAlpha) then
        self.killNumAddBtn_UITweenAlpha = self:Get("view/add", "Top_TweenAlpha")
    end
    return self.killNumAddBtn_UITweenAlpha
end

---击杀次数增加按钮UISprite
function MagicBossLeftPanel_Base:GetKillNumAddBtn_UISprite()
    if CS.StaticUtility.IsNull(self.killNumAddBtn_UISprite) then
        self.killNumAddBtn_UISprite = self:Get("view/add", "UISprite")
    end
    return self.killNumAddBtn_UISprite
end
--endregion

--region 刷新
function MagicBossLeftPanel_Base:RefreshPanel()
    if self:AnalysisParams() == false then
        self:ClosePanel()
    end
    self:InitParam()
    self:DefaultRefresh()
    self:RefreshCurPanel()
    self:RefreshViewDistribut()
end

function MagicBossLeftPanel_Base:InitParam()
    ---位置参数 1：有描述时down的posY 2：无描述时down的posY
    self.DistributPosParam = { 0, 25 }
    ---背景布局参数 1：有描述时bg的长度差值 2：无描述时背景的长度差值
    self.DistributBgOffset = { 0, 25 }
end

---解析参数
---@return boolean 解析数据是否成功
function MagicBossLeftPanel_Base:AnalysisParams()
    self.magicBossAvater = luaclass.MagicBossDataInfo.magicBossAvater
    if self.magicBossAvater == nil then
        return false
    end
    self.monsterTableInfo = luaclass.MagicBossDataInfo.monsterTableInfo
    self.magicBossTableInfo = luaclass.MagicBossDataInfo.magicBossTableInfo
    self.endTime = luaclass.MagicBossDataInfo.endTime
    self.magicBossType = self.magicBossTableInfo.dropType
    self.magicBossTypeInfo = luaclass.MagicBossDataInfo:GetMagicBossTypeInfoByType(self.magicBossType)
    self.magicBossHelpRewardTable = LuaGlobalTableDeal.GetMagicBossRewardTable()
    if self.monsterTableInfo ~= nil and CS.CSScene.MainPlayerInfo ~= nil and clientTableManager.cfg_demon_bossManager ~= nil and clientTableManager.cfg_demon_bossManager.GetMagicBossKillRewardTable ~= nil then
        self.magicBossKillRewardTable = clientTableManager.cfg_demon_bossManager:GetMagicBossKillRewardTable(self.monsterTableInfo.id, Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    end
    if self.magicBossAvater ~= nil and self.magicBossAvater.Head ~= nil and self.magicBossAvater.Head.ActorName ~= nil then
        self.monsterNameColor = self.magicBossAvater.Head.ActorName.color
    end
    if self.magicBossTypeInfo == nil then
        return false
    end
    return true
end

function MagicBossLeftPanel_Base:DefaultRefresh()
    self:RefreshActive(self:GetReward_GameObject(), false)
    self:RefreshActive(self:GetCenterBtn_GameObject(), false)
    self:RefreshActive(self:GetGetRewardBtn_GameObject(), false)
    self:RefreshActive(self:GetGetKillRewardBtn_GameObject(), false)
    self:RefreshActive(self:GetKillReward_GameObject(), true)
end

---具体面板的刷新
function MagicBossLeftPanel_Base:RefreshCurPanel()
    --标题
    self:RefreshLabel(self:GetTitle_UILabel(), self.monsterTableInfo.showLevel .. "级" .. self.monsterTableInfo.name, self.monsterNameColor)
    --倒计时
    if self.endTime == 0 then
        self:RefreshLabel(self:GetTime_UILabel(), string.format(luaEnumColorType.Red .. self.DefaultTimeText, tostring(Utility.RemoveEndZero(self.magicBossTableInfo.reFullTime / 60))))
    else
        self:RefreshLabel(self:GetTime_UILabel(), self:GetRemainTimeText())
    end
    --击杀次数
    --self.killNum = luaclass.MagicBossDataInfo:GetMagicBossTypeKillNum(self.magicBossType)+ luaclass.MagicBossDataInfo:GetBagMagicBossItemNumber(self.magicBossType)
    self.killNum = 0
    if self.magicBossTypeInfo ~= nil then
        self.killNum = self.magicBossTypeInfo:GetCurKillNum()
    end
    local killNumColor = ternary(self.killNum <= 0, luaEnumColorType.Red, luaEnumColorType.Green)
    local configInfoTemp = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(self.magicBossType)
    local killNumText
    if configInfoTemp then
        killNumText = killNumColor .. tostring(self.killNum) .. "[-]/" .. tostring(configInfoTemp.killNumMax)
    else
        killNumText = killNumColor .. tostring(self.killNum) .. "[-]/"
    end
    self:RefreshLabel(self:GetKillNum_UILabel(), killNumText)
    --协助次数
    self.helpNum = luaclass.MagicBossDataInfo:GetMagicBossTypeHelpNum(self.magicBossType)
    local helpNumColor = ternary(self.helpNum <= 0, luaEnumColorType.Red, luaEnumColorType.Green)
    local helpNumText = helpNumColor .. tostring(self.helpNum) .. "[-]/" .. tostring(LuaGlobalTableDeal.GetXieZhuMaxNum())
    self:RefreshLabel(self:GetHelpNum_UILabel(), helpNumText)
    --击杀次数增加按钮
    self:RefreshActive(self:GetKillNumAddBtn_GameObject(), false)
    self:RefreshAddBtnState()
    --击杀条件
    self:RefreshLabel(self:GetConditionDes_UILabel(), clientTableManager.cfg_demon_bossManager:GetMagicBossDes(self.monsterTableInfo.id))
    --击杀奖励
    self:RefreshGridContainer(self:GetKillReward_GridContainer(), self.magicBossKillRewardTable, function(go, info)
        self:RefreshItem(go, info)
    end)
    --协助奖励
    self:RefreshGridContainer(self:GetReward_GridContainer(), self.magicBossHelpRewardTable, function(go, info)
        self:RefreshItem(go, info)
    end)
end

---Update
function MagicBossLeftPanel_Base:Update()
    if self.endTime > 0 then
        local remainTime = luaclass.MagicBossDataInfo:GetRemainTime()
        if remainTime > 0 then
            self:RefreshLabel(self:GetTime_UILabel(), self:GetRemainTimeText())
        else
            self:RefreshLabel(self:GetTime_UILabel(), string.format(luaEnumColorType.Red .. self.DefaultTimeText, tostring(Utility.RemoveEndZero(self.magicBossTableInfo.reFullTime / 60))))
        end
    end
end

---刷新单个item格子
function MagicBossLeftPanel_Base:RefreshItem(go, info)
    if CS.StaticUtility.IsNull(go) == false and info ~= nil then
        local itemGridTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
        if itemGridTemplate ~= nil then
            itemGridTemplate:RefreshUIWithItemInfo(info.itemInfo, tonumber(info.count))
            itemGridTemplate:GetEventListener().onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info.itemInfo, showRight = false })
            end
            itemGridTemplate:RefreshGaiLvIcon(info.showGaiLv == true)
        end
    else
        go:SetActive(false)
    end
end
--endregion

--region 功能
function MagicBossLeftPanel_Base:ClosePanel()
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    if uiMainMenusPanel ~= nil then
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
    end
end

---刷新增加按钮状态
function MagicBossLeftPanel_Base:RefreshAddBtnState()
    --local haveAddKillNumItem = luaclass.MagicBossDataInfo:HaveAddKillItem(self.magicBossType)
    if CS.StaticUtility.IsNull(self:GetKillNumAddBtn_UITweenAlpha()) == false and CS.StaticUtility.IsNull(self:GetKillNumAddBtn_UISprite()) == false then
        if self.killNum ~= nil and self.killNum <= 0 then
            local haveItem = false
            local magicBossConfigInfo = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(self.magicBossType)
            if magicBossConfigInfo ~= nil then
                local addKillNumMaterialItemId = magicBossConfigInfo.killNumRecoverItemId
                if addKillNumMaterialItemId ~= nil then
                    local materialBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(addKillNumMaterialItemId)
                    if materialBagItemInfo ~= nil then
                        haveItem = true
                    end
                end
            end
            if haveItem then
                self:GetKillNumAddBtn_UISprite().spriteName = "add_small4"
                self:GetKillNumAddBtn_UITweenAlpha():Play()
            else
                self:GetKillNumAddBtn_UISprite().spriteName = "add_small3"
                self:GetKillNumAddBtn_UITweenAlpha():ResetToBeginning()
            end
        else
            self:GetKillNumAddBtn_UISprite().spriteName = "add_small3"
            self:GetKillNumAddBtn_UITweenAlpha():ResetToBeginning()
        end
    end
end
--endregion

--region 获取
---获取剩余时间文本
function MagicBossLeftPanel_Base:GetRemainTimeText()
    local remainTime = luaclass.MagicBossDataInfo:GetRemainTime()
    if self.endTime <= 0 or remainTime <= 0 then
        return self.DefaultTimeText, tostring(Utility.RemoveEndZero(self.magicBossTableInfo.reFullTime / 60))
    else
        remainTime = ternary(remainTime >= 0, remainTime, 0)
        local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
        return luaEnumColorType.Red .. string.format(self.RemainTimeText, hour * 24 + minute * 60 + second)
    end
end
--endregion

---刷新视图布局
function MagicBossLeftPanel_Base:RefreshViewDistribut()
    if self.monsterTableInfo == nil then
        return
    end
    local isHaveDis = clientTableManager.cfg_demon_bossManager:GetMagicBossDes(self.monsterTableInfo.id) ~= ""
    if self:GetDown_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetDown_GameObject()) then
        self:GetDown_GameObject().transform.localPosition = { x = 0, y = isHaveDis and self.DistributPosParam[1] or self.DistributPosParam[2], z = 0 }
    end
    if self:GetBG_UIWidget() ~= nil and not CS.StaticUtility.IsNull(self:GetBG_UIWidget().gameObject) then
        local origionHeight = self:GetBG_UIWidget().height
        self:GetBG_UIWidget().height = origionHeight - (isHaveDis and self.DistributBgOffset[1] or self.DistributBgOffset[2])
    end
    if self:GetCenterBtn_Sprite() ~= nil and not CS.StaticUtility.IsNull(self:GetCenterBtn_Sprite().gameObject) and self:GetCenterBtn_Sprite().gameObject.activeSelf then
        self:GetCenterBtn_Sprite():UpdateAnchors()
    end
end

return MagicBossLeftPanel_Base