
// from Saada

float adjustTorch(float lightVal) {
	float K = 1.8;
	float P = 4.5;
	return K * pow(lightVal, P);
}

float adjustSky(float lightVal) {
	float P = 4.0;
	return pow(lightVal, P);
}

vec2 adjustLight(vec2 light) {
	return vec2(adjustTorch(light.x), adjustSky(light.y));
}

vec4 getLight(vec2 light) {
	vec2 adjustedCoord = adjustLight(light);
	adjustedCoord = adjustedCoord * 0.7 + 0.3;

	vec3 torchLightColor = vec3(1.0, 0.75, 0.3);
	vec3 skyLightColor = vec3(1.0, 0.94, 0.85);

	return vec4(adjustedCoord.x * torchLightColor + adjustedCoord.y * skyLightColor, 1.0);
}

vec2 calcTorchSkyWeights(vec2 lmcoord){
	// lmcoord: x -> torch, y -> sky
	// use sigmoid to approximate minecraft lighting properties: max(torch, sky)
	float torchDominantFactor = 3.0;

	float torch =  1.0 / (1.0 + exp(-(torchDominantFactor * lmcoord.x - lmcoord.y)));
	float sky = 1.0 - torch;

	return vec2(torch, sky);
}