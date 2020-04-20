#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265358979323846
#define TWO_PI 6.28318530717958647693

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

float smoothedge(float v) {
    return smoothstep(0.0, 1.0 / u_resolution.x, v);
}

vec2 rotate2D (vec2 _st, float _angle) {
  _st -= 0.5;
  _st =  mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle)) * _st;
  _st += 0.5;
  return _st;
}

vec2 tile (vec2 _st, float _zoom) {
  _st *= _zoom;
  return fract(_st);
}

float rect(vec2 p, vec2 size) {  
  vec2 d = abs(p) - size;
  return min(max(d.x, d.y), 0.0) + length(max(d,0.0));
}

float line(vec2 st, float width) {
    return step(width,1.0-smoothstep(.0,1.,abs(sin(st.y*PI))));
}

vec2 wave(vec2 st, float freq) {
	st.y += cos(st.x*freq);
	return st;
}


void main (void) {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st = tile(st,u_mouse.x/u_resolution.x*10);

    float pattern = 0.0;

    st = rotate2D(st,-PI*u_time*-0.534);
    
    pattern =   line(st, u_mouse.y/u_resolution.y);

    vec3 color = vec3(smoothedge(pattern));

    gl_FragColor = vec4(color,1.0);
}