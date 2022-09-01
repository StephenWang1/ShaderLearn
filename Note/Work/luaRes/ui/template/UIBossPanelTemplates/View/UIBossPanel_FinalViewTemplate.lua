---@class UIBossPanel_FinalViewTemplate:UIBossPanel_BaseViewTemplate 神级boss视图
local UIBossPanel_FinalViewTemplate = {}

setmetatable(UIBossPanel_FinalViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

--region 初始化
---初始化组件
function UIBossPanel_FinalViewTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type Top_UILabel
    self.title = self:Get("Title", 'Top_UILabel')
    ---@type Top_UILabel
    self.time = self:Get("Table/time", 'Top_UILabel')
    ---@type Top_UILabel
    self.number = self:Get("Table/number", 'Top_UILabel')
    ---@type UnityEngine.GameObject
    self.addBtn_GameObject = self:Get("Table/add", 'GameObject')
    ---@type Top_UITable
    self.table_UITable = self:Get("Table", 'Top_UITable')
end

---设置组件默认显示状态
function UIBossPanel_FinalViewTemplate:SetComponentDefaultState()
    if CS.StaticUtility.IsNull(self.addBtn_GameObject) == false then
        self.addBtn_GameObject:SetActive(false)
    end
end
--endregion

--region 刷新
---页签点击后刷新
---@param pageInfo table 当前点击的页签策划配置数据
function UIBossPanel_FinalViewTemplate:ClickSubTypePage(pageInfo)
    if pageInfo == nil then
        return
    end
    self:RefreshParams(pageInfo)
    self:RefreshTitle(pageInfo.detailDes)
    self:ReqPageBossListInfo(LuaEnumBossType.FinalBoss,pageInfo.type)
    if pageInfo.type == LuaEnumFinalBossType.MythBoss then
        luaclass.FinalBossDataInfo:GetMythBossDataInfo():TryCloseGodBossRedPoint()
    end
end

---刷新参数
---@param pageInfo table 当前点击的页签策划配置数据
function UIBossPanel_FinalViewTemplate:RefreshParams(pageInfo)
    if pageInfo == nil then
        return
    end
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_FinalBossBaseTemplate
end

---刷新标题
---@param titleDes string 标题描述内容
function UIBossPanel_FinalViewTemplate:RefreshTitle(titleDes)
    if CS.StaticUtility.IsNull(self.title) == false then
        if CS.StaticUtility.IsNullOrEmpty(titleDes) == false then
            self.title.text = titleDes
        else
            self.title.gameObject:SetActive(false)
        end
    end
end

---刷新右上角描述内容
---@param pageInfo table 当前点击的页签策划配置数据
function UIBossPanel_FinalViewTemplate:RefreshRightUpDes(pageInfo)
    if pageInfo == nil then
        return
    end
    self:ResetRightUpDes()
    if pageInfo.type == LuaEnumFinalBossType.MythBoss then
        local activieBossNum = self:GetGodBossActiveNum()
        local des = luaEnumColorType.Green .. "已刷新"
        if activieBossNum <= 0 then
            des = luaclass.FinalBossDataInfo:GetMythBossDataInfo():GetRefreshTimeDes()
        end

        luaclass.UIRefresh:RefreshActive(self.table_UITable,true)
        luaclass.UIRefresh:RefreshActive(self.number,true)
        luaclass.UIRefresh:RefreshActive(self.time,true)
        luaclass.UIRefresh:RefreshLabel(self.number,luaEnumColorType.Gray .. "刷新时间")
        luaclass.UIRefresh:RefreshLabel(self.time,des)
        self.table_UITable:Reposition()
    end
end

---重置右上角显示
function UIBossPanel_FinalViewTemplate:ResetRightUpDes()
    luaclass.UIRefresh:RefreshActive(self.table_UITable,false)
    luaclass.UIRefresh:RefreshActive(self.time,false)
    luaclass.UIRefresh:RefreshActive(self.number,false)
    luaclass.UIRefresh:RefreshActive(self.addBtn_GameObject,false)
end
--endregion

--region 重写
---是否显示左侧页签
---@protected
function UIBossPanel_FinalViewTemplate:IsShowLeftPageView()
    return true
end

---重置数据
---@param tblData bossV2.ResFieldBossInfo lua table类型消息数据
function UIBossPanel_FinalViewTemplate:ResetData(tblData)
    self:CleanModels()
    if tblData == nil or tblData.subType == nil then
        self:RunBaseFunction("ResetData",tblData)
    else
        self.curList = nil
        self.targetPageType = nil
        self.mInitialized = false
        self.curAllBossDic = {}
        self.curAllBossStateDic = {}
        self.curBossPageStateDic = {}
        self.curAllSortedBossDic = {}
        --self.curAllBossDic[tblData.subType] = nil
        --self.curAllBossStateDic[tblData.subType] = nil
        --self.curBossPageStateDic[tblData.subType] = nil
        --self.curAllSortedBossDic[tblData.subType] = nil
    end
end

---解析数据
---@return boolean 是否解析成功
function UIBossPanel_FinalViewTemplate:ParsData(data)
    ---处理服务器boss数据
    if data == nil or data.boss == nil or data.type ~= self.mBossType then
        return
    end
    if self:GetBossPage() == nil then
        return
    end
    for i = 1, #data.boss do
        local info = data.boss[i]
        if info.bossId ~= nil then
            local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(info.bossId)
            if bossInfo then
                local subType = bossInfo:GetSubType()

                if self.curAllBossDic[subType] == nil then
                    self.curAllBossDic[subType] = {}
                end
                if self.curAllBossDic[subType][bossInfo:GetConfId()] == nil then
                    self.curAllBossDic[subType][bossInfo:GetConfId()] = {}
                end

                if self.curAllBossStateDic[subType] == nil then
                    self.curAllBossStateDic[subType] = {}
                end
                if Utility.IsMeetBossCondition(bossInfo) then
                    if self.curAllBossStateDic[subType][bossInfo:GetConfId()] == nil then
                        self.curAllBossStateDic[subType][bossInfo:GetConfId()] = info.count
                    else
                        self.curAllBossStateDic[subType][bossInfo:GetConfId()] = self.curAllBossStateDic[subType][bossInfo:GetConfId()] + info.count
                    end
                end

                if self.curAllIsMeetBossStateDic[subType] == nil then
                    self.curAllIsMeetBossStateDic[subType] = {}
                end
                self.curAllIsMeetBossStateDic[subType][info.bossId] = Utility.IsMeetBossCondition(bossInfo)

                if self.curAllIsMeetBossIsSurviveDic[subType] == nil then
                    self.curAllIsMeetBossIsSurviveDic[subType] = {}
                end
                if self.curAllIsMeetBossIsSurviveDic[subType][bossInfo:GetConfId()] == nil then
                    self.curAllIsMeetBossIsSurviveDic[subType][bossInfo:GetConfId()] = info.count
                else
                    self.curAllIsMeetBossIsSurviveDic[subType][bossInfo:GetConfId()] = self.curAllIsMeetBossIsSurviveDic[subType][bossInfo:GetConfId()] + info.count
                end

                table.insert(self.curAllBossDic[subType][bossInfo:GetConfId()], info)
            end
        end
    end
    for k1, v in pairs(self.curAllBossStateDic) do
        local pageState = true
        for k2, v2 in pairs(v) do
            if v2 > 0 then
                pageState = false
            end
        end
        self.curBossPageStateDic[k1] = pageState
    end
    self:RefreshRightUpDes(self.curSelectPageInfo)
    if(self.curSelectPageInfo.type == LuaEnumFinalBossType.AncientBoss and not uiStaticParameter.IsEnterAncientBossPanel) then
        uiStaticParameter.IsEnterAncientBossPanel = true;
        gameMgr:GetLuaRedPointManager():CallRedPointKey(Utility.EnumToInt(CS.RedPointKey.BOSS_ANCIENT));
    end
    return
end

---清理原模板里的所有的模型
function UIBossPanel_FinalViewTemplate:CleanModels()
    if self:GetAllBossUnitTemplateDic() ~= nil then
        for k,v in pairs(self:GetAllBossUnitTemplateDic()) do
            --if v ~= nil and v.bossTable ~= nil then
            --    print("名字" .. tostring(v.bossTable:GetName()) .. "----模型" .. tostring(self.ObservationModel))
            --end
            if v ~= nil then
                v:Clear()
            end
        end
    end
end

---页签点击事件
---@param go UnityEngine.GameObject
---@param pageInfo table 策划配置的页签数据
---@return boolean 是否可以点击
function UIBossPanel_FinalViewTemplate:PageClick(go,pageInfo)
    if self.curSelectPageInfo ~= pageInfo then
        self.curSelectPageInfo = pageInfo
        self:ClickSubTypePage(self.curSelectPageInfo)
    end
    return true
end

---显示左侧页签
function UIBossPanel_FinalViewTemplate:ShowLeftPage()
    if self:GetLeftPageTemplate():IsSameBossType(LuaEnumBossType.FinalBoss) == true then
        return
    end
    self:RunBaseFunction("ShowLeftPage")
end

---设置默认页签选择
function UIBossPanel_FinalViewTemplate:SetDefaultSelect()
    if self:GetLeftPageTemplate():IsSameBossType(LuaEnumBossType.FinalBoss) == true then
        return
    end
    self:RunBaseFunction("SetDefaultSelect")
end

---默认刷新
function UIBossPanel_FinalViewTemplate:DefaultRefresh()
    if self:GetLeftPageTemplate():IsSameBossType(LuaEnumBossType.FinalBoss) == true then
        return
    end
    self:RunBaseFunction("DefaultRefresh")
end

---获取排序之后的boss列表
function UIBossPanel_FinalViewTemplate:GetSortedBossListInfo(type)
    if type == nil then
        return
    end
    if self.curAllSortedBossDic[type] == nil then
        local list = self.curAllBossDic[type]
        if list == nil then
            return nil
        end
        local info = {}
        for i, v in pairs(list) do
            local IsMeet = 0
            if self.curAllIsMeetBossStateDic[type] ~= nil then
                for j, allInfo in pairs(v) do
                    if self.curAllIsMeetBossStateDic[type][allInfo.bossId] then
                        IsMeet = 1
                    end
                end
            end
            local IsSurvive = 0
            if self.curAllIsMeetBossIsSurviveDic[type] ~= nil then
                if self.curAllIsMeetBossIsSurviveDic[type][i] ~= 0 then
                    IsSurvive = 1
                end
            end
            local data = { bossId = v[1].bossId, monsterId = i, allInfo = v, isMeet = IsMeet, isSurvive = IsSurvive }
            local ancientTable = clientTableManager.cfg_ancient_bossManager:TryGetValue(data.monsterId)
            ---过滤跨服开启次数未满足配置的boss
            if type ~= LuaEnumFinalBossType.AncientBoss or (ancientTable ~= nil and (ancientTable:GetShareNum() == 0 or gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum() >= ancientTable:GetShareNum()))then
                table.insert(info, data)
            end
        end
        if #info > 0 then
            table.sort(info, function(a, b)
                return self:SortBoss(a, b)
            end)
            self.curAllSortedBossDic[type] = info
        end
    end
    return self.curAllSortedBossDic[type]
end

---刷新单个模板
function UIBossPanel_FinalViewTemplate:RefreshTemplate(go, line)
    if self.curList == nil or go == nil or #self.curList < line + 1 then
        return false
    end
    local info = self:ParseBossTemplateInfo(self.curList[line + 1])
    if info == nil then
        return false
    end
    local temp
    if self:GetAllBossUnitTemplateDic()[go] == nil then
        temp = templatemanager.GetNewTemplate(go, self.unitTemplate)
        self:GetAllBossUnitTemplateDic()[go] = temp
    else
        temp = self:GetAllBossUnitTemplateDic()[go]
    end
    temp:RefreshUI(info, self.shaderClip, { line = line,bossSubtype = self.curSelectPageInfo.type,activeState = self:GetGodBossActiveNum() > 0 })
    local monsterId = self.curList[line + 1].monsterId
    if monsterId then
        self.mMonsterIdToTemplate[monsterId] = temp
    end
    return true
end
--endregion

--region 神级boss
---获取神级boss激活数量
function UIBossPanel_FinalViewTemplate:GetGodBossActiveNum()
    local num = 0
    if self.curSelectPageInfo ~= nil and self.curSelectPageInfo.type == LuaEnumFinalBossType.MythBoss then
        ---@type table<bossV2.FieldBossInfo>
        local fieldBossInfoList = self:GetSortedBossListInfo(LuaEnumFinalBossType.MythBoss)
        if fieldBossInfoList ~= nil then
            for k,v in pairs(fieldBossInfoList) do
                if v ~= nil and v.allInfo ~= nil and type(v.allInfo) == 'table' and v.allInfo[1] ~= nil and v.allInfo[1].count ~= nil and v.allInfo[1].count > 0 then
                    num = num + 1
                end
            end
        end
    end
    return num
end
--endregion

---boss副页签是否显示boss击杀进度
---@return boolean
function UIBossPanel_FinalViewTemplate:BookMarkIsShowBossFill()
    return true
end


return UIBossPanel_FinalViewTemplate