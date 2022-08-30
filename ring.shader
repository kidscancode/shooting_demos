shader_type spatial;

uniform vec2 pos = vec2(0.5);
uniform float width : hint_range(0.5, 2.5) = 1.95;
uniform float radius : hint_range(0.01, 0.5) = 0.25;
uniform vec4 color : hint_color = vec4(0.0);

float haloRing(vec2 uv, vec2 p, float r, float thick) {
  return clamp(-(abs(length(uv-p) - r) * 100.0 / thick) + 0.9, 0.0, 1.0);
}

void fragment() {
	float i = haloRing(UV, pos, radius, width);
	ALBEDO = mix(vec3(0.0), color.rgb, i);
	ALPHA = mix(0.0, color.a, i);
	
	
	
	
}