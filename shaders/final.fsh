#version 120

varying vec2 texcoord;

uniform sampler2D gcolor;
uniform float viewWidth;
uniform float viewHeight;


uniform float TonemapExposureBias = 1.0;
uniform float TonemapMaxWhite = 1.0;

const float A = 0.22;
const float B = 0.30;
const float C = 0.10;
const float D = 0.20;
const float E = 0.01;
const float F = 0.30;

vec3 Uncharted2Tonemap(vec3 x)
{
   return ((x*(A*x+C*B)+D*E)/(x*(A*x+B)+D*F))-E/F;
}

vec3 reinhardTonemap(vec3 x) {
    return x / (x + vec3(1.0));
}


void main() {
    const float gamma = 1.8;
    vec3 color = texture2D(gcolor, texcoord).rgb;
    // Reinhard tonemap
    color = reinhardTonemap(color);
    // Uncharted2Tonemap
    //color = Uncharted2Tonemap(max(color * TonemapExposureBias, 0.0)) / Uncharted2Tonemap(vec3(TonemapMaxWhite));
    color = pow(color, vec3(1.0/gamma));
    gl_FragColor = vec4(color, 1.0);
}