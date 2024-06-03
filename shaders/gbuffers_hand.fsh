#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 normal;


// ============================================================================

#include "lib/HandHeldLight.inc"
#include "lib/CustomLightColor.inc"

uniform int heldBlockLightValue; // main hand
uniform int heldBlockLightValue2; // off hand

// Note that camera position is (0,0,0) in view space
varying vec4 vertex_view;

// ============================================================================


void main() {
	vec4 color_ori = texture2D(texture, texcoord) * glcolor;
	vec4 color = color_ori;

	vec2 lightWeight = calcTorchSkyWeights(lmcoord);

/* DRAWBUFFERS:027 */
	gl_FragData[0] = color * lightWeight.y; // -> gcolor
	gl_FragData[1] = vec4(normal * 0.5 + 0.5, 1.0);
	gl_FragData[2] = calcHandHeldLight(color_ori, vertex_view, normal, float(intMax(heldBlockLightValue, heldBlockLightValue2))) + color * lightWeight.x; // -> colortex7
}