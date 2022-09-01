---
--- Created by Olivier.
--- DateTime: 2021/2/27 13:57
--- 灵魂任务TaskItem
---@class UILingHunRenWu_TaskItemTemplate :TemplateBase
local UILingHunRenWu_TaskItemTemplate = {}

function UILingHunRenWu_TaskItemTemplate:Init()
    self:InitVariable()
    self:InitComponent()
    self:BindEvent()
end

function UILingHunRenWu_TaskItemTemplate:SetData(ClickEvent, Data)
    self.ClickEvent = ClickEvent
    self.netData = Data
    if self.netData ~= nil then
        self.cfgData = clientTableManager.cfg_soul_taskManager:TryGetValue(self.netData.taskId)
    end
    if self.cfgData == nil then
        return
    end
    if self.Com.grid ~= nil then
        self.NeedItem = templatemanager.GetNewTemplate(self.Com.grid.controlList[0], luaComponentTemplates.UIItem)
        self.NeedItemCfgData = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(self.cfgData:GetItemId()))
        self:Refresh()
    end
end

function UILingHunRenWu_TaskItemTemplate:Refresh()
    if self.NeedItemCfgData ~= nil and self.NeedItem ~= nil then
        self.NeedItem:RefreshUIWithItemInfo(self.NeedItemCfgData:CsTABLE())
    end
    CS.UIEventListener.Get(self.NeedItem.go).LuaEventTable = self
    CS.UIEventListener.Get(self.NeedItem.go).OnClickLuaDelegate = self.AddBtnClick

    if self.NeedItemCfgData ~= nil then
        self.Com.name.text = self.NeedItemCfgData:GetName()
    end
    self.Com.des.text = CS.Utility_Lua.StringReplace(self.cfgData:GetDes(), '\\n', '\n')
    self.Com.btn_go:SetActive(self.netData.state == 1)
    self.Com.Submitted:SetActive(self.netData.state == 2)
    local addTweenAlpha = CS.Utility_Lua.Get(self.NeedItem.go.transform, "add", "Top_TweenAlpha")

    if self.netData.state == 2 then
        self.Com.Submittable:SetActive(false)
        self.Com.UnGet:SetActive(false)
        self.NeedItem:GetItemIcon_UISprite().color = CS.UnityEngine.Color.white
        self.NeedItem:GetAdd().gameObject:SetActive(false)
        addTweenAlpha.enabled = false
    else
        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.NeedItemCfgData:GetId())
        addTweenAlpha.enabled = playerHas > 0
        --self.NeedItem:GetItemIcon_UISprite().color = playerHas > 0 and CS.UnityEngine.Color.white  or CS.UnityEngine.Color.black
        self.NeedItem:GetItemIcon_UISprite().color = CS.UnityEngine.Color.black
        self.NeedItem:GetAdd().gameObject:SetActive(true)
        self.NeedItem:GetAdd().spriteName = playerHas > 0 and "SoulMission_add2" or "SoulMission_add1"
        self.Com.Submittable:SetActive(playerHas > 0)
        self.Com.UnGet:SetActive(playerHas <= 0)
    end
end

function UILingHunRenWu_TaskItemTemplate:InitVariable()
    self.Com = {}
    self.ClickEvent = nil
    ---@param self.cfgData TABLE.cfg_soul_task
    self.netData = nil
    self.cfgData = nil
    self.NeedItemCfgData = nil
    self.NeedItem = nil
end

function UILingHunRenWu_TaskItemTemplate:InitComponent()
    self.Com.name = self:Get("name", "Top_UILabel")
    self.Com.des = self:Get("killNum", "Top_UILabel")
    self.Com.bg = self:Get("backGround", "Top_UISprite")
    self.Com.grid = self:Get("dropScroll/AwardGrid", "UIGridContainer")
    self.Com.btn_go = self:Get("btn", "GameObject")
    --可提交
    self.Com.Submittable = self:Get("Submittable", "GameObject")
    --已提交
    self.Com.Submitted = self:Get("Submitted", "GameObject")
    --未获得
    self.Com.UnGet = self:Get("UnGet", "GameObject")
    self.Com.grid.MaxCount = 1
end

function UILingHunRenWu_TaskItemTemplate:BindEvent()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.ChooseBtnClick
    CS.UIEventListener.Get(self.Com.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.Com.btn_go).OnClickLuaDelegate = self.GoBtnClick
end

function UILingHunRenWu_TaskItemTemplate:GoBtnClick()
    if self.cfgData == nil then
        return
    end
    uiTransferManager:TransferToPanel(self.cfgData:GetJumpId())
end

function UILingHunRenWu_TaskItemTemplate:ChooseBtnClick()
    if self.ClickEvent ~= nil then
        self.ClickEvent(self)
    end
end

function UILingHunRenWu_TaskItemTemplate:AddBtnClick()
    if self.netData ~= nil and self.netData.state == 2 then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.NeedItemCfgData:CsTABLE(), showRight = false })
    else
        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.NeedItemCfgData:GetId())
        if playerHas > 0 then
            networkRequest.ReqSubmitSoulTaskItem(self.netData.taskId)
        else
            Utility.ShowItemGetWay(self.NeedItemCfgData:GetId(), self.NeedItem:GetAdd().gameObject, LuaEnumWayGetPanelArrowDirType.Left)
        end
    end
end

function UILingHunRenWu_TaskItemTemplate:OnDestroy()
    self.Com = {}
    self.ClickEvent = nil
    self.netData = nil
    self.cfgData = nil
    self.NeedItemCfgData = nil
    self.NeedItem = nil
end

return UILingHunRenWu_TaskItemTemplate