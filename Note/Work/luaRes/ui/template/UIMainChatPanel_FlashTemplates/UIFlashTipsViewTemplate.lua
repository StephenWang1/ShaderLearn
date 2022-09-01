---@class UIFlashTipsViewTemplate 闪烁提示
local UIFlashTipsViewTemplate = {}

--region 初始化

function UIFlashTipsViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIFlashTipsViewTemplate:InitParameters()
    --数据
    self.allFlashPromptList = {}
    --视图
    self.allTemplateDic = {}
end

function UIFlashTipsViewTemplate:InitComponents()
    self.falshGrid = self:Get("item_messageAlterGrid", "Top_UIGridContainer")
end

--endregion

---刷新闪烁提示
function UIFlashTipsViewTemplate:RefreshFlashPromptView()
    self.falshGrid.MaxCount = #self.allFlashPromptList
    for i, v in pairs(self.allFlashPromptList) do
        local go = self.falshGrid.controlList[i - 1]
        if go then
            local temp = self.allTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIFlashTipsUnitTemplate, self) or self.allTemplateDic[go]
            local info = {}
            info.falshInfo = v
            info.isShowEffect = self:CheckIsShowEffect(v)
            info.clickCallBack = function()
                if v.clickCallBack ~= nil then
                    v.clickCallBack()
                end
                if v.panelName then
                    uimanager:CreatePanel(v.panelName, nil, v.panelPriority)
                end
            end
            temp:SetTemplate(info)
            if self.allTemplateDic[go] == nil then
                self.allTemplateDic[go] = temp
            end
        end
    end
end

---添加闪烁提示
---@param temp.id number flash表
---@param temp.configid number 唯一id
---@param temp.effectPlayInfo tabel 用于特效播放
---@param temp.clickCallBack function 点击回调
---@param temp.panelPriority  number 面板参数  如果需要打开面板
---@param temp.showIntervalTime number 显示的间隔时间
---@param temp.mTime number 結束時間（服務器時間+間隔時間）
function UIFlashTipsViewTemplate:AddFlashPrompt(temp)
    if temp == nil then
        return
    end
    local flashTemp = {}
    local isFind, flashInfo = CS.Cfg_FlashTableManager.Instance.dic:TryGetValue(temp.id)
    if isFind then
        flashTemp.id = temp.id
        self.tempID = temp.id
        flashTemp.configid = temp.configid == nil and -1 or temp.configid
        flashTemp.icon = temp.icon == nil and flashInfo.iconId or temp.icon
        flashTemp.priority = flashInfo.priority
        flashTemp.panelName = flashInfo.param
        flashTemp.panelPriority = temp.panelPriority == nil and -1 or temp.panelPriority
        flashTemp.clickCallBack = temp.clickCallBack
        flashTemp.mTime = temp.mTime
        flashTemp.effectPlayInfo = temp.effectPlayInfo
        flashTemp.showIntervalTime = ternary(temp.showIntervalTime == nil or temp.showIntervalTime < 0,0,temp.showIntervalTime)
    end

    local meetTemp = false
    for i, v in pairs(self.allFlashPromptList) do
        if flashTemp.id == v.id and flashTemp.configid == v.configid and v.id ~= 10 then
            meetTemp = true
            break
        end
    end
    if not meetTemp then
        table.insert(self.allFlashPromptList, flashTemp)
        table.sort(self.allFlashPromptList, function(a, b)
            return a.priority < b.priority
        end)
    end
    if(self:CheckEndTimeToOpenPop(flashTemp.id,flashTemp.showIntervalTime) == true) then
        self:RefreshFlashPromptView()
    end
end

---删除闪烁提示
---@param itemid number 物品ID or ConfigID
---@param type number   ex:1 id; 2 configid
function UIFlashTipsViewTemplate:RemoveFlashPrompt(type, itemid)
    local index = -1
    --获取索引
    for i, v in pairs(self.allFlashPromptList) do
        if itemid == v.id and type == 1 then
            index = i
            break
        elseif itemid == v.configid and type == 2 then
            index = i
            break
        end
    end
    if index ~= -1 then
        self.falshGrid:ClearItem(index - 1)
        table.remove(self.allFlashPromptList, index)
    end
end

---判断闪烁提示是否存在
function UIFlashTipsViewTemplate:CheckFlashPrompt(type, itemid)
    for i, v in pairs(self.allFlashPromptList) do
        if itemid == v.id and type == 1 then
            return true
        elseif itemid == v.configid and type == 2 then
            return true
        end
    end
    return false
end

---刷新闪烁提示(仅仅刷新点击方式)
function UIFlashTipsViewTemplate:RefreshFlashPrompt(temp)
    if temp == nil then
        return
    end
    for i, v in pairs(self.allFlashPromptList) do
        if temp.id == v.id and temp.configid == v.configid then
            v.clickCallBack = temp.clickCallBack
            return
        end
    end
end

---判断此提示是否播放特效
function UIFlashTipsViewTemplate:CheckIsShowEffect(info)
    if info == nil then
        return
    end
    if (info.effectPlayInfo ~= nil and info.effectPlayInfo ~= -1) then
        local info = info.effectPlayInfo.info
        if (info ~= nil and info.type == luaEnumItemType.Assist and info.subType == 4) then
            local isFind, gloinfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22055)
            if isFind then
                local tab = string.Split(gloinfo.value, "#")
                local level = tonumber(tab[1])
                local num = tonumber(tab[2])
                if (CS.CSScene.MainPlayerInfo.Level < tonumber(level)) then
                    if (CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(info.id) >= num) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

--region 间隔显示气泡
---气泡id -> 结束时间（毫秒）
UIFlashTipsViewTemplate.showPopEndTimeTable = {}

---加入气泡结束时间
function UIFlashTipsViewTemplate:AddShowPopEndTime(id,intervalTime)
    if self.showPopEndTimeTable ~= nil and type(self.showPopEndTimeTable) == 'table' and intervalTime > 0 then
        self.showPopEndTimeTable[id] = CS.CSScene.MainPlayerInfo.serverTime + intervalTime
    end
end

---检查结束时间是否显示气泡
function UIFlashTipsViewTemplate:CheckEndTimeToOpenPop(id,intervalTime)
    if intervalTime == nil or intervalTime <= 0 then
        return true
    end
    if self.showPopEndTimeTable ~= nil and type(self.showPopEndTimeTable) == 'table' then
        local endTime = self.showPopEndTimeTable[id]
        if endTime == nil then
            self:AddShowPopEndTime(id,intervalTime)
            return true
        else
            local isCanShowPop = CS.CSScene.MainPlayerInfo.serverTime - endTime > 0
            if isCanShowPop == true then
                self:AddShowPopEndTime(id,intervalTime)
            end
            return isCanShowPop
        end
    end
    return true
end
--endregion

--region ondestroy

function UIFlashTipsViewTemplate:onDestroy()

end

--endregion

return UIFlashTipsViewTemplate