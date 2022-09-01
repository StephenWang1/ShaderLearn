using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadAsset 
{
   private readonly string _path;
   private WWW _www = null;

   private int _countRetry = 5;

   public LoadAsset(string path)
   {
      _path=path;
   }

   public T StartLoad<T>() 
   {
      T result=default;

      while (result == null)
      {
         foreach (var obj in LoadWww<T>())
         {
            result = obj;
         }

         if (_countRetry > 0)
         {
            if (result != null)
            {
               break;
            }
            _countRetry--;
         }
         else
         {
            break;
         }
      }

      DealInit();
      return result;
   }

   private void DealInit()
   {
      _www?.Dispose();
      _www = null;
   }
   private IEnumerable<T> LoadWww<T>()
   {
      _www =new WWW(_path);
      
      if (typeof(T) == typeof(byte[]))
      {
         yield return (T)(object)_www.bytes;
      }
      else if(typeof(T) == typeof(string))
      {
         yield return (T)(object)_www.text;
      }
      else
      {
         var t= JsonUtility.FromJson<T>(_www.text);
         yield return t;
      }
   }
}


public class SyncLoadWWW
{
   private static SyncLoadWWW instance = null;
   public static SyncLoadWWW Instance
   {
      get
      {
         if (instance == null)
         {
            instance = new SyncLoadWWW();
         }
         return instance;
      }
   }
   public byte[] StarLoad(string path)
   {
      byte[] obj = null;
      LoadAsset asset = new LoadAsset(path);
      obj = asset.StartLoad<byte[]>();
      return obj;
   }

   public T StarLoad<T>(string path)
   {
      LoadAsset asset = new LoadAsset(path);
      object obj = asset.StartLoad<T>();
      return ((T)obj);
   }
}
