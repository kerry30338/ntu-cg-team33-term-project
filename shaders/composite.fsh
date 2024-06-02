#version 120

#include "library.glsl"

// Configurations
const float sunPathRotation = -40.0;

// Varyings
varying vec2 texcoord;

// Uniforms
uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D depthtex0;

uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

uniform sampler2D colortex7;

uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

uniform vec3 sunPosition;

float visibility(in sampler2D shadowMap, in vec3 samplecoord) {
	float depth = texture2D(shadowMap, samplecoord.xy).x;
	if (samplecoord.z > depth + 0.001) {
		return 0.0;
	}
	else {
		return 1.0;
	}
}

vec3 colorShadow(in vec3 samplecoord) {
	float v0 = visibility(shadowtex0, samplecoord);
	float v1 = visibility(shadowtex1, samplecoord);
	vec4 color0 = texture2D(shadowcolor0, samplecoord.xy);
	vec3 transmittedColor = color0.rgb * (1.0 - color0.a);
	return mix(transmittedColor * v1, vec3(1.0), v0);
}

vec3 getShadow(in float depth) {
	vec3 clipSpace = vec3(texcoord, depth) * 2.0 - 1.0;
	vec4 viewW = gbufferProjectionInverse * vec4(clipSpace, 1.0);
	vec3 view = viewW.xyz / viewW.w;
	vec4 world = gbufferModelViewInverse * vec4(view, 1.0);
	vec4 shadowSpace = shadowProjection * shadowModelView * world;
	shadowSpace.xy = distortPosition(shadowSpace.xy);
	vec3 samplecoord = shadowSpace.xyz * 0.5 + 0.5;
	return colorShadow(samplecoord);
}

void main() {
	vec3 albedo = texture2D(gcolor, texcoord).rgb;
	
	vec3 L = normalize(sunPosition);
	vec4 normal = texture2D(gnormal, texcoord);
	vec3 N = normalize(normal.xyz * 2.0 - 1.0);

	vec3 sunLight = vec3(1.0, 1.0, 1.0);
	float depth = texture2D(depthtex0, texcoord).x;

	vec3 ambient = sunLight * albedo;
	vec3 diffuse = sunLight * clamp(dot(L, N), 0.0, 1.0) * albedo;

	vec3 color = vec3(0.0);
	bool sky = (depth >= 1.0);

	if (sky) {
		color = albedo;
	}
	else {
		color = 0.3 * ambient + 0.9 * diffuse * getShadow(depth);		
	}

	// vec4 extraLight = texture2D(colortex7, texcoord);
	// if(extraLight != vec4(0.0)) {
	// 	color += extraLight.rgb;
	// }

	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
