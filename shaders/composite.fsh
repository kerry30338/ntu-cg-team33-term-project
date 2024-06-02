#version 120

#include "library.glsl"

varying vec2 texcoord;

// Unused varying
varying vec3 sunVec;
varying vec3 upVec;

uniform sampler2D gcolor;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

float getShadow(void) {
	float depth = texture2D(depthtex0, texcoord).x;
	if (depth >= 1.0) {
		return 1.0;
	}

	vec3 clipSpace = vec3(texcoord, depth) * 2.0 - 1.0;
	vec4 viewW = gbufferProjectionInverse * vec4(clipSpace, 1.0);
	vec3 view = viewW.xyz / viewW.w;
	vec4 world = gbufferModelViewInverse * vec4(view, 1.0);
	vec4 shadowSpace = shadowProjection * shadowModelView * world;
	shadowSpace.xy = distortPosition(shadowSpace.xy);
	vec3 sampleCoord = shadowSpace.xyz * 0.5 + 0.5;
    return step(sampleCoord.z - 0.001f, texture2D(shadowtex0, sampleCoord.xy).r);
}

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;
	color = color * getShadow();
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
