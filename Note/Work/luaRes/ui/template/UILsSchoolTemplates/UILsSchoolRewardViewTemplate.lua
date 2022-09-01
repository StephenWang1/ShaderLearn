---灵兽试炼奖励展示模板
local UILsSchoolRewardViewTemplate = {}

function UILsSchoolRewardViewTemplate:GetModel_ObservationModel()
    if (self.mModel == nil) then
        self.mModel = CS.ObservationModel()
    end
    return self.mModel
end

--region 初始化

function UILsSchoolRewardViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UILsSchoolRewardViewTemplate:InitParameters()

    self.rewardData = nil
    self.page = 1
    self.maxValue = 1
    self.value = 0
    self.getEffect = nil
    self.getEffectPool = nil
    self.getRewardEffect = nil
    self.getRewardEffectPool = nil
    self.isLock = true
    self.lockCallBack = nil
    self.isInitLoadModel = true
end

function UILsSchoolRewardViewTemplate:InitComponents()
    ---@type Top_UILabel 奖励简介
    --self.Label = self:Get("Label", "Top_UILabel")
    ---@type Top_UISprite  物品展示(天成)
    self.showPic = self:Get("rewardParent/showPic", "Top_UISprite")
    ---@type Top_UISprite  物品展示(钻石)
    self.showPic2 = self:Get("rewardParent/showPic2", "Top_UISprite")
    ---@type UnityEngine.GameObject 领取按钮
    self.btn_get = self:Get("btn_get", "GameObject")
    ---@type UnityEngine.GameObject 解锁按钮
    self.btn_lock = self:Get("btn_lock", "GameObject")
    ---@type UnityEngine.GameObject 进度父节点
    self.lv_TaskFill = self:Get("lv_TaskFill", "GameObject")
    ---@type Top_UISprite 奖励进度
    self.Taskexp = self:Get("lv_TaskFill", "Top_UISlider")
    ---@type Top_UILabel  奖励进度值
    self.taskexpvalue = self:Get("lv_TaskFill/taskexpvalue", "Top_UILabel")
    ---@type UnityEngine.GameObject 已获得
    self.geted = self:Get("geted", "GameObject")
    ---@type Top_UILabel 获取按钮 文本
    self.getLabel = self:Get("btn_get/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 奖励父物体
    self.rewardParent = self:Get("rewardParent", "GameObject")
    ---@type UnityEngine.GameObject 领取按钮
    self.effect = self:Get("btn_get/Effect", "GameObject")
end

function UILsSchoolRewardViewTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
    CS.UIEventListener.Get(self.btn_lock).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_lock).OnClickLuaDelegate = self.OnLockBtnClick
    CS.UIEventListener.Get(self.showPic.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.showPic.gameObject).OnClickLuaDelegate = self.OnBGClick
end

function UILsSchoolRewardViewTemplate:BindNetMessage()

end

--endregion

--region Show

---@param data.itemID      number 物品ID
---@param data.Stc         number 当前章节
function UILsSchoolRewardViewTemplate:SetTemplate(data)
    if data then
        self.rewardData = data
        self.page = data.Stc
        self.closeCallBack = data.closeCallBack
        self:GetItemInfo(data.itemID)
        self:SetView()
        if data.lockCallBack ~= nil then
            self.lockCallBack = data.lockCallBack
        end
    end
end

function UILsSchoolRewardViewTemplate:SetView()
    if CS.CSMissionManager.Instance.LsMisssionMgr then
        local max = tostring(CS.CSMissionManager.Instance.LsMisssionMgr.lsMissionMaxCount)
        local cur = tostring(CS.CSMissionManager.Instance.LsMisssionMgr.finishLsMissionCount)
        self.taskexpvalue.text = '任务目标  (' .. cur .. "/" .. max .. ')'
    end
    self:SetBtn()
    self:SetSprite()
end

function UILsSchoolRewardViewTemplate:SetBtn()
    if CS.CSMissionManager.Instance.LsMisssionMgr then
        local isFind, state = CS.CSMissionManager.Instance.LsMisssionMgr.secStatuDic:TryGetValue(self.page)
        if isFind then
            local isfind, Lockstate = CS.CSMissionManager.Instance.LsMisssionMgr.secLockStatuDic:TryGetValue(self.page)
            local isGet = state == CS.LsMissionStatu.Get
            if isfind then
                self.isLock = state ~= CS.LsMissionStatu.Geted and Lockstate == CS.LsMissionRewardLockState.Lock and not isGet
                --self.getLabel.text = self.isLock and '快速解封' or "领取"
                self.btn_get:SetActive(self.isLock or isGet or Lockstate == CS.LsMissionRewardLockState.Get)
                self.btn_get:SetActive(not self.isLock and (isGet or Lockstate == CS.LsMissionRewardLockState.Get))
                self.btn_lock:SetActive(self.isLock)
                --self.geted:SetActive(state == CS.LsMissionStatu.Geted or Lockstate == CS.LsMissionRewardLockSta xte.Geted)
            else
                self.btn_get:SetActive(isGet)
                self.btn_lock:SetActive(false)
            end
            self.geted:SetActive(state == CS.LsMissionStatu.Geted)
            self:SetBtnEffectState(state == CS.LsMissionStatu.Get)
        end
    end
end

function UILsSchoolRewardViewTemplate:SetSprite()
    local isfind, Lockstate = CS.CSMissionManager.Instance.LsMisssionMgr.secLockStatuDic:TryGetValue(self.page)
    local Lock = isfind and Lockstate ~= CS.LsMissionRewardLockState.Lock
    self.showPic.gameObject:SetActive(not Lock)
    self.showPic2.gameObject:SetActive(Lock)
    if not Lock and self.isInitLoadModel then
        self:LoadServantModel()
    end
    --self.ShowPic.spriteName = isfind and Lockstate ~= CS.LsMissionRewardLockState.Lock and '1000001' or '1000002'
end

function UILsSchoolRewardViewTemplate:LoadServantModel()
    self.isInitLoadModel = false
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22153)
    if not isFind then
        return
    end
    local infoArray = string.Split(info.value, '#')
    local id = infoArray[1]
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if isFind and info.useParam ~= nil and info.useParam.list.Count > 0 then
        isFind, info = CS.Cfg_ServantTableManager.Instance:TryGetValue(info.useParam.list[0])
        if not isFind then
            return
        end
        self:GetModel_ObservationModel():ClearModel()
        self:GetModel_ObservationModel():SetShowMotion(CS.CSMotion.ShowStand)
        self:GetModel_ObservationModel():SetPosition(CS.UnityEngine.Vector3(0, -150 + info.y, -300))
        self:GetModel_ObservationModel():SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self:GetModel_ObservationModel():SetBindRenderQueue()
        self:GetModel_ObservationModel():SetDragRoot(self.showPic.gameObject)

        self:GetModel_ObservationModel():CreateModel(info.model, CS.EAvatarType.Monster, self.showPic.transform)
    end
end


--endregion

--region UI函数监听

function UILsSchoolRewardViewTemplate:OnGetBtnClick(go)
    networkRequest.ReqGetSecRewards(self.page)
end

function UILsSchoolRewardViewTemplate:OnLockBtnClick(go)
    --local panel = uimanager:GetPanel('UILsSchoolPanel')
    --uimanager:HidePanel(panel)
    self:ShowTips()
end

function UILsSchoolRewardViewTemplate:OnBGClick(go)
    uimanager:CreatePanel("UILsUnlockModePanel")
end

--endregion

--region otherFunction

function UILsSchoolRewardViewTemplate:GetItemInfo(id)
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        self.rewardData = itemInfo
    end
end

function UILsSchoolRewardViewTemplate:SetBtnEffectState(isOpen)
    if self.effect ~= nil and not CS.StaticUtility.IsNull(self.effect) then
        self.effect:SetActive(isOpen)
    end
end

--endregion

function UILsSchoolRewardViewTemplate:ShowTips()
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(64)
    if isFind then
        local needID = CS.Cfg_GlobalTableManager.Instance.unlockTCLSNeedCoinId
        local needCount = CS.Cfg_GlobalTableManager.Instance.unLockTCLSNeedCoinCount
        local coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(needID)
        local nowCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(needID)
        local temp = {}
        temp.IsClose = false
        temp.IsShowGoldLabel = true
        temp.Content = string.format(info.des, needCount, coinName)
        temp.Content = string.gsub(temp.Content, '\\n', '\n')
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(needID)
        if isFind then
            temp.GoldIcon = info.icon
        end
        --temp.DestroyCallBack = function()
        --    local panel = uimanager:GetPanel('UILsSchoolPanel')
        --    uimanager:ReShowPanel(panel)
        --end
        temp.GoldCount = needCount
        temp.ID = 248
        temp.CallBack = function(go)
            if nowCount < needCount then
                local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(248)
                if isfind then
                    local str = string.format(data.content, coinName)
                    Utility.ShowPopoTips(go.GetCenterButton_GameObject(), str, 248, "UILsUnlockModePanel")
                end
                return
            end
            networkRequest.ReqUnlockLingShouTask()
            uimanager:ClosePanel('UIPromptPanel')
            uimanager:ClosePanel('UILsUnlockModePanel')
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

function UILsSchoolRewardViewTemplate:OnDestroy()
    if CS.CSObjectPoolMgr.Instance ~= nil then
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(self.getEffectPool)
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(self.getRewardEffectPool)
    end
end

return UILsSchoolRewardViewTemplate