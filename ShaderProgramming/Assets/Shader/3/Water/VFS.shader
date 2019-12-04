Shader "Unlit/VFS"
{
    Properties
	{
		_Color("Base color",Color) = (.34,.85,.92,1)
		_HeightTex("Height map",2D) = "white"{}
	_NormalTex("Normal map",2D) = "white"{}
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
				float3 wpos: TEXCOORD01;
                float4 vertex : SV_POSITION;
            };

            sampler2D _HeightTex;
			sampler2D _NormalTex;
            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
				float d = tex2Dlod(_HeightTex, float4(v.uv.xy, 0, 0)).r;
				v.vertex.xyz += float3(0, d, 0);
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.wpos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.uv = v.uv;
                return o;
            }

			float3 get_normal(v2f i) {
		/*		float3 dPosdx = ddx(i.wpos);
				float3 dPosdy = ddy(i.wpos);
				float2 dUVdx = ddx(i.uv);
				float2 dUVdy = ddy(i.uv);

				float3 T = +dPosdx * dUVdy.y - dPosdy * dUVdx.y;
				float3 B = -dPosdx * dUVdy.x - dPosdy * dUVdx.x;*/

//				return -normalize(cross(T, B));

				float2 nTex = tex2D(_NormalTex, i.uv).xy;
				return float3(nTex.x, -sqrt(1.0 - dot(nTex, nTex)), nTex.y);
			}

            fixed4 frag (v2f i) : SV_Target
            {
				float3 normal = get_normal(i);

				float3 v = _WorldSpaceCameraPos - i.wpos;
				float3 l = _WorldSpaceLightPos0;
				float3 h = normalize(l + v);
				float spec = pow(max(dot(h, normal), 0.0), 20.0);

				float diffuse = max(0.0, dot(normal, l)) + 0.7 + 0.3;

				return fixed4(_Color.rgb*diffuse + spec, 1.0);
            }
            ENDCG
        }
    }
}
