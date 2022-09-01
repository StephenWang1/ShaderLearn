---@class UIChallengeBoss_DemonBossTemplates:UIChallengeBossBaseTemplates 魔之boss
local UIChallengeBoss_DemonBossTemplates = {}
setmetatable(UIChallengeBoss_DemonBossTemplates, luaComponentTemplates.UIChallengeBossBaseTemplates)

function UIChallengeBoss_DemonBossTemplates:InitComponents()
    self:RunBaseFunction("InitComponents")

    ---地图信息按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---地图名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---地图怪物数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---掉落道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "UIGridContainer")
    ---UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---@type Top_UISlider 怪物数量进度条
    self.bossNum_Slider = self:Get("Slider","Top_UISlider")
    ---@type UISprite
    self.BlackModel_UISprite = self:Get("BlackModel", "Top_UISprite")
    ---@type UILabel
    self.BossRoomNum_UILabel = self:Get("RoomNum","UILabel")
end
function UIChallengeBoss_DemonBossTemplates:InitOther()
    self:RunBaseFunction("InitOther")
    CS.UIEventListener.Get(self.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = self.OnClickBossInfoBtn
    self:ResetUI()
end

---重置不必要显示的UI
function UIChallengeBoss_DemonBossTemplates:ResetUI()
    luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite,false)
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel,false)
    luaclass.UIRefresh:RefreshActive(self.bossNum_Slider,false)
end

function UIChallengeBoss_DemonBossTemplates:RefreshUI(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    --self:SetItemGrid(self.bossTable)
    self:SetBossInfoBtn()
    self:SetBossDes()
end

---设置掉落道具展示
function UIChallengeBoss_DemonBossTemplates:SetItemGrid()
    if self.bossTable == nil then
        return
    end
    local monsterID = self.bossTable:GetConfId()
    if clientTableManager.cfg_monstersManager.GetDropShowList ~= nil then
        local dropList = clientTableManager.cfg_monstersManager:GetDropShowList(monsterID)
    end
    if dropList then
        self.dropItemGrid.MaxCount = #dropList
        for i = 1, #dropList do
            if dropList[i]:GetItemId() ~= nil then
                local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(dropList[i]:GetItemId())
                local go = self.dropItemGrid.controlList[i - 1]
                if infobool then
                    local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                    temp:RefreshUIWithItemInfo(iteminfo, 1)
                    temp:RefreshOtherUI({ tag = dropList[i]:GetTag() })
                    CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                        if temp.ItemInfo ~= nil then
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                        end
                    end
                end
            end
        end
    end
    self.UIScrollView:ResetPosition()

end

---设置怪物信息按钮
function UIChallengeBoss_DemonBossTemplates:SetBossInfoBtn()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local mapNameList = _fSplit(self.bossTable:GetMapName(), "#")
    local name = ""
    local numberColor = ""
    if self.fieldBossInfo.count > 0 then
        numberColor = "[00ff00]"
    else
        numberColor = "[e85038]"
    end
    if self:IsMeetCondition(self.bossTable) then
        name = tostring(mapNameList[1])
    else
        name = tostring(mapNameList[2])
        numberColor = "[878787]"
    end
    self.lab_name.text = name
    self.lab_num.text = numberColor .. self.fieldBossInfo.count .. "只"

end

---设置boss破防描述
function UIChallengeBoss_DemonBossTemplates:SetBossDes()
    if self.bossTable == nil then
        return
    end
    ---是否能攻击
    local isCanAttack = clientTableManager.cfg_demon_bossManager:MagicBossCanAttack(self.bossTable:GetConfId())
    local demoBossTbl = clientTableManager.cfg_demon_bossManager:TryGetValue(self.bossTable:GetConfId())
    local attackDes = ""
    if demoBossTbl then
        local desList = _fSplit(demoBossTbl:GetDes(), "#")
        if #desList == 2 then
            if isCanAttack then
                attackDes = desList[1]
            else
                attackDes = desList[2]
            end
        end
    end
    self.Deslb.text = attackDes
    self.Deslb.gameObject:SetActive(true)
end

---点击操作
---@param bossTable TABLE.cfg_boss
function UIChallengeBoss_DemonBossTemplates:ClickOperation(bossTable, go)
    if bossTable ~= nil and bossTable:GetType() == LuaEnumBossType.DemonBoss then
        local magicBossType = clientTableManager.cfg_demon_bossManager:GetMagicBossType(bossTable:GetConfId())
        local magicBossTypeInfo = luaclass.MagicBossDataInfo:GetMagicBossTypeInfoByType(magicBossType)
        if magicBossType ~= nil and magicBossTypeInfo ~= nil then
            if magicBossTypeInfo.totalKillNum <= 0 then
                Utility.ShowPopoTips(go,nil,444)
                return
            elseif magicBossTypeInfo.killNum <= 0 then
                Utility.ShowPopoTips(go,nil,443)
                return
            end
        end
    end
    self:RunBaseFunction("ClickOperation",bossTable,go)
end

---点击怪物信息按钮
function UIChallengeBoss_DemonBossTemplates:OnClickBossInfoBtn(go)
    if self.bossTable == nil then
        return
    end
    self:ClickOperation(self.bossTable, go)
end

return UIChallengeBoss_DemonBossTemplates