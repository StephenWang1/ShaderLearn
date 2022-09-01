--矿工
local UIHireMiners_MinerTemplate = {}
function UIHireMiners_MinerTemplate:InitComponents()
    --名称
    self.lb_name = self:Get("lb_name", "Top_UILabel")
    --描述
    self.lb_dec = self:Get("lb_dec", "Top_UILabel")
    --头像
    self.headIcon = self:Get("head/headIcon", "Top_UISprite")
    --雇佣
    self.btn_hire = self:Get("btn_hire", "GameObject")
    --剩余时间
    self.lb_time = self:Get("lb_time", "UICountdownLabel")

    self.Toggle = CS.Utility_Lua.GetComponent(self.go, "UIToggle")
end

function UIHireMiners_MinerTemplate:InitOther()
    self.HireMinersInfo = nil
    self.tab_id = 0
    self.tab_kuanggong = nil
    self.mainPanel=nil
    CS.UIEventListener.Get(self.btn_hire.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_hire.gameObject).OnClickLuaDelegate = self.OnClickBtn_hire

    CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.OnClickSelectKuangGong
    

end

function UIHireMiners_MinerTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

function UIHireMiners_MinerTemplate:RefreshUI(HireMinersInfo,mainPanel,index)
    self.mainPanel=mainPanel
    self.HireMinersInfo = HireMinersInfo
    if HireMinersInfo == nil then
        return
    end
    self.tab_id = HireMinersInfo.Tab_id
    self.tab_kuanggong = HireMinersInfo.Tab_kuanggong
    if self.tab_kuanggong == nil then
        return
    end
    self.btn_hire.gameObject:SetActive(false);
    -- self.lb_time.gameObject:SetActive(not self.HireMinersInfo.IsCanMayEmployed);
    -- self.lb_time:StartCountDown(nil, 3, self.HireMinersInfo.EndTime, " (正在挖矿中 ", " )")

    local IsCanMayEmployed = self.HireMinersInfo.IsCanMayEmployed
    local Type = self.HireMinersInfo.Type
    local oneDesSuffix = ""
    local strdic = ''
    self.lb_time.gameObject:SetActive(not IsCanMayEmployed)
   -- self.lb_complete.gameObject:SetActive(Type ==  CS.HireMinersActivityType.Accomplish)
    if Type ==  CS.HireMinersActivityType.MiningIng then
        strdic = "[00FF00](正在挖矿中 "
        self.lb_time:StartCountDown(nil, 3, self.HireMinersInfo.EndTime, strdic, " )")
    elseif Type ==  CS.HireMinersActivityType.Accomplish then
        oneDesSuffix = "    [00FF00]完成本次挖矿"
        self.lb_time.gameObject:SetActive(false)
     --   self.lb_complete.text='(挖矿'..self.HireMinersInfo.Tab_kuanggong.Tab_kuanggong.time ..'小时）'
    elseif Type ==  CS.HireMinersActivityType.Death then
        strdic = "[ff0000](矿工被击杀 "
        self.lb_time:StartCountDown(nil, 3, self.HireMinersInfo.EndTime, strdic, " )")
    end

    local oneDes = ''
    local twoDes = ''
    if self.HireMinersInfo.IsCanMayEmployed then
        oneDes = self.tab_kuanggong.tips..oneDesSuffix
        twoDes = self.tab_kuanggong.tips2

    else
        oneDes = self.tab_kuanggong.tips..oneDesSuffix
        twoDes = "比奇矿区一层  " .. tostring(HireMinersInfo.Point.x) .. ',' .. tostring(HireMinersInfo.Point.y)
    end
    self.lb_name.text = oneDes
    self.lb_dec.text = twoDes
    if index==0 then
        self.Toggle.value = true;
        self:OnClickSelectKuangGong()
    end
end
function UIHireMiners_MinerTemplate:OnClickBtn_hire(go)
    if self.tab_kuanggong ~= nil and CS.CSScene.MainPlayerInfo ~= nil then
        if self.tab_kuanggong.level <= CS.CSScene.MainPlayerInfo.Level then
            uimanager:CreatePanel("UIHireMinersPromptPanel", nil, self.HireMinersInfo)
            return
        end
    end
    if self.tab_kuanggong ~= nil then
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(247)
        if isfind == false then
            return
        end
        local direction = data.content
        local strList=string.Split(direction, "#")
        local str="";
        if #strList==2 then
            str=strList[1].. self.tab_kuanggong.level .. strList[2]
        else
            str = "请" .. self.tab_kuanggong.level .. "级再来雇佣"
        end
        Utility.ShowPopoTips(self.btn_hire.transform, str, 247, "UIHireMinersPanel")
    end

end

---点击选择当前矿工
function UIHireMiners_MinerTemplate:OnClickSelectKuangGong()
  --print("点击选择当前矿工")
  if self.mainPanel==nil then
      return
  end
  self.mainPanel:RefreShSelectMinerInfo(self.HireMinersInfo,self.tab_kuanggong)
end

return UIHireMiners_MinerTemplate