
//-------------------------------------------------------------------------
//Game Sate
//Author LiZongFu
//Time 2015.12.15
//-------------------------------------------------------------------------


using System.Collections;
using System.Collections.Generic;
using AssetBundles;
using UnityEngine;
using UnityEngine.Networking;

public class CSGame : SFGame, ICBGame, NewI_CSGame
{
    public bool isTestFillMode = false;
    public FilterMode testFillMode = FilterMode.Point;
#if UNITY_EDITOR
    [XLua.BlackList]
    [Header("Only Editor Use")]
    public string debugAvatarName;
#endif
    public bool EditMode;                      // 编辑模式
    //public bool     DisplayerMesh = false;       // 编译编辑数据
    public float PixelRatio;                    // 游戏分辨率

    //public bool IsDebugLoadScene = false;

    [SerializeField]
    [HideInInspector]
    public bool IsDebugLog = true;

    //[SerializeField]
    private bool isLoadLocalRes = false;

    [SerializeField]
    // [HideInInspector]
    public bool isConstraintHotLoadRes = false; //强制热更测试开关 正常操作勿开启！！！
    [SerializeField]
    // [HideInInspector]
    public bool isSimulateOutRes = false; //是否模拟外部下载 正常操作勿开启！！！
    public bool IsSimulateOutRes
    {
        get { return isSimulateOutRes; }
        set { isSimulateOutRes = value; }
    }

    [SerializeField]
    private bool isLoadStreamingAssets = false;
    public bool IsLoadStreamingAssets
    {
        get { return isLoadStreamingAssets; }
        set { isLoadStreamingAssets = value; }
    }

    [SerializeField] private bool isUseStreamingAssetsLua;
    public bool IsUseStreamingAssetsLua
    {
        get => isUseStreamingAssetsLua;
        set => isUseStreamingAssetsLua = value;
    }
    
    public bool isSimulateUILoadAB = false; //模拟本地UI下载ab
    public string localVersion = "1.0.0";

    /// <summary>
    /// 是否正在进入游戏场景
    /// </summary>
    public bool IsEnterMainScene = false;
    public static bool IsUseMono = false;//需要从Android获得正确的值
    /// <summary>
    /// 进入主场景时是否断开了连接,null表示没有此事,false和true分别表示断线后是否需要开启断线重连
    /// </summary>
    public bool? isDisconnectedDuringMainSceneEntering = null;

    public static string resVersionInApk = "0.0.0";

    public Vector2 ContentSize = new Vector2(1334, 750);
    private Vector2 originScreenSize = Vector2.zero;
    public UnityEngine.Vector2 OriginScreenSize
    {
        get { return originScreenSize; }
        set { originScreenSize = value; }
    }
    //public Vector2 ContentSize = new Vector2(1136, 640);
    public EventHandlerManager EventHandler = new EventHandlerManager(EventHandlerManager.DispatchType.Event);
    public EventHandlerManager SocketHandler = new EventHandlerManager(EventHandlerManager.DispatchType.Socket);
    private CSGameState mLastState;
    public CSGameState LastState
    {
        get { return mLastState; }
        set { mLastState = value; }
    }
    private CSGameState mCurrentState;
    public CSGameState CurrentState
    {
        get { return mCurrentState; }
        set { mCurrentState = value; }
    }
    private CSGameState mNextState;
    public CSGameState NextState
    {
        get { return mNextState; }
        set { mNextState = value; }
    }
    [HideInInspector]
    public long roleId = 0;
    private static UIRoot root;
    /// <summary>
    /// 格子尺寸,(72, 48 * 1.414)
    /// </summary>
    [HideInInspector]
    public Vector3 CellSize;

    public static int GLESVersion = 0x30000;//GLES 3.0
    public static bool IsSupportGLES3 = true;
    public static bool isRealGPUInstanceSupport = false;
    public  bool isSyncCallBackBaseEvent = true;
    /// <summary>
    /// 
    /// </summary>
    public string EditorConfigFile = string.Empty;
    public static EOrientationState OrientationState
    {
        set
        {
            if (ConstantPublic.SpecialAdaptRadio == 1 || ConstantPublic.OrientationState == value || root == null)
            {
                return;
            }

            ConstantPublic.OrientationState = value;
            //刷新所有界面的锚点设置
            UIWidget[] widgets = root.GetComponentsInChildren<UIWidget>();
            for (int i = 0; i < widgets.Length; i++)
            {
                UIWidget widget = widgets[i];
                if (widget.enabled && widget.UpdateOnOrientationChange)
                {
                    widget.UpdateAnchors();
                }
            }
            CSNetwork.SendClientEvent(CEvent.UpdateOrientationState);
        }
        get { return ConstantPublic.OrientationState; }
    }

    public virtual void Awake()
    {
        CellSize = new Vector3(72, 67.88225f);
        OriginScreenSize = new Vector2(Screen.width, Screen.height);
        if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        {
            //string sharpSVNToolPath = FileUtility.GetBackDir(Application.dataPath, 4) + "/Tool/SharpSVNTool/SharpSVNTool.exe";
            //bool isSucess = FileUtility.CallProcess(sharpSVNToolPath, "", true);
            //if (!isSucess)
            //{
            //    UnityEngine.Debug.LogError("权限获取失败!");
            //    return;
            //}
            CSInterfaceSingleton.Unity_Editor.CSGame_InitEditorData();
        }
        CSDebug.developerConsoleVisible = IsDebugLog;
        SDebug.developerConsoleVisible = IsDebugLog;
        DontDestroyOnLoad(this);
        Screen.sleepTimeout = SleepTimeout.NeverSleep;
        mSington = this;
        SFCell.Size = new Vector2(CellSize.x, CellSize.y);
        SFCell.HalfSize = new Vector2(CellSize.x / 2, CellSize.y / 2);

        string deviceBrand = SDKManager.GameInterface.GetDeviceBrand();
        string systemModel = SDKManager.GameInterface.GetSystemModel();
        Constant.PhoneName = string.Format("{0}-{1}", deviceBrand, systemModel);

        StartCoroutine(loadAdapt());
        PixelRatio = CSScene.SceneScale.y;
        CSGameManager.Instance = GetComponent<CSGameManager>();
        CSGameManager.Instance.Init();
        Application.targetFrameRate = 60;
        InitOnce();
        InitCBOut();
        CSDebug.Log(SystemInfo.graphicsShaderLevel);
    }

    private void InitCBOut()
    {
        SFOut.Game = mSington;
        SFOut.IGame = mSington;
        SFOut.URL_mClientResPath = URL.mClientResPath;
        SFOut.URL_mCommonResURL = URL.mCommonResURL;
        SFOut.URL_mServerResURL = URL.mServerResURL;
        SFOut.URL_mClientResURL = URL.mClientResURL;
    }

    public void SetPixelzoom(int pixelzoom)
    {
        if (!Constant.IsOpenLiuHaiAdapt()) return;

        Constant.pixelzoom = pixelzoom;
        ConstantPublic.SpecialAdaptRadio = (ContentSize.x - Constant.pixelzoom) * 1.0f / ContentSize.x;
    }

    public void SetResolutionRatioFit(float ResolutionRatioFitScale)
    {
        Vector2 vec = ContentSize * ResolutionRatioFitScale / 100.0f;
        Screen.SetResolution((int)vec.x, (int)vec.y, true);
    }

    public void SetAdapt()
    {
        //string devicemodel = SystemInfo.deviceModel.ToLower().Trim();
        //bool bIsTablet = false;

        root = GameObject.Find("UI Root").gameObject.GetComponent<UIRoot>();
        if (root == null)
        {
            UnityEngine.Debug.LogError("UI Root獲取失敗");
            return;
        }
        double curRoata = (OriginScreenSize.x * 1.0f) / (OriginScreenSize.y * 1.0);
        double defaultRoata = ContentSize.x / ContentSize.y;
        FPS.OriginScreenSize = "分辨率OriginScreenSize:" + OriginScreenSize.x + "*" + OriginScreenSize.y + "\n";
        if (curRoata > defaultRoata)//以高度做适配
        {
            float radio = OriginScreenSize.x * 1.0f / OriginScreenSize.y;
            int newHeight = (int)ContentSize.y;
            int newWidth = Mathf.CeilToInt(ContentSize.y * 1.0f * radio);
            Screen.SetResolution(newWidth, newHeight, true);
            ContentSize.x = newWidth;
            ContentSize.y = newHeight;
            //root.manualWidth = newWidth;
            //root.manualHeight = newHeight;
            CSMesh.PadVisionCountX = (int)(newWidth / CSCell.Size.x * 0.5f);
            CSMesh.PadVisionCountY = (int)(newHeight / CSCell.Size.y * 0.5f) + 1;
            if (Constant.pixelzoom != 0)
            {
                SetPixelzoom(Constant.pixelzoom);
            }
            //1200/1280(2160*1080分辨率的情况下,通过NGUI适配,将屏幕分辨率调整为1280*640,0.9375=1200/1280即左右各缩进40)
            //if (curRoata == 2)//当前测试
            //ConstantPublic.SpecialAdaptRadio = 0.8375f;

            UnityEngine.Debug.Log("0 Screen.width = " + OriginScreenSize.x + " Screen.height=" + OriginScreenSize.y + " root w h = " + root.manualWidth + " " + root.manualHeight);

        }
        else if (curRoata < defaultRoata)//以宽度做适配
        {
            float radio = OriginScreenSize.x * 1.0f / Screen.height;
            int newWidth = (int)ContentSize.x;
            int newHeight = Mathf.CeilToInt(ContentSize.x * 1.0f / radio);
            Screen.SetResolution(newWidth, newHeight, true);
            ContentSize.x = newWidth;
            ContentSize.y = newHeight;
            UIRoot root = GameObject.Find("UI Root").gameObject.GetComponent<UIRoot>();
            root.manualWidth = newWidth;
            root.manualHeight = newHeight;
            CSMesh.PadVisionCountX = (int)(newWidth / CSCell.Size.x * 0.5f);
            CSMesh.PadVisionCountY = (int)(newHeight / CSCell.Size.y * 0.5f) + 1;
            if (Constant.pixelzoom != 0)
            {
                SetPixelzoom(Constant.pixelzoom);
            }

            UnityEngine.Debug.Log("1 Screen.width = " + OriginScreenSize.x + " Screen.height=" + OriginScreenSize.y + " root w h = " + root.manualWidth + " " + root.manualHeight);
        }
        else
        {
            Screen.SetResolution((int)ContentSize.x, (int)ContentSize.y, true);
            UnityEngine.Debug.Log("2 Screen.width = " + OriginScreenSize.x + " Screen.height=" + OriginScreenSize.y + " root w h = " + root.manualWidth + " " + root.manualHeight);

        }

        //PixelRatio = 1 * 2f / ContentSize.y;
        PixelRatio = CSScene.SceneScale.y;
    }

    /// <summary>
    /// 加载特殊机型进行适配
    /// </summary>
    /// <returns></returns>
    private IEnumerator loadAdapt()
    {
        bool IsDisplayCutout = SDKManager.GameInterface.DisplayCutout();
        int height = SDKManager.GameInterface.GetStatusBarHeight();
        UnityEngine.Debug.Log(string.Format("IsDisplayCutout:{0}    height:{1}", IsDisplayCutout, height));
        if (IsDisplayCutout && height != 0)
        {
            Constant.IsLiuHaiAdapt = true;
            SetPixelzoom(height);
            SetAdapt();
            SDKManager.GameInterface.InitPhoneOrientation();
            yield break;
        }
        else
        {
            Constant.IsLiuHaiAdapt = false;
        }
        using (WWW www = new WWW("http://webconf.wjrx.app.9125flying.com/config/ResolutionRatioAdapt.txt"))
        {
            yield return www;
            if (string.IsNullOrEmpty(www.text))
            {
                SetAdapt();
            }
            else
            {
                Constant.OrigionSceneHeight = (int)OriginScreenSize.y;
                Constant.OrigionSceneWidth = (int)OriginScreenSize.x;
                //"2208_1028_40#2208_1028_40";
                string[] resolutions = www.text.Trim().Split('#');
                for (int i = 0; i < resolutions.Length; i++)
                {
                    //"2208_1028_40_oppo-x21";
                    string[] info = resolutions[i].Split('_');
                    bool CheckPhoneName = true;
                    if (info.Length > 3 && !string.IsNullOrEmpty(info[3]))
                    {
                        if (Constant.PhoneName != info[3])
                        {
                            CheckPhoneName = false;
                        }
                    }
                    if (info.Length > 2)
                    {
                        if (Constant.OrigionSceneWidth == int.Parse(info[0]) && Constant.OrigionSceneHeight == int.Parse(info[1]) && CheckPhoneName)
                        {
                            Constant.IsLiuHaiAdapt = true;
                            SetPixelzoom(int.Parse(info[2]));
                            //Constant.pixelzoom = int.Parse(info[2]);
                        }
                    }
                }
                SetAdapt();
                SDKManager.GameInterface.InitPhoneOrientation();
            }
        }
    }

    protected virtual void Start()
    {
        Initialization();
        if (IsLoadStreamingAssets)//mumu模拟器上面IsSupportGLES3是false，会不显示模型
        {
            IsSupportGLES3 = true;
            GLESVersion = 0x30000;
            isRealGPUInstanceSupport = true;
        }
        else
        {
            IsSupportGLES3 = SDKManager.GameInterface.IsSupportGLES3();
            GLESVersion = SDKManager.GameInterface.GetDeviceConfigurationInfo();
            //UnityEngine.Debug.Log("GLESVersion=" + GLESVersion + " IsSupportGLES3=" + IsSupportGLES3);
            isRealGPUInstanceSupport = (IsLoadStreamingAssets || GLESVersion >= 0x30000) && IsSupportGLES3 && SystemInfo.supportsInstancing;
        }
        FPS.SupportsInstancing = "supportsInstancing:" + SystemInfo.supportsInstancing + "\n";
        FPS.GLESVersion = "GLESVersion:" + CSGame.GLESVersion + "\n";
        FPS.IsSupportGLES3 = "IsSupportGLES3:" + CSGame.IsSupportGLES3 + "\n";

        FPS.IsRealGPUInstanceSupport = "isRealGPUInstanceSupport:" + CSGame.isRealGPUInstanceSupport;
        //FPS.FpsStaticInfo = FPS.SupportsInstancing + FPS.GLESVersion + FPS.IsSupportGLES3 +
        //    FPS.IsRealGPUInstanceSupport + FPS.OriginScreenSize;
        FPS.FpsStaticInfo = FPS.IsRealGPUInstanceSupport + "\n";
        //CSVersionMgr.IsNeedHot = IsNeedHot;
        //#if ProfilerTest
        //        isRealGPUInstanceSupport = SystemInfo.supportsInstancing;
        //#else
        //        isRealGPUInstanceSupport = false;
        //#endif
        IsUseMono = SDKManager.GameInterface.GetUseFrame() == EUseFrame.Mono || CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR;
#if LinearGammaPostProc
        GameObject uiCamera = GameObject.Find("UI Root/Camera");
        if(uiCamera!=null)
        {
            uiCamera.AddComponent<AlphaLinearToGammaPostRender>();
        }
#endif
        //CSStringBuilder.Init();

    }



    /// <summary>
    /// 监听网络状态
    /// </summary>
    private bool mWaitToReconnect = false;
    public bool WaitToReconnect
    {
        get { return mWaitToReconnect; }
        set { mWaitToReconnect = value; }
    }

    private void Initialization()
    {
        if (IsLoadLocalRes)
        {
            TableLoader.Instance.PreLoadTables(null);
            TableLoader.Instance.LoadTables();
            CSPreLoadResourceRes.PreLoad();
        }
    }


    public virtual void Update()
    {
        Network.Instance.Update();
        Timer.Instance.Update();
        UpdateLowMemory();
        //if (Input.GetMouseButtonDown(1))
        //{
        //    CSDirectPath.Clear();
        //}
    }

    private void InitOnce()
    {
        CSMisc.InitSpriteData();
    }

    public void Init()
    {
        if (this == null)
        {
            return;
        }

        CSGameManager.Instance.Init();
    }

    protected virtual void OnDestroy()
    {
        CSNetwork.Instance.Close();
        CSNetwork.Instance.CloseThread();
        if (CSResUpdateMgr.Instance != null)
        {
            CSResUpdateMgr.Instance.CloseDownloadThread();
            CSResUpdateMgr.Instance.SaveFailedResList();
        }

        SDKManager.GameInterface.SubmitGameData(ESDKSubmitType.QuitGame);
    }

    public virtual void Clear(bool isClearScene)
    {
        if (this == null)
        {
            return;
        }

        CSGameManager.Instance.Clear();
        CSModelManager.Clear(isClearScene);
        //CSStringBuilder.Destroy();

    }

    public void GameStateEnter(CSGameState gs)
    {
        mLastState = mCurrentState;
        mCurrentState = gs;
    }

    public void OnApplicationQuit()
    {
#if MSGDEBUG
        string msgDebugInfo = "";
        string msgDebugInfo2 = "";
        msgDebugInfo += "static void InitMsg()\n{\n";
        foreach (var cur in CSNetwork.msgDebugDic)
        {
            string funcName = cur.Key.Replace(".", "_");
            msgDebugInfo += funcName + "();\n";
            msgDebugInfo2 += "static void " + funcName + "()\n{\n";
            msgDebugInfo2 += cur.Key + " r = new " + cur.Key + "();\n";
            if(cur.Value)
            {
                msgDebugInfo2 += "InitProtoSerialize(r);\n}\n";
            }
            else
            {
                msgDebugInfo2 += "InitProtoDeSerialize(r);\n}\n";
            }
        }
        msgDebugInfo += "}\n";
        string path = FileUtility.GetBackDir(Application.dataPath, 1) + "/ProjectCaches/MsgDebug.txt";
        FileUtility.Write(path, msgDebugInfo + "\n" + msgDebugInfo2, false);
        UnityEngine.Debug.Log(msgDebugInfo + "\n" + msgDebugInfo2);
#endif
        CSNetwork.Instance.Close();
        CSNetwork.Instance.CloseThread();
        if (CSResUpdateMgr.Instance != null)
        {
            CSResUpdateMgr.Instance.CloseDownloadThread();
            CSResUpdateMgr.Instance.SaveFailedResList();
        }

    }


    //-------------------------------------------------------
    private static CSGame mSington;
    public static CSGame Sington
    {
        get
        {
            return mSington;
        }
    }

    //-------------------------------------------------------

    public Material getShareMaterial(UnityEngine.Object obj, EShareMatType type = EShareMatType.Normal)
    {
        return CSScene.getShareMaterial(obj, type);
    }

    public bool IsLanuchMainPlayer
    {
        get { return CSScene.IsLanuchMainPlayer; }
    }

    public bool IsCanMoveFromSafeArea(Node f, Node s)
    {
        return CSDirectPath.IsCanMoveFromSafeArea(f, s);
    }

    public bool IsNotCrossToAnthor(CSMisc.Dot2 dot, CSMisc.Dot2 dot1)
    {
        return TableLoader.IsNotCrossToAnthor(dot, dot1);
    }

    public int VerticalCount
    {
        get { return CSMesh.VerticalCount; }
    }

    public int HorizontalCount
    {
        get { return CSMesh.HorizontalCount; }
    }

    public string StripSymbols(string text)
    {
        return NGUIText.StripSymbols(text);
    }

    public bool IsLoadLocalRes
    {
        get
        {
            if (CSGameState.RunPlatform == ERunPlatform.Editor)
            {
                return !isSimulateOutRes;
            }
            else
            {
                if (CSGameState.RunPlatform == ERunPlatform.Editor) return true;
                if (IsLoadStreamingAssets) return true;
                return false;
            }

        }
        set { isLoadLocalRes = value; }
    }

    public bool IsOpenDebug
    {
        get
        {
            return OnlineDebug.IsOpenDebug;
        }
        set
        {
            OnlineDebug.IsOpenDebug = value;
        }
    }

    //[SerializeField]
    //public bool IsNeedHot;
    public void AddLog(ELogToggleType type, string log, ELogColorType colorType = ELogColorType.White)
    {
        UIDebugInfo.AddLog(type, log, colorType);
    }

    public int getMapID()
    {
        return CSScene.getMapID();
    }

    public float GetPoolRealseApseat
    {
        get
        {
            //if (CSDynamicChangeSetting.Instance != null)
            //{
            //    return CSDynamicChangeSetting.Instance.PoolRealseApseat;
            //}

            return mPoolRealseApseat;
        }
    }
    float lastGetLowMemoryState = 0;
    bool mIsLowMemory = false;
    long mLeftMemory = 0;
    float mPoolRealseApseat = 1;
    float mResourceDestroyInternal = 0.5f;
    public float ResourceDestroyInternal
    {
        get { return mResourceDestroyInternal; }
        set { mResourceDestroyInternal = value; }
    }
    void UpdateLowMemory()
    {
        if (!CSScene.IsLanuchMainPlayer) return;
        if (Time.time - lastGetLowMemoryState < 5) return;
        lastGetLowMemoryState = Time.time;
        //mIsLowMemory = SDKManager.GameInterface.GetIsLowMemoryState();
        //UnityEngine.Debug.Log("mIsLowMemory=" + mIsLowMemory);
#if UNITY_EDITOR || UNITY_ANDROID

        long t = 0;
        if (!SFOut.IGame.IsLoadLocalRes)
        {
            //t = SDKManager.GameInterface.systemAvaialbeMemorySize()  - SDKManager.GameInterface.getMemoryThreshold();
            t = SDKManager.GameInterface.GetMemoryLimitResidue();
        }
        long mt = (long)(t / 1024f);
        if (CSDebug.developerConsoleVisible)
            CSDebug.Log("GetMemoryLimitResidue = " + mt + "M");
        //float sec = UnityEngine.Profiling.Profiler.GetMonoUsedSizeLong() / 1024f / 1024f;
        //float sec2 = UnityEngine.Profiling.Profiler.GetMonoHeapSizeLong() / 1024f / 1024f;
        //UnityEngine.Debug.Log(GetType().ToString() + " " + sec + "M"+" "+ sec2+"M");
        mLeftMemory = mt;
        mIsLowMemory = false;
        mResourceDestroyInternal = 0.5f;
        mPoolRealseApseat = 1;
        if (mt == 0)
        {
        }
        else if (mt < 100)
        {
            //mIsLowMemory = true;
            mPoolRealseApseat = 0.03f;
            mResourceDestroyInternal = 0.1f;
        }
        else if (mt < 200)
        {
            mPoolRealseApseat = 0.1f;
            mResourceDestroyInternal = 0.25f;
        }
        else if (mt < 300)
        {
            mPoolRealseApseat = 0.2f;
            mResourceDestroyInternal = 0.5f;
        }
        else if (mt < 400)
        {
            mPoolRealseApseat = 0.3f;
            mResourceDestroyInternal = 0.5f;
        }
        //mPoolRealseApseat = 0.03f;
        //mResourceDestroyInternal = 0.02f;
#endif
    }

    public bool IsLowMemory
    {
        get
        {
            return mIsLowMemory;
        }
    }

    public Shader GetHotShader(string s)
    {
        CSPreLoadResourceRes.Data data = CSPreLoadResourceRes.GetData(s);
        if (data != null)
        {
            return data.obj as Shader;
        }
        return null;
    }



    public void StartCheckVoiceState(int time)
    {
        if (!IsInvoking("CheckVoiceInterval"))
        {
            Invoke("CheckVoiceInterval", time * 2);
        }
        else
        {
            CancelInvoke("CheckVoiceInterval");
            Invoke("CheckVoiceInterval", time * 2);
        }
    }

    public List<uint> FirstPackMapIDList
    {
        get
        {
            return TableLoader.Instance.FirstPackMapIDList;
        }
    }


    public static UnityEngine.Object uiIconObj = null;
    public static bool isHasCallLoadingUIIcon = false;
    public static IEnumerator Prestrain()
    {
        if (isHasCallLoadingUIIcon) yield break;
        isHasCallLoadingUIIcon = true;
        if (CSGame.Sington.IsLoadStreamingAssets ||
            !CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        {
            AssetBundleManager.AddPreDeal("icon");
            LoadedAssetBundle assetBudle = AssetBundleManager.LoadUIAssetAsync("chart/icon");
            if (assetBudle == null)
            {
                yield break;
            }

            AssetBundleRequest ar = assetBudle.m_AssetBundle.LoadAssetAsync<UnityEngine.Object>("icon");

            yield return ar;
            uiIconObj = ar.asset;
        }
        else
        {
            uiIconObj = CSInterfaceSingleton.Unity_Editor.CSGame_Prestrain();

        }
    }

    public static UnityEngine.Object uiFontObj = null;
    public static UnityEngine.Object uiMsyhFontObj = null;
    public static bool isHasCallLoadingUIFont = false;
    public static IEnumerator PrestrainFont(string fontName, bool isUIFont)
    {
        //if (isHasCallLoadingUIFont) yield break;
        //isHasCallLoadingUIFont = true;
        if (!CSGame.Sington.IsLoadStreamingAssets)
        {
            if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
            {
                if (Sington.IsLoadLocalRes)
                {
                    if (isUIFont)
                    {
                        uiFontObj = CSInterfaceSingleton.Unity_Editor.CSGame_PrestrainFont(fontName);

                    }
                    else
                    {
                        uiMsyhFontObj = CSInterfaceSingleton.Unity_Editor.CSGame_PrestrainFont(fontName);
                    }
                    yield break;
                }
            }
        }
        AssetBundleManager.AddPreDeal("font/" + fontName);
        LoadedAssetBundle assetBudle = AssetBundleManager.LoadUIAssetAsync("font/" + fontName);
        if (assetBudle == null)
        {
            yield break;
        }

        AssetBundleRequest ar = assetBudle.m_AssetBundle.LoadAssetAsync<UnityEngine.Object>(fontName);
        yield return ar;
        if (isUIFont)
        {
            uiFontObj = ar.asset;
        }
        else
        {
            uiMsyhFontObj = ar.asset;
        }

        //return objs;
    }

    private void StartConnectServerFailTips(object obj)
    {
        StopConnectServerFailTips();
        StartCoroutine("ConnectServerFail", obj);
    }

    public void StopConnectServerFailTips()
    {
        StopCoroutine("ConnectServerFail");
    }

    private IEnumerator ConnectServerFail(object obj)
    {
        object[] objs = obj as object[];
        if (objs == null || objs.Length != 2)
        {
            yield break;
        }

        if (CSSceneManager.Instance.mCurState != SceneType.MainScene)
        {
            for (int i = 0; i < 5; i++)
            {
                yield return NGUIAssist.GetWaitForSeconds(3f);

            }
        }

        yield return NGUIAssist.GetWaitForSeconds(CSSceneManager.Instance.mCurState == SceneType.MainScene ? 15f : 5f);

        Utility.ShowRedTips("连接PVP跨服失败");


    }

    public bool IsCanCrossScene
    {
        get
        {
            return CSMapManager.IsCanCrossScene;
        }
    }

    private int reconnectNumberOfTimes = -1;
    private int reconnectTimeInterval = -1;
    /// <summary>
    /// 断线重连次数
    /// </summary>
    public int ReconnectNumberOfTimes
    {
        get
        {
            if (reconnectNumberOfTimes < 0)
            {
                Cfg_GlobalTableManagerBase.Instance.GetReconnectTime(out reconnectNumberOfTimes, out reconnectTimeInterval);
            }
            return reconnectNumberOfTimes;
        }
    }

    /// <summary>
    /// 断线重连时间间隔
    /// </summary>
    public int ReconnectTimeInterval
    {
        get
        {
            if (reconnectTimeInterval < 0)
            {
                Cfg_GlobalTableManagerBase.Instance.GetReconnectTime(out reconnectNumberOfTimes, out reconnectTimeInterval);
            }
            return reconnectTimeInterval;
        }
    }

    #region 游戏退出相关
    /// <summary>
    /// 返回登录
    /// </summary>
    public virtual void OnReturnLogin()
    {
        LogoutGameAccout();
    }

    /// <summary>
    /// 退出账号返回登入界面
    /// </summary>
    public virtual void LogoutGameAccout()
    {
        //游戏返回选角之后重新登录出现问题，先调用登出  
        UIManager.Instance.CloseAllPanel(null, true, ECloseAllPanel.ChangeScene);

        HttpRequest.Instance.Stop();//停止Http请求
        Constant.mSeverId = 0;//重置登入服务器ID
        CSNetwork.Instance.Close();//关闭网络
        ClearBeforeLeaveGame();
        CSSceneManager.Instance.Load(SceneType.LoginScene);//加载登入场景
    }

    ///// <summary>
    ///// 返回选角
    ///// </summary>
    //public virtual void OnReturnChooseRole()
    //{
    //    UIManager.Instance.CloseAllPanel(null, true, ECloseAllPanel.ChangeScene);

    //    ClearBeforeLeaveGame();
    //    CSSceneManager.Instance.Load(SceneType.LoginScene, 0, false, false, true);
    //}

    public virtual void ClearBeforeLeaveGame()
    {
        CSAudioOut.Clear();
        CSGame.Sington.EventHandler.UnRegAll(false);
        UIManager.Instance.ClearCombats();//清理UI
        CSInterfaceSingleton.ICSPathFinderManager.Reset();//寻路信息重置
        CSAudioMgr.Instance.ClearOnReturn();//清理声音播放
        CSScene.ForceDestroy();//销毁场景
    }

    public void QuitGame()
    {
        SDKManager.GameInterface.QuitGame();
    }

    public virtual UnityWebRequest GetUnityWebRequest(string path)
    {
        return UnityWebRequest.Get(path);
    }
    #endregion

    public void WriteABDebugInfo(string path, string AbCrashDebug2Info)
    {
        FileUtility.DetectCreateDirectory(path);
        FileUtility.Write(path, AbCrashDebug2Info, false);

    }
}