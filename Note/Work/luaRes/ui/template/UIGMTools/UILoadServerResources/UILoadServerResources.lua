local UILoadServerResources = {}

function UILoadServerResources:InitComponents()
    ---服务器路径
    self.ServerResURL = self:Get("ToolTable/ServerResURL/Chat Input", "UIInput")
    ---客户端路径
    self.ClientResPath = self:Get("ToolTable/ClientResPath/Chat Input", "UIInput")
    ---文件路径
    self.relatePath = self:Get("ToolTable/relatePath/Chat Input", "UIInput")

    ---下载
    self.load = self:Get("load", "GameObject")
    ---保存路径
    self.Sever = self:Get("Sever", "GameObject")
    self.scheduleInfo = self:Get("scheduleInfo", "UILabel")

end
function UILoadServerResources:InitOther()
    self.ServerResURL_Key = "ServerResURL"
    self.ClientResPath_Key = "ClientResPath"
    self.relatePath_Key = "relatePath"
    self.RecommendServerResURL= CS.CSLoadServerResources.Instance.RecommendServerResURL
    self.RecommendClientResPath= CS.CSLoadServerResources.Instance.RecommendClientResPath
    self.ServerResURL.text = CS.CSLoadServerResources.Instance:GetPath(self.ServerResURL_Key,  self.RecommendServerResURL)
    self.ClientResPath.text = CS.CSLoadServerResources.Instance:GetPath(self.ClientResPath_Key, self.RecommendClientResPath)
    self.relatePath.text = CS.CSLoadServerResources.Instance:GetPath(self.relatePath_Key, "Map/300035/300035_1_3")

    CS.UIEventListener.Get(self.load.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.load.gameObject).OnClickLuaDelegate = self.OnClickLoad
    CS.UIEventListener.Get(self.Sever.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Sever.gameObject).OnClickLuaDelegate = self.OnClickSever
end

function UILoadServerResources:Init()
    self:InitComponents()
    self:InitOther()
end

function UILoadServerResources:OnClickLoad(go)
    local ServerResURL = self.ServerResURL.text;
    local ClientResPath = self.ClientResPath.text;
    local relatePath = self.relatePath.text;
    CS.CSLoadServerResources.Instance:LoadData(ServerResURL, relatePath, ClientResPath)
end

function UILoadServerResources:OnClickSever(go)
    local ServerResURL = self.ServerResURL.text
    local ClientResPath = self.ClientResPath.text
    local relatePath = self.relatePath.text
    CS.CSLoadServerResources.Instance:SetPath(self.ServerResURL_Key, ServerResURL)
    CS.CSLoadServerResources.Instance:SetPath(self.ClientResPath_Key, ClientResPath)
    CS.CSLoadServerResources.Instance:SetPath(self.relatePath_Key, relatePath)
end


function UILoadServerResources:Show()
    self.go:SetActive(true)
    CS.CSLoadServerResources.Instance.action=function (loadDes)
        self.scheduleInfo.text =loadDes
    end
end

function UILoadServerResources:Hide()
    self.go:SetActive(false)
    CS.CSLoadServerResources.Instance.action=nil
end

function  UILoadServerResources:OnUpdate()
    self.scheduleInfo.text = CS.CSLoadServerResources.Instance.loadDes
end

return UILoadServerResources