//See: https://processing.org/reference/libraries/pdf/index.html
import processing.pdf.*;

void setup() {
  size(400, 400, PDF, "filename.pdf");
  println(PDF);
}

void draw() {
  // Draw something good here
  line(0, 0, frameCount * 4, height);

  PGraphicsPDF pdf = (PGraphicsPDF) g;  // Get the renderer

  // When finished drawing, quit and save the file
  if (frameCount == 100) {
    exit();
  } else {
    pdf.nextPage();  // Tell it to go to the next page
  }
}
