Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_weight("weight",float) = 1.0
		_loopNum("loopNum",int) = 5
		_Radius("Radius",Range(0.0, 100.0)) = 5.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300

        Pass
        {
            CGPROGRAM


			#include "UnityCustomRenderTexture.cginc"
			#pragma vertex CustomRenderTextureVertexShader
			#pragma fragment frag
            

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float _Radius;
			int _loopNum;

            fixed4 frag (v2f_customrendertexture i) : SV_Target
            {
			   float2 scale = _MainTex_ST.xy * _Radius * 0.01;

			   fixed4 col =  tex2D(_MainTex, i.globalTexcoord);
			   float weight = 1.0;
			   const float S2 = 1.0 / 50.0;

			   float num = 1.5;

			   for (int f = 0; f < _loopNum; f++) {
				   float w = exp(-0.5 * num * num * S2);
				   col += w * tex2D(_MainTex, i.globalTexcoord + num *scale);
				   col += w * tex2D(_MainTex, i.globalTexcoord - num *scale);
				   weight += 2.0*w;
				   num += 2;
			   }
			   col /= weight;
			   return col;
            }
            ENDCG
        }
    }
}
