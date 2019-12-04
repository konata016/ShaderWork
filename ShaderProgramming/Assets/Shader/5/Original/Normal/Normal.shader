Shader "Unlit/Normal"
{
	Properties
	{
	   _MainTex("Texture", 2D) = "white" {}
		_weight("weight",float) = 1.0
		_loopNum("loopNum",int) = 8
		_Radius("Radius",Range(0.0, 100.0)) = 5.0
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
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

				fixed4 frag(v2f_customrendertexture i) : SV_Target
				{
					const float2 halton[8] = {
					float2(1.0 / 2.0 - 0.5,1.0 / 3.0 - 0.5),
					float2(1.0 / 4.0 - 0.5,2.0 / 3.0 - 0.5),
					float2(3.0 / 4.0 - 0.5,1.0 / 9.0 - 0.5),
					float2(1.0 / 8.0 - 0.5,4.0 / 9.0 - 0.5),
					float2(5.0 / 8.0 - 0.5,7.0 / 9.0 - 0.5),
					float2(3.0 / 8.0 - 0.5,2.0 / 9.0 - 0.5),
					float2(7.0 / 8.0 - 0.5,5.0 / 9.0 - 0.5),
					float2(1.0 / 16.0 - 0.5,8.0 / 9.0 - 0.5)
					};
					float2 scale = _MainTex_ST.xy * _Radius*0.01;

					fixed4 col = fixed4(0, 0, 0, 1);
					for (int count = 0; count < _loopNum; count++) {
					col += tex2D(_MainTex, i.globalTexcoord + halton[count] * scale);
					}
					col /= 8.0;

					return col;
				}

				ENDCG
			}
		}
}

