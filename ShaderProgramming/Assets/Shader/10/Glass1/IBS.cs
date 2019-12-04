using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions;

public class IBS : MonoBehaviour
{
    public Color color = Color.white;

    // Start is called before the first frame update
    void Start()
    {
        var rendere = GetComponent<Renderer>();
        Assert.IsNotNull(rendere);

        MaterialPropertyBlock block = new MaterialPropertyBlock();
        block.SetColor("_Color", color);
        rendere.SetPropertyBlock(block);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
