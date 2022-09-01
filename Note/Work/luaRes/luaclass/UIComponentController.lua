---@class UIComponentController:luaobject
local UIComponentController = {}

---@class CompStateData 组件数据
---@field public ActiveState boolean 组件显示状态
---@field public Content string Label文本
---@field public SpriteName string 图片名字
---@field public R number 这里特指图片的颜色，文本的再考虑
---@field public G number 这里特指图片的颜色，文本的再考虑
---@field public B number 这里特指图片的颜色，文本的再考虑
---@field public A number 这里特指图片的颜色，文本的再考虑
---@field public fillAmount number

---@class CopyComponentData
---@field GameObject UnityEngine.GameObject 克隆的GO
---@field UISprite UISprite 图片
---@field UILabel UILabel 文本
---@field CurrentData CompStateData 当前组件存储数据
---@field LastData CompStateData 上次组件存储数据

local CSUtility_Lua = CS.Utility_Lua
local CheckNullFunction = CS.StaticUtility.IsNull
local emptyStr = ""
local CSColor = CS.UnityEngine.Color

---@type table<string,CopyComponentData>
UIComponentController.mComps = nil

---保存其他类型组件
UIComponentController.mOtherComps = nil

---@private
function UIComponentController:Init(rootGo, prefabGo)
    self.mRootGo = rootGo
    self.mPrefabGo = prefabGo
end

--region 存储组件需要的状态，并不执行实际的刷新
--region GameObject
---@public
---设置GameObject显示状态
---@param compName string 自定义名字
---@param isTrigger boolean 特效设置为true时先隐藏再显示
function UIComponentController:SetObjectActive(compName, state, isTrigger)
    if compName == nil or state == nil then
        return
    end
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        compTbl.CurrentData.ActiveState = state
        if isTrigger and state then
            if compTbl.GameObject and CheckNullFunction(compTbl.GameObject) == false then
                compTbl.GameObject:SetActive(false)
                compTbl.GameObject:SetActive(true)
            else
                self:CopyComp(compTbl, compName, "GameObject")
                if compTbl.GameObject and CheckNullFunction(compTbl.GameObject) == false then
                    compTbl.GameObject:SetActive(true)
                end
            end
        end
    end
end

---@public
---立即设置GameObject显示状态
---@param compName string 自定义名字
---@param isTrigger boolean 特效设置为true时先隐藏再显示
function UIComponentController:SetObjectActiveImmediately(compName, state, isTrigger)
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        if CheckNullFunction(compTbl.GameObject) == false then
            if isTrigger and state then
                compTbl.GameObject:SetActive(false)
                compTbl.GameObject:SetActive(true)
            else
                compTbl.GameObject:SetActive(state)
            end
        else
            if state then
                self:CopyComp(compTbl, compName, "GameObject")
                if CheckNullFunction(compTbl.GameObject) == false then
                    compTbl.GameObject:SetActive(state)
                end
            end
        end
        compTbl.LastData.ActiveState = state
        compTbl.CurrentData.ActiveState = state
    end
end

---@public
---@return boolean 获取组件当前显示状态Apply之前调用此方法返回false
---@param compName string 自定义名字
function UIComponentController:GetObjectActive(compName)
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        local state = compTbl.LastData.ActiveState
        return state == nil and false or state
    end
    return false
end
--endregion

--region UILabel
---@public
---设置文本
function UIComponentController:SetLabelContent(compName, content)
    if compName == nil then
        return
    end
    if content == nil then
        content = emptyStr
    end
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        compTbl.CurrentData.Content = content
    end
end
--endregion

--region UISprite
---@public
---设置图片名称
function UIComponentController:SetSpriteName(compName, spriteName)
    if compName == nil then
        return
    end
    if spriteName == nil then
        spriteName = emptyStr
    end
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        compTbl.CurrentData.SpriteName = spriteName
    end
end

---@public
---设置图片颜色
---@param compName string
---@param color UnityEngine.Color
function UIComponentController:SetSpriteColor(compName, color)
    self:SetSpriteRGBA(compName, color.r * 255, color.g * 255, color.b * 255, color.a * 255)
end

---@public
---设置图片RGB值
---@param compName string
---@param r System.Single
---@param g System.Single
---@param b System.Single
---@param a System.Single
function UIComponentController:SetSpriteRGBA(compName, r, g, b, a)
    if compName == nil or r == nil or g == nil or b == nil or a == nil then
        return
    end
    local compTbl = self:GetCompTbl(compName)
    if compTbl then
        compTbl.CurrentData.R = r
        compTbl.CurrentData.G = g
        compTbl.CurrentData.B = b
        compTbl.CurrentData.A = a
    end
end
--endregion

--endregion

--region真正执行组件刷新的地方
---@public
function UIComponentController:Apply()
    if self.mComps then
        for k, v in pairs(self.mComps) do
            ---隐藏显示
            if v.CurrentData.ActiveState ~= v.LastData.ActiveState then
                if v.GameObject and CheckNullFunction(v.GameObject) == false then
                    v.GameObject:SetActive(v.CurrentData.ActiveState)
                else
                    if v.CurrentData.ActiveState then
                        self:CopyComp(v, k, "GameObject")
                        if v.GameObject and CheckNullFunction(v.GameObject) == false then
                            v.GameObject:SetActive(v.CurrentData.ActiveState)
                        end
                    end
                end
                v.LastData.ActiveState = v.CurrentData.ActiveState
            end
            ---图片名字
            if v.CurrentData.SpriteName ~= v.LastData.SpriteName then
                if v.UISprite and CheckNullFunction(v.UISprite) == false then
                    v.UISprite.spriteName = v.CurrentData.SpriteName
                    v.UISprite:MakePixelPerfect()
                else
                    self:CopyComp(v, k, "UISprite")
                    if v.UISprite and CheckNullFunction(v.UISprite) == false then
                        v.UISprite.spriteName = v.CurrentData.SpriteName
                        v.UISprite:MakePixelPerfect()
                    end
                end
                v.LastData.SpriteName = v.CurrentData.SpriteName
            end
            ---图片fillAmount
            if v.CurrentData.fillAmount ~= v.LastData.fillAmount then
                if v.UISprite and CheckNullFunction(v.UISprite) == false then
                    v.UISprite.fillAmount = v.CurrentData.fillAmount
                else
                    self:CopyComp(v, k, "UISprite")
                    if v.UISprite and CheckNullFunction(v.UISprite) == false then
                        v.UISprite.fillAmount = v.CurrentData.fillAmount
                    end
                end
                v.LastData.fillAmount = v.CurrentData.fillAmount
            end
            ---图片颜色
            if (v.CurrentData.R ~= v.LastData.R or v.CurrentData.G ~= v.LastData.G or v.CurrentData.B or v.LastData.B or v.CurrentData.A ~= v.LastData.A) then
                local color = CSColor(v.CurrentData.R / 255, v.CurrentData.G / 255, v.CurrentData.B / 255, v.CurrentData.A / 255)
                if v.UISprite and CheckNullFunction(v.UISprite) == false then
                    v.UISprite.color = color
                else
                    self:CopyComp(v, k, "UISprite")
                    if v.UISprite and CheckNullFunction(v.UISprite) == false then
                        v.UISprite.color = color
                    end
                end
                v.LastData.R = v.CurrentData.R
                v.LastData.G = v.CurrentData.G
                v.LastData.B = v.CurrentData.B
                v.LastData.A = v.CurrentData.A
            end
            ---文本
            if v.CurrentData.Content ~= v.LastData.Content then
                if v.UILabel then
                    v.UILabel.text = v.CurrentData.Content
                else
                    self:CopyComp(v, k, "UILabel")
                    if v.UILabel then
                        v.UILabel.text = v.CurrentData.Content
                    end
                end
                v.LastData.Content = v.CurrentData.Content
            end
        end
    end
end
--endregion

--region 获取拷贝组件

---@private
---@param compName string 组件名字/路径
---@return CopyComponentData 获得组件数据
function UIComponentController:GetCompTbl(compName)
    if compName == nil then
        return
    end
    if self.mComps == nil then
        self.mComps = {}
    end
    local data = self.mComps[compName]
    if data == nil then
        data = {}
        ---当前状态数据
        data.CurrentData = {}
        ---上次状态数据
        data.LastData = {}
        self.mComps[compName] = data
    end
    return data
end

---@private
---@param CompData CopyComponentData 组件数据
---@param type string 组件类型
function UIComponentController:CopyComp(CompData, compName, type)
    if CompData == nil or type == nil then
        return
    end

    if CompData.GameObject == nil then
        local go = CSUtility_Lua.Get(self.mPrefabGo.transform, compName, "GameObject")
        if go and CheckNullFunction(go) == false then
            local compGo = self:CopyGoAttachRoot(compName)
            if CompData.CurrentData.ActiveState ~= nil then
                compGo:SetActive(CompData.CurrentData.ActiveState)
            end
            CompData.GameObject = compGo
        end
    end
    if CompData[type] ~= nil then
        return
    end
    if CompData.GameObject and CheckNullFunction(CompData.GameObject) == false then
        ---获取并存储组件
        local comp = CSUtility_Lua.GetComponent(CompData.GameObject, type)
        CompData[type] = comp
        ---设置图片
        if type == "UISprite" then
            if comp and CheckNullFunction(comp) == false then
                ---设置颜色
                local color = comp.color
                local colorRf = color.r
                local colorGf = color.g
                local colorBf = color.b
                local colorAf = color.a
                if color and colorAf and colorRf and colorGf and colorBf then
                    if CompData.LastData.R == nil then
                        CompData.CurrentData.R = math.clamp(math.floor(colorRf * 255), 0, 255)
                        CompData.LastData.R = CompData.CurrentData.R
                    end
                    if CompData.LastData.G == nil then
                        CompData.CurrentData.G = math.clamp(math.floor(colorGf * 255), 0, 255)
                        CompData.LastData.G = CompData.CurrentData.G
                    end
                    if CompData.LastData.B == nil then
                        CompData.CurrentData.B = math.clamp(math.floor(colorBf * 255), 0, 255)
                        CompData.LastData.B = CompData.CurrentData.B
                    end
                    if CompData.LastData.A == nil then
                        CompData.CurrentData.A = math.clamp(math.floor(colorAf * 255), 0, 255)
                        CompData.LastData.A = CompData.CurrentData.A
                    end
                end

                local fillAmount = comp.fillAmount
                CompData.CurrentData.fillAmount = fillAmount
                CompData.LastData.fillAmount = fillAmount
            end
        end
    end
end
--endregion

--region Other
---@public
---获取任意类型组件
---@param path string 组件路径
---@param type string 组件类型
function UIComponentController:GetCustomType(path, type)
    local compTbl = self:GetCompTbl(path) --获取任意GO的总数据
    if compTbl and self.mPrefabGo and self.mRootGo then
        local customComp = compTbl[type] --保存任意类型组件
        if customComp == nil then
            --获取组件的Go
            local compGo = compTbl.GameObject
            if compGo == nil or CheckNullFunction(compGo) then
                compGo = self:CopyGoAttachRoot(path)
                compTbl.GameObject = compGo
            end
            --获取指定类型的组件
            if compGo and CheckNullFunction(compGo) == false then
                customComp = CSUtility_Lua.GetComponent(compGo.transform, type)
                if CheckNullFunction(customComp) == false then
                    compTbl[type] = customComp
                end
            end
        end
        return customComp
    end
end

---@private
---在节点下克隆go
function UIComponentController:CopyGoAttachRoot(path)
    local go = CSUtility_Lua.Get(self.mPrefabGo.transform, path, "GameObject")
    if go and CheckNullFunction(go) == false then
        local compGo = CSUtility_Lua.CopyGO(go, self.mRootGo.transform)
        if compGo and CheckNullFunction(compGo) == false then
            --compGo.name = go.name
            compGo.transform.localPosition = go.transform.localPosition
            compGo.transform.localScale = go.transform.localScale
            compGo.transform.localRotation = go.transform.localRotation
        end
        return compGo
    end
end
--endregion

return UIComponentController