Shader "Unlit/NormalMap"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex CustomRenderTextureVertexShader
			#pragma fragment frag

			#include "UnityCustomRenderTexture.cginc"

			sampler2D _MainTex;

	//float3 get_normal(v2f i) 
	//{
	//	float2 nTex = tex2D(_NormalTex, i.uv).xy;
	//	return float3(nTex.x, sqrt(1.0 - dot(nTex, nTex)), nTex.y);
	//}

	float2 frag(v2f_customrendertexture i) :SV_Target
	{
		float h = tex2D(_MainTex,i.globalTexcoord).x*30.0;
	float3 T = float3(1.0, -ddy(h), 0.0);
	float3 B = float3(0.0, -ddy(h), 1.0);
	float3 n = normalize(cross(T, B));

	return float2(n.x, n.z);
	}
            ENDCG
        }
    }
}
