using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QuadBehaviour : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Camera cam = Camera.main;

        transform.parent = cam.transform;

        float dis = cam.farClipPlane - 3;
        transform.localPosition = new Vector3(0, 0, dis);
        transform.localRotation = new Quaternion();

        float invAspect = (float)Screen.width / (float)Screen.height;
        float s = Mathf.Tan(0.5f * cam.fieldOfView * Mathf.Deg2Rad) * 2.0f * dis;
        transform.localScale = new Vector3(invAspect * s, s, 1);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
