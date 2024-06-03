// version 120

// hand-held light

#define HANDHELDLIGHTCOLOR vec4(1.0, 0.823, 0.501, 1.0)
// diffuse factor
#define Kd 0.8
// specular factor
#define Ks 0.2

// uniform int heldBlockLightValue; // main hand
// uniform int heldBlockLightValue2; // off hand

// // Note that camera position is (0,0,0) in view space
// varying vec4 vertex_view;

int intMax(int a, int b) {
    return (a > b) ? a : b;
}

vec4 clampAll4(vec4 v, float min, float max) {
	return vec4(clamp(v.r, min, max), clamp(v.g, min, max), clamp(v.b, min, max), clamp(v.a, min, max));
}

vec4 calcHandHeldLight(vec4 color, vec4 vertex_view, vec3 normal, float handLightLevel) {
	// vec4 color = texture2D(texture, texcoord) * glcolor;
	
	// V, N, L, H
	vec3 V = -normalize(vertex_view.xyz);

	vec3 N = normalize(normal.xyz);

	vec3 L = normalize(-vertex_view.xyz); // light direction == camera direction

	vec3 H = normalize(V + L);

	// diffuse
	float cos_diffuse = dot(N, L);
	vec3 color_diffuse = (cos_diffuse > 0.0) ? cos_diffuse * Kd * color.rgb : vec3(0.0);
	
	// specular
	float cos_specular = dot(N, H);
	vec3 color_specular = (cos_specular > 0.0) ? vec3(cos_specular * Ks) : vec3(0.0);

	vec4 color_handLight = vec4((color_diffuse + color_specular) * HANDHELDLIGHTCOLOR.rgb, 1.0);

	// float handLightLevel = float((heldBlockLightValue > heldBlockLightValue2) ? heldBlockLightValue : heldBlockLightValue2);

    // 2 type of lighting: 1st darker, 2nd brighter
	// (color_handLight * clamp(handLightLevel - length(-vertex_view.xyz), 0.0, 15.0) / 15.0)
	// (color_handLight * (handLightLevel * (1.0 / length(-vertex_view.xyz))))
	vec4 finalHandHeldLight = clampAll4(vec4((color_handLight * clamp(handLightLevel - length(-vertex_view.xyz), 0.0, 15.0) / 15.0).rgb, 1.0), 0.0, 1.0);

	color *= finalHandHeldLight;

	return color;
}