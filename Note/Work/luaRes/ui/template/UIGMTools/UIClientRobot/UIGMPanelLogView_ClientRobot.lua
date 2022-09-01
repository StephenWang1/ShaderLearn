
local UIGMPanelLogView_ClientRobot = {}

local btnText ={}
function UIGMPanelLogView_ClientRobot:GetRobotGc()
    if self.mGetRobotGc == nil then
        self.mGetRobotGc = self:Get("robotGc", "Top_UIGridContainer")
    end
    return self.mGetRobotGc
end

--region 初始化
function UIGMPanelLogView_ClientRobot:Init(panel)

end

local isUIEffectShow = true
function UIGMPanelLogView_ClientRobot:Show(pos)
    DebugSwitch(false)
    --CS.CSAdaptManager.Instance:SwitchAdaptModel(CS.EAdaptModel.Custom)
    self.go:SetActive(true)
    btnText[0] = '不同模型1个'
    btnText[1] = '不同模型10个'
    btnText[2] = '不同模型100个'
    btnText[3] = '同主角1个'
    btnText[4] = '同主角10个'
    btnText[5] = '同主角100个'
    btnText[6] = 'Clear'
    btnText[7] = "辉光"
    btnText[8] = "影子"
    btnText[9] = "Mesh"
    btnText[10] = "Quality"
    btnText[11] = "UI("..tostring(CS.NGUIAssist.root.gameObject.activeSelf)..")"
    btnText[12] = "UI特效(" .. tostring(isUIEffectShow) .. ")"

    local length = Utility.GetLuaTableCount(btnText)
    ---@type UIGridContainer
    local gc = self:GetRobotGc()
    gc.MaxCount = length

    for i=0,length-1 do
        ---@type UnityEngine.GameObject
        local go = gc.controlList[i]
        ---@type UIData
        local uiData = CS.Utility_Lua.GetComponent(go,"UIData")
        local label = CS.Utility_Lua.GetComponent(go.transform:Find("Label"),"UILabel")
        label.text = btnText[i]
        if CS.StaticUtility.IsNull(uiData) then
            uiData = go:AddComponent(typeof(CS.UIData))
        end
        uiData.ID = i
        uiData.Data = self
        CS.UIEventListener.Get(go).onClick = UIGMPanelLogView_ClientRobot.OnClickItem
    end
end
function UIGMPanelLogView_ClientRobot.OnClickItem(go)
    ---@type UIData
    local uiData = CS.Utility_Lua.GetComponent(go,"UIData")
    local self = uiData.Data
    local index = uiData.ID
    --print('index='..index)
    local swith = {
        [0] = function()
            CS.CSClientRobot.Instance:CreateRobot(1)
        end,
        [1] = function()
            CS.CSClientRobot.Instance:CreateRobot(10)
        end,
        [2] = function()
            CS.CSClientRobot.Instance:CreateRobot(100)
        end,
        [3] = function()
            CS.CSClientRobot.Instance:CreateSingleRobot(1)
        end,
        [4] = function()
            CS.CSClientRobot.Instance:CreateSingleRobot(10)
        end,
        [5] = function()
            CS.CSClientRobot.Instance:CreateSingleRobot(100)
        end,
        [6] = function()
            CS.CSClientRobot.Instance:ClearRobot()
        end,
        [7] = function()
            if CS.CSAdaptCustom.Instance.Data.OpenGlow == true then
                CS.CSAdaptCustom.Instance.Data.OpenGlow = false
            else
                CS.CSAdaptCustom.Instance.Data.OpenGlow = true
            end
            --CS.CSAdaptManager.Instance:SwitchAdaptModel(CS.EAdaptModel.Custom,true)
        end,
        [8] = function()
            if CS.CSAdaptCustom.Instance ~= nil then
                if CS.CSAdaptCustom.Instance.isShowShadow == true then
                    CS.CSAdaptCustom.Instance.isShowShadow = false
                else
                    CS.CSAdaptCustom.Instance.isShowShadow = true
                end
            end
            --CS.CSAdaptManager.Instance:SwitchAdaptModel(CS.EAdaptModel.Custom, true);
        end,
        [9] = function()
            CS.CSAdaptCustom.Instance.Data.MeshLOD = (CS.CSAdaptCustom.Instance.Data.MeshLOD + 1) % 3;
            --CS.CSAdaptManager.Instance:SwitchAdaptModel(CS.EAdaptModel.Custom, true);
        end,
        [10] = function()
            CS.CSAdaptCustom.Instance.Data.QualityLevel = (CS.CSAdaptCustom.Instance.Data.QualityLevel + 1) % 3;
            --CS.CSAdaptManager.Instance:SwitchAdaptModel(CS.EAdaptModel.Custom, true);
        end,
        [11] = function()
            if CS.NGUIAssist.root.gameObject.activeSelf == true then
                CS.NGUIAssist.root.gameObject:SetActive(false)
            else
                CS.NGUIAssist.root.gameObject:SetActive(true);
            end

        end,
        [12] = function()
            local mats = CS.NGUIAssist.root.gameObject:GetComponentsInChildren(typeof(CS.CSMatCollect),true);
            isUIEffectShow = not isUIEffectShow;
            for i = 0,mats.Length-1 do
                mats[i].gameObject:SetActive(isUIEffectShow);
            end
        end,
    }
    local func = swith[index]
    if func then
        local rsoult = func()
        self:Show()
    end
end
function UIGMPanelLogView_ClientRobot:Hide()
    self.go:SetActive(false)
end


return UIGMPanelLogView_ClientRobot