const int shadowMapResolution = 8192;
const float shadowDistance = 80.0;

vec2 distortPosition(in vec2 position){
    float centerDistance = length(position);
    float distortionFactor = mix(1.0, centerDistance, 0.9);
    return position / distortionFactor;
}