using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{

    float time;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        time += Time.deltaTime * 0.1f;
        if (2.0f * Mathf.PI < time) time -= 2.0f * Mathf.PI;

        transform.position = new Vector3(0, 0, 0.5f * Mathf.Sin(time) + 0.5f);
    }
}
