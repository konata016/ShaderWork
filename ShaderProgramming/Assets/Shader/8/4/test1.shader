Shader "Unlit/test1"
{
	Properties
	{
		_Threshold("Threshold",Range(0,10)) = 1.0
		_Color("Color", Color) = (1,0,0,1)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			float _Threshold;
			fixed4 _Color;

			v2f vert(appdata v)
			{
				v2f o;
				v.vertex.xyz = v.vertex.xyz * 0.9;
				o.vertex = UnityObjectToClipPos(v.vertex + v.normal*_Threshold*0.03);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return _Color;
			}
			ENDCG
		}
	}
}
