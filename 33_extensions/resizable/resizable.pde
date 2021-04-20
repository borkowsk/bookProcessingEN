void setup() {
  size(400, 400);
  surface.setResizable(true);
}

void draw() {
  background(255);
  line(100, 100, width-100, height-100);
}

void keyPressed() {
  surface.setSize(round(random(200, 500)), 
                  round(random(200, 500)));
}

