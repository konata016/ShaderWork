using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Chase : MonoBehaviour
{
    public Transform targetObj;
    public Vector3 plusPos;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = 
            new Vector3(targetObj.position.x + plusPos.x, targetObj.position.y + plusPos.y, targetObj.position.z + plusPos.z);
    }
}
