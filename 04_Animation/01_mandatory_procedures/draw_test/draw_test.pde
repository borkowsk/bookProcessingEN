/// `draw()` mandatory only.
//*/////////////////////////

int i=0; // Global needed inside `draw()`

void draw() // It is executed in an invisible loop
{ // external i // Note that external variable is used inside!
  strokeWeight(3);
  stroke(255,0,255);
  fill(i,0,0);
  ellipse(50,50,99,99);
  i++; // Incrementation of "i"
}

// https://github.com/borkowsk/bookProcessingEN
