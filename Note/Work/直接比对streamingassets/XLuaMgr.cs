using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;
using LuaAPI = XLua.LuaDLL.Lua;
public class XLuaMgr : MonoBehaviour, NewI_XLuaMgr
{
    [CSharpCallLua]
    public delegate void XLuaMgr_Init(bool isUnityEditor, string preMainPath);
    [CSharpCallLua]
    public delegate void XLuaMgr_InitUI();
    [CSharpCallLua]
    public delegate void LuaBehaviourMgr_Awake();
    [CSharpCallLua]
    public delegate void LuaBehaviourMgr_Start();
    [CSharpCallLua]
    public delegate void LuaBehaviourMgr_Update();
    [CSharpCallLua]
    public delegate void LuaBehaviourMgr_OnDestroy();
    [CSharpCallLua]
    public delegate double LuaCollectGarbageDel(string order);

    private static string preMainPath = string.Empty;
    private static string mainPath = string.Empty;
    public IntPtr LChache;
#if UNITY_EDITOR
    [BlackList]
    public bool debugLuaStackOpen = true;
    [BlackList]
    public string debugLuaStackType = string.Empty;
    [BlackList]
    public string debugLuaStackMethod = string.Empty;
    [BlackList][HideInInspector]
    public int debugPrintFrame = 0;

    [BlackList]
    [HideInInspector]
    public int debugHasPrintNum = 0;
    [BlackList]
    public int debugPrintMaxCount = 10;
#endif

    public List<string> hotList = new List<string>();
    public bool isLocalTest
    {
        get
        {
            if (CSGameState.RunPlatform == ERunPlatform.Editor) return true;
            return false;
        }
        set { Debug.Log("Testteswfewt"); }
    }
    public bool isDebugWrap = false;
    public bool isDebugListGetEnumerator = true;
    //用来定位，如果把某些字段屏蔽生成之后，没有生成该Type的Wrap代码调用会使用反射，反射的时候捕捉一下打印出来（这些在代码完成生成的时候直接调用会报错）
    [NonSerialized]
    [HideInInspector]
    public bool IsWrapBlackMember = true;
    private LuaCollectGarbageDel luaGCFunction = null;

    /// <summary>
    /// 上一次cs侧lua执行gc的时间点
    /// </summary>
    private float latestCSLuaGCTime = 0;
    /// <summary>
    /// cs侧lua的gc周期
    /// </summary>
    private float csLuaGCPeriod = 3;
    private bool isInit = false;
    private bool isInitUI = false;
    //public string CustomDebugMethodName = "";
    //public bool isDebugCustom = false;
    //public int debugCount = 0;
    public static XLuaMgr mInstance;
    public static XLuaMgr Instance
    {
        get
        {
            return mInstance;
        }
    }

    public bool IsRegistDelayWrapLoaderFinish
    {
        get
        {
            return _IsRegistDelayWrapLoaderFinish;
        }
    }

    private LuaEnv luaenv;
    public LuaEnv Luaenv
    {
        get { return luaenv; }
        set { luaenv = value; }
    }

    private LuaTable luaUIManager;
    public LuaTable LuaUIManager
    {
        get
        {
            if (luaUIManager == null)
            {
                if (luaenv != null)
                {
                    luaUIManager = luaenv.Global.Get<LuaTable>("uimanager");
                }
            }
            return luaUIManager;
        }
    }

    private Action<object> releaseUIPanelFunction;
    protected Action<object> ReleaseUIPanelFunction
    {
        get
        {
            if (releaseUIPanelFunction == null)
            {
                if (LuaUIManager != null)
                {
                    releaseUIPanelFunction = LuaUIManager.Get<Action<object>>("ReleasePanel");
                }
            }
            return releaseUIPanelFunction;
        }
    }

    private Action clearCacheBeforeLeaveGame;
    /// <summary>
    /// 在退出游戏后清理缓存
    /// </summary>
    protected Action ClearCacheBeforeLeaveGame
    {
        get
        {
            return clearCacheBeforeLeaveGame;
        }
    }

    private LuaScriptContentCache scriptContentCache;
    /// <summary>
    /// 脚本内容缓存
    /// </summary>
    public LuaScriptContentCache ScriptContentCache
    {
        get
        {
            if (scriptContentCache == null)
            {
                scriptContentCache = new LuaScriptContentCache();
            }
            return scriptContentCache;
        }
    }

    [HideInInspector]
    public bool mIsOpenLuaScriptContentCache = false;

    //[NonSerialized]
    //public List<string> dynamichotSaveTxtPathList = new List<string>();
    [NonSerialized]
    public Dictionary<string, bool> dynamichotSaveTxtPathSelfDic = new Dictionary<string, bool>();
    static bool dynamichotSaveTxtPathSelfDicChange = false;
    static bool dynamichotSaveTxtPathInit = false;

    //public List<string> dynamichotAssemPathList = new List<string>();
    public static string streamLuaLoadInfo;
    private void Awake()
    {
        mInstance = this;
        CSInterfaceSingleton.IXLuaMgr = this;
        DontDestroyOnLoad(gameObject);
        IXLuaProtobuf i = new IXLuaProtobuf();
        CSInterfaceSingleton.IXLuaProtobuf_InterfaceUse = i;
        if (!CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        {
            mIsOpenLuaScriptContentCache = true;
        }
        ScriptContentCache.IsOpenScriptContentCache = mIsOpenLuaScriptContentCache;
        //BeginCheckVersion(false);
        if (CSGame.Sington.IsLoadStreamingAssets)
        {
            StartCoroutine(CopyStreamAssetLuaToOut());
        }
        else
        {
            if (CSGame.Sington.IsLoadLocalRes)
            {
                Init();
            }
        }
        //List<Type> list = XLuaConfig.GetTypesList();
        //if (Debug.developerConsoleVisible)
        //{
        //    UnityEngine.Debug.Log("C#类数量 = " + list.Count);
        //}
    }

    IEnumerator CopyStreamAssetLuaToOut()
    {
        //UnityEngine.Debug.Log(CSStaticAssist.persistentDataPath);
        if (Directory.Exists(CSStaticAssist.persistentDataPath + "/luaRes"))
        {
            Init();
            yield break;
        }
        yield return null;

        string targetLuaPath = CSStaticAssist.persistentDataPath + "/";
        string luaPathText = CSStaticAssist.streamingAssetsPath + "/luaRes/luaResPath.txt";

        WWW www = new WWW(luaPathText);
        yield return www;
        if (www.isDone)
        {
            string[] contents = www.text.Split(new string[] { "\r\n" },
                StringSplitOptions.None);
            www.Dispose();
            int index = 0;
            foreach (var cur in contents)
            {
                if (string.IsNullOrEmpty(cur)) continue;
                if (cur.EndsWith(".meta")) continue;
                if (cur.EndsWith("luaResPath.txt")) continue;
                streamLuaLoadInfo = index + "/" + contents.Length;
                index++;
                string path = CSStaticAssist.streamingAssetsPath + "/" + cur;
                string tPath = targetLuaPath + cur;
                WWW w = new WWW(path);
                yield return w;
                if (w.isDone)
                {
                    if (index % 100 == 0)
                    {
                        UnityEngine.Debug.Log("复制完成 = " + index + "/" + contents.Length);
                    }

                    FileUtility.DetectCreateDirectory(tPath);
                    File.WriteAllBytes(tPath, w.bytes);
                }
                w.Dispose();
            }


        }
        UnityEngine.Debug.Log("复制Stream lua完成");
        Init();
        InitUI();//假设复制luares的时候，这边直接调用没有问题。
    }

    public void Init()
    {
        LoadDynamichotSaveTxtPathList();
        isInit = true;

        OnlineDebug.HotLogSB.Append("\r\n初始化XluaMgr");

        #region before

        /*if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        {
            string luaPath = CSEditorPath.Get(EEditorPath.LuaPath);
            if (!luaPath.EndsWith("/") && !luaPath.EndsWith("\\"))
            {
                //即不以/结尾,又不以\结尾
                luaPath = luaPath + "/";
            }
            mainPath = luaPath + "main_out.lua";
            preMainPath = luaPath.Substring(0, luaPath.LastIndexOf("/"));
        }
        else
        {
            mainPath = Application.persistentDataPath + "/luaRes/main_out.lua";
            preMainPath = Application.persistentDataPath + "/luaRes";//lua文件不能放在StreamingAssets下加载（报加载被禁止的错误）
        }*/

        #endregion

        #region end
        mainPath = Application.persistentDataPath + "/luaRes/main_out.lua";
        preMainPath = EditorPath.GetStreamingAssetsPath() + "/luaRes";//lua文件不能放在StreamingAssets下加载（报加载被禁止的错误）
        #endregion


        //UnityEngine.Debug.Log("Lua Main Path = " + mainPath);

        if (!File.Exists(mainPath))
        {
            #region before
            /*Debug.Log(mainPath + " is not exist!");
            return;*/
            #endregion

            #region end
            mainPath = preMainPath + "/main_out.lua";
            #endregion

        }
        //TestStateful();
        luaenv = new LuaEnv(true);
        luaenv.InitGlobalTranslator();
       
        if (XLuaEncrypt.IsXLuaEncryptOpened)
        {
            luaenv.AddLoader(LuaEncryptLoader);
        }
        else
        {
            #region before
#if UNITY_EDITOR
            luaenv.AddLoader(LuaEmmLuaOutPathDebugLoader);
#endif
            #endregion
        }

        if (!isLocalTest)
        {
            luaenv.DoString("require 'main_in'");//main_in中引用的是mainPath的lua脚本，所以前面通过判断外部是否有mainPath这个脚本，mainPath路径的lua脚本里面才是将其他需要热更的lua脚本require进去
        }
        else
        {
            luaenv.DoString("require 'main_in'");//main_in中引用的是mainPath的lua脚本，所以前面通过判断外部是否有mainPath这个脚本，mainPath路径的lua脚本里面才是将其他需要热更的lua脚本require进去
        }

        ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(XLuaMgr.Instance.Luaenv.L);
        StartCoroutine(RegistDelayWrapLoader(translator, XLuaMgr.Instance.Luaenv.L));

        XLuaMgr_Init f = luaenv.Global.Get<XLuaMgr_Init>("InitRequire");
        if (f != null)
        {
            f(CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR, preMainPath);
        }
        clearCacheBeforeLeaveGame = luaenv.Global.Get<Action>("ClearCacheBeforeLeaveGame");
        if (isLocalTest)
        {
            gameObject.AddComponent(typeof(XLuaTest));
        }
        UnityEngine.Debug.Log("Xlua Mgr init");
        //UnityEngine.Debug.Log("----------------------after------------------------");

        //TestStateful();
        luaGCFunction = luaenv.Global.Get<LuaCollectGarbageDel>("collectgarbage");
        StartCoroutine(CSPreDeal.PreDealingOnGameStart());
        //CSSceneManager.Instance.Load(SceneType.LoginScene);
        CheckCommitWrapConfig();
    }

    void CheckCommitWrapConfig()
    {
#if UNITY_EDITOR
        string commitTimeConifg = Application.persistentDataPath + "/CommitTimeConfig.txt";
        bool isNeedCommit = true;
        //FileUtility.DetectCreateDirectory(commitTimeConifg);
        Debug.Log("Editor Log:commitTimeConifg = " + commitTimeConifg);
        //Debug.Log("System.DateTime.Now.Day = " + System.DateTime.Now.Day);
        List<string> list = new List<string>();
        bool isHasUpdate = false;
        if (File.Exists(commitTimeConifg))
        {
            list = FileUtility.ReadToEnd_Line(commitTimeConifg);
            for (int i = 0; i < list.Count; i++)
            {
                string s = list[i];
                string[] strs = s.Split('#');
                if (strs.Length == 2)
                {
                    string dataPath = strs[0];
                    if (dataPath == Application.dataPath)
                    {
                        int day;
                        if (int.TryParse(strs[1], out day))
                        {
                            if (System.DateTime.Now.Day == day)
                            {
                                isNeedCommit = false;
                            }
                        }
                        if (isNeedCommit)
                        {
                            list[i] = Application.dataPath + "#" + System.DateTime.Now.Day.ToString();
                            isHasUpdate = true;
                        }
                    }
                }

            }
        }


        if (isNeedCommit)
        {
            if (!isHasUpdate)
            {
                list.Add(Application.dataPath + "#" + System.DateTime.Now.Day.ToString());
            }
            string content = "";
            foreach (var cur in list)
            {
                content += cur + "\n";
            }
            FileUtility.Write(commitTimeConifg, content, false);
            string commitPath = XLuaConfig.GetLocalDynamicPath();
            UnityEngine.Debug.Log("Editor Log:commit = " + commitPath);
            if (File.Exists(commitPath))
            {
                System.Diagnostics.Process pp1 = System.Diagnostics.Process.Start("TortoiseProc.exe", @"/command:commit" + " /path:" + commitPath + " /closeonend:4");
            }
            //pp1.WaitForExit();
        }

#endif
    }

    /// <summary>
    /// 读取并解密proto文件
    /// </summary>
    /// <param name="protoFilePath"></param>
    /// <param name="res"></param>
    /// <returns></returns>
    public bool ReadAndDecodeProtoFile(string protoFilePath, out byte[] res)
    {
        try
        {
            if (!File.Exists(protoFilePath))
            {
                res = null;
                return false;
            }
            res = File.ReadAllBytes(protoFilePath);
            XLuaEncrypt.Decode(res);
            return true;
        }
        catch (Exception ex)
        {
            if (CSDebug.developerConsoleVisible)
            {
                CSDebug.LogError(ex.Message);
            }
            res = null;
            return false;
        }
    }
    private byte[] LuaEmmLuaOutPathDebugLoader(ref string filepath)
    {
        if (filepath.Contains("emmy_core")) return null;
        if(filepath.Contains("main_in"))
        {
            string inPath = Application.dataPath + "/XLua/XLuaFrame/XLua/Resources/main_in.lua.txt";
            byte[] infileContent = File.ReadAllBytes(inPath);
            return infileContent;
        }
        if (!filepath.Contains("luaRes."))
        {
            return null;
        }
        CSStringBuilder.Clear();

        #region before

        // if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        // {
        //     CSStringBuilder.Append(CSEditorPath.Get(EEditorPath.LuaPath));
        //     CSStringBuilder.Append(filepath.Substring(7).Replace('.', '/'));
        //     CSStringBuilder.Append(".lua");
        // }
        // else
        // {
        //     CSStringBuilder.Append(Application.persistentDataPath);
        //     CSStringBuilder.Append("/");
        //     CSStringBuilder.Append(filepath.Replace('.', '/'));
        //     CSStringBuilder.Append(".lua");
        // }

        #endregion
        #region end
        CSStringBuilder.Append(Application.persistentDataPath);
        CSStringBuilder.Append("/");
        CSStringBuilder.Append(filepath.Replace('.', '/'));
        CSStringBuilder.Append(".lua");

        if (!File.Exists(CSStringBuilder.ToString()))
        {
            CSStringBuilder.Clear();
            CSStringBuilder.Append(EditorPath.GetStreamingAssetsPath());
            CSStringBuilder.Append("/");
            CSStringBuilder.Append(filepath.Replace('.', '/'));
            CSStringBuilder.Append(".lua");
        }
        

        #endregion
       


        string path = CSStringBuilder.ToString();
        if (!File.Exists(path))
        {
            UnityEngine.Debug.LogError(path +" not find");
            return null;
        }
        byte[] fileContent = File.ReadAllBytes(path);
        if (fileContent.Length > 3 && fileContent[0] == 239 && fileContent[1] == 187 && fileContent[2] == 191)
        {
            fileContent[0] = 32;
            fileContent[1] = 32;
            fileContent[2] = 32;
        }
        //filepath = FileUtility.GetBackDir(Application.dataPath, 1) + "/" + filepath.Replace(".", "/") + ".lua";
        //Debug.Log("filepath = " + filepath);
        return fileContent;
    }
    /// <summary>
    /// lua加密加载
    /// </summary>
    /// <param name="filepath"></param>
    /// <returns></returns>
    private byte[] LuaEncryptLoader(ref string filepath)
    {
        try
        {
            if(filepath.Contains("main_in"))
            {
                string inPath = Application.dataPath + "/XLua/XLuaFrame/XLua/Resources/main_in.lua.txt";
                byte[] infileContent = File.ReadAllBytes(inPath);
                return infileContent;
            }
            
            if (!filepath.Contains("luaRes."))
            {
                return null;
            }
            CSStringBuilder.Clear();

            #region before
            /*if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
            {
                CSStringBuilder.Append(CSEditorPath.Get(EEditorPath.LuaPath));
                CSStringBuilder.Append(filepath.Substring(7).Replace('.', '/'));
                CSStringBuilder.Append(".lua");
            }
            else
            {
                CSStringBuilder.Append(Application.persistentDataPath);
                CSStringBuilder.Append("/");
                CSStringBuilder.Append(filepath.Replace('.', '/'));
                CSStringBuilder.Append(".lua");
            }*/
            #endregion
           
            #region end

            /*if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
            {
                CSStringBuilder.Append(CSEditorPath.Get(EEditorPath.LuaPath));
                CSStringBuilder.Append(filepath.Substring(7).Replace('.', '/'));
                CSStringBuilder.Append(".lua");
            }
            else
            {*/
            CSStringBuilder.Append(Application.persistentDataPath);
            CSStringBuilder.Append("/");
            CSStringBuilder.Append(filepath.Replace('.', '/'));
            CSStringBuilder.Append(".lua");

            if (!File.Exists(CSStringBuilder.ToString()))
            {
                CSStringBuilder.Clear();
                CSStringBuilder.Append(EditorPath.GetStreamingAssetsPath());
                CSStringBuilder.Append("/");
                CSStringBuilder.Append(filepath.Replace('.', '/'));
                CSStringBuilder.Append(".lua");
            }
            //}
            #endregion
            
            string path = CSStringBuilder.ToString();
            if (!File.Exists(path))
            {
                return null;
            }
            byte[] fileContent = File.ReadAllBytes(path);
            XLuaEncrypt.Decode(fileContent);
            //规避带bom头的UTF8文件
            if (fileContent.Length > 3 && fileContent[0] == 239 && fileContent[1] == 187 && fileContent[2] == 191)
            {
                fileContent[0] = 32;
                fileContent[1] = 32;
                fileContent[2] = 32;
            }
            return fileContent;
        }
        catch (Exception ex)
        {
            CSDebug.LogError(ex.Message);
            return null;
        }
    }

    public static bool _IsRegistDelayWrapLoaderFinish = false;
    float mRegistDelayWrapLoaderProcess = 0;
    public float RegistDelayWrapLoaderProcess
    {
        get
        {
            return mRegistDelayWrapLoaderProcess;
        }
    }
    public bool isCollectFirstRegister = false;
    public static string firstRegisterContent = "";
    public static Dictionary<Type, bool> firstRegisterContentDic;
    int processIndex = 0;
    int perCount = 0;
    int perMax = 0;
    IEnumerator RegistDelayWrapLoader(ObjectTranslator translator, System.IntPtr L)
    {
        //yield return NGUIAssist.GetWaitForSeconds(1.0f);
        //yield break;
        if (isCollectFirstRegister)
        {
            yield break;
        }
        int index = 0;

        float beginTime = Time.realtimeSinceStartup;
        //UnityEngine.Debug.Log("RegistDelayWrapLoader Begin=" + beginTime + " " + translator.delayWrap.Count);

        foreach (var cur in XLuaFirstRegister.firstRegisterDic)
        {
            if (translator.delayWrap.ContainsKey(cur.Key))
            {
                //if (CSDebug.developerConsoleVisible) Debug.Log(index + "RegistDelayWrapLoader=" + cur.Key);
                bool b = SyncStep(cur.Key, index);
                if (b) yield return null;
                if (!translator.IsHasWrapLoader(cur.Key))
                {
                    index++;
                    translator.TryDelayWrapLoader(L, cur.Key, ObjectTranslator.curHasCode);
                }
            }
        }
        //UnityEngine.Debug.Log("RegistDelayWrapLoader0 Finish=" + (Time.realtimeSinceStartup - beginTime) + " " + XLuaFirstRegister.firstRegisterDic.Count);
        XLuaFirstRegister.firstRegisterDic.Clear();
        Dictionary<Type, Action<System.IntPtr>> dic = new Dictionary<Type, Action<System.IntPtr>>();
        foreach (var cur in translator.delayWrap)
        {
            dic.Add(cur.Key, cur.Value);
        }
        index = 0;
        processIndex = 0;
        perCount = 0;
        perMax = 0;
        foreach (var cur in dic)
        {
            //if (CSDebug.developerConsoleVisible) Debug.Log(index + "RegistDelayWrapLoader=" + cur.Key);
            mRegistDelayWrapLoaderProcess = processIndex * 1f / dic.Count;
            processIndex++;
            if (!translator.delayWrap.ContainsKey(cur.Key)) continue;
            bool b = SyncStep(cur.Key, index);
            if (b) yield return null;
            if (!translator.IsHasWrapLoader(cur.Key))
            {
                index++;
                translator.TryDelayWrapLoader(L, cur.Key, ObjectTranslator.curHasCode);
            }
        }
        mRegistDelayWrapLoaderProcess = 1;
        translator.delayWrap.Clear();
        UnityEngine.Debug.Log("RegistDelayWrapLoader Finish=" + (Time.realtimeSinceStartup - beginTime) + " " + dic.Count);
        _IsRegistDelayWrapLoaderFinish = true;
    }

    bool SyncStep(Type type, int index)
    {
        if (CSSceneManager.Instance.IsChangeMainMap)
        {
            if (index % 20 == 0) return true;
        }
        else
        {
            if (perMax != 0 && perCount < perMax)
            {
                perCount++;
                if (perCount >= perMax)
                {
                    perMax = 0;
                    return true;
                }
            }
            else if (FPS.Instance != null)
            {
                perMax = (int)((FPS.Fps - 30) * 1f / 3);
                perMax = Mathf.Max(perMax, 1);
                perCount = 0;//这里计算完之后就会调用一次TryDelayWrapLoader，然后进上面的逻辑。
            }
            else
            {
                if (index % 1 == 0) return true;
            }

        }
        return false;
    }

    public void WriteFirstRegist()
    {
#if UNITY_EDITOR
        UnityEngine.Debug.Log(XLuaMgr.firstRegisterContent);
        string path = Application.dataPath + "/XLua/XLuaFrame/XLua/XLuaFirstRegister.cs";
        string content = "using System.Collections;\r\nusing System.Collections.Generic;\r\nusing UnityEngine;\r\nusing System;\r\n";
        content += "public class XLuaFirstRegister {\r\npublic static Dictionary<Type, bool> firstRegisterDic = new Dictionary<Type, bool>()\r\n";
        content += "{\r\n" + firstRegisterContent + "\r\n};\r\n}";
        FileUtility.Write(path, content, false);
#endif
    }

    void LoadDynamichotSaveTxtPathList()
    {
#if UNITY_EDITOR
        if (!CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR) return;
        CombineHotSave();
        //string content = XLuaConfig.GetLocalDynamicContent(XLuaConfig.GetLocalDynamicPath());
        //dynamichotSaveTxtPathList.Clear();
        //string[] strs = content.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
        //foreach (var cur in strs)
        //{
        //    if (!dynamichotSaveTxtPathList.Contains(cur))
        //    {
        //        dynamichotSaveTxtPathList.Add(cur);
        //    }
        //}

        string content = FileUtility.ReadToEnd(XLuaConfig.GetLocalDynamicPath());
        dynamichotSaveTxtPathSelfDic.Clear();
        string[] strs = content.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
        foreach (var cur in strs)
        {
            dynamichotSaveTxtPathSelfDic[cur] = true;
        }
        dynamichotSaveTxtPathInit = true;
#endif
    }

    public static void CombineHotSave()
    {
        string path = XLuaConfig.GetLocalDynamicPath();
        string content = XLuaConfig.GetLocalDynamicContent(path);
        if (string.IsNullOrEmpty(content)) return;

        content += XLuaConfig.ReadToEnd(path) + "\r\n";
        //XLuaConfig.GetLocalDynamicPath()
        List<string> list = new List<string>();
        string[] strs = content.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
        var zeroStr = new string('\0', 3);
        foreach (var cur in strs)
        {
            if (!string.IsNullOrEmpty(cur) && !cur.Contains(zeroStr) && !list.Contains(cur))
            {
                //Type t = XLuaConfig.GetType(cur);
                list.Add(cur);
            }
        }

        // content = "";
        CSStringBuilder.Clear();
        foreach (var cur in list)
        {
            CSStringBuilder.Append(cur,"\r\n");
        }

        FileUtility.Write(path, CSStringBuilder.ToString(), false);
        XLuaConfig.DeleteLocalDynamicContent(path);
        UnityEngine.Debug.Log(path);
    }

    public void AddDynamichotSaveTxt(Type type)
    {
#if UNITY_EDITOR
        if (!CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR) return;
        //if (type.IsGenericParameter) return;
        if (!dynamichotSaveTxtPathSelfDic.ContainsKey(type.FullName))
        {
            Type t = XLuaConfig.GetType(type.FullName);
            if (t == null)
            {
                string assemPath = type.Assembly.Location;
                string fileName = FileUtility.GetFileName(assemPath);
                string targetPath = FileUtility.GetBackDir(Application.dataPath, 1) + "/ProjectCaches/" + fileName + ".dll";
                if (!File.Exists(targetPath))
                {
                    File.Copy(assemPath, targetPath, true);
                    //UnityEngine.Debug.LogError("没有找到类型 = " + type.FullName + " 请上传文件 = " + XLuaConfig.dynamichotSaveTxtPath);
                }
                //return;
            }
            if (!isDebugWrap)//调用的地方已经打印了
            {
                UnityEngine.Debug.Log("(这只是一个提示,不是BUG)需要添加到Wrap 请关闭游戏再上传文件 = " + XLuaConfig.dynamichotSaveTxtPath +
                            " " + type.FullName);
            }
            dynamichotSaveTxtPathSelfDicChange = true;
            dynamichotSaveTxtPathSelfDic.Add(type.FullName, true);

            //string assemPath = type.Assembly.Location;
            //string fileName = FileUtility.GetFileName(assemPath);
            //string targetPath = FileUtility.GetBackDir(Application.dataPath, 1) + "/ProjectCaches/"+ fileName+".dll";
            //if (!dynamichotAssemPathList.Contains(assemPath))
            //{
            //    dynamichotAssemPathList.Add(assemPath);
            //    File.Copy(assemPath, targetPath, true);
            //}
            //UnityEngine.Debug.LogError(assemPath);
            //UnityEngine.Debug.LogError(targetPath);
        }
#endif
    }

    //public Dictionary<XLua.LuaDLL.lua_CSFunction, float> funcAdressDic = new Dictionary<XLua.LuaDLL.lua_CSFunction, float>();
    public void OnApplicationQuit()
    {
        if (!CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR) return;
        //if(funcAdressDic.Count!=0)
        //{
        //    string c = "";
        //    List<KeyValuePair<XLua.LuaDLL.lua_CSFunction, float>> list = new List<KeyValuePair<XLua.LuaDLL.lua_CSFunction, float>>();
        //    list.AddRange(funcAdressDic);
        //    list.Sort(delegate (KeyValuePair<XLua.LuaDLL.lua_CSFunction, float> f, KeyValuePair<XLua.LuaDLL.lua_CSFunction, float> s)
        //    {
        //        return s.Value.CompareTo(f.Value);
        //    });
        //    foreach (var cur in list)
        //    {
        //        //if(cur.Value>=2)
        //        c += cur.Key.Method.DeclaringType+" "+cur.Key.Method.Name+" "+cur.Value + "\r\n";
        //    }
        //    c += "总函数:"+funcAdressDic.Count + "";
        //    FileUtility.Write(FileUtility.GetBackDir(Application.dataPath,1)+ "/funcAdressDic.txt", c, false);
        //}
        //UnityEngine.Debug.Log("totalGetFunctionPointTime" + XLua.LuaDLL.Lua.totalGetFunctionPointTime);
        if (!dynamichotSaveTxtPathSelfDicChange) return;
        if (!dynamichotSaveTxtPathInit) return;
        UnityEngine.Debug.Log("XLuaMgr Quit save GetLocalDynamicPath");
        CSStringBuilder.Clear();
        foreach (var cur in dynamichotSaveTxtPathSelfDic.Keys)
        {
            CSStringBuilder.Append(cur,"\r\n");
        }
        FileUtility.Write(XLuaConfig.GetLocalDynamicPath(), CSStringBuilder.ToString(), false);
    }

#if false
    private void OnGUI()
    {
        CSStringBuilder.Clear();
        CSStringBuilder.Append("Lua Memory: ");
        CSStringBuilder.Append(GetLuaMemoryCount().ToString());
        CSStringBuilder.Append(" MB");
        GUI.color = Color.cyan;
        GUI.Label(new Rect(0, Screen.height - 150, 250, 50), CSStringBuilder.ToString());
    }
#endif

    /// <summary>
    /// 获取Lua内存(B)
    /// </summary>
    /// <returns></returns>
    public long GetLuaMemory()
    {
        if (luaGCFunction != null)
        {
            var temp = luaGCFunction("count");
            return (long)(temp * 1024);
        }
        return 0;
    }

    /// <summary>
    /// 获取lua占用的内存(MB)
    /// </summary>
    /// <returns></returns>
    public double GetLuaMemoryCount()
    {
        if (luaGCFunction != null)
        {
            return (int)(luaGCFunction("count") / 1024f * 100f) / 100f;
        }
        return 0;
    }

    public void Destroy()
    {
        if (luaenv != null)
        {
            luaenv.DestroyGlobalTranslator();
            luaenv.Dispose();
            luaenv = null;
        }
        if (luaUIManager != null)
        {
            luaUIManager.Dispose();
            luaUIManager = null;
        }
        releaseUIPanelFunction = null;
    }

    public void Tick()
    {
        if (luaenv != null)
        {
            luaenv.Tick();
        }
    }

    private void Update()
    {
        //if (XLuaMgr.Instance.Luaenv!=null)
        //{
        //    //UnityEngine.Profiling.Profiler.BeginSample("LuaGC");
        //    for (int i = 0; i < 1; i++)
        //    {
        //        LuaAPI.lua_pushstdcallcfunction(XLuaMgr.Instance.Luaenv.L,XLuaMgr.Instance.luaenv.translator.metaFunctions.GcMeta);
        //    }
        //    //UnityEngine.Profiling.Profiler.EndSample();
        //}

        //    //if (Input.GetKeyDown(KeyCode.A))
        //    //{
        //    //    Net.ReqEnterScene();
        //    //}
        //    //sft.Update();
        //    /*if (luaTest == null)
        //        return;
        //    if ((luaTest.tick+1) % 100 == 0) 
        //    {
        //        UtilityTip.ShowTips("XluaTest Update !", 1.5f, ColorType.Red);
        //    }
        //    if ((luaTest.tickLua+1) % 100 == 0) 
        //    {
        //        UtilityTip.ShowTips("XluaTest lua Update !", 1.5f, ColorType.Red);
        //    }*/
        float currentTime = Time.time;
        if (currentTime - latestCSLuaGCTime > csLuaGCPeriod)
        {
            latestCSLuaGCTime = currentTime;
            Tick();
        }
    }

    public static bool IsNull(UnityEngine.Object o) // 或者名字叫IsDestroyed等等
    {
        return o == null;
    }

    public void InitUI()
    {
        if (!isInit) return;
#if UNITY_EDITOR
        if (CSVersionMgr.Instance.ServerVersion == null)
        {
            Debug.LogWarning("Editor Log:Try wait ServerVersion load");
            StartCoroutine(WaitServerVersion());
            return;
        }
#endif
        //UnityEngine.Debug.Log("CSGame.Sington.IsLoadLocalRes=" + CSGame.Sington.IsLoadLocalRes+" "+Time.time);
        //UnityEngine.Debug.Log("isLocalTest=" + isLocalTest);
        if (isInitUI)
        {
            CSNetwork.SendClientEvent(CEvent.V2_CreateXLuaPanel, "UILoginPanel");
            return;
        }
        isInitUI = true;
        XLuaMgr_InitUI f = luaenv.Global.Get<XLuaMgr_InitUI>("InitUI");
        if (f != null)
        {
            f();
        }
    }

    IEnumerator WaitServerVersion()
    {
        while (CSVersionMgr.Instance.ServerVersion == null) yield return null;
        InitUI();
    }

    /// <summary>
    /// 在lua的uimanager中释放ui界面使用的table
    /// </summary>
    /// <param name="luaTable"></param>
    public void ReleaseUITableInLua(object luaTable)
    {
        if (ReleaseUIPanelFunction != null)
        {
            ReleaseUIPanelFunction(luaTable);
        }
    }

    /// <summary>
    /// 清理lua中的缓存
    /// </summary>
    public void ClearCache()
    {
        if (ClearCacheBeforeLeaveGame != null)
        {
            ClearCacheBeforeLeaveGame();
        }
    }

    public void GetStrack(IntPtr L, string pre, bool isErrorLog = false)
    {
#if UNITY_EDITOR
        int oldTop = LuaAPI.lua_gettop(L);
        //int debug = LuaAPI.xlua_getglobal(L, "debug");
        LuaAPI.xlua_getglobal(L, "debug");
        LuaAPI.xlua_pushasciistring(L, "traceback");
        //int info = LuaAPI.xlua_pgettable(L, -2);
        LuaAPI.xlua_pgettable(L, -2);
        int e = LuaAPI.lua_pcall(L, 0, 1, 0);

        if (e != 0)
        {
            UnityEngine.Debug.LogError("调用失败 ");
        }
        else
        {
            string s = LuaAPI.lua_tostring(L, -1);
            if (isErrorLog)
            {
                UnityEngine.Debug.LogError(pre + " 调用堆栈:\n" + s);
            }
            else
            {
                UnityEngine.Debug.Log(pre + " 调用堆栈:\n" + s);
            }
        }

        LuaAPI.lua_settop(L, oldTop);
#endif
    }

    public string GetStrackInfo(IntPtr L)
    {
#if UNITY_EDITOR
        int oldTop = LuaAPI.lua_gettop(L);
        //int debug = LuaAPI.xlua_getglobal(L, "debug");
        LuaAPI.xlua_getglobal(L, "debug");
        LuaAPI.xlua_pushasciistring(L, "traceback");
        //int info = LuaAPI.xlua_pgettable(L, -2);
        LuaAPI.xlua_pgettable(L, -2);
        int e = LuaAPI.lua_pcall(L, 0, 1, 0);
        string info = "";
        if (e != 0)
        {
            //UnityEngine.Debug.LogError("调用失败 ");
        }
        else
        {
            info = LuaAPI.lua_tostring(L, -1);
        }
        //UnityEngine.Debug.Log(" 调用堆栈:\n" + info);
        LuaAPI.lua_settop(L, oldTop);
        return info;
#else
        return string.Empty;
#endif
    }

    //public int test0;
    //private int test1 = 2;
    //private static int test2 = 3;
    ////public int test1 { get { return _test1; } set { _test1 = value; } }
    //private void test3()
    //{
    //    Debug.Log("testfdsfasfdas3333333333");
    //    //object obj = null;
    //    //string s = obj.ToString();
    //}

}
