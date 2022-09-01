---GM命令模板
local UIGMDirectiveTemplate = {}
--region 局部变量
--endregion

--region 初始化
function UIGMDirectiveTemplate:Init()
    self:InitComponents()
    self:BindClickEvent()
end

function UIGMDirectiveTemplate:InitComponents()
    self.mGMRemark = self:Get("remark", "Top_UILabel")
    self.mGMParms = self:Get("parms", "Top_UILabel")
    self.mGMPostfix = self:Get("Chat Input/Label", "Top_UILabel")
    self.mExtractBtn = self:Get("btn_extract", "GameObject")
end

function UIGMDirectiveTemplate:InitParameters(info)
    self.info = info
    self.content = info.content
end
--endregion

--region 事件
function UIGMDirectiveTemplate:BindClickEvent()
    if (self.mExtractBtn ~= nil) then
        CS.UIEventListener.Get(self.mExtractBtn).LuaEventTable = self
        CS.UIEventListener.Get(self.mExtractBtn).OnClickLuaDelegate = self.ExtractBtnOnClick
    end
end
--endregion

--region 刷新界面
function UIGMDirectiveTemplate:ReFreshUIPanel()
    self.mGMRemark.text = tostring(self.info.remarks)
    self.mGMParms.text = tostring(self.info.parms)
end
--endregion

--region UIEvent
---发送GM命令
function UIGMDirectiveTemplate:ExtractBtnOnClick()
    local str = tostring(self.content) .." ".. tostring(self.mGMPostfix.text)
    networkRequest.ReqGM(str)
end
--endregion
return UIGMDirectiveTemplate