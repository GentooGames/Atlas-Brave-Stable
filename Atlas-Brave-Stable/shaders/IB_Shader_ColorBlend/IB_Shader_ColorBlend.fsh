varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_color[3];
uniform float u_blend_amount;

void main() {
	
	vec4  base_color  = texture2D(gm_BaseTexture, v_vTexcoord);	
	float red_blend	  = mix(base_color.r, (u_color[0] / 255.0), u_blend_amount);
	float green_blend = mix(base_color.g, (u_color[1] / 255.0), u_blend_amount);
	float blue_blend  = mix(base_color.b, (u_color[2] / 255.0), u_blend_amount);
	gl_FragColor	  = vec4(red_blend, green_blend, blue_blend, base_color.a);
}
