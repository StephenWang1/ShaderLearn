---@class UIDevilSquare_DeviItemTemplate 恶魔广场传送按钮
local UIDevilSquare_DeviItemTemplate = {}

--region 初始化

function UIDevilSquare_DeviItemTemplate:Init()
    self:BindUIMessage()
end

function UIDevilSquare_DeviItemTemplate:InitComponents()
    self.UILabel_Name = self:Get("check/TitleName", "Top_UILabel")
    self.UILabel_Name.text = self.name

    self.SelectEffect = self:Get("UIEffect", "GameObject")
end

function UIDevilSquare_DeviItemTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickBtn_EnterDuplicate
end

---初始化模板,并且依据传入的选择ID进行判定是否展示特效
function UIDevilSquare_DeviItemTemplate:InitData(panel, data, selectID)
    self.id = data.id
    self.name = data.name
    self.duplicateID = data.duplicateID
    self.parentPanel = panel

    self:InitComponents()

    if(self.SelectEffect~=nil) then
        self.SelectEffect:SetActive(selectID == self.id)
    end
end

--endregion

--region UI函数监听
function UIDevilSquare_DeviItemTemplate.OnClickBtn_EnterDuplicate(self)
    if(uiStaticParameter.DevilRemaining == nil) then
        CS.Utility.ShowRedTips('剩余时间不足')
        self.parentPanel.OnClickBtn_AddTime(self.parentPanel:GetBtn_AddTime());
    else
        uiStaticParameter.RequireOpenAutoFight();
        networkRequest.ReqEnterDuplicate(self.duplicateID)
        uimanager:ClosePanel('UIDevilSquarePanel')
    end
end
--endregion

--region otherFunction

--endregion

return UIDevilSquare_DeviItemTemplate