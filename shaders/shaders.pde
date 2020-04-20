PShader s;

void setup() {
  size(600, 500, P3D);
  noStroke();
  fill(204);
  s = loadShader("rotatingLines.glsl");
}

void draw() {
  shader(s);
  s.set("u_resolution", float(width), float(height));
  s.set("u_mouse", float(mouseX), float(mouseY));
  s.set("u_time", millis() / 1000.0);
  //rect(0.,0., width, height);
  background(255);
  translate(width/2, height/2);
  circle(0,0, height/2+100);
}
