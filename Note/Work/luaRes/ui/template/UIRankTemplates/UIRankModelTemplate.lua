---@class UIRankModelTemplate:TemplateBase 排行榜模型展示模板
local UIRankModelTemplate = {}
--region 初始化
function UIRankModelTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end

function UIRankModelTemplate:InitComponents()

    ---@type UnityEngine.GameObject 模型父节点
    self.modelRoot = self:Get("roleModel", "GameObject")
    ---@type UnityEngine.GameObject 查看按钮
    self.checkBtn = self:Get("btn_euqip", "GameObject")
    ---@type Top_UILabel 玩家名称
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel 玩家行会名称
    self.guild = self:Get("guild", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.effectParent = self:Get("effect", "GameObject")
    ---@type CSUIEffectLoad
    self.effectLoad = self:Get("effect/FaZhenEffect", "CSUIEffectLoad")
    ---@type CSUIEffectLoad
    self.secondEffectLoad = self:Get("effect/FaZhenEffect2", "CSUIEffectLoad")
end

--初始化变量
function UIRankModelTemplate:InitParameters()
    ---@type table<number,LuaPlayerModelInfo>
    self.otherPlayerInfoDic = {}
    ---@type ObservationModel
    self.ObservationModel = nil
    ---当前显示模型的rank数据
    self.rankData = nil
    ---当前需要显示模型的人物id
    self.curRid = 0
end

function UIRankModelTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.checkBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.checkBtn).OnClickLuaDelegate = self.OnCheckBtnClick
    CS.UIEventListener.Get(self.effectParent).LuaEventTable = self
    CS.UIEventListener.Get(self.effectParent).OnClickLuaDelegate = self.OnEffectClickCallBack

end

--endregion

--region UI函数监听

function UIRankModelTemplate:OnCheckBtnClick(go)
    if self.rankData == nil then
        return
    end
    if self.curRid == CS.CSScene.MainPlayerInfo.ID then
        Utility.ShowPopoTips(go, nil, 308, "UIRankPanel")
        return
    end
    CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(self.curRid,
            LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
end

function UIRankModelTemplate:OnEffectClickCallBack()
    if self.csFaZhenItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.csFaZhenItemInfo })
    end
end

--endregion


---刷新视图
---@param rankType number
---@param targetRoleId number
---@param rankData rankV2.RoleRankDataInfo
function UIRankModelTemplate:RefreshView(rankType, targetRoleId, rankData)
    if not uiStaticParameter.UIRankManager:IsShowModel(rankType) then
        return
    end
    if self.curRid == targetRoleId then
        return
    end
    self.curRid = targetRoleId
    self.rankData = rankData

    self.name.text = rankData.name
    self.guild.text = rankData.unionName
    self:RefreshFaZhenData()
    self:TryCreatTargetModel()
    self:RefreshZhenFaEffect(rankData)
end

---尝试创建目标模型
---@param targetRoleId number
function UIRankModelTemplate:TryCreatTargetModel()
    if self.otherPlayerInfoDic[self.curRid] ~= nil then
        self:CreatTargetModel(self.otherPlayerInfoDic[self.curRid])
    else
        networkRequest.ReqGetRoleModelInfo(self.curRid)
    end
end

---创建目标模型
---@param LuaPlayerModelInfo LuaPlayerModelInfo
function UIRankModelTemplate:CreatTargetModel(luaPlayerModelInfo)
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self.modelRoot) then
        isModelChanged = self.ObservationModel:CreateRoleModel(luaPlayerModelInfo.Sex, luaPlayerModelInfo.Career,
                luaPlayerModelInfo.BodyModel, luaPlayerModelInfo.Weapon, luaPlayerModelInfo.Hair, luaPlayerModelInfo.Face, nil, self.modelRoot.transform,luaPlayerModelInfo.DouLi,luaPlayerModelInfo.LeftWeapon)
    end
    if isModelChanged then
        self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(0, 0, 0))
        self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.ObservationModel:SetScaleSize(CS.UnityEngine.Vector3(150, 150, 150))
    end
end

---刷新阵法特效
function UIRankModelTemplate:RefreshZhenFaEffect()

    if self.zhenfaInfoTbl[1] ~= nil then
        self.effectLoad:ChangeEffect(self.zhenfaInfoTbl[1].faZhenEffectName)
        self.effectLoad.transform.localPosition = self.zhenfaInfoTbl[1].faZhenLocalPosition
        self.effectLoad.transform.localScale = self.zhenfaInfoTbl[1].faZhenScale
        if not self.effectLoad.gameObject.activeSelf then
            self.effectLoad.gameObject:SetActive(true)
        end
    else
        if self.effectLoad.gameObject.activeSelf then
            self.effectLoad.gameObject:SetActive(false)
        end
    end

    if self.zhenfaInfoTbl[2] ~= nil then
        self.secondEffectLoad:ChangeEffect(self.zhenfaInfoTbl[2].faZhenEffectName)
        self.secondEffectLoad.transform.localPosition = self.zhenfaInfoTbl[2].faZhenLocalPosition
        self.secondEffectLoad.transform.localScale = self.zhenfaInfoTbl[2].faZhenScale
        if not self.secondEffectLoad.gameObject.activeSelf then
            self.secondEffectLoad.gameObject:SetActive(true)
        end
    else
        if self.secondEffectLoad.gameObject.activeSelf then
            self.secondEffectLoad.gameObject:SetActive(false)
        end
    end
end

function UIRankModelTemplate:ClearModel()
    if self.ObservationModel == nil then
        return
    end
    self.ObservationModel:ClearModel()
    self.curRid = 0
    self.rankData = nil
    self.csFaZhenItemInfo = nil
end

function UIRankModelTemplate:ChangeState(isOpen)
    self.go:SetActive(isOpen)
end

function UIRankModelTemplate:OnRoleModelInfoCallBack(serverData)
    local roleModelInfo = Utility.AnalysisOtherPlayerModelInfo(serverData)
    self.otherPlayerInfoDic[serverData.roleId] = roleModelInfo
    if serverData.roleId == self.curRid then
        self:CreatTargetModel(roleModelInfo)
    end
end

function UIRankModelTemplate:RefreshFaZhenData()
    if self.rankData == nil then
        self.zhenfaInfoTbl = {}
        self.csFaZhenItemInfo = nil
        return
    end

    self.csFaZhenItemInfo = nil
    self.zhenfaInfoTbl = clientTableManager.cfg_zhenfaManager:GetFaZhenEffectInfoList(self.rankData.zhenfaId)
    local tbl = clientTableManager.cfg_zhenfaManager:TryGetValue(self.rankData.zhenfaId)
    if tbl then
        local itemId, isFind = tbl:GetItemId(), false
        isFind, self.csFaZhenItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
    end
end

return UIRankModelTemplate