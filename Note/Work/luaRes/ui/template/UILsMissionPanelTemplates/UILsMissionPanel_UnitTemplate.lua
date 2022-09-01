---@class UILsMissionPanel_UnitTemplate:TemplateBase 灵兽任务单元模板
local UILsMissionPanel_UnitTemplate = {}

--region 初始化

function UILsMissionPanel_UnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UILsMissionPanel_UnitTemplate:InitParameters()
    ---@type LsMission
    self.curMissionData = nil
    self.mGoAndTemplateDic = {}
end

function UILsMissionPanel_UnitTemplate:InitComponents()
    ---@type Top_UILabel 任务介绍
    self.des = self:Get("Title", "Top_UILabel")
    ---@type Top_UISprite 底图
    self.di = self:Get("di", "Top_UISprite")
    ---@type UnityEngine.GameObject  已获取图片
    self.geted = self:Get("geted", "GameObject")
    ---@type UnityEngine.GameObject 获取按钮
    self.btn_get = self:Get("btn_get", "GameObject")
    ---@type UnityEngine.GameObject 获取按钮特效
    --self.getEffect = self:Get("btn_get/Effect", "GameObject")
    ---@type UnityEngine.GameObject 前往按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---@type UIGridContainer
    self.reward = self:Get("dropScroll/DropItem", "UIGridContainer")
end

function UILsMissionPanel_UnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
    CS.UIEventListener.Get(self.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = self.OnGoBtnClick
end

--endregion

--region Show
---@param data table
---@field data.missionData LsMission 灵兽任务信息
function UILsMissionPanel_UnitTemplate:SetTemplate(data)
    if data then
        self.curMissionData = data.missionData
        self:RefreshView()
    end
end

---刷新视图
function UILsMissionPanel_UnitTemplate:RefreshView()
    self:RefreshUnitLayerout()
    self:RefreshMissionView()
    self:RefreshRewardView()
end

---刷新任务视图
function UILsMissionPanel_UnitTemplate:RefreshMissionView()

    local color = self.curMissionData.maxFillValue > self.curMissionData.curFillValue and luaEnumColorType.Red or luaEnumColorType.Green
    local str = color .. self.curMissionData.curFillValue .. '[-]/' .. self.curMissionData.maxFillValue
    self.des.text = string.format(self.curMissionData.des, str)

    self.geted:SetActive(self.curMissionData.rewardState == LuaLsMissionStateEnum.Geted)
    self.btn_get:SetActive(self.curMissionData.rewardState == LuaLsMissionStateEnum.CanGet)
    self.btn_go:SetActive(self.curMissionData.rewardState == LuaLsMissionStateEnum.NotGet or
            self.curMissionData.rewardState == LuaLsMissionStateEnum.None)
end

---刷新奖励视图
function UILsMissionPanel_UnitTemplate:RefreshRewardView()
    if self.curMissionData.rewardInfo ~= nil then
        self.reward.MaxCount = #self.curMissionData.rewardInfo
        for i = 1, #self.curMissionData.rewardInfo do
            local data = self.curMissionData.rewardInfo[i]
            local go = self.reward.controlList[i - 1]

            local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(data.itemid)
            if isFind then
                local template = self.mGoAndTemplateDic[go]
                if template == nil then
                    template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                    self.mGoAndTemplateDic[go] = template
                end

                template:RefreshUIWithItemInfo(itemTbl, data.count)
                template:RefreshOtherUI({
                    showItemInfo = itemTbl
                })
            end
        end
    end
end

---刷新单元布局
function UILsMissionPanel_UnitTemplate:RefreshUnitLayerout()
    if self.curMissionData.unitParams == nil or #self.curMissionData.unitParams < 5 then
        return
    end

    self.di.spriteName = self.curMissionData.unitParams[1]

    self.go.transform.localPosition = { x = 1000 - tonumber(self.curMissionData.unitParams[2]),
                                        y = 1000 - tonumber(self.curMissionData.unitParams[3]), z = 0 }

    self.di.transform.localPosition = { x = 1000 - tonumber(self.curMissionData.unitParams[5]),
                                        y = 0, z = 0 }

    local flipNum = tonumber(self.curMissionData.unitParams[4])

    self.di.flip = flipNum == 0 and CS.UIBasicSprite.Flip.Nothing or
            flipNum == 1 and CS.UIBasicSprite.Flip.Horizontally or
            flipNum == 2 and CS.UIBasicSprite.Flip.Vertically or CS.UIBasicSprite.Flip.Both
end


--endregion

--region UI函数监听

---点击领取
function UILsMissionPanel_UnitTemplate:OnGetBtnClick(go)
    if self.curMissionData == nil then
        return
    end
    networkRequest.ReqGetRewards(self.curMissionData.lsTaskId)
end

---点击前往
function UILsMissionPanel_UnitTemplate:OnGoBtnClick(go)

    if self.curMissionData == nil then
        return
    end
    if self.curMissionData.jumpType == 3 then
        ---跳转npc并打开面板
        Utility.TryTransfer(tonumber(self.curMissionData.jumpId))
    else
        ---进行跳转
        uiTransferManager:TransferToPanel(self.curMissionData.jumpId)
    end
    luaEventManager.DoCallback(LuaCEvent.ClickWeaponBookUnit, self.curMissionData)
    uimanager:ClosePanel("UILsMissionPanel")
end

--endregion


--region otherFunction



--endregion

--region ondestroy

function UILsMissionPanel_UnitTemplate:onDestroy()

end

--endregion

return UILsMissionPanel_UnitTemplate