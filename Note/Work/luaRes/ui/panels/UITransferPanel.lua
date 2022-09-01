local UITransferPanel = {};

function UITransferPanel:GetBtnGoTo_GameObject()
    if(self.mBtnGoTo_GameObject == nil) then
        self.mBtnGoTo_GameObject = self:GetCurComp("Sprite","GameObject");
    end
    return self.mBtnGoTo_GameObject;
end

function UITransferPanel:GetUIInput_UIInput()
    if(self.mUIInput_UIInput == nil) then
        self.mUIInput_UIInput = self:GetCurComp("input", "UIInput");
    end
    return self.mUIInput_UIInput;
end


function UITransferPanel:Init()
    CS.UIEventListener.Get(self:GetBtnGoTo_GameObject()).onClick = function()
        local transferId = tonumber(self:GetUIInput_UIInput().value);
        if(transferId ~= nil) then
            uiTransferManager:TransferToPanel(transferId);
        end
    end
end

function UITransferPanel:Show()

end

return UITransferPanel;