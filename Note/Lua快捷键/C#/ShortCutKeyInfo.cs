using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[Serializable]
public class ShortCutKeyInfo
{
    [SerializeField] private ShortCutKeyItem[] defaultKeyCodes;
    [SerializeField] private ShortCutKeyItem[] currKeyCodes;
    [SerializeField] private ShortCutKeyItem[] lastTimeKeyCodes;
    public string Name;

    public string ShowName;

    //是否使用传统的快捷键方式（前面几个键一直按着最后一个按钮按下响应）
    [SerializeField] private bool useDefaultShortCutTyp;

    public event Action OnShortCut;

    /// <summary>
    /// 设置快捷键
    /// </summary>
    /// <param name="keys">快捷键数组</param>
    /// <param name="useDefaultInputType">是否使用传统的快捷键方式，使用的话弃用原先的输入类型</param>
    public ShortCutKeyInfo(ShortCutKeyItem[] keys, string name, string showName = "", bool useDefaultInputType = true)
    {
        Set(keys, name, showName, useDefaultInputType);
    }

    /// <summary>
    /// 是否触发快捷键信息
    /// </summary>
    /// <returns></returns>
    public bool IsMatchShortCut()
    {
        return useDefaultShortCutTyp ? MatchTraditionalShortcutKeys() : FreedomShortcutKeys();
    }

    /// <summary>
    /// 传统的快捷键方式（前面几个键一直按着最后一个按钮按下响应）
    /// </summary>
    private bool MatchTraditionalShortcutKeys()
    {
        var keyCount = currKeyCodes.Length;
        for (int i = 0; i < keyCount; i++)
        {
            var keyItem = currKeyCodes[i];
            bool isDone = false;
            isDone = keyItem.IsInput(i == keyCount ? InputTypeEnum.Down : InputTypeEnum.On);

            if (!isDone)
            {
                return false;
            }
        }

        return true;
    }

    /// <summary>
    /// 自由配置按键（每个配置的按键是按下还是抬起，还是一直按着，随便配，条件全部满足时响应）
    /// </summary>
    /// <returns></returns>
    private bool FreedomShortcutKeys()
    {
        var keyCount = currKeyCodes.Length;
        for (int i = 0; i < keyCount; i++)
        {
            var keyItem = currKeyCodes[i];
            bool isDone = false;

            if (keyItem.InputTypeEnum == InputTypeEnum.None)
            {
                var code = i == keyCount ? InputTypeEnum.Down : InputTypeEnum.On;
                isDone = keyItem.IsInput(code);
            }
            else
            {
                isDone = keyItem.IsInput();
            }

            if (!isDone)
            {
                return false;
            }
        }

        return true;
    }

    //重置快捷键
    public void Reset()
    {
        lastTimeKeyCodes = currKeyCodes;
        currKeyCodes = defaultKeyCodes;
    }

    //撤回到上一次
    public void Withdraw()
    {
        //todo:带扩展将历史快捷存储成队列，然后可以undo,redo
        if (lastTimeKeyCodes == null)
        {
            lastTimeKeyCodes = defaultKeyCodes;
        }

        if (lastTimeKeyCodes != null)
        {
            currKeyCodes = lastTimeKeyCodes;
        }
        else
        {
            Debug.Log("恢复上次设置失败");
        }
    }

    /// <summary>
    /// 设置快捷键
    /// </summary>
    /// <param name="keys">快捷键数组</param>
    /// <param name="useDefaultInputType">是否使用传统的快捷键方式，使用的话弃用原先的输入类型</param>
    public void Set(ShortCutKeyItem[] keys, string name, string showName = "", bool useDefaultInputType = true)
    {
        keys = keys.Distinct().ToArray();

        if (defaultKeyCodes == null)
        {
            defaultKeyCodes = keys;
        }

        lastTimeKeyCodes = keys;
        currKeyCodes = keys;
        Name = name;
        ShowName = string.IsNullOrEmpty(showName) ? name : showName;
    }

    /// <summary>
    /// 快捷键是否相同
    /// </summary>
    public bool IsMatchKey(ShortCutKeyInfo info)
    {
        if (info == null)
        {
            return false;
        }

        return IsMatchKey(info.currKeyCodes);
    }

    /// <summary>
    /// 快捷键是否相同
    /// </summary>
    public bool IsMatchKey(ShortCutKeyItem[] keys)
    {
        if (keys == null)
        {
            return false;
        }

        for (int i = 0; i < keys.Length; i++)
        {
            var selfKey = currKeyCodes[i];
            if (selfKey == null)
            {
                return false;
            }

            if (!(selfKey.KeyCodes == keys[i].KeyCodes && selfKey.InputTypeEnum == keys[i].InputTypeEnum))
            {
                return false;
            }
        }

        return true;
    }

    public void BroadCaste()
    {
        OnShortCut?.Invoke();
    }

    public bool IsValid()
    {
        return currKeyCodes != null && currKeyCodes.Length >= 1;
    }
}

[Serializable]
public class ShortCutKeyItem
{
    public KeyCode[] KeyCodes;

    public InputTypeEnum InputTypeEnum = InputTypeEnum.None;

    //是否是鼠标输入
    public bool IsMouse;
    public int[] InputMouseCodes;

    /// <summary>
    /// 键盘输入
    /// </summary>
    /// <param name="keyCodes">多个按键一个响应即可，例如（left ctrl and right ctrl）</param>
    /// <param name="inputTypeEnum"></param>
    public ShortCutKeyItem(KeyCode[] keyCodes, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        InitData(keyCodes, inputTypeEnum);
    }

    public ShortCutKeyItem(KeyCode keyCode, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        InitData(new[] {keyCode}, inputTypeEnum);
    }

    private void InitData(KeyCode[] keyCodes, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        KeyCodes = keyCodes;
        IsMouse = false;
        InputTypeEnum = inputTypeEnum;
        InputMouseCodes = new[] {-1};
    }

    /// <summary>
    /// 鼠标输入
    /// </summary>
    /// <param name="keyCode"></param>
    /// <param name="inputTypeEnum"></param>
    /// <param name="isMouse"></param>
    public ShortCutKeyItem(int[] keyCode, bool isMouse = true, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        InitData(keyCode, isMouse, inputTypeEnum);
    }

    public ShortCutKeyItem(int keyCode, bool isMouse = true, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        InitData(new[] {keyCode}, isMouse, inputTypeEnum);
    }

    private void InitData(int[] keyCode, bool isMouse = true, InputTypeEnum inputTypeEnum = InputTypeEnum.None)
    {
        if (isMouse)
        {
            KeyCodes = new[] {UnityEngine.KeyCode.None};
            IsMouse = true;
            InputTypeEnum = inputTypeEnum;
            InputMouseCodes = keyCode;
        }
        else
        {
            KeyCodes = CovertIntArrToEnumArr(keyCode);
            IsMouse = false;
            InputTypeEnum = inputTypeEnum;
            InputMouseCodes = new[] {-1};
        }
    }

    public static KeyCode[] CovertIntArrToEnumArr(int[] keys)
    {
        List<KeyCode> keyList = new List<KeyCode>();
        for (int i = 0; i < keys.Length; i++)
        {
            keyList.Add((KeyCode) keys[i]);
        }

        return keyList.ToArray();
    }

    public bool IsInput()
    {
        return IsInput(InputTypeEnum);
    }

    public bool IsInput(InputTypeEnum inputTypeEnum)
    {
        if (IsMouse)
        {
            switch (inputTypeEnum)
            {
                case InputTypeEnum.Down:
                    for (int i = 0; i < InputMouseCodes.Length; i++)
                    {
                        if (Input.GetMouseButtonDown(InputMouseCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
                case InputTypeEnum.On:
                    for (int i = 0; i < InputMouseCodes.Length; i++)
                    {
                        if (Input.GetMouseButton(InputMouseCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
                case InputTypeEnum.Up:
                    for (int i = 0; i < InputMouseCodes.Length; i++)
                    {
                        if (Input.GetMouseButtonUp(InputMouseCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
            }
        }
        else
        {
            switch (InputTypeEnum)
            {
                case InputTypeEnum.Down:
                    for (int i = 0; i < KeyCodes.Length; i++)
                    {
                        if (Input.GetKeyDown(KeyCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
                case InputTypeEnum.On:
                    for (int i = 0; i < KeyCodes.Length; i++)
                    {
                        if (Input.GetKey(KeyCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
                case InputTypeEnum.Up:
                    for (int i = 0; i < KeyCodes.Length; i++)
                    {
                        if (Input.GetKeyUp(KeyCodes[i]))
                        {
                            return true;
                        }
                    }

                    break;
            }
        }

        return false;
    }
}

/*public class EqualShortKey : IEqualityComparer<ShortCutKeyItem>
{
    public bool Equals(ShortCutKeyItem x, ShortCutKeyItem y)
    {
        /*for (int i = 0; i < x; i++)
        {
            
        }
        return  #1#
    }

    public int GetHashCode(ShortCutKeyItem obj)
    {
        return 0;
    }
}*/

public enum InputTypeEnum
{
    Up, //按键抬起
    Down, //按键按下
    On, //按键一直按着
    None, //按传统快捷键方式处理该按键配置
}

public enum InputMouseTypeEnum
{
    Left,
    Right,
    Middle
}