---@class UITextTipsContainerTemplate 提示容器模板
local UITextTipsContainerTemplate = {}

--region 初始化
function UITextTipsContainerTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

--控件变量
function UITextTipsContainerTemplate:InitComponents()
    self.TipTemplate_GameObject = self:Get("UITip", "GameObject")
end
--初始化 变量 按钮点击 服务器消息事件等
function UITextTipsContainerTemplate:InitOther()
    --最大数量
    self.mMaxCount = 5
    --间隔
    self.mInterval = 5
    --当前tips
    self.mCurTipsList = {}
    --当前tips
    self.mCurTipsObjList = {}
    --池
    self.mTipsPool = {}
    if self.TipTemplate_GameObject then
        self.TipTemplate_GameObject:SetActive(false)
    end
end
--endregion

function UITextTipsContainerTemplate:Show(maxCount, interval)
    self.mMaxCount = maxCount
    self.mInterval = interval
end

--region 公开的方法
---添加tips
---@param commonData.tipsType LuaEnumTextTipsType
---@param commonData.firstStr string
---@param commonData.secondStr string
---@param commonData.firstIconName string
---@param commonData.secondIconName string
---@param commonData.itemId number
function UITextTipsContainerTemplate:AddTips(commonData)
    --如果超出,则不播放
    local tipsCount = #self.mCurTipsList
    if tipsCount >= self.mMaxCount then
        return
    end

    --解析参数（是否有必须要有的参数）
    if self:AnalysisParams(commonData) == false then
        return
    end

    --生成
    local poolCount = #self.mTipsPool
    local goTemp = nil
    if poolCount >= 1 then
        goTemp = self.mTipsPool[poolCount]
        table.remove(self.mTipsPool)
    else
        if self.TipTemplate_GameObject == nil then
            return
        end
        goTemp = CS.UnityEngine.GameObject.Instantiate(self.TipTemplate_GameObject)
        goTemp:SetActive(true);
    end
    goTemp.transform:SetParent(self.go.transform)
    goTemp:SetActive(true)
    goTemp.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    ---@type UITipsTemplate
    local template = self:GetTemplateForGameObject(goTemp, self.template)
    if template == nil then
        return
    end
    table.insert(self.mCurTipsObjList, 1, goTemp)
    table.insert(self.mCurTipsList, 1, template)

    --播放
    tipsCount = #self.mCurTipsList
    for i = 1, tipsCount do
        local tips = self.mCurTipsList[i]
        local form = CS.UnityEngine.Vector3(0, 0, 0)
        if i ~= 1 then
            form = self.mCurTipsObjList[i].transform.localPosition
        end
        local to = CS.UnityEngine.Vector3(0, (i - 1) * self.mInterval, 0)
        tips:Play(form, to)
    end
    template:Show(self, commonData)
    --goTemp:SetActive(true)
end

---根据GameObject和Template获取go上绑定的Template
---@param go UnityEngine.GameObject
---@param template TemplateBase
function UITextTipsContainerTemplate:GetTemplateForGameObject(go, template)
    if go == nil or template == nil or CS.StaticUtility.IsNull(go) then
        return
    end
    local goID = go:GetInstanceID()
    if self.mTemplatesForGo == nil then
        ---@type table<number, table<string, TemplateBase>>
        self.mTemplatesForGo = {}
    end
    local chunkName = template.chunkName
    if chunkName == nil then
        return
    end
    local templateDic = self.mTemplatesForGo[goID]
    if templateDic == nil then
        templateDic = {}
        self.mTemplatesForGo[goID] = templateDic
    end
    local templateTemp = templateDic[chunkName]
    if templateTemp ~= nil then
        return templateTemp
    else
        templateTemp = templatemanager.GetNewTemplate(go, template)
        templateDic[chunkName] = templateTemp
        return templateTemp
    end
end

---移除tips
function UITextTipsContainerTemplate:RemoveTips(tips)
    for i = #self.mCurTipsList, 1, -1 do
        if self.mCurTipsList[i] == tips then
            table.remove(self.mCurTipsList, i)
            local goTemp = self.mCurTipsObjList[i]
            --goTemp.transform.localScale = CS.UnityEngine.Vector3.zero;
            goTemp:SetActive(false)
            table.remove(self.mCurTipsObjList, i)
            table.insert(self.mTipsPool, goTemp)
        end
    end
end

---解析参数
function UITextTipsContainerTemplate:AnalysisParams(commonData)
    if commonData == nil or commonData.firstStr == nil or commonData.tipsType == nil then
        return false
    end
    if commonData.itemId ~= nil then
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(commonData.itemId)
        if itemInfoIsFind then
            if CS.StaticUtility.IsNullOrEmpty(commonData.firstIconName) == true then
                commonData.firstIconName = itemInfo.icon
            end

            local prefix = CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality)
            local second = commonData.secondStr
            if CS.StaticUtility.IsNullOrEmpty(second) == false and second and prefix then
                commonData.secondStr = prefix .. second  --attempt to concatenate a nil value
            end
        end
    end
    self.template = self:GetTemplateByTipsType(commonData.tipsType)
    if self.template == nil then
        return false
    end
    return true
end
--endregion

--region 获取
function UITextTipsContainerTemplate:GetTemplateByTipsType(tipsType)
    if tipsType == LuaEnumTextTipsType.MiddleTips or tipsType == LuaEnumTextTipsType.LeftBottomTips or tipsType == LuaEnumTextTipsType.DelayMiddleTips then
        return luaComponentTemplates.UITipsTemplate
    elseif tipsType == LuaEnumTextTipsType.MiddleTopTips then
        return luaComponentTemplates.UITipsMiddleTopTemplate
    end
end
--endregion

return UITextTipsContainerTemplate