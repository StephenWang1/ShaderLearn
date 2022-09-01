---@class UIBossPanel_AncientViewTemplate:UIBossPanel_BaseViewTemplate 远古boss视图
local UIBossPanel_AncientViewTemplate = {}

setmetatable(UIBossPanel_AncientViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

function UIBossPanel_AncientViewTemplate:InitTemplate(customData)
    self:RunBaseFunction('InitTemplate', customData)
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_AncientBossTemplates
end

function UIBossPanel_AncientViewTemplate:ResetData()
    self:RunBaseFunction('ResetData')
    self.curAllBossArray = nil
    ---储存远古boss的刷新个数
    self.curAllBossCountDic = {}
end

function UIBossPanel_AncientViewTemplate:GetSortedBossListInfo()
    return self.curAllBossArray
end

---是否显示左侧页签
---@protected
function UIBossPanel_AncientViewTemplate:IsShowLeftPageView()
    return true
end

function UIBossPanel_AncientViewTemplate:ParseBossTemplateInfo(info)
    local isCanChange = self.curAllBossCountDic[info.monsterId] ~= nil and self.curAllBossCountDic[info.monsterId] > 0
    return { allInfo = info.allInfo, bossCount = self.curAllBossStateDic[info.monsterId], canChange = isCanChange }
end

---解析数据
---@return boolean 是否解析成功
function UIBossPanel_AncientViewTemplate:ParsData(data)
    if data == nil or data.boss == nil or data.type ~= self.mBossType then
        return
    end
    local allBossInfo = {}
    for i = 1, #data.boss do
        local info = data.boss[i]
        local isFind, ancientBossTable = CS.Cfg_AncientBossTableManager.Instance:TryGetValue(info.configId)
        if isFind then
            if ancientBossTable.type == 1 then
                if allBossInfo[info.configId] == nil then
                    allBossInfo[info.configId] = {}
                end
                if self.curAllBossStateDic[info.configId] == nil then
                    self.curAllBossStateDic[info.configId] = info.killCount
                else
                    self.curAllBossStateDic[info.configId] = self.curAllBossStateDic[info.configId] + info.killCount
                end

                if self.curAllBossCountDic[info.configId] == nil then
                    self.curAllBossCountDic[info.configId] = info.count
                else
                    self.curAllBossCountDic[info.configId] = self.curAllBossStateDic[info.configId] + info.count
                end

                table.insert(allBossInfo[info.configId], info)
            end
        end
    end

    self.curAllBossArray = {}

    for i, v in pairs(allBossInfo) do
        local bossData = { bossId = v[1].bossId, monsterId = i, allInfo = v, freshTime = v[1].freshTime }
        table.insert(self.curAllBossArray, bossData)
    end

    if #self.curAllBossArray > 0 then
        table.sort(self.curAllBossArray, function(a, b)
            return self:SortBoss(a, b)
        end)
    end
end

function UIBossPanel_AncientViewTemplate:SortBoss(a, b)

    local aCanChange = self.curAllBossCountDic[a.monsterId] ~= nil and self.curAllBossCountDic[a.monsterId] > 0
    local bCanChange = self.curAllBossCountDic[b.monsterId] ~= nil and self.curAllBossCountDic[b.monsterId] > 0

    if aCanChange ~= bCanChange then
        return aCanChange
    end

    local aOrder = 0
    local bOrder = 0
    if a and b and a.bossId and b.bossId then
        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
        if bossInfo then
            aOrder = bossInfo:GetOrder()
            aOrder = aOrder == nil and 0 or aOrder
        end
        bossInfo = clientTableManager.cfg_bossManager:TryGetValue(b.bossId)
        if bossInfo then
            bOrder = bossInfo:GetOrder()
            bOrder = bOrder == nil and 0 or bOrder
        end
    end
    return aOrder < bOrder
end

return UIBossPanel_AncientViewTemplate