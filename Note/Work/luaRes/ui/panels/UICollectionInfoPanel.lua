---藏品的连锁属性信息界面
---@class UICollectionInfoPanel:UIBase
local UICollectionInfoPanel = {}

---背景碰撞盒
---@return UnityEngine.GameObject
function UICollectionInfoPanel:GetBgBox()
    if self.mBgBox == nil then
        self.mBgBox = self:GetCurComp("WidgetRoot/window/box", "GameObject")
    end
    return self.mBgBox
end

---连锁属性名
---@return UILabel
function UICollectionInfoPanel:GetLinkEffectNameLabel()
    if self.mLinkEffectNameLabel == nil then
        self.mLinkEffectNameLabel = self:GetCurComp("WidgetRoot/infoPanel/ItemName", "UILabel")
    end
    return self.mLinkEffectNameLabel
end

---连锁属性的icon
---@return UISprite
function UICollectionInfoPanel:GetLinkEffectIconSprite()
    if self.mLinkEffectIconSprite == nil then
        self.mLinkEffectIconSprite = self:GetCurComp("WidgetRoot/infoPanel/ItemIcon", "UISprite")
    end
    return self.mLinkEffectIconSprite
end

---属性模板物体
---@return UnityEngine.GameObject
function UICollectionInfoPanel:GetLinkEffectAttributeTemplateGo()
    if self.mLinkEffectAttributeTemplateGo == nil then
        self.mLinkEffectAttributeTemplateGo = self:GetCurComp("WidgetRoot/infoPanel/ItemInfo/baseattributetemplate", "GameObject")
    end
    return self.mLinkEffectAttributeTemplateGo
end

---总属性容器
---@return UnityEngine.GameObject
function UICollectionInfoPanel:GetLinkEffectAttributeRootGo()
    if self.mLinkEffectAttributeRootGo == nil then
        self.mLinkEffectAttributeRootGo = self:GetCurComp("WidgetRoot/infoPanel/ItemInfo/root", "GameObject")
    end
    return self.mLinkEffectAttributeRootGo
end

function UICollectionInfoPanel:Init()
    self:BindUIEvents()
    self:GetLinkEffectAttributeTemplateGo():SetActive(false)
end

function UICollectionInfoPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBgBox()).onClick = function()
        self:ClosePanel()
    end
end

---@param linkEffectTblList table<number, TABLE.cfg_linkeffect>
function UICollectionInfoPanel:Show(collectionInfo, career, linkEffectTblList)
    self.mCollectionInfo = collectionInfo
    self.mCareer = career
    if linkEffectTblList == nil or #linkEffectTblList == nil then
        self:ClosePanel()
        return
    end
    self.mLinkEffectTblList = linkEffectTblList
    self:RefreshUI()
end

---@private
function UICollectionInfoPanel:RefreshUI()
    if self.mLinkEffectTblList == nil or #self.mLinkEffectTblList == 0 then
        return
    end
    self:GetLinkEffectIconSprite().spriteName = self.mLinkEffectTblList[1]:GetTipIcon()
    self:GetLinkEffectNameLabel().text = self.mLinkEffectTblList[1]:GetTipName()
    local dataList = self:PrepareDataList(self.mLinkEffectTblList)
    self:RefreshAttributes(dataList)
end

---准备数据
---@private
---@param linkEffectTblList table<number, TABLE.cfg_linkeffect>
---@return table<number, UICollectionInfoPanel_AttributeChunk>
function UICollectionInfoPanel:PrepareDataList(linkEffectTblList)
    if linkEffectTblList == nil then
        return nil
    end
    ---@type table<number, UICollectionInfoPanel_AttributeChunk>
    local dataList = {}
    ---填入普通属性
    for i = 1, #linkEffectTblList do
        local tbl = linkEffectTblList[i]
        ---@type UICollectionInfoPanel_AttributeChunk
        local singleData = {}
        singleData.title = "[73ddf7]" .. tbl:GetDescription()
        local attrArray = {}
        singleData.array = attrArray
        if tbl:GetPhyAttMin() ~= 0 or tbl:GetPhyAttMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]攻  击",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetPhyAttMin(), "-", tbl:GetPhyAttMax())
            })
        end
        if tbl:GetMagicAttMin() ~= 0 or tbl:GetMagicAttMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]魔  法",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetMagicAttMin(), "-", tbl:GetMagicAttMax())
            })
        end
        if tbl:GetTaoAttMin() ~= 0 or tbl:GetTaoAttMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]道  术",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetTaoAttMin(), "-", tbl:GetTaoAttMax())
            })
        end
        if tbl:GetPhyDefMin() ~= 0 or tbl:GetPhyDefMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]防  御",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetPhyDefMin(), "-", tbl:GetPhyDefMax())
            })
        end
        if tbl:GetMagicDefMin() ~= 0 or tbl:GetMagicDefMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]魔  防",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetMagicDefMin(), "-", tbl:GetMagicDefMax())
            })
        end
        if tbl:GetHp() ~= nil and tbl:GetHp().list ~= nil and #tbl:GetHp().list > 0 then
            if self.mCareer == LuaEnumCareer.Warrior then
                table.insert(attrArray, {
                    key = "[dde6eb]血  量",
                    value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetHp().list[1].list[2])
                })
            elseif self.mCareer == LuaEnumCareer.Master then
                table.insert(attrArray, {
                    key = "[dde6eb]血  量",
                    value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetHp().list[2].list[2])
                })
            elseif self.mCareer == LuaEnumCareer.Taoist then
                table.insert(attrArray, {
                    key = "[dde6eb]血  量",
                    value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetHp().list[3].list[2])
                })
            end
        end
        if tbl:GetMp() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]蓝  量",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetMp())
            })
        end
        local criticalTemp = tbl:GetShowCritical() * 0.01
        criticalTemp = criticalTemp == math.floor(criticalTemp) and math.floor(criticalTemp) or criticalTemp
        if criticalTemp ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]暴  击",
                value = Utility.CombineStringQuickly("[dde6eb]", criticalTemp, "%")
            })
        end
        local resistanceCritTemp = tbl:GetResistanceCrit() * 0.01
        resistanceCritTemp = resistanceCritTemp == math.floor(resistanceCritTemp) and math.floor(resistanceCritTemp) or resistanceCritTemp
        if tbl:GetResistanceCrit() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]抗  暴",
                value = Utility.CombineStringQuickly("[dde6eb]", resistanceCritTemp, "%")
            })
        end
        if tbl:GetAccurate() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]准  确",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetAccurate())
            })
        end
        if tbl:GetDodge() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]敏  捷",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetDodge())
            })
        end
        if tbl:GetHolyAttackMin() ~= 0 or tbl:GetHolyAttackMax() ~= 0 then
            table.insert(attrArray, {
                key = "[dde6eb]切  割",
                value = Utility.CombineStringQuickly("[dde6eb]", tbl:GetHolyAttackMin(), "-", tbl:GetHolyAttackMax())
            })
        end
        table.insert(dataList, singleData)
    end
    return dataList
end

---@private
---@param dataList table<number, UICollectionInfoPanel_AttributeChunk>
function UICollectionInfoPanel:RefreshAttributes(dataList)
    if self.mAttributes == nil then
        ---@type table<number, UnityEngine.GameObject>
        self.mAttributes = {}
    end
    for i = #self.mAttributes, 1, -1 do
        self:PushTemplateToPool(self.mAttributes[i])
        table.remove(self.mAttributes, i)
    end
    if dataList == nil then
        return
    end
    local posY = 0
    for i = 1, #dataList do
        local data = dataList[i]
        local go = self:FetchAttributeTemplateGoFromPool()
        local attrCount = 0
        if data.array ~= nil then
            attrCount = #data.array
        end
        self:RefreshAttributeChunk(go, data)
        local pos = go.transform.localPosition
        pos.y = posY
        go.transform.localPosition = pos
        posY = posY - 32 - 26 * attrCount
    end
end

---从对象池中拿出模板物体
---@return UnityEngine.GameObject
function UICollectionInfoPanel:FetchAttributeTemplateGoFromPool()
    if self.mTemplateGoPool == nil then
        ---@type table<number, UnityEngine.GameObject>
        self.mTemplateGoPool = {}
    end
    local count = #self.mTemplateGoPool
    if count > 0 then
        local go = self.mTemplateGoPool[count]
        table.remove(self.mTemplateGoPool, count)
        go:SetActive(true)
        return go
    end
    local newGo = CS.Utility_Lua.CopyGO(self:GetLinkEffectAttributeTemplateGo(), self:GetLinkEffectAttributeRootGo().transform)
    newGo:SetActive(true)
    newGo.transform.localPosition = CS.UnityEngine.Vector3.zero
    newGo.transform.localScale = CS.UnityEngine.Vector3.one
    newGo.transform.localRotation = CS.UnityEngine.Quaternion.identity
    return newGo
end

---向对象池中压入模板物体
---@param templateGo UnityEngine.GameObject
function UICollectionInfoPanel:PushTemplateToPool(templateGo)
    if self.mTemplateGoPool == nil then
        self.mTemplateGoPool = {}
    end
    templateGo:SetActive(false)
    table.insert(self.mTemplateGoPool, templateGo)
end

---刷新属性块
---@private
---@alias UICollectionInfoPanel_AttributeChunk {title:string, array: table<number,{key:string,value:string}>}
---@param attributeChunkGo UnityEngine.GameObject
---@param data UICollectionInfoPanel_AttributeChunk
function UICollectionInfoPanel:RefreshAttributeChunk(attributeChunkGo, data)
    if data == nil or attributeChunkGo == nil then
        return
    end
    ---@type UILabel
    local titleLabel = self:GetComp(attributeChunkGo.transform, "title", "UILabel")
    ---@type UIGridContainer
    local gridContainer = self:GetComp(attributeChunkGo.transform, "Attr", "UIGridContainer")
    titleLabel.text = data.title
    gridContainer.MaxCount = #data.array
    for i = 1, #data.array do
        local singleData = data.array[i]
        ---@type UnityEngine.GameObject
        local singleAttrGo = gridContainer.controlList[i - 1]
        ---@type UILabel
        local singleAttrNameLabel = self:GetComp(singleAttrGo.transform, "AttrName", "UILabel")
        ---@type UILabel
        local singleAttrValueLabel = self:GetComp(singleAttrGo.transform, "AttrValue/AttrValue", "UILabel")
        singleAttrNameLabel.text = singleData.key
        singleAttrValueLabel.text = singleData.value
    end
end

return UICollectionInfoPanel