using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstantPanel : MonoBehaviour
{
    public GameObject obj;
    public int num;
    public int activeNum;
    List<GameObject> objList = new List<GameObject>();

    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i < num; i++)
        {
            objList.Add(Instantiate(obj, Vector3.back * (obj.transform.position.z + (float)i * 0.1f), new Quaternion()));
        }
    }

    // Update is called once per frame
    void Update()
    {
        for(int i=0;i<objList.Count;i++ )
        {
            if (i < activeNum)
            {
                objList[i].SetActive(true);
            }
            else
            {
                objList[i].SetActive(false);
            }
        }
    }
}
