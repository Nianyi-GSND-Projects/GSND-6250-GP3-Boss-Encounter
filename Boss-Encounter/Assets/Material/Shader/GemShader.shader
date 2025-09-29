Shader "Custom/GemShader"
{
    Properties
    {
        [HDR]_Color ("Color_Back", Color) = (1,1,1,1)
        _RefratTex ("RefratTex", Cube) = "white" {}
        _RefratIntensity ("RefratIntensity", Range(0,5)) = 1
        _ReflectTex ("ReflectTex", Cube) = "white" {}
        [HDR]_Color2("Color_Front",Color) = (1,1,1,1)
        _F_Power("_F_Power",Range(0,20)) = 1
        _F_Intensity("F_Intensity",Range(0,5)) = 1
        _F_Blas("_F_Blas",float) = 0
        [HDR]_F_Color("_F_Color",color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType"="Transparent" "RenderPipeline" = "UniversalPipeline"}
        LOD 100
        
        Pass
        {
          Tags{"LightMode" = "UniversalForward"}
          Blend one one
          Cull back
          
          HLSLPROGRAM

          #pragma vertex vert
          #pragma fragment frag

          #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
          #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
          #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
          #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

          CBUFFER_START(UnityPerMaterial)
          float4 _Color,_Color2,_F_Color;
          float _RefratIntensity;
          float _F_Power, _F_Intensity,_F_Bias;
          CBUFFER_END

          TEXTURECUBE(_RefratTex); SAMPLER(sampler_RefratTex);
          TEXTURECUBE(_ReflectTex); SAMPLER(sampler_ReflectTex);

          struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalOS : NORMAL;
                
            };

            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 positionVS : TEXCOORD2;
                float4 positionOS : TEXCOORD3;
                float4 positionCS : SV_POSITION;
                float3 viewDirWS : TEXCOORD4;
                float3 normalWS : TEXCOORD5;
            };

          Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                o.positionOS = v.positionOS;
                o.positionWS = TransformObjectToWorld(v.positionOS.xyz);
                o.positionVS = TransformWorldToView(o.positionWS);
                o.positionCS = TransformWViewToHClip(o.positionVS);
                o.uv = v.uv;
                o.viewDirWS = normalize(_WorldSpaceCameraPos - o.positionWS);
                o.normalWS = normalize(TransformObjectToWorldNormal(v.normalOS));
                return o;
            }

            half4 frag (Varyings i) :SV_Target
            {
                half3 viewDirWS_dir = normalize(i.viewDirWS);
                half3 reflect_dir = reflect(-viewDirWS_dir,i.normalWS);
                half Fre = 1-saturate(dot(viewDirWS_dir,i.normalWS));
                Fre = max(pow(Fre,_F_Power),0.00001) * _F_Intensity + _F_Bias;
                half4 Fre_Color = Fre*_F_Color;
                half4 refra = SAMPLE_TEXTURECUBE_LOD(_RefratTex,sampler_RefratTex,reflect_dir,0);
                half4 refle = SAMPLE_TEXTURECUBE_LOD(_ReflectTex,sampler_ReflectTex,reflect_dir,0)*Fre;
                half4 c = refra*refle*_Color2;
                return c + Fre_Color;
            }
          ENDHLSL
        }
        Pass
        {
            Tags{"LightMode" = "SRPDefaultUnlit"}
            Blend Off
            Cull front
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            CBUFFER_START(UnityPerMaterial)
            float4 _Color,_Color2;
            float _RefratIntensity;

            CBUFFER_END

            TEXTURECUBE(_RefratTex); SAMPLER(sampler_RefratTex);
            TEXTURECUBE(_ReflectTex); SAMPLER(sampler_ReflectTex);

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalOS : NORMAL;
                
            };

            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 positionVS : TEXCOORD2;
                float4 positionOS : TEXCOORD3;
                float4 positionCS : SV_POSITION;
                float3 viewDirWS : TEXCOORD4;
                float3 normalWS : TEXCOORD5;
            };

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                o.positionOS = v.positionOS;
                o.positionWS = TransformObjectToWorld(v.positionOS.xyz);
                o.positionVS = TransformWorldToView(o.positionWS);
                o.positionCS = TransformWViewToHClip(o.positionVS);
                o.uv = v.uv;
                o.viewDirWS = normalize(_WorldSpaceCameraPos - o.positionWS);
                o.normalWS = normalize(TransformObjectToWorldNormal(v.normalOS));
                return o;
            }

            half4 frag (Varyings i) :SV_Target
            {
                half3 viewDirWS_dir = normalize(i.viewDirWS);
                half3 reflect_dir = reflect(-viewDirWS_dir,i.normalWS);

                half4 refra = SAMPLE_TEXTURECUBE_LOD(_RefratTex,sampler_RefratTex,reflect_dir,0)*_RefratIntensity;
                half4 refle = SAMPLE_TEXTURECUBE_LOD(_ReflectTex,sampler_ReflectTex,reflect_dir,0);
                half4 c = refra*refle*_Color;
                return c;
            }
            ENDHLSL
        }
    }
    
}
