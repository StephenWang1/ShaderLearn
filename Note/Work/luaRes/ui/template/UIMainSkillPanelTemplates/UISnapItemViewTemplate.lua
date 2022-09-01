local UISnapItemViewTemplate = {}

--region 初始化

function UISnapItemViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UISnapItemViewTemplate:InitParameters()
    --数据
    self.allSnapItemPromptList = {}
    --视图
    self.allSnapUnitTemplateDic = {}
end

function UISnapItemViewTemplate:InitComponents()
    self.itemList = self:Get("itemList", "Top_UIGridContainer")
    self.autofight = self:Get("autofight", "GameObject")
end
--endregion

--region 临时道具列表

---刷新临时道具
function UISnapItemViewTemplate:RefreshSnapItemPrompt()
    self.itemList.MaxCount = #self.allSnapItemPromptList
    for i, v in pairs(self.allSnapItemPromptList) do
        local go = self.itemList.controlList[i - 1]
        if go then
            local temp = self.allSnapUnitTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UISnapItemUnitTemplate) or self.allSnapUnitTemplateDic[go]
            local info = {}
            info.ItemInfo = v
            info.clickCallBack = v.clickCallBack
            info.timeEndCallBack = v.timeEndCallBack
            temp:SetTemplate(info)
            if self.allSnapUnitTemplateDic[go] == nil then
                self.allSnapUnitTemplateDic[go] = temp
            end
        end
    end
    if luaEventManager.HasCallback(LuaCEvent.SnapItemGridChange) then
        luaEventManager.DoCallback(LuaCEvent.SnapItemGridChange)
    end
end

---添加临时道具提示
---@param temp.itemId number itemId
---@param temp.lid number 物品唯一id
---@param temp.clickCallBack function 点击回调
---@param temp.panelPriority  number 面板参数  如果需要打开面板
function UISnapItemViewTemplate:AddSnapItemPrompt(temp)
    if temp == nil or temp.itemId == nil then
        return
    end
    local snapItemTemp = {}
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(temp.itemId)
    if isFind then
        snapItemTemp.itemId = itemInfo.id
        snapItemTemp.lid = temp.lid == nil and -1 or temp.lid
        snapItemTemp.icon = temp.icon ~= nil and temp.icon or itemInfo.icon
        snapItemTemp.panelPriority = temp.panelPriority == nil and -1 or temp.panelPriority
        snapItemTemp.clickCallBack = temp.clickCallBack
        snapItemTemp.timeEndCallBack = temp.timeEndCallBack
    end
    local isfind, info = CS.Cfg_GlobalTableManager.Instance.snapItemTimeDic:TryGetValue(temp.itemId)
    if isfind then
        snapItemTemp.time = info
    end
    local meetTemp = false
    for i, v in pairs(self.allSnapItemPromptList) do
        if snapItemTemp.lid == v.lid and snapItemTemp.itemId == v.itemId then
            meetTemp = true
            break
        end
    end
    if not meetTemp then
        table.insert(self.allSnapItemPromptList, snapItemTemp)
        --table.sort(self.allSnapItemPromptList, function(a, b)
        --    return a.priority < b.priority
        --end)
    end
    self:RefreshSnapItemPrompt()
end

---删除临时道具提示
---@param id number itemId or lid
---@param type number   ex:1 itemId; 2 lid
function UISnapItemViewTemplate:RemoveSnapItemPrompt(type, id)
    local index = -1
    --获取索引
    for i, v in pairs(self.allSnapItemPromptList) do
        if id == v.itemId and type == 1 then
            index = i
            break
        elseif id == v.lid and type == 2 then
            index = i
            break
        end
    end
    if index ~= -1 then
        self.itemList:ClearItem(index - 1)
        table.remove(self.allSnapItemPromptList, index)
    end
    self:RefreshSnapItemPrompt()
end

---判断临时道具提示是否存在
---@param id number     itemId or lid
---@param type number   ex:1 itemId; 2 lid
function UISnapItemViewTemplate:CheckSnapItemPrompt(type, id)
    for i, v in pairs(self.allSnapItemPromptList) do
        if id == v.itemId and type == 1 then
            return true
        elseif id == v.lid and type == 2 then
            return true
        end
    end
    return false
end

function UISnapItemViewTemplate:TryAddSnapItemPrompt(temp, type)
    local isMeet = false
    local value = nil

    for i, v in pairs(self.allSnapItemPromptList) do
        if (temp.itemId == v.itemId and type == 1) or (temp.lid == v.lid and type == 2) then
            local isfind, info = CS.Cfg_GlobalTableManager.Instance.snapItemTimeDic:TryGetValue(temp.itemId)
            if isfind then
                v.time = info
                v.lid = temp.lid == nil and -1 or temp.lid
                v.clickCallBack = temp.clickCallBack
                v.timeEndCallBack = temp.timeEndCallBack
                isMeet = true
                value = v
                break
            end
        end
    end

    if isMeet then
        for i, v in pairs(self.allSnapUnitTemplateDic) do
            if (temp.itemId == v.itemId and type == 1) or (temp.lid == v.lid and type == 2) then
                v:RefreshTemplate(value)
                return
            end
        end
    else
        self:AddSnapItemPrompt(temp)
    end
end


--endregion


--region ondestroy

function UISnapItemViewTemplate:onDestroy()

end

--endregion

return UISnapItemViewTemplate