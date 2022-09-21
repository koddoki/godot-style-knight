shader_type canvas_item;

uniform float heatAmplitude : hint_range(0.0, 0.15) = 0.15;
uniform float heatPeriod = 6.0;
uniform float heatPhaseShift = 8.0;
uniform float heatUpperLimit : hint_range(0.5, 40.0) = 8.0;

uniform vec4 color : hint_color;

vec2 calculateUV(vec2 uv) {
	vec2 modifiedUVHot = uv;
	vec2 modifiedUVCold = uv;
	
	modifiedUVHot.y -= (((1.0 - modifiedUVHot.y) * heatAmplitude) *
	tan(heatPeriod * (modifiedUVHot.y - (TIME * 0.016  * heatPhaseShift)))) *
	clamp(1.0 - (modifiedUVHot.y * (10.0 - heatUpperLimit)), 0.0, 0.5);
	
	return modifiedUVHot;
}


void fragment() {
	vec4 pixelcolor = texture(TEXTURE, calculateUV(UV));
	float brightness = (pixelcolor.r + pixelcolor.g + pixelcolor.b / 6.0);
	vec4 grayScale = vec4(brightness, brightness, brightness, pixelcolor.a);
	COLOR = grayScale * color;
}